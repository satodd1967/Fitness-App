class Log < ActiveRecord::Base
    belongs_to :user
    has_many :log_userpoints
    has_many :userpoints, through: :log_userpoints
end