class User < ActiveRecord::Base
  has_many :transactions
  has_many :peers, through: :transactions

  def full_name
    "#{firstname} #{lastname}"
  end
end
