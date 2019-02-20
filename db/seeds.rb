# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "creating movies"

def page_check()
  page_count = Tmdb::Genre.movies(27).total_pages - 1
  return page_count
end

def create_movies()
  page_number = 1
  posterUrl = "https://image.tmdb.org/t/p/w780"
  youtubeUrl = "https://www.youtube.com/watch?v="
  total_pages = page_check()
  while page_number < 60
    movies = Tmdb::Genre.movies(27, page: page_number)
    i = 0
    while i < 20
      if Movie.exists?(:synopsis => movies.results[i].overview)
        i += 1
      elsif (movies.results[i].original_language == "en") && (movies.results[i].adult == false) && (movies.results[i].poster_path != nil)
        movie_name = movies.results[i].original_title
        movie_summary = movies.results[i].overview
        movie_poster = posterUrl + movies.results[i].poster_path
        movie_release = movies.results[i].release_date
        movie_original_id = movies.results[i].id
        # movie_trailer = youtubeUrl + Tmdb::Movie.videos(movies.results[i].id).last.key
        Movie.create(name: movie_name, poster: movie_poster, synopsis: movie_summary, release: movie_release, originalid: movie_original_id)
        i += 1
        puts "creating #{movie_name}"
      else
        i += 1
      end
    end
    if page_number % 30 == 0
      puts "on #{page_number} of #{total_pages}"
      puts "waiting ..."
      sleep(30)
    end
    page_number += 1
  end
end

create_movies()

# puts "beging seeding test data"

# puts "seeding movies"
# Movie.create(name: "Friday the 13th", poster: "posterurl", synopsis: "scary stuff")
# Movie.create(name: "The Conjuring", poster: "posterurl", synopsis: "really scary stuff")
# Movie.create(name: "The Nun", poster: "posterurl", synopsis: "very scary stuff")
# Movie.create(name: "The Ring", poster: "posterurl", synopsis: "funny scary stuff")

# puts "seeding clubs"
# Club.create(movie_id: 54, active: true)
# Club.create(movie_id: 2, active: true)
# Club.create(movie_id: 3, active: true)
# Club.create(movie_id: 4, active: false)
# Club.create(movie_id: 62, active: true)

# puts "seeding users"
# User.create(username: "Seb", email: "seb@seb", password: "secure", matched: true, club_id: 1, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Chris", email: "chris@chris", password: "secure", matched: true, club_id: 1, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Sabrina", email: "sabrina@sabrina", password: "secure", matched: true, club_id: 1, image: "https://i.imgur.com/RTdi6B1.png")

# User.create(username: "Sasha", email: "sasha@sasha", password: "secure", matched: true, club_id: 2, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "ChiChi", email: "chichi@chichi", password: "secure", matched: true, club_id: 2, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Dude", email: "dude@dude", password: "secure", matched: true, club_id: 2, image: "https://i.imgur.com/RTdi6B1.png")

# User.create(username: "Bentley", email: "bentley@bentley", password: "secure", matched: true, club_id: 5, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Spencer", email: "spencer@spencer", password: "secure", matched: true, club_id: 5, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Tom", email: "tom@tom", password: "secure", matched: true, club_id: 5, image: "https://i.imgur.com/RTdi6B1.png")

# User.create(username: "Bozena", email: "bozena@bozena", password: "secure", matched: false, club_id: 5, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Nicole", email: "nicole@nicole", password: "secure", matched: false, club_id: 5, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Al", email: "al@al", password: "secure", matched: false, club_id: 5, image: "https://i.imgur.com/RTdi6B1.png")

# User.create(username: "Leszek", email: "leszek@leszek", password: "secure", matched: true, club_id: 1, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Baby", email: "baby@baby", password: "secure", matched: true, club_id: 1, image: "https://i.imgur.com/RTdi6B1.png")
# User.create(username: "Panther", email: "panther@panther", password: "secure", matched: true, club_id: 1, image: "https://i.imgur.com/RTdi6B1.png")

# puts "seeding ratings"
# Rating.create(user_id: 1, liked: true, movie_id: 1)
# Rating.create(user_id: 1, liked: true, movie_id: 2)
# Rating.create(user_id: 2, liked: false, movie_id: 1)
# Rating.create(user_id: 3, liked: false, movie_id: 1)

# Rating.create(user_id: 4, liked: true, movie_id: 2)
# Rating.create(user_id: 4, liked: true, movie_id: 3)
# Rating.create(user_id: 5, liked: false, movie_id: 2)
# Rating.create(user_id: 6, liked: false, movie_id: 2)

# Rating.create(user_id: 7, liked: true, movie_id: 3)
# Rating.create(user_id: 8, liked: false, movie_id: 3)
# Rating.create(user_id: 9, liked: false, movie_id: 3)

# Rating.create(user_id: 10, liked: true, movie_id: 4)
# Rating.create(user_id: 11, liked: false, movie_id: 4)
# Rating.create(user_id: 12, liked: false, movie_id: 4)

# Rating.create(user_id: 13, liked: true, movie_id: 1)
# Rating.create(user_id: 14, liked: false, movie_id: 1)
# Rating.create(user_id: 15, liked: false, movie_id: 1)

puts "movies created"

# puts "Reminder: this is only test data"