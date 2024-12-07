# Library Management System using SQL Project

## Project Overview




This project demonstrates the implementation of a Library Management System using SQL. It includes creating and managing tables, performing CRUD operations, and executing advanced SQL queries. The goal is to showcase skills in database design, manipulation, and querying.

## How to Use



1. **Set Up the Database**.
2. **Run the Queries**: Use the SQL queries in the `lib_managment_sys.sql` file to perform the analysis.
3. **Explore and Modify**: Customize the queries as needed to explore different aspects of the data or answer additional questions.

![Library_project](https://github.com/najirh/Library-System-Management---P2/blob/main/library.jpg)



## Project Structure

### 1. Database Setup
![ERD](https://github.com/najirh/Library-System-Management---P2/blob/main/library_erd.png)

- **Database Creation**: Created a database named `Library Management System`.
- **Table Creation**: Created tables for branches, employees, members, books, issued status, and return status. Each table includes relevant columns and relationships.

```sql
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

```

### 2. CRUD Operations

- **Create**: Inserted sample records into the `books` table.
- **Read**: Retrieved and displayed data from various tables.
- **Update**: Updated records in the `employees` table.
- **Delete**: Removed records from the `members` table as needed.

**Task 1. Create a New Book Record**
-- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

```sql
INSERT INTO lib.books(isbn, book_title, category, rental_price, status, author, publisher)
VALUES('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
SELECT * FROM lib.books;

```
**Task 2: Update an Existing Member's Address**

```sql
UPDATE lib.members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';
select * from lib.members where member_id = 'C103';
```

**Task 3: Delete a Record from the Issued Status Table**
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

```sql
DELETE FROM lib.issued_status
WHERE   issued_id =   'IS121';
```

**Task 4: Retrieve All Books Issued by a Specific Employee**
-- Objective: Select all books issued by the employee with emp_id = 'E101'.
```sql
SELECT * FROM lib.issued_status
WHERE emp_id = 'E101'
```


**Task 5: List Members Who Have Issued More Than One Book**
-- Objective: Use GROUP BY to find members who have issued more than one book.

```sql
SELECT
    emp_id,
    COUNT(*)
FROM lib.issued_status
GROUP BY emp_id
HAVING COUNT(*) > 1
```

### 3. create (Table_Valued_Functions)

- **Task 6: Create Summary Tables**: Used Table valued functions to generate new tables based on query results - each book and total book_issued_cnt**

```sql
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
```


### 4. Data Analysis & Findings

The following SQL queries were used to address specific questions:

Task 7. **Retrieve All Books in a Specific Category EX:classic**:

```sql
select *from lib.books
where category = 'classic';
```

8. **Task 8: Find Total Rental Income by Category**:

```sql
Sselect category,sum(rental_price)as total_rental_price,count(*)as total_books_per_category
from lib.books 
group by category;
```

9. **List Members Who Registered in the Last 180 Days**:
```sql
SELECT *
FROM lib.members
WHERE reg_date >= DATEADD(DAY, -180, GETDATE());
```

10. **List Employees with Their Branch Manager's Name and their branch details**:

```sql
select e1.emp_id,e1.emp_name,e1.position,e1.salary,b.*,e2.emp_name as manger
from lib.employees as e1 join lib.branch as b on e1.branch_id = b.branch_id
join lib.employees as e2 on e2.emp_id= b.manger_id;
```

Task 11. **Create a Table of Books with Rental Price Above a Certain Threshold**:
```sql
SELECT * 
INTO expensive_books
FROM lib.books
WHERE rental_price > 7.00;
select*from expensive_books;
```

Task 12: **Retrieve the List of Books Not Yet Returned**
```sql
SELECT * FROM lib.issued_status as ist
 left JOIN
lib.returns_status as rs
ON rs.issued_id = ist.issued_id
WHERE rs.return_id IS NULL;
```



Task 13: Identify Members with Overdue Books**  
Write a query to identify members who have overdue books 
(assume a 180-day return period).
Display the member's_id, member's name, book title, issue date, and days overdue.

```sql
select 
ist.member_id , m.member_name , bk.book_title, ist.issued_date ,
DATEDIFF(DAY, ist.issued_date, GETDATE()) AS over_due_days
from lib.issued_status as ist join lib.members as m on ist.member_id = m.member_id
join lib.books as bk  on bk.isbn = ist.isbn
left join lib.returns_status as rs on rs.issued_id = ist.issued_id 
where rs.issued_id is null and datediff (day,ist.issued_date, GETDATE())>180
order by ist.member_id;
```


Task 14: Update Book Status on Return**  
Write a query to update the status of books in the books table to "Yes" when they are returned (based on entries in the return_status table).


```sql

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
```




Task 15: Branch Performance Report**  
Create a query that generates a performance report for each branch, showing the number of books issued, the number of books returned, and the total revenue generated from book rentals.

```sql
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
```

Task 16: CTAS: Create a Table of Active Members**  
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing members who have issued at least one book in the last 2 months.

```sql

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
```


Task 17: Find Employees with the Most Book Issues Processed**  
Write a query to find the top 3 employees who have processed the most book issues. Display the employee name, number of books processed, and their branch.

```sql
SELECT 
    e.emp_name,
    b.*,
    COUNT(ist.issued_id) AS no_book_issued
FROM lib.issued_status AS ist
JOIN lib.employees AS e
    ON e.emp_id = ist.emp_id
JOIN lib.branch AS b
    ON e.branch_id = b.branch_id
GROUP BY e.emp_name, b.branch_id, b.manger_id, b.branch_address,b.contact_no;
```




## Reports

- **Database Schema**: Detailed table structures and relationships.
- **Data Analysis**: Insights into book categories, employee salaries, member registration trends, and issued books.
- **Summary Reports**: Aggregated data on high-demand books and employee performance.

## Conclusion

This project demonstrates the application of SQL skills in creating and managing a library management system. It includes database setup, data manipulation, and advanced querying, providing a solid foundation for data management and analysis.



