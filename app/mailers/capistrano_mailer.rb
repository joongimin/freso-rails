class CapistranoMailer < ActionMailer::Base
  def capistrano_mail(args)
    @release_name = args[:release_name]
    @current_revision = args[:current_revision]
    @user = args[:user]
    @email = args[:email]
    @log = args[:log]
    @github_prefix = "https://github.com/#{args[:github]}"

    mail({
      from: args[:from],
      to: args[:to],
      subject: "[#{args[:application]} #{args[:stage]}] Deployed #{@release_name} by #{@user}",
      template_path: args[:template_path]
      }) do |format|
      format.text { render 'app/views/capistrano_mailer/capistrano_mail' }
      format.html { render 'app/views/capistrano_mailer/capistrano_mail' }
    end
  end
end