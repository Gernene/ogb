class Contact
  include ActiveModel::Model
  attr_accessor :name, :email, :title, :message
  
  validates :title, presence: true, length: { maximum: 50 }
  validates :message, presence: true, length: { maximum: 500 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
                    
  validates :name, presence: true, length: { maximum: 50 }


  # Sends email
  def send_email(name, email, title, message)
    UserMailer.contact_email(name, email, title, message).deliver_now
  end
end