class Goal < ActiveRecord::Base
    belongs_to :user

    def self.convert_create(params, user)
        params[:start_bodyfat] = params[:start_bodyfat].to_f/100
        params[:body_fat_goal] = params[:body_fat_goal].to_f/100
        params[:user_id] = user.id
        @goals = Goal.create(params)
    end

    def self.goals_update(params, user, goals)
        goals.update(
            start_weight: params[:start_weight],
            start_bodyfat: params[:start_bodyfat].to_f/100,
            weight_goal: params[:weight_goal],
            body_fat_goal: params[:body_fat_goal].to_f/100,
            start_calorie_goal: params[:start_calorie_goal],
            user_id: user.id
        )
    end

end
