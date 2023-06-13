# class MyClass:
#     def __init__(self, some_val):
#         self.some_val = some_val

#     def plus_n(self, n):
#         return n + self.some_val 
        
class DigestiveSystem:
    """This class is already done for you
    don't changea any code on it.
    """
    def process_food(self, food):
        return f'processed-{food}'


class Animal:
    def __init__(self):
        self.digestive_system = DigestiveSystem()

    def has_allergy(self, food):
        if food.lower() in ['peanut', 'milk']:
            return True
        return False

    def eat_food(self, food):
        """
        The 'food' parameter is just a string, such as 'apple', 'pear' or 'peanut'
        """
        if self.has_allergy(food):
            return print(f'Is Allergic to {food}')
        return self.digestive_system.process_food(food)    

class Human(Animal):
    def has_allergy(self, food):
        if food.lower() in ['peanut']:
            return True
        return False

class Child(Human):

    def __init__(self, toy):
        super().__init__()
        self.toy = toy

    def playing_with_toy(self):
        return self.toy
    

########################Testing#############################
# print('Question1 - A')    
# my_instance = MyClass(90)
# assert my_instance.some_val == 90

# print('Question1 - B')
# another_instance = MyClass(100)
# assert another_instance.plus_n(3) == 103

#checking if digestive_system object in Animal class is an instance of DigestiveSystem class
# print('Question2')
#animal = Animal()
# assert isinstance(animal.digestive_system, DigestiveSystem)

# #check if food is alergic
# assert animal.eat_food('Chicken') == "processed-Chicken"
# assert animal.eat_food('peanut') == "processed-peanut", "Allergy"
#assert animal.eat_food('milk') == "processed-milk", "Allergy"


#Human class inherits the properties of Animal class
# human = Human()
# assert isinstance(human, Animal)
# #method over-riding
# #assert human.has_allergy('peanut') == "processed-peanut", "Allergy"
# assert human.has_allergy('milk') == False
# assert human.has_allergy('peanut') == False

child = Child('toy')
# assert isinstance(child, Human)
# assert child.has_allergy('peanut') == True
# assert child.has_allergy('milk') == False


#assert isinstance(child.digestive_system, DigestiveSystem)
assert child.eat_food('peanut') == 'processed-peanut'
assert child.eat_food('Chicken') == "processed-Chicken"