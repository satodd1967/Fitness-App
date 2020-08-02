class CleanController < ApplicationController

    # This model and method are used to clear the database so that it can be re-seeded.

    def self.clean
        User.destroy_all
        Log.destroy_all
        Goal.destroy_all
    end
    
end