import turtle
class polygon:
    def __init__(self,sides,name,size,color="Blue"):
        self.sides = sides
        self.name = name
        self.size = size
        self.color = color
        self.interior = (self.sides-2)*180
        self.angle = self.interior/self.sides
        
    def draw(self):
        turtle.color(self.color)
        for each in range(self.sides):
           turtle.forward(self.size)
           turtle.right(180-self.angle)
        
    
class Sqaure(polygon):
    def __init__(self,size=100,color="Red"):
        super().__init__(4, "Sqaure",size,color)
        
    def draw(self):
        turtle.begin_fill()
        super().draw()
        turtle.end_fill()
        
#sqaure = polygon(4, 'Square',100,"red")
#pentagon = polygon(5, 'Pentagon',100)
#hexagon = polygon(6, "Hexagon",100,color = "red")

#sqaure.draw()   
#hexagon.draw()

sqaure = Sqaure(color="red",size=200)
#print(sqaure.sides)

sqaure.draw()


turtle.done()