class TweetsController < ApplicationController
  before_action :set_method, only: [:edit, :show]
  before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    @tweet = Tweet.new
  end


  def create
  binding.pry
    @tweet = Tweet.new(tweet_params)
    @tweet.valid?
    @tweet.save
    redirect_to action: :index
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  def edit
    # binding.pry
  end

  def update
    # binding.pry
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to tweets_path
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:text).merge(user_id: current_user.id)
  end

  def set_method
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

end
