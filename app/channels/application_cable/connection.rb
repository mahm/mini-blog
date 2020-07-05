module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if cookie_user_id.present?
        if (verified_user = User.find_by(id: cookie_user_id))
          return verified_user
        end
      end
      reject_unauthorized_connection
    end

    def cookie_user_id
      return if cookies.encrypted[Rails.application.config.session_options[:key]].nil?

      user_key = cookies.encrypted[Rails.application.config.session_options[:key]]["warden.user.user.key"]
      if user_key.present?
        user_key[0][0]
      end
    end
  end
end
