class TransactionMailer < MandrillMailer::TemplateMailer
  default from: 'hello@asknow.io', from_name: 'Ask Now'
 
  def verify(account)
    mandrill_mail template: 'verify',
      to: {email: account.email, name: account.name},
      vars: {
        'NAME' => account.name,
        'VERIFICATION_URL' => account_verify_url(account.code)
      },
      important: true,
      inline_css: true,
      async: true
  end
end