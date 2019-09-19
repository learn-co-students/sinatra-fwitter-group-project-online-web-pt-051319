require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if !logged_in?
      erb :index
    else 
      redirect '/tweets' 
    end
  end

  helpers do

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def params_present?
      params[:username].present? && params[:password].present? && params[:email].present? || params[:content].present?
    end

  end
end
