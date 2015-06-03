json.array!(@games) do |game|
  json.extract! game, :id, :name, :slug, :banner
  json.url game_url(game, format: :json)
end
