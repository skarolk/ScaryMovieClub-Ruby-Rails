require 'nokogiri'
require 'httparty'
require 'byebug'

puts "creating movies"

# IMDB Scraper Tool

def scraper
  # Nokogiri prepping page for scraping
  url = 'https://www.imdb.com/search/title/?title_type=movie&genres=horror&sort=release_date,asc&explore=title_type,genres'
  unparsed_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(unparsed_page)
  movie_list = parsed_page.css('div.lister-item-content')

  # Array of scraped movies
  movies = Array.new 
  # Grabbing movie info
  movie_list.each do |movie_listing|
    # Attributes: name, poster, synopsis, release, trailer
    movie_synopsis = movie_listing.css('p.text-muted')[1].text
    movie_title = movie_listing.css('a')[0].text

    # Format synopsis
    def format_synopsis(synopsis)
      if synopsis[0] == "\n" && synopsis[-1] == "\n"
        movie_synopsis = synopsis[5..-36]
      elsif synopsis[0] == "\n"
        movie_synopsis = synopsis[5..-1]
      else
        movie_synopsis = synopsis
      end
    end

    movie = { #hash of each movie
      name: movie_title, 
      synopsis: format_synopsis(movie_synopsis),
      release: movie_listing.css('span.lister-item-year').text,
      # trailer: ,
      # page_url: "https://sworkit.com" + movie_listing.css('a')[0].attributes["href"].value
    }
    byebug
    movies << movie 
  end 
  # index = 0 
  # exercises.each do |each_exercise|
  #     ex_unparsed_page = HTTParty.get(each_exercise[:page_url])
  #     ex_parsed_page = Nokogiri::HTML(ex_unparsed_page)
  #     exercise_details = ex_parsed_page.css('div.shadow.card.exercise-card')
  #     exercise = {
  #         exercise_difficulty: exercise_details.css('p')[0] ? exercise_details.css('p')[0].text : "no information",
  #         exercise_impact_level: exercise_details.css('p')[1] ? exercise_details.css('p')[1].text : "no information",
  #         target_body_parts: exercise_details.css('p')[2] ? exercise_details.css('p')[2].text : "no information",
  #         exercise_video: exercise_details.css('video')[0] ? exercise_details.css('video')[0].attributes['src'].value : "no video"
  #     }
  #     exercises[index].merge!(exercise)
  #     # byebug
  #     Exercise.create(exercises[index])
  #     # puts each_exercise
  #     puts "#{index + 1}: creating #{each_exercise[:exercise_name]}"
  #     index += 1
  #     # byebug
  # end 
end 

scraper()

#  TMDB API

# def page_check()
#   page_count = Tmdb::Genre.movies(27).total_pages - 1
#   return page_count
# end

# def create_movies()
#   page_number = 1
#   posterUrl = "https://image.tmdb.org/t/p/w780"
#   youtubeUrl = "https://www.youtube.com/results?search_query="
#   total_pages = page_check()
#   current_year = Time.now.strftime("%Y-%m-%d").slice(0..3).to_i
  
#   while page_number < page_check()
#     movies = Tmdb::Genre.movies(27, page: page_number)
#     i = 0
#     while i < 20
#       if Movie.exists?(:synopsis => movies.results[i].overview)
#         i += 1
#       elsif (movies.results[i].original_language == "en") && (movies.results[i].adult == false) && (movies.results[i].poster_path != nil) && (movies.results[i].release_date.slice(0..3).to_i < current_year) && (movies.results[i].original_title != nil)     
#         movie_name = movies.results[i].original_title
#         movie_summary = movies.results[i].overview
#         movie_poster = posterUrl + movies.results[i].poster_path
#         movie_release = movies.results[i].release_date
#         movie_original_id = movies.results[i].id
#         # TMDB trailers
#         # movie_trailer = youtubeUrl + Tmdb::Movie.videos(movies.results[i].id).last.key

#         # Youtube Search
#         formatted_name = movie_name.tr_s(' ', '+') + "+trailer"
#         movie_trailer = youtubeUrl + formatted_name
#         Movie.create(name: movie_name, poster: movie_poster, synopsis: movie_summary, release: movie_release, trailer: movie_trailer)
#         i += 1
#         puts "creating #{movie_name}"
#       else
#         i += 1
#       end
#     end
#     if page_number % 10 == 0
#       puts "on #{page_number} of #{total_pages}"
#       puts "waiting ..."
#       sleep(30)
#     end
#     page_number += 1
#   end
# end

# create_movies()

puts "movies created"