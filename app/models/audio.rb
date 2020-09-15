class Audio < ApplicationRecord
  mount_uploader :file, AudioFileUploader

  validates :title, presence: true
  validates :file, presence: true
end
