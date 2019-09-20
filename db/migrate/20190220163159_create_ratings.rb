class CreateRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :movie_id
      t.boolean :favorited
      t.integer :engagement_tier

      t.timestamps
    end
  end
end
