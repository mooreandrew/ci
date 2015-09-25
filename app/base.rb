require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader' if development?

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

class SinatraRecord < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure :development do
    register Sinatra::Reloader
    set :database, 'sqlite3:dev.db'
  end

  configure :production do
    set :database, 'sqlite3:dev.db'
  end

  configure :test do
    set :database, 'sqlite3:dev.db'
  end

end
