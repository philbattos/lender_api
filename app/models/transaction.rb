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
  # scope :opened, -> { where(aasm_state: 'open') }

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

    event :sent_request do
      transitions from: :fresh, to: :requested_confirmation, :unless => :pending_request?
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
end