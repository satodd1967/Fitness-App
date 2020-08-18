class GoalsController < ApplicationController
    
    # This route goes to the show page for goals.  It utilizes the user_check method for validation.
    
    get '/goals' do
        user_check
        @user = current_user
        @goals = @user.goal
        erb :'goals/goals'
    end

    # This route takes in params from the goals new page.  It first utilizes the user_check method for validation and then
    # utilizes the check_completion method to make sure that all form fields are completed.
    # Then the route reformats some fields for database ingestion and then creates goals based on the updated params.
    # Once created it messages and routes the to the goals show page.

    post '/goals' do
        user_check
        check_completion(params)
        @user = current_user
        Goal.convert_create(params, @user)
        # params[:start_bodyfat] = params[:start_bodyfat].to_f/100
        # params[:body_fat_goal] = params[:body_fat_goal].to_f/100
        # params[:user_id] = @user.id
        # @goals = Goal.create(params)
        flash[:notice] = "You have successfully created your goals"
        flash[:navigation] = "Review and edit your goals, view your diary, or continue on to view all user diaries"
        redirect '/goals'
    end

    # This route takes the user to the new goals page.  It utilizes the user_check method for validation.

    get '/goals/new' do
        user_check
        @user = current_user
        erb :'goals/new'
    end

    # This route takes the user to the goals edit page and utilizes the user_check method for validation

    get '/goals/edit' do
        user_check
        @user = current_user
        @goals = @user.goal
        erb :'goals/edit'
    end

    # This route takes in params from the goals edit page.  It uses the user_check method for validation.
    # If then uses the check_completion method to ensure all fields have been filled in.
    # If all checks are passed it updates the users goals, message and routes them to the goals show page.
    
    patch '/goals' do
        user_check
        check_completion(params)
        @user = current_user
        @goals = @user.goal
        @goals.update(
            start_weight: params[:start_weight],
            start_bodyfat: params[:start_bodyfat].to_f/100,
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