require './config/environment'

class ApplicationController < Sinatra::Base
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end 

  # Checks to see if the user has an open session and is logged in.
  # If they are it routes then directly to the logs page, if not it takes them to the signup/login page.

  get "/" do
    if logged_in?
      redirect '/logs'
    else
      erb :index
    end
  end

  # Helper Methods 
  
  helpers do

    # Checks to see if a user is logged in or not.

    def logged_in?
      !!session[:user_id]
    end

    # This method is for security in case someone tries to hit a route that navigation should not take them to.
    # If they aren't logged in it routes them back to the login page.

    def user_check
      if !logged_in?
        flash[:notice] = "You must be logged in!"
        redirect '/'
      end
    end

    # This method identifies the current user via the session.

    def current_user
      User.find(session[:user_id])
    end

    # This method checks to see if a password meets the complexity and validation requirements.

    def pass_valid(password)
      reg = /^(?=.*\d)(?=.*([a-z]|[A-Z]))([\x20-\x7E]){8,40}$/
      return (reg.match(password))? true : false
    end

    # This method checks to see if the email address passes the validation requirements.

    def email_valid(email)
      reg = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
      return (reg.match(email))? true : false
    end

    # This method checks to ensure that all required fields are filled in upon a form submission.

    def check_completion(params)
      params.each do |key, value|
        if value == ""
            flash[:notice] = "Please complete all fields"
            redirect back
        end
      end
    end

    # This method converts radio button responses to binary 1's and zero's for the database.

    def binary_convert(string)
      if string.to_i == 0
        "No"
      else
        "Yes"
      end
    end

    # This method converts binary 1's and zero's back into strings for the views.

    # def string_convert(string)
    #   if string.downcase == "yes"
    #     1
    #   else
    #     0
    #   end
    # end

    # This method performs all of the validation for the user signup form.

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
