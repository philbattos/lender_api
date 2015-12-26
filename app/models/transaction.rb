class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :peer, class_name: 'User'

  validates :user, presence: true
  validates :peer, presence: true
end