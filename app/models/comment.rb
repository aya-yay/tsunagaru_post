class Comment < ApplicationRecord
  belongs_to :tweet 
  belongs_to :user 
  has_one_attached :image
  mount_uploader :audio_file, AudioFileUploader
end
