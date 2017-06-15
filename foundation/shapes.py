import turtle
import winsound

def draw_square(some_turtle):
	for i in range(1,5):
		some_turtle.forward(200)
		some_turtle.right(90)

def begin_music():

	winsound.PlaySound("angry.wav", winsound.SND_ALIAS)
	
def stop_music():

	winsound.PlaySound(None, winsound.SND_ALIAS)	
		
def egg():
	window = turtle.Screen()
	window.bgcolor("red")

	kathleen = turtle
	kathleen.shape("turtle")
	kathleen.color("yellow")
	kathleen.resizemode("user")
	#kathleen.shapesize(5,5,20)
	kathleen.speed(2)
	
	for i in range(36):
		draw_square(kathleen)
		kathleen.right(10)
	stop_music()
	#$taylen = turtle.Turtle()
	#taylen.shape("arrow")
	#taylen.circle(100)

	window.exitonclick()

begin_music()	
egg()