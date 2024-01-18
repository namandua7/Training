class Blog < ApplicationRecord
    validates :title, :description, presence: true
    mount_uploader :image, ImageUploader
    belongs_to :user
    has_many :comments, dependent: :destroy
    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "description", "id", "id_value", "image", "title", "updated_at", "user_id"]
    end
end
