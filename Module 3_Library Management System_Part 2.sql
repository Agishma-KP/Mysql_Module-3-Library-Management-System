USE library;
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