class GoalsController < ApplicationController

    get '/goals/' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        @goals = @user.goals
        erb :'goals/goals'
    end

    post '/goals' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        params.each do |key, value|
            if value == ""
                flash[:notice] = "Please enter all goals"
                redirect '/goals/new'
            end
        end
        @goals = Goal.create(
            weight_goal: params[:weight_goal],
             body_fat_goal: "#{params[:body_fat_goal].to_f/100}",
              start_calorie_goal: params[:start_calorie_goal],
               user_id: @user.id
               )
        @user.start_weight = params[:start_weight]
        @user.start_bodyfat = "#{params[:start_bodyfat].to_f/100}"
        @user.save
        flash[:notice] = "You have successfully created your goals"
        redirect '/goals'
    end

    get '/goals/new' do
        if !logged_in?
            redirect '/'
        end
        @user = current_user
        erb :'goals/new'
    end

end