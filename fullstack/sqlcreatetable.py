

import sqllite3
conn = sqllite3.connect('restaurantmenu.db')


c = conn.cursor()

c.execute('''
    CREATE TABLE restaurant
    (id INTEGER PRIMARY KEY ASC, name VARCHAR(250) NOT NULL)
    ''')
    
c.execute('''
    CREATE TABLE menu_item
    (id INTEGER PRIMARY KEY ASC, name VARCHAR(250), price VARCHAR(250),
    description VARCHAR(250) NOT NULL,  restaurant_id INTERGER NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurant(id))   
    ''')    
    
conn.commit()
conn.close()    