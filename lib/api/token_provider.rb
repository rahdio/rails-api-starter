module Api
  class TokenProvider
    def self.encode(payload, exp = 2.days.from_now)
      payload[:exp] = exp.to_i
      [JWT.encode(payload, Rails.application.secrets.secret_key_base), exp]
    end

    def self.decode(token)
      JWT.decode(token, Rails.application.secrets.secret_key_base).first
    rescue
      nil
    end
  end
end
