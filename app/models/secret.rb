class Secret
  Rails.application.credentials[Rails.env.to_sym].keys.each do |key|
    define_singleton_method(key) do
      Rails.application.credentials[Rails.env.to_sym][key]
    end
  end
end
