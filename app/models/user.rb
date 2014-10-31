class User < ActiveRecord::Base
	attr_reader :password

	# called only when you try to #save/create or #valid? 
	validates :email, presence: true, uniqueness: true
	validates :password_digest, presence: { message: "Password can't be blank" }
	validates :session_token, presence: true, uniqueness: true
	validates :password, length: { minimum: 6, allow_nil: true }

	# called after User.new but before @user.save!
	after_initialize :ensure_session_token

	has_many(
		:notes,
		class_name: "Note",
		foreign_key: :user_id,
		primary_key: :id
	)

	def self.find_by_credentials(user_email, user_password)
		found_user = self.find_by_email(user_email)
		if found_user.nil?
			# errors[:request] = "No such e-mail found!"
			return nil
		else
			if found_user.is_password?(user_password)
				return found_user
			else
				# errors[:request] = "Incorrect password!"
				return nil
			end
		end
	end

	def self.generate_session_token
		SecureRandom::urlsafe_base64(16)
	end

	def password=(set_password)
		@password = set_password
		self.password_digest = BCrypt::Password.create(set_password)	
	end

	def is_password?(password)
    	BCrypt::Password.new(self.password_digest).is_password?(password)
  	end
  

	def reset_session_token!
		self.session_token = self.class.generate_session_token
		self.save!

		self.session_token
	end


	private
		def ensure_session_token
			self.session_token ||= self.class.generate_session_token
		end
end
