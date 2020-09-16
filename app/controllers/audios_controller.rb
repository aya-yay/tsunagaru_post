class AudiosController < ApplicationController
  def index  #録音部屋の表示のため  
  end


  # def create
  #   audio = Audio.create(audio_params)
 
  #   @audio = Audio.find(params[:id])
  #   send_file @audio.upload_file_path

  #   redirect_to "/tweets/#{audio.tweet.id}"  # コメントと結びつくツイートの詳細画面に遷移する
  # end


  # private

  # def audio_params
  #   params.require(:audio).permit(:audio_file).merge(user_id: current_user.id, tweet_id: params[:tweet_id], comment_id: params[:comment_id])
  # end


end
