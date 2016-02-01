class User < ActiveRecord::Base

  #-------------------------------------------------
  #    Authentication with Devise
  #-------------------------------------------------
  devise  :database_authenticatable,
          :registerable,
          :recoverable,
          :rememberable,
          :trackable,
          :validatable
          # :confirmable,
          # :lockable,
          # :timeoutable,
          # :omniauthable

  #-------------------------------------------------
  #    Associations
  #-------------------------------------------------
  has_many :transactions
  has_many :peers, through: :transactions

  #-------------------------------------------------
  #    Validations
  #-------------------------------------------------
  validates :email, uniqueness: true

  #-------------------------------------------------
  #    Public Instance Methods
  #-------------------------------------------------
  def full_name
    "#{firstname} #{lastname}"
  end

  def transactions_as_lender
    Transaction.find_by_lender(self.id)
  end

  def transactions_as_peer
    Transaction.find_by_peer(self.id)
  end

  def all_transactions
    Transaction.where("user_id = 1 OR peer_id = 1")
  end

  def open_request
    @open_request ||= Transaction.where(peer_id: self.id).requested_confirmation.first
  end

  def has_open_request?
    open_request.present?
  end

end
