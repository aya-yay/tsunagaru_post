class TweetsTag

  include ActiveModel::Model
  attr_accessor :text, :name, :user_id, :tweet_id, :tag_id

  with_options presence: true do
    validates :text
    validates :name
  end

  delegate :persisted?, to: :tweet

  def initialize(attributes = nil, tweet: Tweet.new)
    @tweet = tweet
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    tweet = Tweet.create(text: text, user_id: user_id)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    TweetTagRelation.create(tweet_id: tweet.id, tag_id: tag.id)
  end

  def update
    return if invalid?

      ActiveRecord::Base.transaction do
        tags = split_tag_names.map { |name| Tag.find_or_create_by!(name: name) }
        @tweet.update!(text: text, tags: tags)
      end
    rescue ActiveRecord::RecordInvalid
      false
  end

  def to_model
    tweet
  end

  private

  attr_reader :tweet

  def default_attributes
    {
      text: tweet.text,
      name: tweet.tags.pluck(:name).join(',')
    }
  end

  def split_tag_names
    name.split(',')
  end

end