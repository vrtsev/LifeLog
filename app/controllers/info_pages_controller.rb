class InfoPagesController < ApplicationController
  layout 'info_pages'

  def about
  end

  def contacts
  end

  def send_feedback
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      flash[:notice] = 'Вы успешно отправили сообщение'
    else
      flash[:error] = 'Произошла ошибка при отправке сообщения'
    end
    redirect_to contacts_path
  end

  private

  def feedback_params
    params.require(:feedback).permit(:email, :subject, :message)
  end
end