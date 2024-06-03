class AuthenticationTokenService
  def self.generate(id)
    Digest::SHA256.hexdigest(Rails.application.secret_key_base + id.to_s)
  end
end
