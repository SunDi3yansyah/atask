module RequestSpecHelper
  def json
    @json ||= JSON.parse(response.body)
  end

  def json_payload(payload)
    @json_payload ||= JSON.parse(payload.to_json)
  end

  def without_jwt_headers
    {
      'Content-Type': 'application/json'
    }
  end
end
