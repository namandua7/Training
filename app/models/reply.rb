class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :comment
  belongs_to :blog
end
