USE classicmodels;

-- Metadata of the table
DESCRIBE information_schema.columns;

-- Check table presence in database schema
SHOW tables;

-- Check table name conventions
SHOW tables;

-- Check number of columns in a table
SELECT COUNT(*) number_of_columns
FROM information_schema.columns
WHERE table_schema = 'classicmodels'
AND table_name = 'customers';

-- Check column names in a table
SELECT column_name
FROM information_schema.columns
WHERE table_schema = 'classicmodels'
AND table_name = 'customers';

-- Check data type of columns in a table
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'classicmodels'
AND table_name = 'customers';

-- Check size of the columns in a table
SELECT column_name, column_type
FROM information_schema.columns
WHERE table_schema = 'classicmodels'
AND table_name = 'customers';

-- Check nulls fields in a table
SELECT column_name, is_nullable
FROM information_schema.columns
WHERE table_schema = 'classicmodels'
AND table_name = 'customers';

-- Check column keys in a table
SELECT column_name, column_key
FROM information_schema.columns
WHERE table_schema = 'classicmodels'
AND table_name = 'customers';