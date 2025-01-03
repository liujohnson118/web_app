class ApiResponse
  def self.call(...)
    new(...).call
  end

  def initialize(response:)
    @response ||= response
  end

  def parsed_response
    JSON.parse(response.response_body) || {}
  end

  def response_code
    response.response_code
  end

  private

  attr_reader :response
end
