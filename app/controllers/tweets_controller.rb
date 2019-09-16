class TweetsController < ApplicationController

    get '/tweets' do
        if is_logged_in?
            @tweets = Tweet.all
            erb :'tweets/index'
        else
            redirect to '/login'
        end
    end

    get '/tweets/new' do
        if is_logged_in?
            erb :'tweets/new'
        else
            redirect to '/login'
        end
    end

    post '/tweets' do
        @tweet = Tweet.new(content: params[:content], user_id: current_user.id)
        
        if @tweet.save
            redirect to '/tweets'
        else
            redirect to '/tweets/new'
        end
    end

    get '/tweets/:id' do
        if is_logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'tweets/show'
        else
            redirect to '/login'
        end
    end

    get '/tweets/:id/edit' do
        if is_logged_in?
            @tweet = Tweet.find(params[:id])
            erb :'tweets/edit'
        else
            redirect to '/login'
        end
    end

    patch '/tweets/:id' do
        if params[:content] == ""
            redirect to "/tweets/#{params[:id]}/edit"
        else
            @tweet = Tweet.find(params[:id])
            @tweet.content = params[:content]
            @tweet.save
            redirect to "/tweets/#{@tweet.id}/edit"
        end
        
    end

    delete '/tweets/:id' do
        @tweet = Tweet.find(params[:id])

        if @tweet.user == current_user
            @tweet.delete
        end
        
        redirect to '/tweets'
    end


end
