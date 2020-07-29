class LogsController < ApplicationController

    get '/logs' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        if @logs = Log.where(date: params[:date]) != []
            @logs = Log.where(date: params[:date])
            erb :'/logs/logs'
        elsif params != {}
            flash[:notice] = "There are no diary entries for #{params[:date]})."
            params[:date].clear
            redirect '/logs'
        else
            @logs = Log.where(date: Log.last.date)
            erb :'logs/logs'
        end

    end

    get '/logs/new' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        @logs = @user.logs
        erb :'logs/new'
    end

    post '/logs' do
        if !logged_in?
            redirect '/'
        else
            check_completion(params)
        end
        @user = current_user
        if @user.logs.find_by(date: params[:date])
            flash[:notice] = "You have already logged for #{params[:date]}."
            flash[:navigation] = "Change the date and try again or edit or delete the original log."
            flash[:date_param] = "#{params[:date]}"
            redirect '/logs/new'
        else
            Log.create(
                worked_out: string_convert(params[:worked_out]),
                tracked_food: string_convert(params[:tracked_food]),
                weight: params[:weight],
                body_fat: "#{params[:body_fat].to_f/100}",
                active_calories: params[:active_calories],
                calories: params[:calories],
                date: params[:date],
                user_id: @user.id
            )
        end
        redirect '/logs'
    end

    get '/logs/:id' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        if !@user.logs.find_by(id: params[:id])
            flash[:notice] = "You can only view logs that belong to you"
            redirect '/logs'
        end
        @log = Log.find_by(id: params[:id])
        erb :'logs/show'
    end

    get '/logs/:id/edit' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        if !@user.logs.find_by(id: params[:id])
            flash[:notice] = "You can only edit logs that belong to you"
            redirect '/logs'
        end
        @log = Log.find_by(id: params[:id])
        erb :'logs/edit'
    end

    patch '/logs/:id' do
        if !logged_in?
            redirect '/'
        else
            check_completion(params)
        end
        @user = current_user
        @log = Log.find_by(id: params[:id])
        @log.update(
            worked_out: string_convert(params[:worked_out]),
            tracked_food: string_convert(params[:tracked_food]),
            weight: params[:weight],
            body_fat: params[:body_fat],
            active_calories: params[:active_calories],
            calories: params[:calories],
            user_id: @user.id
            )
        flash[:notice] = "You have succesfully upated this diary entry"
        redirect "/logs/#{@log.id}"
    end

    get '/logs/:id/delete' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        @log = Log.find_by(id: params[:id])
        if @user.id == @log.user_id
            @log.delete
            redirect '/logs'
        else
            flash[:notice] = "You can only delete your own diary entries"
            redirect '/logs'
        end
    end

end