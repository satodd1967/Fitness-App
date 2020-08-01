class GoalsController < ApplicationController

    get '/goals' do
        user_check
        @user = current_user
        @goals = @user.goal
        erb :'goals/goals'
    end

    post '/goals' do
        user_check
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
        flash[:navigation] = "Review and edit your goals, view your diary, or continue on to view all user diaries"
        redirect '/goals'
    end

    get '/goals/new' do
        user_check
        @user = current_user
        erb :'goals/new'
    end

    get '/goals/edit' do
        user_check
        @user = current_user
        @goals = @user.goal
        erb :'goals/edit'
    end
    
    patch '/goals' do
        user_check
        check_completion(params)
        @user = current_user
        @goals = @user.goal
        @user.update(
            start_weight: params[:start_weight],
            start_bodyfat: params[:start_bodyfat].to_f/100
            )
        @goals.update(
            weight_goal: params[:weight_goal],
            body_fat_goal: params[:body_fat_goal].to_f/100,
            start_calorie_goal: params[:start_calorie_goal],
            user_id: @user.id
            )
        @user.save
        flash[:notice] = "You have succesfully upated your goals!"
        redirect '/goals'
    end 

end