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
  
  def group_post(question, account)
    if account.settings.group_email_notifications
      mandrill_mail template: 'group_post',
        subject: question.account.display_name + " asked a question",
        to: {email: account.email, name: account.name },
        vars: {
          'ACCOUNT_NAME' => account.name,
          'GROUP_NAME' => question.group.name,
          'QUESTION_NAME' => question.account.name,
          'QUESTION_ENTRY' => question.entry,
          'QUESTION_URL' => question_show_url(question)
        },
        important: true,
        inline_css: true,
        async: true
    end
  end
end