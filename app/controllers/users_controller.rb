class UsersController < ApplicationController
    # get '/users/:slug' do
    #     @user = User.find_by_slug(params[:slug])
    #     erb :'users/show'
    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if @user
            erb :'/users/show'
        else
            redirect '/tweets'
        end
    end

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/signup', locals: {message: "Please sign up before you sign in"}
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            "All fields must be filled!"
            redirect to '/signup'
        else
            @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
            @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    post '/login' do
        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/tweets'
        else
            erb :'users/login_error'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
            redirect '/login'
        else
            redirect '/'
        end
    end
end
