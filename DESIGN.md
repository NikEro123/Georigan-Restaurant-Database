# Design Document

By NIKA KVIRKVAIA

Video overview: <https://youtu.be/MWy-7hPq8IE?si=9R1pW0kZYOyNcQW3>


## Scope

* What is the purpose of your database?
  - Database is used by the owner or cashier of a small Georgian restaurant. They can record customers, the menu, visits and the ordered food in each visit.


* Which people, places, things, etc. are you including in the scope of your database?
 - Users table includes their name and phone number (optional). Food table includes Georgian dishes with price (GEL) and region of origin. Orders table includes one visit, with time, optional rating and payment method. user_ordered_food table includes dishes, their quantities and their prices.

* Which people, places, things, etc. are *outside* the scope of your database?
  - There are some things that are outside of my database. For example, staff, because database wouldn't be able to say which waiter served in order. Reservations, because a database can't know which tables are booked. Card details, because it would be easier to get leaked the details of loyal customers. Drinks, well, because restaurant is new and they are waiting for distribution to deliver.


## Functional Requirements

* What should a user be able to do with your database?
 - User of my database can  find the most popular dish, the customer who has paid the most, average ratings, restaurant revenue. Also can add new customers, change the quantity of a dish in an order, canceling or adding dishes, increasing or decreasing prices, deleting data from any optional information.

* What's beyond the scope of what a user should be able to do with your database?
 - User cannot find the data of card details, drinks, staff, reservations. They cannot enter invalid or incomplete data. They cannot search for customers' addresses, surnames, families. The user cannot record a rating for a single dish or payments other than cash, BOG or TBC (Georgian bank names).



## Representation

### Entities

* Which entities will you choose to represent in your database?
 - My database has 4 entities:
 - users - for showing customers and their phone numbers of the restaurant,
 - food - for showing the restaurant food, their prices and regions,
 - orders - for showing customer ratings and payments,
 - user_ordered_food - for showing quantity of served dishes and prices, which are paid by customer.

* What attributes will those entities have?
 - users: id, name, phone_number.
 - food: id, name, price, region.
 - orders: id, user_id, placed_at, rating, payment.
 - user_ordered_food: id, food_id, order_id, quantity, price.

* Why did you choose the types you did?
 - I chose INTEGER for ids, quantity and rating, because they keep whole numbers as info.
 - I chose TEXT for name, region, payment, phone_number, because their information are saved as texts. For example, text that is written by letter or phone number, on which I am not able to do math.
 - I chose REAL for both price columns, because they hold the info of numbers in decimal points.
 - I chose NUMERIC for placed_at, because it works with DEFAULT CURRENT_TIMESTAMP.

* Why did you choose the constraints you did?
 - I chose PRIMARY KEY for every id, because of making the ids unique for connecting the table information to another table.
 - I chose FOREIGN KEY for user_id, order_id, food_id, for connecting tables to each other, because an order must belong to a real customer, and an item must point to a real dish and order.
 - I chose NOT NULL for names, prices, region, payment, quantity, food_id, for not leaving important information blank.
 - I chose CHECK for food.price, user_ordered_food.price, user_ordered_food.quantity, orders.rating, orders.payment for blocking the data I did not want the database to save.
 - I chose DEFAULT CURRENT_TIMESTAMP for placed_at for giving the entity current time, if the column is empty.
 - I chose phone_number to have no NOT NULL, for customers being able to ask for deleting their personal data, such as phone number.
 - I chose rating not to have NOT NULL, because not every customer leaves a rating.
 - I chose name not to be unique, because there are many customers with same names.
 - I chose user_ordered_food and food entities to have their own price, for not mistaking the current price and the customer's paid price while updating the current price.


### Relationships

![ER Diagram](diagram.png)

 - A customer can have zero to many orders. One order belongs to exactly one customer.
 - An order can contain one to many dishes. An order can not have zero dishes.
 - A dish can appear in zero to many orders. A dish can have zero orders.


## Optimizations

* Which optimizations (e.g., indexes, views) did you create? Why?

 - Without an index, SQLite has to check each row one by one. With an index, it looks straight to the matching rows. However, indexes have a cost. They take extra space and make every insert a little slower.
 - I created orders_user_index for being the foreign key, so it is one of the most used in queries. With the same idea, I created orders_id and food_num indexes.
 - I created rich_client view for showing customers ranked by how much they spent. I made a view instead of table because view is recalculated every time it is used, so the totals are always up to date, even after a price change or a canceled order.


## Limitations

* What are the limitations of your design?
 - Payment is limited to cash, BOG or TBC, so customer who pays with anything else, can not be recorded.
 - Prices use REAL, so they can have tiny rounding errors. I could keep storing prices as whole tetri in an INTEGER, but i preferred in GEL.
 - placed_at uses CURRENT_TIMESTAMP, which is in UTC time, and it is 4 hours behind Tbilisi.

* What might your database not be able to represent very well?
 - The database does not store which dishes are ordered together. Combinations like baje and gomi can only be guessed from past orders.
 - The database can not store reservations, so it can not show which tables are booked.
