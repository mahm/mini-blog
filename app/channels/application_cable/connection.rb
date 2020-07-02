module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      if (verified_user = User.find_by(id: cookie_user_id))
        verified_user
      else
        reject_unauthorized_connection
      end
    end

    def cookie_user_id
      return if cookies.encrypted[Rails.application.config.session_options[:key]].nil?

      cookies.encrypted[Rails.application.config.session_options[:key]]["warden.user.user.key"][0][0]
    end
  end
end
