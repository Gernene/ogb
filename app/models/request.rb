class Request < ApplicationRecord
    belongs_to :user
    belongs_to :post
    default_scope -> { order(created_at: :desc) }
    
    before_create :make_pending
    
    validates :user_id, presence: true
    validates :post_id, presence: true
    validates :message, presence: true, length: { maximum: 300 }
    
    private
  
    def make_pending
        self.status = "pending"
    end
end
