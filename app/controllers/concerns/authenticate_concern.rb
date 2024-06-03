module AuthenticateConcern
  include ActionController::HttpAuthentication::Token

  def authenticate_user
    # Authorization: Bearer <token>
    token, _options = token_and_options(request)
    @student = Student.find_by(id: token)
  end

  def set_header_x_auth_token(id)
    response.headers['X-Auth-Token'] = AuthenticationTokenService.generate(id)
  end
end
