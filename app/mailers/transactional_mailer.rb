class TransactionalMailer < MandrillMailer::TemplateMailer
  default from: 'hello@asknow.io', from_name: 'Ask Now'
 
  def welcome(account)
    mandrill_mail template: 'verify',
      subject: I18n.t('email.welcome.subject'),
      to: {email: account.email, name: account.name},
      vars: {
        'NAME' => account.name,
        'VERIFICATION_URL' => account_verify_path
      },
      important: true,
      inline_css: true,
      async: true
  end
end