class UsersController < ApplicationController

    # This method posts the params from the index login page.
    # It checks to see if the user can be found by the username and then uses the authenticate method to ensure that the username and password are correct
    # It then logs the user in by setting the session user_id to the logged in users id
    # If the user has not set thier goals yet the route takes then to the goals new page and messages.
    # If they have goals it routes them to the logs page
    # If the user fails to authenticate it reloads the login page and messages
    
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

    # This route checks to see if the user is logged in.  If they aren't it routes to the login page.
    # If they are it clears the session and then routes to the login page.

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end

    # This rout checks to see if the user is logged in.  If they are it messages and then routes back to the login page.
    # If not it routes to the create_user view.

    get '/signup' do
        if logged_in?
            flash[:notice] = "You are currently logged in.  Please logout to create a new user account"
            redirect '/'
        end
        erb :"/users/create_user" 
    end

    # This route posts the params from the new user signup page.
    # It runs the signup_valid method which validates all of the parameters and reroutes as necessary with appropriate messages.
    # if the signup_valid passes it creates the user, logs them in by setting the session user_id to the logged in user id.
    # It then messages and routes them to the goals new page to setup thier goals.

    post '/signup' do
        signup_valid(params)
        user = User.create(params)
        session[:user_id] = user.id
        flash[:notice] = "Account successfully created.  Please enter your goals."
        redirect '/goals/new'
        # end
    end

    # This route take the user to thier personal diary page and utilizes a slug in the url of thier username instead of an id.
    # If the user found by the slug is not equal to the logged in user then it messages and reroutes to the logs page.
    # If there is no user logged in this will default to the login page.
    # If the user doesn't have any logs it reroutes them to the log page to create thier first log.
    # If they do have logs it routes them to thier personal diary page.

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if @user != current_user
            flash[:notice] = "You can only view your own diary"
            redirect '/logs'
        end
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