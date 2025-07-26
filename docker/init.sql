-- Create databases
CREATE DATABASE IF NOT EXISTS clients_db;
CREATE DATABASE IF NOT EXISTS cars_db;

-- Create users and grant privileges for each service
CREATE USER IF NOT EXISTS 'client_user'@'%' IDENTIFIED BY 'client_password';
CREATE USER IF NOT EXISTS 'car_user'@'%' IDENTIFIED BY 'car_password';
CREATE USER IF NOT EXISTS 'marouane'@'%' IDENTIFIED BY 'dbibih123';

GRANT ALL PRIVILEGES ON clients_db.* TO 'client_user'@'%';
GRANT ALL PRIVILEGES ON cars_db.* TO 'car_user'@'%';

-- Optionally, grant all privileges to the main MYSQL_USER as well
GRANT ALL PRIVILEGES ON clients_db.* TO 'marouane'@'%';
GRANT ALL PRIVILEGES ON cars_db.* TO 'marouane'@'%';

-- Apply changes
FLUSH PRIVILEGES;