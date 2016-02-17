class Transaction < ActiveRecord::Base
  include AASM

  #-------------------------------------------------
  #    Associations
  #-------------------------------------------------
  belongs_to :user
  belongs_to :peer, class_name: 'User'

  #-------------------------------------------------
  #    Validations
  #-------------------------------------------------
  validates :user, presence: true
  validates :peer, presence: true

  #-------------------------------------------------
  #    Scopes
  #-------------------------------------------------
  scope :open,            ->              { where(aasm_state: [:requested_confirmation, :active, :delinquent]) }
  scope :find_by_lender,  -> (lender_id)  { where(user_id: lender_id) }
  scope :find_by_peer,    -> (peer_id)    { where(peer_id: peer_id) }

  #-------------------------------------------------
  #    States
  #-------------------------------------------------
  aasm do
    state :fresh, initial: true   # state when transaction is created
    state :requested_confirmation # sent request to peer to confirm loan
    state :active                 # in repayment
    state :rejected               # request unaccepted by peer
    state :closed                 # loan opened, confirmed, and repaid
    state :delinquent             # terms of loan have been broken (late repayment, etc.)
    state :twilio_error           # Twilio could not dispatch SMS

    event :send_request do
      transitions from: :fresh, to: :requested_confirmation, :unless => :pending_request?
    end

    event :phone_fail do
      transitions from: :fresh, to: :twilio_error
    end

    event :confirm do
      transitions from: :requested_confirmation, to: :active
    end

    event :decline do
      transitions from: :requested_confirmation, to: :rejected
    end

    event :finalize do
      transitions from: :active, to: :closed
    end

    event :flag do
      transitions from: :active, to: :delinquent
    end
  end

  #-------------------------------------------------
  #    Public Instance Methods
  #-------------------------------------------------
  def pending_request?
    user.transactions.requested_confirmation.any?
  end

  def accrued_interest
    daily_apr   = terms.to_f / 100 # assumes that '.terms' is a number between 1-100
    start       = start_date || created_at
    days        = (Time.current.to_date - start.to_date).to_i
    daily_rate  = daily_apr / 365

    @accrued_interest = (daily_rate * days * amount).round(2)
  end

  def balance
    @accrued_interest ||= accrued_interest
    @accrued_interest + amount
  end
end