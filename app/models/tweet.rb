class Tweet < ApplicationRecord
  validates :text, presence: true
  belongs_to :user
  has_many :comments

  has_many :tweet_tag_relations
  has_many :tags, through: :tweet_tag_relations
end
