--creating the schema--
create schema lib;
--creating the data base tables --


--creating the branch table--

create table lib.branch
(
branch_id varchar(10) primary key,
manger_id varchar(10) not null, 
branch_address varchar(30) not null,
contact_no varchar(20),
);

--creating the employee table--
create table lib.employees
(
emp_id varchar(10) primary key,
emp_name varchar(30) not null,
position varchar(30) not null,
salary numeric (10,2)not null,
branch_id varchar(10)not null,
constraint branch_employees_fk foreign key (branch_id)
references lib.branch (branch_id)
);

--creating members table--

create table lib.members
(
member_id varchar(10) primary key,
member_name varchar(30) not null,
member_address varchar(30),
reg_date date 
);

--creating books table--
create table lib.books 
(
isbn varchar(50) primary key,
book_title varchar(80) not null,
category varchar(30) not null,
rental_price numeric (6,2) not null,
status varchar(10) not null,
author varchar(30),
publisher varchar(30)
);
--creating issue_status table--
DROP TABLE IF EXISTS lib.issue_status
create table lib.issued_status
(
issued_id varchar(10) primary key,
member_id varchar(10) not null,
book_name varchar(70)not null,
issued_date date not null,
isbn varchar(50) not null,
emp_id varchar(10) not null,
constraint employees_issue_fk foreign key (emp_id)
references lib.employees (emp_id),
constraint books_issue_fk foreign key (isbn)
references lib.books (isbn),
constraint members_issue_fk foreign key (member_id)
references lib.members (member_id)
);

--create returns_status table--
DROP TABLE IF EXISTS lib.returns_status
create table lib.returns_status
(
return_id varchar(10) primary key,
issued_id varchar(30),
return_book_name varchar(80) ,
return_date date not null,
return_book_isbn varchar (50),
constraint books_returns_fk foreign key (return_book_isbn)
references lib.books (isbn)
);

-------------------------------------------------------------------------------------
--inserting data in tables 

INSERT INTO lib.members(member_id, member_name, member_address, reg_date) 
VALUES
('C101', 'Alice Johnson', '123 Main St', '2021-05-15'),
('C102', 'Bob Smith', '456 Elm St', '2021-06-20'),
('C103', 'Carol Davis', '789 Oak St', '2021-07-10'),
('C104', 'Dave Wilson', '567 Pine St', '2021-08-05'),
('C105', 'Eve Brown', '890 Maple St', '2021-09-25'),
('C106', 'Frank Thomas', '234 Cedar St', '2021-10-15'),
('C107', 'Grace Taylor', '345 Walnut St', '2021-11-20'),
('C108', 'Henry Anderson', '456 Birch St', '2021-12-10'),
('C109', 'Ivy Martinez', '567 Oak St', '2022-01-05'),
('C110', 'Jack Wilson', '678 Pine St', '2022-02-25'),
('C118', 'Sam', '133 Pine St', '2024-06-01'),    
('C119', 'John', '143 Main St', '2024-05-01');
SELECT * FROM lib.members;


-- Insert values into each branch table
INSERT INTO lib.branch(branch_id, manger_id, branch_address, contact_no) 
VALUES
('B001', 'E109', '123 Main St', '+919099988676'),
('B002', 'E109', '456 Elm St', '+919099988677'),
('B003', 'E109', '789 Oak St', '+919099988678'),
('B004', 'E110', '567 Pine St', '+919099988679'),
('B005', 'E110', '890 Maple St', '+919099988680');
SELECT * FROM lib.branch;


-- Insert values into each employees table
INSERT INTO lib.employees(emp_id, emp_name, position, salary, branch_id) 
VALUES
('E101', 'John Doe', 'Clerk', 60000.00, 'B001'),
('E102', 'Jane Smith', 'Clerk', 45000.00, 'B002'),
('E103', 'Mike Johnson', 'Librarian', 55000.00, 'B001'),
('E104', 'Emily Davis', 'Assistant', 40000.00, 'B001'),
('E105', 'Sarah Brown', 'Assistant', 42000.00, 'B001'),
('E106', 'Michelle Ramirez', 'Assistant', 43000.00, 'B001'),
('E107', 'Michael Thompson', 'Clerk', 62000.00, 'B005'),
('E108', 'Jessica Taylor', 'Clerk', 46000.00, 'B004'),
('E109', 'Daniel Anderson', 'Manager', 57000.00, 'B003'),
('E110', 'Laura Martinez', 'Manager', 41000.00, 'B005'),
('E111', 'Christopher Lee', 'Assistant', 65000.00, 'B005');
SELECT * FROM lib.employees;


-- Inserting into books table 
INSERT INTO lib.books(isbn, book_title, category, rental_price, status, author, publisher) 
VALUES
('978-0-553-29698-2', 'The Catcher in the Rye', 'Classic', 7.00, 'yes', 'J.D. Salinger', 'Little, Brown and Company'),
('978-0-330-25864-8', 'Animal Farm', 'Classic', 5.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-118776-1', 'One Hundred Years of Solitude', 'Literary Fiction', 6.50, 'yes', 'Gabriel Garcia Marquez', 'Penguin Books'),
('978-0-525-47535-5', 'The Great Gatsby', 'Classic', 8.00, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-0-141-44171-6', 'Jane Eyre', 'Classic', 4.00, 'yes', 'Charlotte Bronte', 'Penguin Classics'),
('978-0-307-37840-1', 'The Alchemist', 'Fiction', 2.50, 'yes', 'Paulo Coelho', 'HarperOne'),
('978-0-679-76489-8', 'Harry Potter and the Sorcerers Stone', 'Fantasy', 7.00, 'yes', 'J.K. Rowling', 'Scholastic'),
('978-0-7432-4722-4', 'The Da Vinci Code', 'Mystery', 8.00, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-09-957807-9', 'A Game of Thrones', 'Fantasy', 7.50, 'yes', 'George R.R. Martin', 'Bantam'),
('978-0-393-05081-8', 'A Peoples History of the United States', 'History', 9.00, 'yes', 'Howard Zinn', 'Harper Perennial'),
('978-0-19-280551-1', 'The Guns of August', 'History', 7.00, 'yes', 'Barbara W. Tuchman', 'Oxford University Press'),
('978-0-307-58837-1', 'Sapiens: A Brief History of Humankind', 'History', 8.00, 'no', 'Yuval Noah Harari', 'Harper Perennial'),
('978-0-375-41398-8', 'The Diary of a Young Girl', 'History', 6.50, 'no', 'Anne Frank', 'Bantam'),
('978-0-14-044930-3', 'The Histories', 'History', 5.50, 'yes', 'Herodotus', 'Penguin Classics'),
('978-0-393-91257-8', 'Guns, Germs, and Steel: The Fates of Human Societies', 'History', 7.00, 'yes', 'Jared Diamond', 'W. W. Norton & Company'),
('978-0-7432-7357-1', '1491: New Revelations of the Americas Before Columbus', 'History', 6.50, 'no', 'Charles C. Mann', 'Vintage Books'),
('978-0-679-64115-3', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-14-143951-8', 'Pride and Prejudice', 'Classic', 5.00, 'yes', 'Jane Austen', 'Penguin Classics'),
('978-0-452-28240-7', 'Brave New World', 'Dystopian', 6.50, 'yes', 'Aldous Huxley', 'Harper Perennial'),
('978-0-670-81302-4', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Knopf'),
('978-0-385-33312-0', 'The Shining', 'Horror', 6.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52993-5', 'Fahrenheit 451', 'Dystopian', 5.50, 'yes', 'Ray Bradbury', 'Ballantine Books'),
('978-0-345-39180-3', 'Dune', 'Science Fiction', 8.50, 'yes', 'Frank Herbert', 'Ace'),
('978-0-375-50167-0', 'The Road', 'Dystopian', 7.00, 'yes', 'Cormac McCarthy', 'Vintage'),
('978-0-06-025492-6', 'Where the Wild Things Are', 'Children', 3.50, 'yes', 'Maurice Sendak', 'HarperCollins'),
('978-0-06-112241-5', 'The Kite Runner', 'Fiction', 5.50, 'yes', 'Khaled Hosseini', 'Riverhead Books'),
('978-0-06-440055-8', 'Charlotte''s Web', 'Children', 4.00, 'yes', 'E.B. White', 'Harper & Row'),
('978-0-679-77644-3', 'Beloved', 'Fiction', 6.50, 'yes', 'Toni Morrison', 'Knopf'),
('978-0-14-027526-3', 'A Tale of Two Cities', 'Classic', 4.50, 'yes', 'Charles Dickens', 'Penguin Books'),
('978-0-7434-7679-3', 'The Stand', 'Horror', 7.00, 'yes', 'Stephen King', 'Doubleday'),
('978-0-451-52994-2', 'Moby Dick', 'Classic', 6.50, 'yes', 'Herman Melville', 'Penguin Books'),
('978-0-06-112008-4', 'To Kill a Mockingbird', 'Classic', 5.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.'),
('978-0-553-57340-1', '1984', 'Dystopian', 6.50, 'yes', 'George Orwell', 'Penguin Books'),
('978-0-7432-4722-5', 'Angels & Demons', 'Mystery', 7.50, 'yes', 'Dan Brown', 'Doubleday'),
('978-0-7432-7356-4', 'The Hobbit', 'Fantasy', 7.00, 'yes', 'J.R.R. Tolkien', 'Houghton Mifflin Harcourt')
SELECT * FROM lib.books;



-- inserting into issued table
INSERT INTO lib.issued_status(issued_id, member_id, book_name, issued_date,isbn,emp_id) 
VALUES
('IS106', 'C106', 'Animal Farm', '2024-03-10', '978-0-330-25864-8', 'E104'),
('IS107', 'C107', 'One Hundred Years of Solitude', '2024-03-11', '978-0-14-118776-1', 'E104'),
('IS108', 'C108', 'The Great Gatsby', '2024-03-12', '978-0-525-47535-5', 'E104'),
('IS109', 'C109', 'Jane Eyre', '2024-03-13', '978-0-141-44171-6', 'E105'),
('IS110', 'C110', 'The Alchemist', '2024-03-14', '978-0-307-37840-1', 'E105'),
('IS111', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-03-15', '978-0-679-76489-8', 'E105'),
('IS112', 'C109', 'A Game of Thrones', '2024-03-16', '978-0-09-957807-9', 'E106'),
('IS113', 'C109', 'A Peoples History of the United States', '2024-03-17', '978-0-393-05081-8', 'E106'),
('IS114', 'C109', 'The Guns of August', '2024-03-18', '978-0-19-280551-1', 'E106'),
('IS115', 'C109', 'The Histories', '2024-03-19', '978-0-14-044930-3', 'E107'),
('IS116', 'C110', 'Guns, Germs, and Steel: The Fates of Human Societies', '2024-03-20', '978-0-393-91257-8', 'E107'),
('IS117', 'C110', '1984', '2024-03-21', '978-0-679-64115-3', 'E107'),
('IS118', 'C101', 'Pride and Prejudice', '2024-03-22', '978-0-14-143951-8', 'E108'),
('IS119', 'C110', 'Brave New World', '2024-03-23', '978-0-452-28240-7', 'E108'),
('IS120', 'C110', 'The Road', '2024-03-24', '978-0-670-81302-4', 'E108'),
('IS121', 'C102', 'The Shining', '2024-03-25', '978-0-385-33312-0', 'E109'),
('IS122', 'C102', 'Fahrenheit 451', '2024-03-26', '978-0-451-52993-5', 'E109'),
('IS123', 'C103', 'Dune', '2024-03-27', '978-0-345-39180-3', 'E109'),
('IS124', 'C104', 'Where the Wild Things Are', '2024-03-28', '978-0-06-025492-6', 'E110'),
('IS125', 'C105', 'The Kite Runner', '2024-03-29', '978-0-06-112241-5', 'E110'),
('IS126', 'C105', 'Charlotte''s Web', '2024-03-30', '978-0-06-440055-8', 'E110'),
('IS127', 'C105', 'Beloved', '2024-03-31', '978-0-679-77644-3', 'E110'),
('IS128', 'C105', 'A Tale of Two Cities', '2024-04-01', '978-0-14-027526-3', 'E110'),
('IS129', 'C105', 'The Stand', '2024-04-02', '978-0-7434-7679-3', 'E110'),
('IS130', 'C106', 'Moby Dick', '2024-04-03', '978-0-451-52994-2', 'E101'),
('IS131', 'C106', 'To Kill a Mockingbird', '2024-04-04', '978-0-06-112008-4', 'E101'),
('IS132', 'C106', 'The Hobbit', '2024-04-05', '978-0-7432-7356-4', 'E106'),
('IS133', 'C107', 'Angels & Demons', '2024-04-06', '978-0-7432-4722-5', 'E106'),
('IS134', 'C107', 'The Diary of a Young Girl', '2024-04-07', '978-0-375-41398-8', 'E106'),
('IS135', 'C107', 'Sapiens: A Brief History of Humankind', '2024-04-08', '978-0-307-58837-1', 'E108'),
('IS136', 'C107', '1491: New Revelations of the Americas Before Columbus', '2024-04-09', '978-0-7432-7357-1', 'E102'),
('IS137', 'C107', 'The Catcher in the Rye', '2024-04-10', '978-0-553-29698-2', 'E103'),
('IS138', 'C108', 'The Great Gatsby', '2024-04-11', '978-0-525-47535-5', 'E104'),
('IS139', 'C109', 'Harry Potter and the Sorcerers Stone', '2024-04-12', '978-0-679-76489-8', 'E105'),
('IS140', 'C110', 'Animal Farm', '2024-04-13', '978-0-330-25864-8', 'E102')
SELECT * FROM lib.issued_status;


-- inserting into return table
INSERT INTO lib.returns_status(return_id, issued_id, return_date) 
VALUES
('RS101', 'IS101', '2023-06-06'),
('RS102', 'IS105', '2023-06-07'),
('RS103', 'IS103', '2023-08-07'),
('RS104', 'IS106', '2024-05-01'),
('RS105', 'IS107', '2024-05-03'),
('RS106', 'IS108', '2024-05-05'),
('RS107', 'IS109', '2024-05-07'),
('RS108', 'IS110', '2024-05-09'),
('RS109', 'IS111', '2024-05-11'),
('RS110', 'IS112', '2024-05-13'),
('RS111', 'IS113', '2024-05-15'),
('RS112', 'IS114', '2024-05-17'),
('RS113', 'IS115', '2024-05-19'),
('RS114', 'IS116', '2024-05-21'),
('RS115', 'IS117', '2024-05-23'),
('RS116', 'IS118', '2024-05-25'),
('RS117', 'IS119', '2024-05-27'),
('RS118', 'IS120', '2024-05-29');
SELECT * FROM lib.returns_status;
----------------------------------------------------------------------------------------
--CRUD Operations
--Create: Inserted sample records into the books table.
--Read: Retrieved and displayed data from various tables.
--Update: Updated records in the employees table.
--Delete: Removed records from the members table as needed.

--1. Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
INSERT INTO lib.books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM lib.books;

--2: Update an Existing Member's Address
UPDATE lib.members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';
select * from lib.members where member_id = 'C103';

--3: Delete a Record from the Issued Status Table -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
DELETE FROM lib.issued_status
WHERE   issued_id =   'IS121';

--4: Retrieve All Books Issued by a Specific Employee -- Objective: Select all books issued by the employee with emp_id = 'E101'.
SELECT * FROM lib.issued_status
WHERE emp_id = 'E101'

--5: List Members Who Have Issued More Than One Book -- Objective: Use GROUP BY to find members who have issued more than one book.
SELECT
    emp_id,
    COUNT(*)
FROM lib.issued_status
GROUP BY emp_id
HAVING COUNT(*) > 1

--------------------------------------------------------------------------------------------
--3. create (Table_Valued_Functions)
declare @book_issued_cnt table 
(
isbn varchar(70),
book_title varchar(100),
issue_count int
);
insert into @book_issued_cnt
select b.isbn ,b.book_title , count(ist.issued_id) as issue_count
from lib.issued_status as ist join lib.books as b
on ist.isbn=b.isbn
group by b.isbn ,b.book_title;
select* from @book_issued_cnt ;
------------------------------------------------------------------------------------------
--4. Data Analysis & Findings
--1-Retrieve All Books in a Specific Category EX:classic
select *from lib.books where category = 'classic';

-- 2- Find Total Rental Income by Category
select category,sum(rental_price)as total_rental_price,count(*)as total_books_per_category
from lib.books 
group by category;

-- 3- List Members Who Registered in the Last 180 Days
SELECT *
FROM lib.members
WHERE reg_date >= DATEADD(DAY, -180, GETDATE());

-- 4- List Employees with Their Branch Manager's Name and their branch details

select e1.emp_id,e1.emp_name,e1.position,e1.salary,b.*,e2.emp_name as manger
from lib.employees as e1 join lib.branch as b on e1.branch_id = b.branch_id
join lib.employees as e2 on e2.emp_id= b.manger_id;

-- 5- Create a Table of Books with Rental Price Above a Certain Threshold
SELECT * 
INTO expensive_books
FROM lib.books
WHERE rental_price > 7.00;
select*from expensive_books;

-- 6- Retrieve the List of Books Not Yet Returned
SELECT * FROM lib.issued_status as ist
 left JOIN
lib.returns_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;

-- 7- Identify Members with Overdue Books
--Write a query to identify members who have overdue books 
--(assume a 180-day return period).
--Display the member's_id, member's name, book title, issue date, and days overdue.
select 
ist.member_id , m.member_name , bk.book_title, ist.issued_date ,DATEDIFF(DAY, ist.issued_date, GETDATE()) AS over_due_days
from lib.issued_status as ist join lib.members as m on ist.member_id = m.member_id
join lib.books as bk  on bk.isbn = ist.isbn
left join lib.returns_status as rs on rs.issued_id = ist.issued_id 
where rs.issued_id is null and datediff (day,ist.issued_date, GETDATE())>180
order by ist.member_id;

-- 8- Update Book Status on Return
--Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).

CREATE TRIGGER UpdateBookStatusOnReturn
ON lib.returns_status
AFTER INSERT, UPDATE
AS
BEGIN
    -- Update the book status to 'Yes' in the books table when a book is returned
    UPDATE b
    SET b.status = 'Yes'
    FROM lib.books b
    INNER JOIN lib.issued_status isu 
        ON b.isbn = isu.isbn join inserted i on i.issued_id = isu.issued_id
    WHERE i.return_date IS NOT NULL;
END;
---  test  --------to test the above coode we insrted a new record in the returns_status table and the new record was for a book having status ='no' in the books table and we insert the date and then the status in the book table updated automatically 
insert into lib.returns_status (return_id ,issued_id ,return_book_name  ,return_date ,return_book_isbn )
values ('RS119','IS136','1491: New Revelations of the Americas Before Columbus',getdate(),'978-0-7432-7357-1')
select* from lib.books

-- 9- Branch Performance Report
--Create a query that generates a performance report for each branch,
--showing the number of books issued, 
--the number of books returned, and the total revenue generated from book rentals.
select b.branch_id ,b.manger_id,COUNT(ist.issued_id) as number_book_issued,
COUNT(rs.return_id) as number_of_book_return,SUM(bk.rental_price) as total_revenue
FROM lib.issued_status as ist
JOIN 
lib.employees as e
ON e.emp_id = ist.emp_id
JOIN
lib.branch as b
ON e.branch_id = b.branch_id
LEFT JOIN
lib.returns_status as rs
ON rs.issued_id = ist.issued_id
JOIN 
lib.books as bk
ON ist.isbn = bk.isbn
group by b.branch_id ,b.manger_id
-- 10- CTAS: Create a Table of Active Members
--Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.
-- Step 1: Use a CTE to get the list of active members
WITH ActiveMembersCTE AS (
    SELECT DISTINCT member_id
    FROM lib.issued_status
    WHERE issued_date >= DATEADD(MONTH, -11, GETDATE())
)
-- Step 2: Use the CTE in the main query to select from members
SELECT *
FROM lib.members
WHERE member_id IN (SELECT member_id FROM ActiveMembersCTE);

-- 11- Find Employees with the Most Book Issues Processed
--Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch
SELECT 
    e.emp_name,
    b.*,
    COUNT(ist.issued_id) AS no_book_issued
FROM lib.issued_status AS ist
JOIN lib.employees AS e
    ON e.emp_id = ist.emp_id
JOIN lib.branch AS b
    ON e.branch_id = b.branch_id
GROUP BY e.emp_name, b.branch_id, b.manger_id, b.branch_address,b.contact_no;  -- Adjust columns based on branch table structure



