class Post < ApplicationRecord
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  has_many :notices, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def create_favorite_notice(current_user)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ?", current_user.id, user_id, id, 'favorite'])
    if temp.blank?
      notice = current_user.active_notices.new(
        post_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      if notice.visitor_id == notice.visited_id
        notice.cheked = true
      end
      notice.save if notice.valid?
    end
  end
end
