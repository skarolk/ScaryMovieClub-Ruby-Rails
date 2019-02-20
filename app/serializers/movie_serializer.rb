class MovieSerializer < ActiveModel::Serializer
    attributes :id, :name, :poster, :synopsis, :release
    has_many :ratings

    class RatingSerializer < ActiveModel::Serializer
        attributes :id, :liked, :user_id
    end

end