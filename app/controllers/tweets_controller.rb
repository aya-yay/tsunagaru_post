class TweetsController < ApplicationController
  before_action :set_method, only: [:edit, :show]
  before_action :move_to_index, except: [:index, :show, :top]


  def top
  end

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    @tweets = Kaminari.paginate_array(@tweets).page(params[:page]).per(12)
    @tweet = Tweet.new
    @tweet = TweetsTag.new
  end

  def new
    @tweet = TweetsTag.new
  end


  def create
    @tweet = TweetsTag.new(tweet_params)
    binding.pry
    if user_signed_in? 
     @tweet.save
     redirect_to tweets_path
    end
  end

  def update
    load_tweet

    @tweet = TweetsTag.new(tweet_params, tweet: @tweet)
    if @tweet.update
      redirect_to tweets_path
    else
      render 'edit'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  def edit
    load_tweet
    @tweet = TweetsTag.new(tweet: @tweet)
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order("created_at DESC")
  end

  def search
    return nil if params[:input] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:input]}%"] )
    render json:{ keyword: tag }
  end

  def tweet_search
    @tweets = Tweet.search(params[:keyword])
  end


  private

  def tweet_params
    params.require(:tweet).permit(:text, :name).merge(user_id: current_user.id)
  end

  def load_tweet
    @tweet = current_user.tweets.find(params[:id])
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