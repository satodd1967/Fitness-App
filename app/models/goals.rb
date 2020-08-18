class Goal < ActiveRecord::Base
    belongs_to :user

    def self.convert_create(params, user)
        params[:start_bodyfat] = params[:start_bodyfat].to_f/100
        params[:body_fat_goal] = params[:body_fat_goal].to_f/100
        params[:user_id] = user.id
        @goals = Goal.create(params)
    end

end