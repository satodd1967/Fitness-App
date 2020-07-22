class CleanController < ApplicationController

    def self.clean
        User.destroy_all
        Log.destroy_all
        Goal.destroy_all
    end
    
end