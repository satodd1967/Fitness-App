ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc 'clean db'
task :clean do
    User.destroy_all
    Log.destroy_all
    Goal.destroy_all
    Point.destroy_all
end