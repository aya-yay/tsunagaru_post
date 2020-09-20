class TweetsTag

  include ActiveModel::Model
  attr_accessor :text, :name, :user_id, :tweet_id, :tag_id

  with_options presence: true do
    validates :text
    validates :name
  end

  def save
    tweet = Tweet.create(text: text, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    TweetTagRelation.create(tweet_id: tweet.id, tag_id: tag.id)
  end

end