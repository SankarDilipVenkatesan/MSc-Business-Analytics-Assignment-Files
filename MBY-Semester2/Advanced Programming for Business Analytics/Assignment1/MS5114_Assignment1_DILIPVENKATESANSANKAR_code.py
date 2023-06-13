###############################################################################
## Module name and Code: Advanced Programming for Business Analytics MS5114  ##
## Student name and ID: DILIP VENKATESAN SANKAR 22225743                     ##
###############################################################################

# Expected knowledge to resolve the assignment:
#  functions
#  strings
#  lists
#  tuples
#  dictionaries
#  conditionals
#  operators


# 1. donuts
# Given an int count of a number of donuts, return a string
# of the form 'Number of donuts: <count>', where <count> is the number
# passed in. However, if the count is 10 or more, then use the word 'many'
# instead of the actual count.
# So donuts(5) returns 'Number of donuts: 5'
# and donuts(23) returns 'Number of donuts: many'
def donuts(count):
    if count>= 10:
        output = "Number of donuts: many"
    else:
        output = "Number of donuts: "+str(count)
    return output


# 2. both_ends
# Given a string s, return a string made of the first 2
# and the last 2 chars of the original string,
# so 'spring' yields 'spng'. However, if the string length
# is less than 2, return instead the empty string.
def both_ends(s):
    if len(s) <2:
        output = ""
    else:
        output_first = s[:2]
        output_last = s[-2:]
        output = output_first+output_last
    return output


# 3. fix_start
# Given a string s, return a string
# where all occurences of its first char have
# been changed to '*', except do not change
# the first char itself.
# e.g. 'babble' yields 'ba**le'
# Assume that the string is length 1 or more.
# Hint: s.replace(stra, strb) returns a version of string s
# where all instances of stra have been replaced by strb.
def fix_start(s):
    char = s[0]
    temp = s.replace(char,'*')
    output = char+temp[1:]
    return output


# 4. MixUp
# Given strings a and b, return a single string with a and b separated
# by a space '<a> <b>', except swap the first 2 chars of each string.
# e.g.
#   'mix', pod' -> 'pox mid'
#   'dog', 'dinner' -> 'dig donner'
# Assume a and b are length 2 or more.
def mix_up(a, b):
    char = a
    a = b[:2] + a[2:]
    b = char[:2] + b[2:]
    output = a+" "+b
    return output


# 5. match_ends
# Given a list of strings, return the count of the number of
# strings where the string length is 2 or more and the first
# and last chars of the string are the same.
# Note: python does not have a ++ operator, but += works.
def match_ends(words):
    count = 0
    for each in words:
        if(len(each) >= 2 and each[0] == each[-1]):
            count += 1
    return count


# 6. front_x
# Given a list of strings, return a list with the strings
# in sorted order, except group all the strings that begin with 'x' first.
# e.g. ['mix', 'xyz', 'apple', 'xanadu', 'aardvark'] yields
# ['xanadu', 'xyz', 'aardvark', 'apple', 'mix']
# Hint: this can be done by making 2 lists and sorting each of them
# before combining them.
def front_x(words):
    empty_list1=[]
    empty_list2=[]
    for each in words:
        if(each[0] == 'x'):
            empty_list1.append(each)
        else:
            empty_list2.append(each)
    empty_list1.sort()
    empty_list2.sort()
    output = empty_list1+empty_list2
    return output


# 7. sort_last
# Given a list of non-empty tuples, return a list sorted in increasing
# order by the last element in each tuple.
# e.g. [(1, 7), (1, 3), (3, 4, 5), (2, 2)] yields
# [(2, 2), (1, 3), (3, 4, 5), (1, 7)]
# Hint: use a custom key= function to extract the last element form each tuple.
def sort_last(tuples):
    tuples.sort(key=lambda x:x[-1])
    return tuples


# 8. front_back
# Consider dividing a string into two halves.
# If the length is even, the front and back halves are the same length.
# If the length is odd, we'll say that the extra char goes in the front half.
# e.g. 'abcde', the front half is 'abc', the back half 'de'.
# Given 2 strings, a and b, return a string of the form
#  a-front + b-front + a-back + b-back
def front_back(a, b):
    if(len(a)%2 == 0):
        a_front=a[0:round(len(a)//2)]
        a_back = a[round(len(a)//2):]
    else:
        a_front=a[0:round(len(a)//2)+1]
        a_back = a[round(len(a)//2)+1:]
    if(len(b)%2 == 0):
        b_front=b[0:round(len(b)//2)]
        b_back = b[round(len(b)//2):]
    else:
        b_front=b[0:round(len(b)//2)+1]
        b_back = b[round(len(b)//2)+1:]   
    output = a_front + b_front + a_back + b_back
    return output


# 9. Given two lists sorted in increasing order, create and return a merged
# list of all the elements in sorted order. You may modify the passed in lists.
# Ideally, the solution should work in "linear" time, making a single
# pass of both lists.
def linear_merge(list1, list2):
    a,b=0,0
    empty_list = [] 
    
    while (a < len(list1) and b < len(list2)):
        if (list1[a] <= list2[b]):
            empty_list.append(list1[a])
            a=a+1
        else:
            empty_list.append(list2[b])
            b=b+1
    if(a <= len(list1) - 1): 
        empty_list.extend(list1[a:])
    else: #b <= len(list2) - 1: check elseif condition
        empty_list.extend(list2[b:])
    return empty_list


# 10.
# Write a function called accept_login(users, username, password) with three parameters:
# users a dictionary of username keys and password values (already created below),
# username a string for a login name and password a string for a password.
# The function should return
# True if the user exists and the password is correct and False otherwise.

users = {
    "user1": "password1",
    "user2": "password2",
    "user3": "password3"
}


def accept_login(users, user, password):
    login = False
    if(user in users and users[user] == password):
        login = True
    else:
        login = False
    return login


# 11.
# Write a function called
# find_value(mydict, val)
# that accepts a dictionary called mydict (already created below) and a variable of any type called
# val. The function should return a list of keys that map to the value val in mydict.
mydict = {
    "day1": "sunny",
    "day2": "rainy",
    "day3": "sunny"
}


def find_value(mydict, val):
    empty_list=[]
    for key,value in mydict.items():
        if(value==val):
            empty_list.append(key)
    return empty_list


# 12. Write a function to invert a dictionary. It should accept a dictionary as a parameter and return a
# dictionary where the keys are
# values from the input dictionary and the values are lists of keys from the input dictionary.
# For example, this input:
# { "key1" : "value1", "key2" : "value2", "key3" : "value1" }
# should return this dictionary:
# { "value1" : ["key1", "key3"], "value2" : ["key2"] }

my_dict = {
    "key1": "value1",
    "key2": "value2",
    "key3": "value1"
}


def invert_dict(my_dict):
    final_dictionary = {}
    for value in my_dict.values():
        if value not in final_dictionary.keys():
            final_dictionary[value] = []
            for key in my_dict.keys():
                if my_dict[key] == value:
                    if key not in final_dictionary[value]: 
                        final_dictionary[value].append(key)
    return final_dictionary


# 13.
# Write a function called word_frequencies(mylist) that accepts a list of strings
# called mylist and returns a dictionary where
# the keys are the words from mylist and the values are the number
# of times that word appears in mylist:
# INPUT
mylist = ['a', 'a', 'a', 'a', 'a', 'b', 'b', 'b', 'b', 'c', 'c', 'c', 'd', 'd', 'e']


# OUTPUT
# {'a': 5, 'b': 4, 'c': 3, 'd': 2, 'e': 1}


def word_frequencies(mylist):
    Dictionary = dict({})
    for each in mylist:
        i=0
        for value in mylist:
            if(each == value):
                i=i+1;
        Dictionary[each] = i
    return Dictionary
