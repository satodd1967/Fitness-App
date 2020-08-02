require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end 

  get "/" do
    if logged_in?
      redirect '/logs'
    else
      erb :index
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def user_check
      if !logged_in?
        flash[:notice] = "You must be logged in!"
        redirect '/'
      end
    end

    def current_user
      User.find(session[:user_id])
    end

    

    def pass_valid(password)
      reg = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}$/
      return (reg.match(password))? true : false
    end

    def email_valid(email)
      reg = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      return (reg.match(email))? true : false
    end

    def check_completion(params)
      params.each do |key, value|
        if value == ""
            flash[:notice] = "Please complete all fields"
            redirect back
        end
      end
    end

    def binary_convert(string)
      if string.to_i == 0
        "No"
      else
        "Yes"
      end
    end

    def string_convert(string)
      if string.downcase == "yes"
        1
      else
        0
      end
    end

    def signup_valid(params)
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
      end
    end

  end
  
end
