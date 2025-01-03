module MarketStackApiRequests
  class DividendsRequest < MarketStackApiRequests::MarketStackApiRequest
    LIMIT = 0
    PATH = "v2/dividends".freeze

    def initialize(symbols: [], limit: 0, offset: 0)
      @symbols ||= Array.wrap(symbols)
      @limit ||= limit
      @offset ||= offset
    end

    private

    attr_reader :symbols, :limit, :offset

    def base_url
      MARKET_STACK_BASE_URL
    end

    def path
      PATH
    end

    def params
      super.merge(dividend_params)
    end

    def dividend_params
      {
        symbols: symbols.join(","),
        limit: limit,
        offset: offset
      }
    end
  end
end
