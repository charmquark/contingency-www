json.array!(@news_posts) do |news_post|
  json.extract! news_post, :id, :title, :member_id, :game_id, :short_body, :long_body
  json.url news_post_url(news_post, format: :json)
end
