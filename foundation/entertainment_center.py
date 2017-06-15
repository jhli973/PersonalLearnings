
import media
import fresh_tomatoes

toy_story = media.Movie("Toy Story",
                        "A story of a boy and his toys that come to life.",
                        'https://upload.wikimedia.org/wikipedia/en/thumb/1/13/Toy_Story.jpg/220px-Toy_Story.jpg',
                        'https://www.youtube.com/watch?v=cywMybbnXt0')
                        

hunger_games = media.Movie("Hunger Games",
                           "A really real reality show",
                           "https://upload.wikimedia.org/wikipedia/en/3/39/The_Hunger_Games_cover.jpg",
                           "https://www.youtube.com/watch?v=NDqc0HOGoVM")                        
                        
movies = [toy_story, hunger_games]

#fresh_tomatoes.open_movies_page(movies)

print(media.Movie.VALID_RATINGS)
print(toy_story.VALID_RATINGS)

# predefined class variables
print(media.Movie.__doc__)
print(media.Movie.__name__)
print(media.Movie.__module__)