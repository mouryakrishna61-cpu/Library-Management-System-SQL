create database sqlproject;
use sqlproject;
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    department VARCHAR(50),
    class VARCHAR(50),
    phone VARCHAR(15)
);
desc students;
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    book_name VARCHAR(100),
    author VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);
desc books;
CREATE TABLE issue_books (
    issue_id INT PRIMARY KEY,
    student_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);
desc issue_books;
CREATE TABLE fine (
    fine_id INT PRIMARY KEY,
    student_id INT,
    issue_id INT,
    fine_amount DECIMAL(10,2),
    fine_status VARCHAR(20),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (issue_id) REFERENCES issue_books(issue_id)
);
desc fine;
INSERT INTO students 
(student_id, student_name, department, class, phone)
VALUES
(1, 'Rahul Sharma', 'BCA', 'FYBCA', '9876543210'),
(2, 'Priya Patil', 'BCOM', 'SYBCOM', '9876543211'),
(3, 'Aman Khan', 'BMS', 'TYBMS', '9876543212'),
(4, 'Sneha Gupta', 'BCA', 'SYBCA', '9876543213'),
(5, 'Rohan Mehta', 'BSC IT', 'FYBSCIT', '9876543214'),
(6, 'Neha Singh', 'BCOM', 'TYBCOM', '9876543215'),
(7, 'Karan Yadav', 'BMS', 'FYBMS', '9876543216'),
(8, 'Anjali More', 'BSC IT', 'SYBSCIT', '9876543217');
select* from students;
INSERT INTO books 
(book_id, book_name, author, category, price)
VALUES
(101, 'SQL Basics', 'James Carter', 'Database', 450.00),
(102, 'Python Programming', 'Mark Wilson', 'Programming', 650.00),
(103, 'Business Management', 'R K Sharma', 'Management', 500.00),
(104, 'Financial Accounting', 'S N Maheshwari', 'Accounting', 550.00),
(105, 'Web Designing', 'David Miller', 'IT', 600.00),
(106, 'Data Analytics', 'John Smith', 'Data Science', 750.00),
(107, 'Marketing Principles', 'Philip Kotler', 'Marketing', 700.00),
(108, 'Computer Networks', 'Andrew Tanenbaum', 'Networking', 800.00),
(109, 'Java Programming', 'Herbert Schildt', 'Programming', 900.00),
(110, 'Cyber Security Basics', 'Robert Wilson', 'Security', 850.00);
select * from books;
INSERT INTO issue_books
(issue_id, student_id, book_id, issue_date, return_date, status)
VALUES
(1001, 1, 101, '2024-01-05', '2024-01-15', 'Returned'),
(1002, 2, 104, '2024-01-08', '2024-01-18', 'Returned'),
(1003, 3, 103, '2024-01-10', NULL, 'Pending'),
(1004, 4, 102, '2024-01-12', '2024-01-25', 'Returned'),
(1005, 5, 106, '2024-01-15', NULL, 'Pending'),
(1006, 6, 107, '2024-01-18', '2024-01-28', 'Returned'),
(1007, 7, 105, '2024-01-20', NULL, 'Pending'),
(1008, 8, 108, '2024-01-22', '2024-02-02', 'Returned'),
(1009, 1, 106, '2024-02-01', '2024-02-10', 'Returned'),
(1010, 4, 101, '2024-02-05', NULL, 'Pending'),
(1011, 2, 102, '2024-02-07', '2024-02-17', 'Returned'),
(1012, 3, 107, '2024-02-10', NULL, 'Pending');
select * from issue_books;
INSERT INTO fine
(fine_id, student_id, issue_id, fine_amount, fine_status)
VALUES
(501, 1, 1001, 20.00, 'Paid'),
(502, 2, 1002, 30.00, 'Paid'),
(503, 4, 1004, 50.00, 'Unpaid'),
(504, 6, 1006, 10.00, 'Paid'),
(505, 8, 1008, 40.00, 'Unpaid'),
(506, 1, 1009, 25.00, 'Paid'),
(507, 2, 1011, 15.00, 'Paid');
select * from fine;

SELECT category, COUNT(book_id) AS total_books
FROM books
GROUP BY category;

SELECT b.book_name, COUNT(i.issue_id) AS total_issued
FROM issue_books i
JOIN books b ON i.book_id = b.book_id
GROUP BY b.book_name
ORDER BY total_issued DESC;

SELECT s.student_name, b.book_name, i.issue_date, i.return_date
FROM issue_books i
JOIN students s ON i.student_id = s.student_id
JOIN books b ON i.book_id = b.book_id;

SELECT s.student_name, b.book_name, i.issue_date, i.status
FROM issue_books i
JOIN students s ON i.student_id = s.student_id
JOIN books b ON i.book_id = b.book_id
WHERE i.status = 'Pending';

SELECT SUM(fine_amount) AS total_fine_collected
FROM fine
WHERE fine_status = 'Paid';

SELECT s.student_name, f.fine_amount, f.fine_status
FROM fine f
JOIN students s ON f.student_id = s.student_id
WHERE f.fine_status = 'Unpaid';

SELECT s.student_name, COUNT(i.issue_id) AS total_books_issued
FROM issue_books i
JOIN students s ON i.student_id = s.student_id
GROUP BY s.student_name
ORDER BY total_books_issued DESC
LIMIT 5;

SELECT s.department, COUNT(i.issue_id) AS total_books_issued
FROM issue_books i
JOIN students s ON i.student_id = s.student_id
GROUP BY s.department;

SELECT book_name, author, category
FROM books
WHERE book_id NOT IN (
    SELECT book_id FROM issue_books
);

SELECT MONTH(issue_date) AS issue_month, COUNT(issue_id) AS total_issues
FROM issue_books
GROUP BY MONTH(issue_date)
ORDER BY issue_month;

SELECT status, COUNT(issue_id) AS total_books
FROM issue_books
GROUP BY status;

SELECT s.student_name, COUNT(i.issue_id) AS total_books_issued
FROM issue_books i
JOIN students s ON i.student_id = s.student_id
GROUP BY s.student_name
HAVING COUNT(i.issue_id) > 1;

SELECT i.issue_id, s.student_name, b.book_name, i.issue_date, i.return_date, i.status
FROM issue_books i
JOIN students s ON i.student_id = s.student_id
JOIN books b ON i.book_id = b.book_id;

SELECT fine_status, SUM(fine_amount) AS total_fine_amount
FROM fine
GROUP BY fine_status;














