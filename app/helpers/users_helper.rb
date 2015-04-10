module UsersHelper
  def ranking_badge(user, post)
    return content_tag(:span, class: "badge") unless user

    span_class = "badge #{user.username.parameterize}-rank"
    span_class << ' alert-danger' if user.ranking_for(post) < 0

    content_tag(:span, user.ranking_for(post), class: span_class)
  end
end
