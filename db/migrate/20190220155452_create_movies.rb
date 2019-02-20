class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :name
      t.string :poster
      t.string :synopsis
      t.string :release
      t.string :trailer

      t.timestamps
    end
  end
end
