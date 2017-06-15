import turtle
import math

def draw_square(x, y, some_turtle, size):
	some_turtle.pencolor("blue")
	some_turtle.fillcolor("green")
	some_turtle.begin_fill()
	some_turtle.goto(x,y)
	for i in range(1,4):
		some_turtle.forward(size)
		some_turtle.left(120)
	some_turtle.end_fill()	
	
	some_turtle.fillcolor("white")
	some_turtle.begin_fill()
	some_turtle.goto(size/4 + x,  size/4 * math.sqrt(3) + y)
	for i in range(1,4):
		some_turtle.forward(size/2)
		some_turtle.right(120)
	
	some_turtle.end_fill()	



		
def egg():
	window = turtle.Screen()
	window.bgcolor("red")

	kathleen = turtle
	kathleen.shape("turtle")
	kathleen.color("yellow")
	kathleen.resizemode("user")
	#kathleen.shapesize(5,5,20)
	kathleen.speed(9)
	
	draw_square(-180, -0, kathleen, 360)


	window.exitonclick()

egg()