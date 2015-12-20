class User < ActiveRecord::Base
  has_many :transactions
  has_many :peers, through: :transactions
end
