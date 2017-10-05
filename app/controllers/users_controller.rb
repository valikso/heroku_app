class UsersController < ApplicationController
 def show
      @user = User.find(params[:id])
      #@microposts = @user.microposts.paginate(page: params[:page])
    end
  def new
      @user = User.new
    end
    def edit
       @user = User.find(params[:id])
    end

    def login
      user = User.find_by(email: params[:email])
      if user.password == params[:password]
          session[:user_id] = user.id
      else
        flash[:error] = "Failed"
      end
    end

    def authenticate
      user = User.find_by_id(session[:user_id])
      if user.present
        @current_user = user
      end
    end
    def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
   def index
      @user = User.all
    end

      private

        def user_params
          params.require(:user).permit(:name, :last_name, :age, :email, :avatar, :password,
                                       :password_confirmation)
        end
    end
