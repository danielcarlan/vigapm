class CreateEvents < ActiveRecord::Migration
  def change
    enable_extension 'hstore'

    change_table :users do |t|
      t.hstore :notification_settings
    end

    User.find_each do |user|
      user.notify_becoming_guru = 1
      user.notify_post_commented = 1
      user.notify_post_edited = 1
      user.save
    end

    create_table :events, force: true do |t|
      t.integer :kind
      t.belongs_to :post, index: true
      t.belongs_to :user

      t.timestamps
    end

    create_table :notifications do |t|
      t.belongs_to :event, index: true
      t.string :message

      t.timestamps
    end

    create_table :users_notifications do |t|
      t.belongs_to :user, index: true
      t.belongs_to :notification, index: true
      t.boolean :viewed, default: false, null: false

      t.timestamps
    end

    add_index :users_notifications, %i(user_id notification_id)
  end
end
