

class Parent():

    def __init__(self, first_name, eye_color):
        print("Parent Constructor Called.")
        self.eye_color = eye_color
        self.first_name = first_name

    def show_info(self):
        print("first name - "+self.first_name)
        print("Eye color - "+self.eye_color)



class Child(Parent):  # inheritance

    def __init__(self, first_name, eye_color, num_of_toys):
        print("Child Constructor Called.")
        Parent.__init__(self, first_name, eye_color)
        self.num_of_toys = num_of_toys
        
    def show_info(self):  # method overriding
        print("first name - "+self.first_name)
        print("Eye color - "+self.eye_color)
        print("Number of toys - "+str(self.num_of_toys))
# instances        
Taylen = Child("Taylen", "black", 4)
Jianhua = Parent("Jianhua", "black")

print(Jianhua.first_name)
print(Jianhua.eye_color)  
Jianhua.show_info() 

print(Taylen.first_name)
print(Taylen.eye_color)   
print(Taylen.num_of_toys)  
Taylen.show_info() 
              