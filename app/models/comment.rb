class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  has_many :notices, dependent: :destroy
end
