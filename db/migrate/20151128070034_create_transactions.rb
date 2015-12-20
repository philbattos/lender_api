class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references  :user
      t.references  :peer
      t.string      :terms
      t.decimal     :amount
      t.datetime    :start_date
      t.datetime    :end_date

      t.timestamps null: false
    end

    add_index :transactions, [:user_id, :peer_id]
  end
end
