module Notifications
  class Notification < ActiveRecord::Base
    belongs_to :event

    has_one :post, through: :event
    has_one :sender, through: :event, source: :user

    has_many :users_notifications
    has_many :users, through: :users_notifications

    validates :event, :message, presence: true

    after_commit :create_users_notifications, on: :create

    protected

    def create_users_notifications
      # Guru changed
      if event.becoming_guru?
        UsersNotification.create!(user: post.guru, notification: self)
      end

      # Post edited
      if event.post_edited?
        post.users.find_each do |user|
          UsersNotification.create!(user: user, notification: self) unless user == event.user
        end
      end

      # Post commented
      if event.post_commented?
        (post.users + [post.user] + [post.guru]).uniq.each do |user|
          UsersNotification.create!(user: user, notification: self) #unless user == event.user
        end
      end
    end
  end
end
