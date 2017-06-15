

"""
Question 1
Given two strings s and t, determine whether some anagram of t is a substring of s. For example: if s = "udacity" and t = "ad", then the function returns True. Your function definition should look like: question1(s, t) and return a boolean True or False.
"""

# define a helper function to build a dictionary

def build_dict(string):
    
    char_dict = {}
    
    for char in string:
        if char in char_dict:
            char_dict[char] += 1
        else:
            char_dict[char] = 1
            
    return char_dict

def question1(s, t):
    
    t_len = len(t)
    s_len = len(s)
    
    for i in range(s_len - t_len + 1):
        # compare the dictionary
        if build_dict(s[i:i+t_len]) == build_dict(t) :
            
            return True
        
    return False

# test case 1:  
# should return False 
question1('scilent', 'listen') 

# test case 2:  
# should return True  
question1('udacity', 'ad')   

# test case 3:  
# should return True
question1('astronomer', 'moon')

"""
Question 2
Given a string a, find the longest palindromic substring contained in a. Your function definition should look like question2(a), and return a string.
"""
# Manacher's algorithm

def question2(a):
    
    N = len(a)
    if N == 0:
        return
    
    ps = ['#']
    for s in list(a):
        ps.append(s)
        ps.append('#')
    
    N = len(ps)
    L = [0] * N
    
    C = 0     # center position
    R = 0     # center right position

    mirror = 0     # current left position
    maxLPSLength = 0
    maxLPSCenterPosition = 0

  
    for i in range(N):
      
        # get current left position mirror for current right position i
        mirror = 2*C-i

        # If current right position i is within center right position R
        if i < R:
            L[i] = min(L[mirror], R - i)
  
        # Attempt to expand palindrome at the center i
        # we compare characters and if match then increment LPS Length by ONE

        while ((i + 1 + L[i]) < N and ps[ i + (1 + L[i])] == ps[i - (1 + L[i])]):
                L[i]+=1
        
        if L[i] > maxLPSLength:        # Track maxLPSLength
            maxLPSLength = L[i]
            maxLPSCenterPosition = i
  
        # If palindrome centered at current right position i
        # expand beyond center right position R,
        # adjust center position C based on expanded palindrome.
        if i + L[i] > R:
            C = i
            R = i + L[i]
  
    # return LPS 
    start = int((maxLPSCenterPosition - maxLPSLength) / 2)
    end = int(start + maxLPSLength)
    return a[start:end]
    
# test case 1:  
# should return 'abccba'
question2('hcbytgwsabccbaw')

# test case 2:  
# should return 'ggtttttgg'
question2('acgactagctaggggtttttgg')  

# test case 3:  
# should return 'abcdefggfedcba'
question2('acgactagctaggggtttttgg          abcdefggfedcbahitklfhhishsh  ')

"""
### Question 3
Given an undirected graph G, find the minimum spanning tree within G. A minimum spanning tree connects all vertices in a graph with the smallest 
possible total weight of edges. Your function should take in and return an adjacency list structured like this:

{'A': [('B', 2)],
 'B': [('A', 2), ('C', 5)], 
 'C': [('B', 5)]}
Vertices are represented as unique strings. The function definition should be question3(G)
"""
def find(parent, i):
    if parent[i] == i:
        return i
    return find(parent, parent[i])
 
# A function that does union of two sets of x and y
# (uses union by rank)
def union(parent, rank, x, y):
    xroot = find(parent, x)
    yroot = find(parent, y)
 
    # Attach smaller rank tree under root of high rank tree
    # (Union by Rank)
    if rank[xroot] < rank[yroot]:
        parent[xroot] = yroot
    elif rank[xroot] > rank[yroot]:
        parent[yroot] = xroot
        
    # If ranks are same, then make one as root and increment
    # its rank by one
    else :
        parent[yroot] = xroot
        rank[xroot] += 1

def question3(G):
    
    dct = {}
    rank = {}
    parent = {}
    cnt = 0
    
    for k in sorted(G.keys()):
        parent[k] = k
        rank[k] = 0
        
        for tp in G[k]:
            t = tp[0]
            w = tp[1]
            if (t, k) in dct.keys():
                break                
            else:
                # handle None and Empty str value
                if w == None or w == '':
                    cnt += 1
                    break
                else:
                    dct[(k, t)] = w

    edges = []
    for k, w in sorted(dct.items(), key=lambda x: (x[1], x[0])):
        edges.append((k[0], k[1], w))
        
    i = 0
    e = 0 

    mini_spanning_tree = {}
    while e < len(parent) -1 -cnt:
        
        u , v, w = edges[i]
        i += 1
        
        x = find(parent, u)
        y = find(parent, v)
        
        if x != y:
            e += 1
            if u in mini_spanning_tree:
                mini_spanning_tree[u].append((v,w))
            else:
                mini_spanning_tree[u] = [(v, w)]

            union(parent, rank, x, y)
            
    return mini_spanning_tree
    
# test case 1
# return {'A': [('B', 2)], 'B': [('C', 5)]}
G ={'A': [('B', 2)], 'B': [('A', 2), ('C', 5)], 'C': [('B', 5)]}
question3(G) 

# test case 2
# return {'A': [('D', 5), ('B', 10)], 'D': [('C', 4)], 'E': [('B', 15)]}
G ={'A': [('B', 10), ('C', 6), ('D', 5)], 'B': [('A', 10),('E', 15)], 'C': [('A',6),('D', 4)],'D': [('C', 4)], 'E':[('B',15)]}
question3(G) 

# test case 3
# return {'A': [('D', 5), ('C', 6), ('B', 10)], 'D': [('E', 15)]}
G ={'A': [('B', 10), ('C', 6), ('D', 5)], 'B': [('A', 10)], 'C': [('A', 6)], 'D':[('A', 5),('E', 10)], 'E':[('D', 10)]}
question3(G)  

# test case 4
# return {'A': [('D', 5), ('C', 6), ('B', 10)]}
G ={'A': [('B', 10), ('C', 6), ('D', 5)], 'B': [('A', 10)], 'C': [('A', 6)], 'D':[('A', 5),('E', None)], 'E':[('D', None)]}
question3(G)
     
"""
### Question 4
Find the least common ancestor between two nodes on a [binary search tree]. The least common ancestor is the farthest node from the root that 
is an ancestor of both nodes. For example, the root is a common ancestor of all nodes on the tree, but if both nodes are descendents of the root's 
left child, then that left child might be the lowest common ancestor. You can assume that both nodes are in the tree, and the tree itself adheres to
all BST properties. The function definition should look like question4(T, r, n1, n2), where T is the tree represented as a matrix, where the index of
the list is equal to the integer stored in that node and a 1 represents a child node, r is a non-negative integer representing the root, and n1 and n2 
are non-negative integers representing the two nodes in no particular order. For example, one test case might be

question4([[0, 1, 0, 0, 0],
           [0, 0, 0, 0, 0],
           [0, 0, 0, 0, 0],
           [1, 0, 0, 0, 1],
           [0, 0, 0, 0, 0]],
          3,
          1,
          4)
and the answer would be 3.
"""
    
def question4(T, r, n1, n2):
 
    # find the parent of n1 node and save its ancestor in a list
    n1_parent = []
    while T[:,n1].sum() == 1:
        for row in range(len(T)):
            if T[row][n1] == 1:
                n1 = row
                n1_parent.append(n1)

    # find the parent of n2 node and save its ancestor in a list
    n2_parent = []
    while T[:,n2].sum() == 1:
        for row in range(len(T)):
            if T[row][n2] == 1:
                n2 = row
                n2_parent.append(n2)

    for p in n1_parent:
        if p in n2_parent:
            return p
    return None   

# test case 1:  
# should return 3
import numpy as np
x = np.array([[0, 1, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [1, 0, 1, 0], [0, 0, 0, 0]])
question4(x, 3, 1, 2) 

# test case 2:  
# should return 3
import numpy as np
x = np.array([[0, 1, 0, 0, 0], [0, 0, 0, 0, 0], [0, 0, 0, 0, 0], [1, 0, 0, 0, 1], [0, 0, 0, 0, 0]])
question4(x, 3, 1, 4) 

# test case 3:  
# should return 0
import numpy as np
x = np.array([[0, 1, 0, 0, 0, 1], [0, 0, 1, 0, 0, 0], [0, 0, 0, 0, 0, 0], 
              [1, 0, 0, 0, 1, 0], [0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0]])
question4(x, 3, 2, 5)    


"""
### Question 5
Find the element in a singly linked list that's m elements from the end. For example, if a linked list has 5 elements, the 3rd element from 
the end is the 3rd element. The function definition should look like question5(ll, m), where ll is the first node of a linked list and m is 
the "mth number from the end". You should copy/paste the Node class below to use as a representation of a node in the linked list. Return the 
value of the node at that position.

class Node(object):
  def __init__(self, data):
    self.data = data
    self.next = None
"""
## define a node
class Node(object): 
    def __init__(self, data): 
        self.data = data 
        self.next = None

## define a Linked List
class LinkedList:
    def __init__(self, head=None):
        self.head = head

    def append(self, new_node):
        current = self.head
        if self.head:
            while current.next:
                current = current.next
            current.next = new_node
        else:
            self.head = new_node

def question5(ll, m):
    
    node_value_list = []
    
    # loop through the linked list and save each node's value in a list if the first node exists
    if ll: 
        node_value_list.append(ll.data)
        
        current_node = ll
        while current_node.next:
            current_node = current_node.next
            node_value_list.append(current_node.data)
            
    else:
        return None

    # make sure the m less than or equal to the length of the list
    # pop out the last value m times and catch the m th element value and return it        
    if m <= len(node_value_list):
        for i in range(m):
            x =  node_value_list.pop()
        return x
    else:
        return None    
        

## test case 1
## should return 3
# Set up some Elements
nd1 = Node(1)
nd2 = Node(2)
nd3 = Node(3)
nd4 = Node(4)

# Start setting up a LinkedList
lkl = LinkedList(nd1)
lkl.append(nd2)
lkl.append(nd3)
lkl.append(nd4)
ll = nd1

print(question5(ll, 2) )   

## test case 2
## should return 20
# Set up some Elements
nd1 = Node(4)
nd2 = Node(7)
nd3 = Node(8)
nd4 = Node(10)
nd5 = Node(20)
nd6 = Node(30)

# Start setting up a LinkedList
lkl = LinkedList(nd1)
lkl.append(nd2)
lkl.append(nd3)
lkl.append(nd4)
lkl.append(nd5)
lkl.append(nd6)

ll = nd1
print(question5(ll, 2) )     

## test case 3
## should return 4
# Set up some Elements
nd1 = Node(2)
nd2 = Node(4)
nd3 = Node(8)
nd4 = Node(10)
nd5 = Node(20)
nd6 = Node(30)

# Start setting up a LinkedList
lkl = LinkedList(nd1)
lkl.append(nd2)
lkl.append(nd3)
lkl.append(nd4)
lkl.append(nd5)
lkl.append(nd6)

ll = nd1
print(question5(ll,5) )       