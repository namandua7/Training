class AddCommentAndUserReferencesToReplies < ActiveRecord::Migration[7.1]
  def change
    add_reference :replies, :comment, foreign_key: true
    add_reference :replies, :user, foreign_key: true
  end
end
