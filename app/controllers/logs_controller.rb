class LogsController < ApplicationController

    get '/logs' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        @logs = Log.all
        erb :'logs/logs'
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

    patch '/logs/' do
    end

end