###############################################################################
## Title: Individual Assignemnt 2                                            ##
## Module name and Code: Advanced Programming for Business Analytics MS5114  ##
## Student name and ID: DILIP VENKATESAN SANKAR 22225743                     ##
############################################################################### 

# Expected knowledge to resolve the assignment:
#   1. Objected oriented programming in Python
#   2. Classes
#   3. Composition
#   4. Inheritance
#   5. Polymorphism

#####################################################################################################################
#####################################################################################################################

# 1. Implement a class named "MyClass"
# This class should have:
# * During instantiation of this class, the 'some_val' parameter should be set as
#   a variable with the same name in the instance
# * Implement the method called 'plus_n' that takes one parameter (named 'n'), such that
#   it should return the sum of instance's 'some_val' variable and 'n'

class MyClass:
    def __init__(self, some_val):
        #The instance of MyClass has an argument called some_val and assigns it to the instance of the method
        self.some_val = some_val

    def plus_n(self, n):
        #The method takes one arguent called n and returns the sum of self.some_val and n
        return self.some_val + n

#####################################################################################################################
#####################################################################################################################

# 2. Given two classes 'Animal' and 'DigestiveSystem, implement, using COMPOSITION the method 'eat_food' in the 'Animal' class.
# * Animal instances should have a 'diggestive_system' attribute, which is the DigestiveSystem instance of that object.
# * The eat_food method should PROCESS any 'food' (any string) that are not allergenic (use the method 'has_allergy' to check for this case)
# * The DigestiveSystem is a class responsible for the PROCESS of any food eaten,
#       so make use of this in the Animal.eat_food method (remember COMPOSITION!)

class DigestiveSystem:
    """This class is already done for you
    don't changea any code on it.
    """
    def process_food(self, food):
        return f'processed-{food}'


class Animal:
    def __init__(self):
        #Instance of the Animal class will have access to the methods of the DigestiveSystem class through the digestive_system attribute
        self.digestive_system = DigestiveSystem()

    def has_allergy(self, food):
        if food.lower() in ['peanut', 'milk']:
            return True
        return False

    def eat_food(self, food):
        """
        The 'food' parameter is just a string, such as 'apple', 'pear' or 'peanut'
        """
        #Using has_allergy method to check if argument passed is alergic based on the list present in has_alergy method
        #else calls the process food method in DigestiveSystem class using digestive_system method
        if self.has_allergy(food):
            return f'allergy-{food}'
        else:
            return self.digestive_system.process_food(food)


#####################################################################################################################
#####################################################################################################################


# 3. Rewrite the Human class bellow (without changing it's name), so that it inherits from the Animal class of the exercice 2.
# * You should override the 'has_allergy' method in the Human class, so that it now only returns True if the food is 'peanut'

#Human class which inherits the proerties of Animal Class 
class Human(Animal):
    #Method overriding to check has_alergy method to accept only one food as alergic
    def has_allergy(self, food):
        if food.lower() in ['peanut']:
            return True
        return False


#####################################################################################################################
#####################################################################################################################

# 4. Implement the Child class below, which inherets from Human (from exercice 3).
# * Instances of Child need to have a 'toy' attribute (string), which is defined during instantiation
# * This class should also have a 'playing_with_toy' method, which should return the 'toy' (string) that the Child has.
# * Other than that, a Child should behave exactly like a Human instance, so make sure it is inheriting all the logic from its parents '__init__' method

#Child class inherits the properties of Human class and Animal class indirectly through Animal class
class Child(Human):
    def __init__(self, toy):
        self.toy = toy
        super().__init__()

    def playing_with_toy(self):
        return self.toy


#####################################################################################################################
#####################################################################################################################


# 5. Write code in the following __main__ function to test all classes, their attributes and functions.
# * Currently this function includes some examples tests, so you need to extend this code to include all needed tests.
if __name__ == '__main__':

    # Example code for testing
    #Question1 
    my_instance = MyClass(some_val=90)
    assert my_instance.some_val == 90

    another_instance = MyClass(some_val=100)
    assert another_instance.plus_n(3) == 103

    #Question2
    animal_call = Animal()
    assert isinstance(animal_call.digestive_system, DigestiveSystem)

    #check if food is alergic
    #Calling has_allergy method which returns boolean
    assert animal_call.has_allergy('chicken') == False
    assert animal_call.has_allergy('milk') == True

    #peanut and milk are allergic whereas chicken and beans are not allergic
    #Calling eat_food method which return string
    assert animal_call.eat_food('chicken') == "processed-chicken"
    assert animal_call.eat_food('beans') == 'processed-beans'
    assert animal_call.eat_food('peanut') ==  'allergy-peanut'
    assert animal_call.eat_food('milk') == 'allergy-milk'
    
    
    #Question3
    #Checking instance of parent and child class
    human_call = Human()
    assert isinstance(human_call,Animal)

    #Method over-riding so only peanut is allergic
    assert human_call.eat_food('peanut') == 'allergy-peanut'
    assert human_call.eat_food('milk') == 'processed-milk'
    assert human_call.has_allergy('peanut') == True
    assert human_call.has_allergy('Chicken') == False

    #Question4
    #Inheriting all the properties of both Human and Animal class 
    child_call = Child('plane')
    assert isinstance(child_call, Human)
    assert isinstance(child_call, Animal)
    
    assert child_call.eat_food('peanut') == 'allergy-peanut'
    assert child_call.eat_food('Chicken') == 'processed-Chicken'
    assert child_call.has_allergy('milk') == False
    assert child_call.has_allergy('peanut') == True

    print('All my tests passed')