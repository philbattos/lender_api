class CreateSms < ActiveRecord::Migration
  def change
    create_table :sms do |t|
      t.string :from
      t.string :to
      t.string :body
      t.string :to_zip
      t.string :to_city
      t.string :to_state
      t.string :to_country
      t.string :from_zip
      t.string :from_city
      t.string :from_state
      t.string :from_country
      t.string :sms_status
      t.string :sms_message_sid
      t.string :sms_sid
      t.string :message_sid
      t.string :account_sid
      t.string :num_media
      t.string :num_segments
      t.string :api_version

      t.timestamps null: false
    end
  end
end
