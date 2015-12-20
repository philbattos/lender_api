class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :peer_id, :amount, :terms
end
