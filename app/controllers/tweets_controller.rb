class TweetsController < ApplicationController
  before_action :set_method, only: [:edit, :show]
  before_action :move_to_index, except: :index

  def index
    @tweets = Tweet.includes(:user).order("created_at DESC")
    @tweet = Tweet.new
    @tweet = TweetsTag.new
  end

  def new
    @tweet = TweetsTag.new
  end


  def create
    @tweet = TweetsTag.new(tweet_params)
    if @tweet.valid?
      @tweet.save
      redirect_to action: :index
    else
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to tweets_path
  end

  def edit
  end

  def update
    tweet = Tweet.find(params[:id])
    tweet.update(tweet_params)
    redirect_to tweets_path
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
    params.require(:tweets_tag).permit(:text, :name).merge(user_id: current_user.id)
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