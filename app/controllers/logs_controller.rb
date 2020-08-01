class LogsController < ApplicationController

    get '/logs' do
        user_check
        @user = current_user
        if @logs = Log.where(date: params[:date]) != []
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

    get '/logs/new' do
        user_check
        @user = current_user
        @logs = @user.logs
        erb :'logs/new'
    end

    post '/logs' do
        user_check
        check_completion(params)
        @user = current_user
        if @user.logs.find_by(date: params[:date])
            flash[:notice] = "You have already logged for #{params[:date]}."
            flash[:navigation] = "Change the date and try again or edit/delete the original log."
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
            flash[:notice] = "You have successfully added a diary entry."
            flash[:date] = "#{params[:date]}"
        end
        redirect '/logs'
    end

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

    patch '/logs/:id' do
        user_check
        check_completion(params)
        @user = current_user
        @log = Log.find_by(id: params[:id])
        @log.update(
            worked_out: string_convert(params[:worked_out]),
            tracked_food: string_convert(params[:tracked_food]),
            weight: params[:weight],
            body_fat: "#{params[:body_fat].to_f/100}",
            active_calories: params[:active_calories],
            calories: params[:calories],
            user_id: @user.id
            )
        @log.save
        flash[:notice] = "You have succesfully upated this diary entry"
        redirect "/logs/#{@log.id}"
    end

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