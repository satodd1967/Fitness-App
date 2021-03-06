kris = User.create(username: "KrisDecker", email: "kris@outlook.com", password: "kris1")
Goal.create(weight_goal: "112", body_fat_goal: ".105", start_calorie_goal: "2800", start_weight: "120", start_bodyfat: ".155", user: kris)
Log.create(worked_out: "1", tracked_food: "1", weight: "124", body_fat: ".148", active_calories: "800", calories: "3000", date: "2020-07-01", user: kris)
Log.create(worked_out: "1", tracked_food: "1", weight: "124.2", body_fat: ".1473", active_calories: "750", calories: "2700", date: "2020-07-02", user: kris)
Log.create(worked_out: "1", tracked_food: "0", weight: "123.2", body_fat: ".1373", active_calories: "600", calories: "2650", date: "2020-07-03", user: kris)

tim = User.create(username: "TimCoonfield", email: "Tim@outlook.com", password: "tim1")
Goal.create(weight_goal: "130", body_fat_goal: ".20", start_calorie_goal: "2800", start_weight: "140", start_bodyfat: ".2553", user: tim)
Log.create(worked_out: "1", tracked_food: "0", weight: "138", body_fat: ".2485", active_calories: "400", calories: "2900", date: "2020-07-01", user: tim)
Log.create(worked_out: "0", tracked_food: "1", weight: "137", body_fat: ".2342", active_calories: "0", calories: "3200", date: "2020-07-02", user: tim)
Log.create(worked_out: "1", tracked_food: "0", weight: "136", body_fat: ".2256", active_calories: "357", calories: "2800", date: "2020-07-03", user: tim)

ab = User.create(username: "AbKhattar", email: "Ab@outlook.com", password: "ab1")
Goal.create(weight_goal: "140", body_fat_goal: ".21", start_calorie_goal: "2800", start_weight: "145", start_bodyfat: ".2433", user: ab)
Log.create(worked_out: "1", tracked_food: "1", weight: "140", body_fat: ".2482", active_calories: "428", calories: "2900", date: "2020-07-01", user: ab)
Log.create(worked_out: "0", tracked_food: "1", weight: "135", body_fat: ".2335", active_calories: "0", calories: "3100", date: "2020-07-02", user: ab)
Log.create(worked_out: "1", tracked_food: "0", weight: "136", body_fat: ".2245", active_calories: "320", calories: "2700", date: "2020-07-03", user: ab)

joe = User.create(username: "JoeSmith", email: "joe@outlook.com", password: "joe1")
Goal.create(weight_goal: "140", body_fat_goal: ".21", start_calorie_goal: "2800", start_weight: "145", start_bodyfat: ".2433",user: joe)
Log.create(worked_out: "1", tracked_food: "1", weight: "140", body_fat: ".2482", active_calories: "428", calories: "2900", date: "2020-07-01", user: joe)
Log.create(worked_out: "0", tracked_food: "1", weight: "135", body_fat: ".2335", active_calories: "0", calories: "3100", date: "2020-07-02", user: joe)
Log.create(worked_out: "1", tracked_food: "0", weight: "136", body_fat: ".2245", active_calories: "320", calories: "2700", date: "2020-07-03", user: joe)

angie = User.create(username: "AngieBrown", email: "angie@outlook.com", password: "angie1")
Goal.create(weight_goal: "140", body_fat_goal: ".21", start_calorie_goal: "2800", start_weight: "145", start_bodyfat: ".2433",user: angie)
Log.create(worked_out: "1", tracked_food: "1", weight: "140", body_fat: ".2482", active_calories: "428", calories: "2900", date: "2020-07-01", user: angie)
Log.create(worked_out: "0", tracked_food: "1", weight: "135", body_fat: ".2335", active_calories: "0", calories: "3100", date: "2020-07-02", user: angie)
Log.create(worked_out: "1", tracked_food: "0", weight: "136", body_fat: ".2245", active_calories: "320", calories: "2700", date: "2020-07-03", user: angie)


Point.create(points_worked_out: 10, points_tracked_food: 10, points_met_calorie_goal: 10, points_maintain_weight: 5, points_maintain_bodyfat: 5, points_met_active_calories: 10)

User.all.each do |user|
    user.logs.each do |log|
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
