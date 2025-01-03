module MarketStackApiRequests
  class MarketStackApiRequest < ApiRequest
    MARKET_STACK_BASE_URL = "http://api.marketstack.com".freeze

    private

    def base_url
      MARKET_STACK_BASE_URL
    end

    def params
      {
        access_key: Secret.market_stack_api_key
      }
    end
  end
end
