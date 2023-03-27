class SessionsController < ApplicationController
    class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:manager_id] = manager.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Email or password is invalid."
      render "new"
    end
  end

  def destroy
    session[:manager_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end

end
