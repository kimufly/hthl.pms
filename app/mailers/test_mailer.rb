class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.test_smtp.subject
  #
  def test_smtp
    @greeting = "Hi"

    mail to: "system_pms@hthl-tech.com", subject: "test smtp"
  end
end
