# -*- coding: utf-8 -*-
"""
Created on Mon Feb 13 18:43:34 2023

@author: DilipVenkatesan
"""
import matplotlib.pyplot as plt
class point:
    def __init__(self,x,y):
        self.x = x
        self.y = y
        
    def plot(self):
        plt.scatter(self.x, self.y)
        
    def __add__(self,other):
        x = self.x+other.x
        y = self.y+other.y
        return point(x,y)
        
point1 = point(1,5)
point2 = point(2,2)
point3 = point1 + point2
point3.plot()

plt.show()