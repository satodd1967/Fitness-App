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

  end
  
end
