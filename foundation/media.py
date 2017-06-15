
import webbrowser

class Movie():
    """ This class provides a way to store movie related information. """  #use triple quote
    VALID_RATINGS = ["G", "PG", "PG-13", "R"]  # class variable
    # things to remember: -title, storyline, poster_image, youtube_trailer

    def __init__(self, movie_title, movie_storyline, poster_image, youtube_trailer):  # also called instructor
    
        self.title = movie_title         # without self. it is a local variable inside a function 
        self.storyline = movie_storyline # with self.  it is a instance variable
        self.poster_image = poster_image
        self.youtube_trailer = youtube_trailer
        
    # things to do
    def show_trailer(self):
        webbrowser.open(self.youtube_trailer)
        
