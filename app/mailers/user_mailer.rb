# 10.1.2 Created with rails generate mailer UserMailer account_activation password_reset

class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject

	# 10.11 Mailing the account activation link
  def account_activation(user)
    @user = user
		mail to: user.email, subject: "Account activation"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject

	# 10.43 Mailing the password reset link.
	def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end

end
