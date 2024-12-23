class IdpSettingsAdapter
  def self.call(...)
    settings = OneLogin::RubySaml::Settings.new
    settings.assertion_consumer_service_url = Secret.assertion_consumer_service_url
    settings.sp_entity_id                   = Secret.sp_entity_id
    settings.idp_sso_service_url            = Secret.idp_sso_service_url
    settings.idp_sso_service_binding        = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" # or :post, :redirect
    settings.idp_slo_service_url            = Secret.idp_slo_service_url
    settings.idp_slo_service_binding        = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" # or :post, :redirect
    settings.idp_cert_fingerprint           = Secret.idp_cert_fingerprint
    settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2000/09/xmldsig#sha1"
    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
    settings.idp_entity_id                  = Secret.idp_entity_id

    # Optional for most SAML IdPs
    settings.authn_context = "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport"
    # or as an array
    settings.authn_context = [
      "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport",
      "urn:oasis:names:tc:SAML:2.0:ac:classes:Password"
    ]

    # Optional bindings (defaults to Redirect for logout POST for ACS)
    settings.single_logout_service_binding      = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" # or :post, :redirect
    settings.assertion_consumer_service_binding = "urn:oasis:names:tc:SAML:2.0:bindings:HTTP-POST" # or :post, :redirect

    settings
  end
end
