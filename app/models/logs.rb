class Log < ActiveRecord::Base
    belongs_to :user

    # This method converts bodyfat from a percentage to a float and then creates the log

    def self.convert_create(params, user)
        params[:body_fat] = params[:body_fat].to_f/100
        params[:user_id] = user.id
        Log.create(params)
    end

   # This method converts binary 1's and zero's back into strings for the views.
    
    def self.string_convert(string)
        if string.downcase == "yes"
          1
        else
          0
        end
      end

    def self.log_update(params, user, log)
        log.update(
        worked_out: string_convert(params[:worked_out]),
        tracked_food: string_convert(params[:tracked_food]),
        weight: params[:weight],
        body_fat: "#{params[:body_fat].to_f/100}",
        active_calories: params[:active_calories],
        calories: params[:calories],
        user_id: user.id
        )
    end


end