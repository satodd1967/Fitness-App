class LogsController < ApplicationController

    # This route routes to login if not logged in.  It then checks to see if there is a log for the date provided by the change date form.
    # If there is a date then routes to the logs page and displays that date.
    # If there is no date it checks to see if there is a date stored in the flash hash.
    # If there is a date in the flash hash it routes to the logs page and displays that date.
    # If there is no date in the flash hash it routes to the logs page and displays the date of the last log in the database.
    
    get '/logs' do
        user_check
        @user = current_user
        if Log.where(date: params[:date]) != []
            @logs = Log.where(date: params[:date])
            erb :'/logs/logs'
        elsif params != {}
            flash[:notice] = "There are no diary entries for #{params[:date]}."
            params[:date].clear
            redirect '/logs'
        elsif flash[:date] != nil
            @logs = Log.where(date: flash[:date])
            erb :'logs/logs'
        else
            @logs = Log.where(date: Log.last.date)
            erb :'logs/logs'
        end

    end

    # This route goes to the login page if not logged in the routes to the logs new page if logged in.

    get '/logs/new' do
        user_check
        @user = current_user
        @logs = @user.logs
        erb :'logs/new'
    end

    # This route goes to the login page if not logged in then checks that the form from logs/new was filled out completely.
    # If not filled out reroutes back.  It then checks to see if there is already a log for that user on that date.
    # If there is it messages the user and routes back to the logs new page and also displays a link to edit the log that it was asked to create.
    # It does this by passing the date through the flash hash to the view.
    # If there is no log on that date it creates the log and routes to the logs page.
    # The user is messaged and the date of the newly created log is passed in the flash hash and the logs page displays that date.

    post '/logs' do
        user_check
        check_completion(params)
        @user = current_user
        if @user.logs.find_by(date: params[:date])
            flash[:notice] = "You have already logged for #{params[:date]}."
            flash[:navigation] = "Change the date and try again or edit/delete the original entry."
            flash[:date_param] = "#{params[:date]}"
            redirect '/logs/new'
        else
            Log.convert_create(params, @user)
            flash[:notice] = "You have successfully added a diary entry."
            flash[:date] = "#{params[:date]}"
        end
        redirect '/logs'
    end

    # This route is the show page for logs.  If the user isn't logged in it routes to the login page.
    # If checks to see that the requested log belongs to the user that is currently logged in.
    # If not then it routes back to the main logs page.
    # If so then it pulls the log and routes to the log show view.

    get '/logs/:id' do
        user_check
        @user = current_user
        if !@user.logs.find_by(id: params[:id])
            flash[:notice] = "You can only view logs that belong to you"
            redirect '/logs'
        end
        @log = Log.find_by(id: params[:id])
        erb :'logs/show'
    end

    # This route goes to the edit page for logs and behaves in the same way as the route above, but routes to the edit page.

    get '/logs/:id/edit' do
        user_check
        @user = current_user
        if !@user.logs.find_by(id: params[:id])
            flash[:notice] = "You can only edit diary entries that belong to you"
            redirect '/logs'
        end
        @log = Log.find_by(id: params[:id])
        erb :'logs/edit'
    end

    # This route goes to the login page if not logged in.  Then checks for a completed set of params from the edit form.
    # If it was not completed then it reroutes back.
    # The route then checks to ensure that the log being edited is owned by the current user.
    # IF not it messages and sends them to the main logs page.
    # If it is then it updates the log and routes to the show page for that log and messages the user.


    patch '/logs/:id' do
        user_check
        check_completion(params)
        @user = current_user
        @log = Log.find_by(id: params[:id])
        if @user.id == @log.user_id
            # @log.update(
            #     worked_out: string_convert(params[:worked_out]),
            #     tracked_food: string_convert(params[:tracked_food]),
            #     weight: params[:weight],
            #     body_fat: "#{params[:body_fat].to_f/100}",
            #     active_calories: params[:active_calories],
            #     calories: params[:calories],
            #     user_id: @user.id
            #     )
            Log.log_update(params, @user, @log)
            flash[:notice] = "You have succesfully upated this diary entry"
            redirect "/logs/#{@log.id}"
        else
            flash[:notice] = "You can only edit diary entries that belong to you"
            redirect '/logs'
        end
    end

    # This route actis in the same way as the route above, but the action taken is to delete the log.

    get '/logs/:id/delete' do
        user_check
        @user = current_user
        @log = Log.find_by(id: params[:id])
        if @user.id == @log.user_id
            @log.delete
            flash[:notice] = "The log for #{@log.date} has been deleted."
            redirect '/logs'
        else
            flash[:notice] = "You can only delete your own diary entries."
            redirect '/logs'
        end
    end

end