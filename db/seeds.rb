kris = User.create(username: "KrisDecker", email: "kris@outlook.com", password: "kris1", start_weight: "120", start_bodyfat: "15.5")
Goal.create(weight_goal: "112", body_fat_goal: "10.5", start_calorie_goal: "2800", user: kris)
log1 = Log.create(worked_out: "1", tracked_food: "1", weight: "124", body_fat: "14.8", active_calories: "800", calories: "3000", date: "1/1/2020", user: kris)
