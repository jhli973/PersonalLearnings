import turtle
import math

def draw_pentagon(x, y, some_turtle, size):
	some_turtle.pencolor("blue")
	some_turtle.fillcolor("green")
	some_turtle.begin_fill()
	some_turtle.goto(x,y)
	for i in range(1,6):
		some_turtle.forward(size)
		some_turtle.left(72)
	some_turtle.end_fill()	
	window.exitonclick()


"""		
def egg():
	window = turtle.Screen()
	window.bgcolor("red")

	kathleen = turtle
	kathleen.shape("turtle")
	kathleen.color("yellow")
	kathleen.resizemode("user")
	#kathleen.shapesize(5,5,20)
	kathleen.speed(9)
	
	draw_star(0, 0, kathleen, 100)
    window.exitonclick()
"""
	
window = turtle.Screen()
window.bgcolor("red")

t = turtle
    
draw_pentagon(0, 0, t, 120)