class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  default to: "from@example.com"
  layout 'mailer'
end