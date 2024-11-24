class Upload < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true
  validates :image, attached: true, content_type: ['image/png', 'image/jpeg']
end
