class ApplicationMailer < ActionMailer::Base
  default from: I18n.t('blacklight.email.record_mailer.name') +
                ' <' + I18n.t('blacklight.email.record_mailer.email') + '>'
  layout 'mailer'
end
