class UsersController < ApplicationController

    post '/login' do
        user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          if user.goal == nil
            flash[:notice] = "You have not entered your goals yet.  Please enter your goals to continue"
            redirect '/goals/new'
          else
            redirect '/logs'
          end
        else
            flash[:notice] = "Failed to login.  Please try again."
		    redirect '/'
		end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end

    get '/signup' do
        if logged_in?
            flash[:notice] = "You are currently logged in.  Please logout to create a new user account"
            redirect '/'
        end
        erb :"/users/create_user" 
    end

    post '/signup' do
        signup_valid(params)
        user = User.create(params)
        session[:user_id] = user.id
        flash[:notice] = "Account successfully created.  Please enter your goals."
        redirect '/goals/new'
        # end
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        @logs = @user.logs
        @goals = @user.goal
        if @logs == []
            flash[:notice] = "You don't currently have any Diary Entries."
            flash[:navigation] = "Create your first entry below."
            redirect '/logs/new'
        else
            erb :'users/show'
        end
    end

end