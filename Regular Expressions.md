# SQL Pattern Matching and Regular Expressions

This project showcases SQL queries that use `LIKE`, `REGEXP`, and `REGEXP_*` functions to search, replace, and analyze text in a `customers` table, focusing on the `first_name` column.

---

## SQL Query Examples

### 1. Match First Names Ending with 'k'
```sql
SELECT *
FROM customers
WHERE first_name LIKE '%k';
```
- Finds all customers whose first name ends with the letter 'k'.

### 2. Match First Names Containing 'k' Using REGEXP
```sql
SELECT *
FROM customers
WHERE first_name REGEXP 'k';
```
- Retrieves all customers with 'k' anywhere in their first name using regular expressions.

### 3. Replace 'a' with '-cil-' in First Names
```sql
SELECT first_name, REGEXP_REPLACE(first_name, 'a', '-cil-')
FROM customers;
```
- Substitutes every 'a' in `first_name` with `-cil-`.

### 4. Check if First Name Contains 'a' (Boolean Result)
```sql
SELECT first_name, REGEXP_LIKE(first_name, 'a')
FROM customers;
```
- Returns `TRUE` if 'a' exists in the name, `FALSE` otherwise.

### 5. Find Position of First 'a' in First Name
```sql
SELECT first_name, REGEXP_INSTR(first_name, 'a')
FROM customers;
```
- Returns the position (index) of the first occurrence of 'a' in each first name.

### 6. Extract First Occurrence of 'a' from First Name
```sql
SELECT first_name, REGEXP_SUBSTR(first_name, 'a')
FROM customers;
```
- Extracts and displays the first occurrence of 'a' from each name.

---

## Purpose

These SQL snippets demonstrate:
- Pattern matching (`LIKE`, `REGEXP`)
- String manipulation using regex functions
- Simple text search and analysis in SQL

---

## Notes

- Syntax may vary between databases (e.g., Oracle, MySQL, PostgreSQL).
- Functions such as `REGEXP_LIKE`, `REGEXP_INSTR`, `REGEXP_SUBSTR`, and `REGEXP_REPLACE` are typically supported in Oracle and some other SQL engines.

---

## License

This example is provided for educational purposes. Free to use and modify.
