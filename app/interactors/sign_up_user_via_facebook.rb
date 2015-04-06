class SignUpUserViaFacebook
  include Interactor

  def call
    create_identity
    create_user

    UserMailer.facebook_registration(context.user).deliver
  end

  protected

  def create_identity
    context.identity = Identity.create_by_omniauth(context.omniauth)
  end

  def create_user
    context.user = context.identity.build_user(
      username: context.omniauth.info.first_name,
      email: context.omniauth.info.email)
    context.user.avatar = URI.parse(context.omniauth.info.image)

    context.user.save(validate: false)
    context.identity.save
  end
end
