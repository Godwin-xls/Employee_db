// This SQL script is creating a database named 'Employee_db' if it does not already exist. It then
// creates two tables within this database:
-- This SQL script creates a database named 'Employee_db' if it does not already exist.
DROP DATABASE IF EXISTS Employee_db;
CREATE DATABASE Employee_db;

-- Use 'Employee_db' database.
USE Employee_db;

-- This SQL script creates a table named 'departments' with two columns: 'department_id' and 'department_name'.
DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
  department_id INT PRIMARY KEY,
  department_name VARCHAR(100)
);


-- This SQL script creates a table named 'employees' with five columns: 'employee_id', 'employee_name', 'department_id', 'salary', and 'hire_date'.
-- It also establishes a foreign key relationship with the 'departments' table.
DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
  employee_id INT PRIMARY KEY,
  employee_name VARCHAR(100),
  department_id INT,
  salary DECIMAL(10, 2),
  hire_date DATE,
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Insert sample data into the 'departments' table.
-- This data is used to demonstrate the foreign key relationship with the 'employees' table.
INSERT INTO departments (department_id, department_name) VALUES
(1, 'Human Resources'),
(2, 'Finance'),
(3, 'Engineering'),
(4, 'Marketing');

-- Insert sample data into the 'employees' table.
-- This data is used to demonstrate the foreign key relationship with the 'departments' table.
INSERT INTO employees (employee_id, employee_name, department_id, salary, hire_date) VALUES
(101, 'Alice Smith', 1, 60000.00, '2020-01-15'),
(102, 'Bob Johnson', 2, 75000.00, '2019-03-22'),
(103, 'Charlie Brown', 3, 80000.00, '2021-07-30'),
(104, 'Diana Prince', 4, 70000.00, '2018-11-05'),
(105, 'Ethan Hunt', 3, 90000.00, '2022-02-10'),
(106, 'Fiona Gallagher', 1, 65000.00, '2020-05-20'),
(107, 'George Costanza', 2, 72000.00, '2019-09-15'),
(108, 'Hannah Baker', 4, 68000.00, '2021-04-25'),
(109, 'Ian Malcolm', 3, 85000.00, '2020-12-01'),
(110, 'Jane Doe', 1, 62000.00, '2019-06-18');

--Distinct departments in the employee table
SELECT DISTINCT d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

--Departments with more than 2 employees who earn more than 70000
SELECT d.department_name, COUNT (e.employee_id) AS employee_count
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > 70000
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2;

--Average salary of employees in each department
SELECT d.department_name, AVG (e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

--Top 3 highest paid employees in each department, ordered by salary descending
SELECT TOP 3 e.employee_name, d.department_name, e.salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
ORDER BY d.department_name, e.salary DESC;
