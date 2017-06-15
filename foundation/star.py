import turtle
import math

def draw_pentagon(x, y, some_turtle, size):
    some_turtle.pencolor("red")
    some_turtle.fillcolor("red")
    some_turtle.begin_fill()
    some_turtle.goto(x,y)
    for i in range(1,6):
        some_turtle.backward(size)
        some_turtle.right(216)
    some_turtle.end_fill()
    some_turtle.right(256)
    some_turtle.circle(size/math.sqrt(3))
    window.exitonclick()



window = turtle.Screen()
window.bgcolor("white")

t = turtle
    
draw_pentagon(0, 0, t, 240)