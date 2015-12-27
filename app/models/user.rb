class User < ActiveRecord::Base
  has_many :transactions
  has_many :peers, through: :transactions

  # scope :open_request, -> { joins(:transactions).where('transactions.state = ?', 'open') }

  def full_name
    "#{firstname} #{lastname}"
  end
end
