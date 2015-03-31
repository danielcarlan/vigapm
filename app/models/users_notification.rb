class UsersNotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notification, class_name: Notifications::Notification
  has_one :sender, through: :notification
  has_one :post, through: :notification

  delegate :message, to: :notification

  after_create :send_email_to_user!

  protected

  def send_email_to_user!
    if send_email_to_user?
      mail = EventMailer.send(notification.event.kind, notification.event, user)
      mail.deliver if mail
    end
  end

  def send_email_to_user?
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(
      user.public_send(%[notify_#{notification.event.kind}]))
  end
end
