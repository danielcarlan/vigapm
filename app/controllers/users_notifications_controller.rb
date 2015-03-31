class UsersNotificationsController < ApplicationController
  respond_to :js, only: :mark

  def mark
    @users_notifications = current_user.unread_users_notifications
    @users_notification = @users_notifications.find(params[:id])
    @users_notification.update(viewed: true)
  end
end
