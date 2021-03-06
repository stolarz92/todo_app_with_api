module JsonHelpers
  def json_data
    json['data']
  end

  def json_included
    json['included']
  end

  def json_id
    json_data['id']
  end

  def json_attributes
    json_data['attributes'].keys.each_with_object({}) do |k, hash|
      hash[k.to_s.underscore] = json_data['attributes'][k]
    end
  end

  def json_errors
    json['errors']
  end

  def json_included_ids
    json_included.map { |inc| inc['id'] }
  end

  def json_included_attributes
    json_included.map do |inc|
      inc['attributes'].keys.each_with_object({}) do |k, hash|
        hash[k.to_s.underscore] = inc['attributes'][k]
      end
    end
  end

  def json_meta
    json['meta']
  end

  private

  def json
    JSON.parse(response.body)
  end
end