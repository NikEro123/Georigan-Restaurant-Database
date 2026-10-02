-- Used Claude (AI) as a tutor for explanations and code review. All SQL written by me.


-- Info of users (id, name, phone numbers).

INSERT INTO "users" ("id", "name", "phone_number")
    VALUES (1, 'Nika', '+995568715562'),
           (2, 'Lado', '+995551526842'),
           (3, 'Levani', '+995574685215'),
           (4, 'Avto', '+995595854426'),
           (5, 'Dali', '+995593153234'),
           (6, 'Miriani', '+995595565452'),
           (7, 'Nana', '+995559594456'),
           (8, 'Beso', '+995568125556'),
           (9, 'Luka', '+995595887445'),
           (10, 'Lana', '+995555123543'),
           (11, 'Nana', '+995555665448'),
           (12, 'Jemali', '+995541235856'),
           (13, 'Nuca', '+995597745685'),
           (14, 'Giorgi', '+995551123543'),
           (15, 'Gvanca', '+995593441625'),
           (16, 'Nini', '+995551428762');

-- Info of food  (names, prices, regions).

INSERT INTO "food" ("name", "price", "region")
    VALUES ('Khinkali', 2, 'Tusheti'),
           ('Lobiani', 5, 'Imereti'),
           ('Khachapuri Adjaruli', 10, 'Adjara'),
           ('Khachapuri Megruli', 8, 'Samegrelo'),
           ('Khachapuri Imeruli', 6, 'Imereti'),
           ('Mtsvadi', 15, 'Kakheti'),
           ('Mchadi', 1, 'Samegrelo'),
           ('Ostri', 4, 'Kakheti'),
           ('Souzi', 4, 'Samegrelo'),
           ('Kharcho', 4, 'Samegrelo'),
           ('Gomi', 2, 'Samegrelo'),
           ('Baje', 3, 'Samegrelo'),
           ('Chakhokhbili', 6, 'Samegrelo');

-- Info of orders(rating, payment), connecting to users.

INSERT INTO "orders" ("user_id", "rating", "payment")
    VALUES (1, 4, 'BOG'),
           (2, 5, 'TBC'),
           (3, 4, 'TBC'),
           (4, 4, 'BOG'),
           (5, NULL, 'cash'),
           (6, NULL, 'BOG'),
           (7, 5, 'TBC'),
           (8, NULL, 'BOG'),
           (9, 5, 'cash'),
           (10, 4, 'BOG'),
           (11, NULL, 'cash'),
           (12, 5, 'TBC'),
           (13, 5, 'TBC'),
           (14, NULL, 'cash'),
           (15, 3, 'TBC'),
           (16, NULL, 'BOG');

-- Info of ordered food from users (quantity, price), connecting to food and orders.

INSERT INTO "user_ordered_food" ("food_id", "order_id", "quantity", "price")
    VALUES (1, 1, 99, 2),
           (1, 16, 10, 2),
           (2, 15, 2, 5),
           (3, 14, 1, 10),
           (4, 13, 2, 8),
           (4, 4, 3, 8),
           (5, 12, 1, 6),
           (6, 11, 2, 15),
           (6, 3, 3, 15),
           (7, 2, 3, 1),
           (7, 10, 5, 1),
           (8, 8, 1, 4),
           (8, 5, 1, 4),
           (9, 9, 5, 4),
           (11, 8, 1, 2),
           (10, 10, 3, 4),
           (12, 7, 3, 3),
           (13, 6, 3, 6),
           (10, 2, 2, 4),
           (10, 12, 1, 4),
           (11, 15, 1, 2),
           (11, 13, 2, 2);


-- Mari coming to the restaurant for the first time, so adding her.


INSERT INTO "users" ("name", "phone_number")
    VALUES ('Mari', '+995595884551');

-- Lado added 2 more mchadi.

UPDATE "user_ordered_food"
    SET "quantity" = 5
    WHERE "food_id" = 7 AND "order_id" = 2;

-- Beso canceled his order (ostri).

DELETE FROM "user_ordered_food"
    WHERE "order_id" = 8 AND "food_id" = 8;

-- Mtsvadi's price increased with 2 GEL.

UPDATE "food"
    SET "price" = 17
    WHERE "id" = 6;

-- Giorgi rated his visit with 5 stars.

UPDATE "orders"
    SET "rating" = 5
    WHERE "id" = 14;

-- Dali asked for deleting her phone number.

UPDATE "users"
    SET "phone_number" = NULL
    WHERE "id" = 5;

-- Dishes from Adjara or Samegrelo.

SELECT "name" FROM "food"
    WHERE "region" IN ('Samegrelo', 'Adjara');

-- Showing what Levani ordered.

SELECT  "users"."name", "food"."name", "user_ordered_food"."quantity", "user_ordered_food"."price"
    FROM "users"
    JOIN "orders" ON "orders"."user_id" = "users"."id"
    JOIN "user_ordered_food" ON "user_ordered_food"."order_id" = "orders"."id"
    JOIN "food" ON "food"."id" = "user_ordered_food"."food_id"
    WHERE "users"."name" = 'Levani';

-- Amount of money a restaurant made in total.

SELECT SUM("quantity" * "price") FROM "user_ordered_food";

-- Dish that got sold the most.

SELECT "food"."name", SUM("user_ordered_food"."quantity")
    AS "total_sold"
    FROM "food"
    JOIN "user_ordered_food" ON "user_ordered_food"."food_id" = "food"."id"
    GROUP BY "food"."name"
    ORDER BY "total_sold" DESC
    LIMIT 1;

-- Money paid by each payment method (BOG, TBC, cash).

SELECT "orders"."payment", SUM("user_ordered_food"."quantity" * "user_ordered_food"."price") AS "total"
    FROM "orders"
    JOIN "user_ordered_food" ON "user_ordered_food"."order_id" = "orders"."id"
    GROUP BY "orders"."payment";

-- The average rating.

SELECT AVG("rating") FROM "orders";

-- Customers who have never ordered yet.

SELECT "name" FROM "users"
    WHERE "id" NOT IN (
        SELECT "user_id"
            FROM "orders"
    );

-- The best customers (showing view).

SELECT * FROM "rich_client";

