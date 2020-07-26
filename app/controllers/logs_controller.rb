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
        erb :'logs/new'
    end

    post '/logs' do
        if !logged_in?
            redirect '/'
        else
            check_completion(params)
        end
        erb :'/logs/logs'
    end

    get '/logs/:id/edit' do
    end

    patch '/logs/' do
    end

end