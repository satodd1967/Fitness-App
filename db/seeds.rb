kris = User.create(username: "KrisDecker", email: "kris@outlook.com", password: "kris1", start_weight: "120", start_bodyfat: "15.5")
Goal.create(weight_goal: "112", body_fat_goal: "10.5", start_calorie_goal: "2800", user: kris)
Log.create(worked_out: "1", tracked_food: "1", weight: "124", body_fat: "14.8", active_calories: "800", calories: "3000", date: "2020-07-1", user: kris)
Log.create(worked_out: "1", tracked_food: "1", weight: "124.2", body_fat: "14.73", active_calories: "750", calories: "2700", date: "2020-07-2", user: kris)
Log.create(worked_out: "1", tracked_food: "0", weight: "123.2", body_fat: "13.73", active_calories: "600", calories: "2650", date: "2020-07-3", user: kris)

tim = User.create(username: "TimCoonfield", email: "Tim@outlook.com", password: "Tim1", start_weight: "140", start_bodyfat: "25.53")
Goal.create(weight_goal: "130", body_fat_goal: "20", start_calorie_goal: "2800", user: tim)
Log.create(worked_out: "1", tracked_food: "0", weight: "138", body_fat: "24.85", active_calories: "400", calories: "2900", date: "2020-07-1", user: tim)
Log.create(worked_out: "0", tracked_food: "1", weight: "137", body_fat: "23.42", active_calories: "0", calories: "3200", date: "2020-07-2", user: tim)
Log.create(worked_out: "1", tracked_food: "0", weight: "136", body_fat: "22.56", active_calories: "357", calories: "2800", date: "2020-07-3", user: tim)

ab = User.create(username: "AbKhattar", email: "Ab@outlook.com", password: "Ab1", start_weight: "145", start_bodyfat: "24.33")
Goal.create(weight_goal: "140", body_fat_goal: "21", start_calorie_goal: "2800", user: tim)
Log.create(worked_out: "1", tracked_food: "1", weight: "140", body_fat: "24.82", active_calories: "428", calories: "2900", date: "2020-07-1", user: ab)
Log.create(worked_out: "0", tracked_food: "1", weight: "135", body_fat: "23.35", active_calories: "0", calories: "3100", date: "2020-07-2", user: ab)
Log.create(worked_out: "1", tracked_food: "0", weight: "136", body_fat: "22.42", active_calories: "320", calories: "2700", date: "2020-07-3", user: ab)


