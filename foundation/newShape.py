from turtle import *
import turtle

some_turtle = Turtle()

some_turtle.hideturtle()
some_turtle.speed(0)
some_turtle.pencolor("blue")
window = turtle.Screen()
window.bgcolor("white")

for i in range(350):
    some_turtle.forward(i)
    some_turtle.right(98)
    
window.exitonclick()    