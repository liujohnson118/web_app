class SamlSessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token, raise: false

  def new
    request = OneLogin::RubySaml::Authrequest.new
    action = request.create(saml_config)
    redirect_to action, allow_other_host: true
  end

  def metadata
    meta = OneLogin::RubySaml::Metadata.new
    render xml: meta.generate(saml_config)
  end

  def create
    saml_response = OneLogin::RubySaml::Response.new(params[:SAMLResponse], settings: saml_config)
    if saml_response.is_valid? && email = saml_response.nameid
      if user = User.find_by_email(email)
        sign_in user
      else
        sign_in User.create(email: email, password: SecureRandom.base58(24))
      end
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    logout_request = OneLogin::RubySaml::Logoutrequest.new

    if saml_config.name_identifier_value.nil?
      saml_config.name_identifier_value = current_user.email
    end

    sign_out current_user
    relayState = url_for(controller: "welcome", action: "index")
    redirect_to logout_request.create(saml_config, RelayState: relayState), allow_other_host: true
  end

  private

  def saml_config
    @saml_config ||= IdpSettingsAdapter.call
  end
end
