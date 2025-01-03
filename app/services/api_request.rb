class ApiRequest
  JSON_HEADER = { "Content-Type" => "application/json" }.freeze

  def self.call(...)
    new(...).call
  end

  def initialize
  end

  def call
    ApiResponse.new(response: request.run)
  end

  private

  attr_reader :params, :body

  def request
    @request ||= Typhoeus::Request.new(
      url,
      method: method,
      params: params,
      body: body,
      headers: JSON_HEADER
    )
  end

  def method
    :get
  end

  def url
    "#{base_url}/#{path}"
  end

  def base_url
    raise NotImplementedError
  end

  def path
    nil
  end

  def body
    {}
  end

  def params
    {}
  end

  def headers
    JSON_HEADER
  end
end
  