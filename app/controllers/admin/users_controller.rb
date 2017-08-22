class Admin::UsersController < AdminController
  def index
    @users = User.all.order(created_at: :desc)
                 .paginate(page: params[:page], per_page: 15)
  end
end