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
  
  def create_comment_notice(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notice_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notice_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end
  
  def save_notice_comment(current_user, comment_id, visited_id)
    notice = current_user.active_notices.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    
    if notice.visitor_id == notice.visited_id
       notice.checked = true
    end
    notice.save if notice.valid?
  end
end
