-- Used Claude (AI) as a tutor for explanations and code review. All SQL written by me.


-- Table represents the restaurant's customers.
CREATE TABLE "users" (
                      "id" INTEGER,
                      "name" TEXT NOT NULL,
                      "phone_number" TEXT,
                      PRIMARY KEY("id")
);

-- Represents dishes on the menu, with price in GEL and region of origin

CREATE TABLE "food" (
                      "id" INTEGER,
                      "name" TEXT NOT NULL,
                   "price" REAL NOT NULL CHECK("price" > 0),
                      "region" TEXT NOT NULL,
                      PRIMARY KEY("id")
);

-- Represents one customer visit, with time, rating and payment method
CREATE TABLE "orders" (
                       "id" INTEGER,
                       "user_id" INTEGER NOT NULL,
                       "placed_at" NUMERIC NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       "rating" INTEGER CHECK("rating" BETWEEN 1 AND 5),
                       "payment" TEXT NOT NULL CHECK("payment" IN ('cash', 'BOG', 'TBC')),
                       PRIMARY KEY("id"),
                       FOREIGN KEY("user_id") REFERENCES "users"("id")
);

-- Table 'user ordered food' is for showing each dish in an order with quantity and price at time of order.

CREATE TABLE "user_ordered_food" (
                                  "id" INTEGER,
                                  "food_id" INTEGER NOT NULL,
                                  "order_id" INTEGER NOT NULL,
                                  "quantity" INTEGER NOT NULL CHECK("quantity" > 0),
                                  "price" REAL NOT NULL CHECK("price" > 0),
                                  PRIMARY KEY("id"),
                                  FOREIGN KEY("food_id") REFERENCES "food"("id"),
                                  FOREIGN KEY("order_id") REFERENCES "orders"("id")
);

-- Represents indexes of the id's which are used many times, for not making computer search all by one.

CREATE INDEX "orders_user_index" ON "orders"("user_id");
CREATE INDEX "orders_id" ON "user_ordered_food"("order_id");
CREATE INDEX "food_num" ON "user_ordered_food"("food_id");

-- Represents views of specific data, which are used commonly

CREATE VIEW "rich_client" AS
    SELECT "users"."name", SUM("user_ordered_food"."price" * "user_ordered_food"."quantity") AS "total_spent"
    FROM "users"
    JOIN "orders" ON "orders"."user_id" = "users"."id"
    JOIN "user_ordered_food" ON "user_ordered_food"."order_id" = "orders"."id"
    GROUP BY "users"."id"
    ORDER BY "total_spent" DESC;
