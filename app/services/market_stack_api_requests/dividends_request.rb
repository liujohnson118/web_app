module MarketStackApiRequests
  class DividendsRequest < MarketStackApiRequests::MarketStackApiRequest
    LIMIT = 100
    PATH = "v2/dividends".freeze

    # Initializes a new DividendsRequest object.
    #
    # @param symbols [Array<String>] an array of stock symbols to request dividends for. Default to empty array.
    # @param limit [Integer] the maximum number of results to return. Default to 100.
    # @param offset [Integer] the number of results to skip before starting to collect the result set. Default is 0.
    def initialize(symbols: [], limit: LIMIT, offset: 0)
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
