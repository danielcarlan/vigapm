$ ->
  $('.user-area').on 'ajax:complete', '.mark-notification', (e) ->
    $(@).parent('.notification').remove()

  $('.user-area').on 'click', 'div[data-notification-post-id]', (e) ->
    $.ajax Routes.mark_users_notification_path($(@).closest('.notification').attr('id')),
      dataType: 'json',
      method: 'PUT'
    post_path = Routes.post_path($(@).data('notification-post-id'))
    window.location.href = post_path
