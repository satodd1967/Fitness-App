class Log < ActiveRecord::Base
    belongs_to :user

    def self.convert_create(params, user)
        params[:body_fat] = params[:body_fat].to_f/100
        params[:user_id] = user.id
        Log.create(params)
    end

end