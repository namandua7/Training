class Blog < ApplicationRecord
    validates :title, :description, presence: true
end
