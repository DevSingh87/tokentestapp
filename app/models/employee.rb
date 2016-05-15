class Employee < ActiveRecord::Base
	   validates :email, presence: true
	   validates :phone_number, presence: true, numericality: true

	   before_create :verification_email_phone_number_token
	   #after_save :check_updates_on_email_phone_number

		def email_activate
		    self.email_phone_number_verified = true
		    save!
		end

		def email_deactivate
		    self.email_phone_number_verified = false
		    save!
		end


		private
		def verification_email_phone_number_token
		      if self.verify_token.blank?
		         self.verify_token = SecureRandom.urlsafe_base64.to_s
		      end
	    end

	   # def check_updates_on_email_phone_number
	    	#if self.email_changed? || self.phone_number_changed?
	    	#	self.email_phone_number_verified = true
	    	#	self.verify_token = nil
		   # #    save!
	    #	end
	   # end
end
