class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :blog
    has_many :replies, dependent: :destroy
end
