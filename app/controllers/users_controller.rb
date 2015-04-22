class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    
    @user.assign_attributes(user_params)
    
    # check if email was updated
    if @user.email_changed?
      extra_info = " A confirmation email was sent to \"" + params[:user][:email] + "\". Please follow the email instructions to confirm your new email."
    else
      extra_info = ''
    end
    
    if @user.save
      flash[:notice] = "Account settings updated successfully.#{extra_info}"
      redirect_to edit_user_path
    else
      flash[:error] = "There was a problem updating your account"
      render :edit
    end
  end
  
  def reset_password
    current_user.send_reset_password_instructions
    flash[:notice] = "A password reset email has been sent to \"#{current_user.email}\". Please follow the instruction in the email to change your password"
    redirect_to edit_user_path
  end
    
  private
  
  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :time_zone_id, :allow_email_reminders, :email_reminders_days)
  end
end