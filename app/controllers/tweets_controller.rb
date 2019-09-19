class TweetsController < ApplicationController
  get '/tweets' do 
    if logged_in?
      @tweets = Tweet.all 
      @user = current_user
      erb :'tweets/index'
    else
      redirect to '/login'
    end
  end


  get '/tweets/new' do 
    if !logged_in? 
      redirect to '/login'    
    else 
      erb :'/tweets/new'     
    end
  end

  post '/tweets' do 
    if logged_in? && params_present?
      @tweet = Tweet.create(content: params[:content], user_id: current_user.id)
      redirect to "/tweets/#{@tweet.id}"
    else  
      redirect to "/tweets/new"
    end
  end 


  get '/tweets/:id' do 
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else 
      redirect to '/login'
    end
    
  end 



  get '/tweets/:id/edit' do
    if logged_in?
        @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
          erb :'/tweets/edit'
        else 
          redirect "/tweets"
      end 
    else 
      redirect to '/login'
    end 
  end
    
  patch '/tweets/:id/edit' do
  @tweet = Tweet.find(params[:id])
    if params_present? 
      @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      redirect to "/tweets/#{@tweet.id}/edit"
    end
  end


  delete '/tweets/:id/delete' do 
    if logged_in? 
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete 
        redirect to '/tweets'
      end 
    else
      redirect "/login"
    end           
  end

end 

