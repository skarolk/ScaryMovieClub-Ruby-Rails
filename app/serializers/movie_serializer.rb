class MovieSerializer < ActiveModel::Serializer
  attributes :id, :name, :poster, :synopsis, :release, :trailer
  has_many :ratings

  class FavoriteSerializer < ActiveModel::Serializer
    attributes :id, :favorited, :engagement_tier, :user_id
  end
end
