json.array!(@definitions) do |definition|
  json.extract! definition, :id
  json.url definition_url(definition, format: :json)
end
