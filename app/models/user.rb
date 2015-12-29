class User < ActiveRecord::Base
  #-------------------------------------------------
  #    Associations
  #-------------------------------------------------
  has_many :transactions
  has_many :peers, through: :transactions

  #-------------------------------------------------
  #    Public Instance Methods
  #-------------------------------------------------
  def full_name
    "#{firstname} #{lastname}"
  end

  def open_request
    transactions.requested_confirmation.first
  end

  def has_open_request?
    transactions.requested_confirmation.any?
  end

  # def active_loans
  #   transactions.active
  # end

  # def completed_loans
  #   transactions.closed
  # end

  # def delinquent_loans
  #   transactions.delinquent
  # end
end
