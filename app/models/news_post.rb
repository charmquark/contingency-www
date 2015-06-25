class NewsPost < ActiveRecord::Base
  belongs_to :member
  belongs_to :game
end
