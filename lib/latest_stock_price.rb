class LatestStockPrice
  include HTTParty
  base_uri 'https://latest-stock-price.p.rapidapi.com'

  def initialize(payload = {})
    @is_retry_failed = payload[:is_retry_failed] || true
  end

  def price(payload = {})
    url = "/#{payload[:path]}"
    default_query = {}
    default_header = {
      'Content-Type': 'application/json', 'Accept': 'application/json',
      'X-RapidAPI-Host': 'latest-stock-price.p.rapidapi.com',
      'X-RapidAPI-Key': '5dfa63fc8fmshd2f5eacec642eedp197ca5jsn1613c7cdb9cc',
    }

    begin
      url = URI.parse(url)
    rescue URI::InvalidURIError
      url = URI.parse(URI.escape(url))
    end

    begin
      response = self.class.get(
        url,
        query: default_query.merge(payload[:query] || {}),
        headers: default_header.merge(payload[:headers] || {})
      )
    rescue Timeout::Error, OpenSSL::SSL::SSLError, SocketError
      response = nil
      retry if @is_retry_failed
    end

    response
  end

end
