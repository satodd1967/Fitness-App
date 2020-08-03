class Userpoint < ActiveRecord::Base
    has_many :log_userpoints
    has_many :logs, through: :log_userpoints
    has_many :users, through: :logs
end