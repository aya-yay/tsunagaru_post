class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :tweet_tag_relations, dependent: :destroy
  has_many :tags, through: :tweet_tag_relations

  def self.search(search)
    if search != ""
      Tweet.where('text LIKE(?)', "%#{search}%")
    else
      Tweet.all
    end
  end
end
