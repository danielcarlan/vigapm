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
    user = User.find_by(email: context.omniauth.info.email)

    if user
      context.user = user
    else
      context.user = User.new(
        username: context.omniauth.info.first_name,
        email: context.omniauth.info.email,
        password: ('0'..'z').to_a.shuffle[0,16].join)
      context.user.avatar = URI.parse(context.omniauth.info.image)
      context.user.save!
    end

    context.identity.update(user: context.user)
  end
end
