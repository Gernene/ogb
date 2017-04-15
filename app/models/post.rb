class Post < ApplicationRecord
    belongs_to :user
    belongs_to :category
    has_many :requests
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    validates :title, presence: true
    validates :description, presence: true, length: { maximum: 300 }
    
    def feed
        Request.where("post_id = ?", id)
    end
    
    
    def self.search(search)
        where("title LIKE ? OR description LIKE ?", "%#{search}%", "%#{search}%") 
    end
end
