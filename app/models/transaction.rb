class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :peer, class_name: 'User'
end