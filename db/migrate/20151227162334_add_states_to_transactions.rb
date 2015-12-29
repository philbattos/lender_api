class AddStatesToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :aasm_state, :string
  end
end
