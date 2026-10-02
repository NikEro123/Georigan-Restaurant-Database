# Georgian Restaurant Database

SQLite database for a Georgian restaurant, built as my final project for **Harvard's CS50: Introduction to Databases with SQL**.

## Video walkthrough

[▶ Watch on YouTube](https://youtu.be/MWy-7hPq8IE)

## Schema

<p align="center">
  <img src="diagram.png" alt="ER diagram" width="400">
</p>

`USER_ORDERED_FOOD` is a junction table resolving the many-to-many relationship between orders and food items.

## Run it

```bash
sqlite3 restaurant.db
```

## Files

- `schema.sql`: table definitions
- `queries.sql`: example queries
- `restaurant.db`: ready-to-use database
- `DESIGN.md`: design document
- `diagram.png`: ER diagram

## Certificate

[CS50 SQL certificate](https://cs50.harvard.edu/certificates/218b5d09-26a2-4001-a7cd-d7f5947af842)
