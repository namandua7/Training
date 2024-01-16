class Blog < ApplicationRecord
    validates :title, :description, presence: true
    mount_uploader :image, ImageUploader
    belongs_to :user
    has_many :comments
    has_many :replies
end
