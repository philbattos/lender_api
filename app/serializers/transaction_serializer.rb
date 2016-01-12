class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :peer_id, :amount, :terms, :aasm_state, :start_date, :end_date
end
