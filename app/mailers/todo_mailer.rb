class TodoMailer < ApplicationMailer
  helper ItemsHelper
  default from: 'no-reply@blafri868-blocitoff.herokuapp.com'
  
  def todo_summary_email(user, tasks)
    @user = user
    @tasks = tasks
    
    mail(to: @user.email, subject: "Todo Reminders for #{@user.first_name}")
  end
end
