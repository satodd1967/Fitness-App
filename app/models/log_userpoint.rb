class LogUserpoint < ActiveRecord::Base
    belongs_to :log
    belongs_to :userpoint
end