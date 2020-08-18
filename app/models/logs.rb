class Log < ActiveRecord::Base
    belongs_to :user

    # This method converts bodyfat from a percentage to a float and then creates the log

    def self.convert_create(params, user)
        params[:body_fat] = params[:body_fat].to_f/100
        params[:user_id] = user.id
        pointless_log = Log.create(params)
        pointed_log(pointless_log, user)
    end

   # This method converts binary 1's and zero's back into strings for the views.
    
    def self.string_convert(string)
        if string.downcase == "yes"
          1
        else
          0
        end
      end

    # This method converts some params from strings to binaries and converts
    # bodyfat to a decimal point for the datebase and then updates the record.

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
        pointed_log(log, user)
    end

    def self.pointed_log(log, user)
      log.points_worked_out = log.worked_out * Point.last.points_worked_out
      log.points_tracked_food = log.tracked_food * Point.last.points_tracked_food
      if user.goal.start_calorie_goal - log.calories >= 0
          log.points_met_calorie_goal = Point.last.points_met_calorie_goal
      else
          log.points_met_calorie_goal = 0
      end
      if log.weight <= user.goal.start_weight
          log.points_maintain_weight = Point.last.points_maintain_weight
      else
          log.points_maintain_weight = 0
      end
      if log.body_fat <= user.goal.start_bodyfat
          log.points_maintain_bodyfat = Point.last.points_maintain_bodyfat
      else
          log.points_maintain_bodyfat = 0
      end
      if log.active_calories <= 400
          log.points_met_active_calories = Point.last.points_met_active_calories
      else
          log.points_met_active_calories = 0
      end
      log.total_points = [
          log.points_worked_out,
           log.points_tracked_food,
            log.points_met_calorie_goal,
             log.points_maintain_weight,
              log.points_maintain_bodyfat,
               log.points_met_active_calories
              ].sum
      log.save
  end


end