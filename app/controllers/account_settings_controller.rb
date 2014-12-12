class AccountSettingsController < ApplicationController
  def update
    settings = current_account.settings
    if settings.update(settings_params)
      flash[:notice] = "Setting updated like a boss."
      redirect_to :back
    else
      flash[:error] = "Boo. That didn't work. #{settings.error.full_messages.join(',')}"
      redirect_to :back
    end
  end
  private
  def settings_params
    params.require(:account_settings).permit(:group_email_notifications)
  end
end
