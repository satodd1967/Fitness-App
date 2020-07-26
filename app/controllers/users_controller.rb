class UsersController < ApplicationController

    post '/login' do
        user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
		  session[:user_id] = user.id
		  redirect '/logs'
        else
            @error = "Failed to login.  Please try again."
		    erb :index
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
        erb :"/users/create_user" 
    end

    post '/signup' do
        if User.find_by(username: params[:username])
            flash[:notice] = "#{params[:username]} is not available."
            redirect '/signup'
        elsif params[:username].include?(" ") || params[:username] == ""
            flash[:notice] = "Usernames cannot include spaces or be blank."
            redirect '/signup'
        elsif User.find_by(email: params[:email])
            flash[:notice] = "#{params[:email]} has already signed up please login."
            redirect '/'
        elsif !email_valid(params[:email])
            flash[:notice] = "#{params[:email]} is an invalid email address.  Please enter a valid email address."
            redirect '/signup'
        elsif !pass_valid(params[:password])
            flash[:notice] = "Password does not meet complexity requirements."
            redirect '/signup'
        else
        user = User.create(params)
        session[:user_id] = user.id
        flash[:notice] = "Account successfully created.  Please enter your goals."
        redirect '/goals/new'
        end
    end

end