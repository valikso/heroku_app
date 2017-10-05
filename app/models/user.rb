class User < ApplicationRecord
#  attr_accessor :password, :password_confirmation
  before_save { self.email = email.downcase }
   before_create :create_remember_token
    before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  def User.new_remember_token
      SecureRandom.urlsafe_base64
    end
    def following?(other_user)
        relationships.find_by(followed_id: other_user.id)
      end
      def feed
          Micropost.from_users_followed_by(self)
        end
      def follow!(other_user)
        relationships.create!(followed_id: other_user.id)
      end

      def unfollow!(other_user)
        relationships.find_by(followed_id: other_user.id).destroy!
      end


    def feed
        # Это предварительное решение. См. полную реализацию в "Following users".
        Micropost.where("user_id = ?", id)
      end

    def User.encrypt(token)
      Digest::SHA1.hexdigest(token.to_s)
    end

    private

      def create_remember_token
        self.remember_token = User.encrypt(User.new_remember_token)
      end
end
