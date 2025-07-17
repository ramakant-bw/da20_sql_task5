
-- Creating ENUM types

CREATE TYPE account_type_enum AS ENUM ('Saving', 'Current');
CREATE TYPE transaction_type_enum AS ENUM ('Credit', 'Debit');
CREATE TYPE feature_type_enum AS ENUM ('Loan', 'FD', 'Insurance', 'Credit Card', 'Locker', 'Overdraft');

-----------------------------------------------------------------------------------------------------------------------------------------------


-- Bank table (100 entries)

CREATE TABLE bank (
    bank_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    branch VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    ifsc_code VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone BIGINT(15) UNIQUE NOT NULL,
    funds DECIMAL(15,2) DEFAULT 0.00
);

Insert into bank (name, branch, address, ifsc_code, email, phone, funds) values
('HDFC Bank','Chandigarh Branch 2','Chandigarh Branch 2, Chandigarh, India','HDFC3607','chandigarhbranch2@hdfcbank.com',9229683850,69491816.08);

Copy bank from 'D:\DA20\SQL\Sql_task\da20_sql_task05\bank_table.csv' DELIMITER ',' CSV HEADER;
-----------------------------------------------------------------------------------------------------------------------------------------------


-- Employee table (2000 entries)

CREATE TABLE employee (
    employee_id SERIAL PRIMARY KEY,
    bank_id INT REFERENCES bank(bank_id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    position VARCHAR(50) NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    phone BIGINT UNIQUE NOT NULL
);

Insert Into employee (employee_id, bank_id, first_name, last_name, position, salary, phone) VALUES (1,47,'Rajesh','Mehta','Clerk',53372.65,9689579843);

Copy employee from 'D:\DA20\SQL\Sql_task\da20_sql_task05\employee_table.csv' DELIMITER ',' CSV HEADER;

-----------------------------------------------------------------------------------------------------------------------------------------------


-- Customer table (8000 entries)

CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
    bank_id INT REFERENCES bank(bank_id) ON DELETE CASCADE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    account_no VARCHAR(20) UNIQUE NOT NULL,
    account_type account_type_enum NOT NULL,
    phone BIGINT(15) UNIQUE NOT NULL
);

Insert Into customer Values (1,1,'Vijay','Nair',2883978319,'Saving',9114126381);

Copy customer from 'D:\DA20\SQL\Sql_task\da20_sql_task05\customer_table.csv' DELIMITER ',' CSV HEADER;

-----------------------------------------------------------------------------------------------------------------------------------------------


-- Transaction table (10000 entries)

CREATE TABLE transaction (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id) ON DELETE CASCADE,
    amount DECIMAL(12,2) NOT NULL,
    transaction_type transaction_type_enum NOT NULL,
    transaction_date DATE NOT NULL,
    mode_of_transaction VARCHAR(30) NOT NULL
);

Insert Into transaction Values (1,1,94584.41,'Debit','2023-04-18','Debit Card');

Copy transaction from 'D:\DA20\SQL\Sql_task\da20_sql_task05\transaction_table.csv' DELIMITER ',' CSV HEADER;

-----------------------------------------------------------------------------------------------------------------------------------------------


-- Account Opening table (2000 entries)

CREATE TABLE account_opening (
    account_opening_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id) ON DELETE CASCADE,
    employee_id INT REFERENCES employee(employee_id) ON DELETE CASCADE,
    bank_id INT REFERENCES bank(bank_id) ON DELETE CASCADE,
    opening_date DATE NOT NULL,
    account_type account_type_enum NOT NULL  
);

Insert Into account_opening Values(1,1,1,1,'06-08-2023','Saving');

Copy account_opening from 'D:\DA20\SQL\Sql_task\da20_sql_task05\account_opening.csv' DELIMITER ',' CSV HEADER;

-----------------------------------------------------------------------------------------------------------------------------------------------


-- Customer Feature table

CREATE TABLE customer_feature (
    feature_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer(customer_id) ON DELETE CASCADE,
    feature_type feature_type_enum NOT NULL,
    amount INT Not Null,
    sart_date DATE Not Null,
    end_date DATE Null
);


Insert Into customer_feature Values (1,1,'Overdraft',95725.92,'2019-04-23','2021-04-22');

Copy customer_feature from 'D:\DA20\SQL\Sql_task\da20_sql_task05\customer_feature.csv' DELIMITER ',' CSV HEADER;

-----------------------------------------------------------------------------------------------------------------------------------------------