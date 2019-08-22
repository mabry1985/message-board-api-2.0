class SessionsController < ActionController::Base
  helper_method :current_user
  skip_before_action :verify_authenticity_token

  def create
    @user = User.authenticate(params[:email], params[:password])
    if @user
      flash[:notice] = "You've signed in."
      session[:user_id] = @user.id
      redirect_to "/user/#{@user.id}"
    else
      flash[:alert] = "There was a problem signing in. Please try again."
      redirect_to signin_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've signed out."
    redirect_to "/"
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end
  end
end
