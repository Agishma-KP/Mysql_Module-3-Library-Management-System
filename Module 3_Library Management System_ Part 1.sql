CREATE DATABASE library;
USE library;
-- Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(15)
);
-- Employee Table
CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
-- Book Table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10,2),
    Status ENUM('yes', 'no'),
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
-- Customer Table
CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
-- Issue table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
-- Return Status Table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
-- Retrieve the book title, category, and rental price of all available books
SELECT Book_title, Category, Rental_Price 
FROM Books 
WHERE Status = 'yes';

-- List the employee names and their respective salaries in descending order of salary
SELECT Emp_name, Salary 
FROM Employee 
ORDER BY Salary DESC;

-- Retrieve the book titles and the corresponding customers who have issued those books
SELECT i.Issued_book_name, c.Customer_name 
FROM IssueStatus i 
JOIN Customer c ON i.Issued_cust = c.Customer_Id;

-- Display the total count of books in each category
SELECT Category, COUNT(*) AS Total_Books 
FROM Books 
GROUP BY Category;

-- Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000
SELECT Emp_name, Position 
FROM Employee 
WHERE Salary > 50000;

-- List the customer names who registered before 2022-01-01 and have not issued any books yet
SELECT Customer_name 
FROM Customer 
WHERE Reg_date < '2022-01-01' 
AND Customer_Id NOT IN (SELECT Issued_cust FROM IssueStatus);

-- Display the branch numbers and the total count of employees in each branch
SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no;

-- Display the names of customers who have issued books in the month of June 2023
SELECT DISTINCT c.Customer_name 
FROM Customer c 
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust 
WHERE i.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- Retrieve book_title from books table containing 'history'
SELECT Book_title 
FROM Books 
WHERE Book_title LIKE '%history%';

-- Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Employee_Count 
FROM Employee 
GROUP BY Branch_no 
HAVING Employee_Count > 5;

-- Retrieve the names of employees who manage branches and their respective branch addresses
SELECT e.Emp_name, b.Branch_address 
FROM Employee e 
JOIN Branch b ON e.Emp_Id = b.Manager_Id;

-- Display the names of customers who have issued books with a rental price higher than Rs. 25
SELECT DISTINCT c.Customer_name 
FROM Customer c 
JOIN IssueStatus i ON c.Customer_Id = i.Issued_cust 
JOIN Books b ON i.Isbn_book = b.ISBN 
WHERE b.Rental_Price > 25;

-- Insert Data into Branch Table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no) VALUES
(1, 101, 'Downtown Library, City Center', '9876543210'),
(2, 102, 'Westside Library, 5th Avenue', '9856231470'),
(3, 103, 'Eastside Library, Main Street', '9865471230');
-- Insert Data into Employee Table
INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no) VALUES
(101, 'John Doe', 'Manager', 75000, 1),
(102, 'Sarah Smith', 'Manager', 72000, 2),
(103, 'Michael Johnson', 'Manager', 68000, 3),
(104, 'Emma Davis', 'Librarian', 45000, 1),
(105, 'David Brown', 'Assistant Librarian', 35000, 2),
(106, 'Olivia Wilson', 'Librarian', 52000, 3);
-- Insert Data into Books Table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher) VALUES
('978-0451524935', '1984', 'Fiction', 30.00, 'yes', 'George Orwell', 'Penguin'),
('978-0061120084', 'To Kill a Mockingbird', 'Fiction', 25.00, 'yes', 'Harper Lee', 'HarperCollins'),
('978-1451673319', 'Fahrenheit 451', 'Science Fiction', 40.00, 'no', 'Ray Bradbury', 'Simon & Schuster'),
('978-0743273565', 'The Great Gatsby', 'Classic', 35.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0140449266', 'The History of the Peloponnesian War', 'History', 50.00, 'yes', 'Thucydides', 'Penguin Classics');
--  Insert Data into Customer Table
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date) VALUES
(1, 'Alice Johnson', '123 Elm Street', '2021-12-15'),
(2, 'Bob Williams', '456 Oak Avenue', '2022-02-10'),
(3, 'Charlie Brown', '789 Pine Road', '2023-06-05'),
(4, 'Daniel Lee', '321 Maple Lane', '2023-06-18'),
(5, 'Emily Clark', '654 Birch Boulevard', '2021-09-22');
-- Insert Data into IssueStatus Table
INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book) VALUES
(1, 2, '1984', '2023-06-05', '978-0451524935'),
(2, 3, 'To Kill a Mockingbird', '2023-06-10', '978-0061120084'),
(3, 4, 'Fahrenheit 451', '2023-06-15', '978-1451673319');
-- insert Data into ReturnStatus Table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2) VALUES
(1, 2, '1984', '2023-07-01', '978-0451524935'),
(2, 3, 'To Kill a Mockingbird', '2023-07-05', '978-0061120084');

-- Verify data
SELECT * FROM Branch;
SELECT * FROM Employee;
SELECT * FROM Books;
SELECT * FROM Customer;
SELECT * FROM IssueStatus;
SELECT * FROM ReturnStatus;





















