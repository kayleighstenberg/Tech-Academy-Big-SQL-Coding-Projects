CREATE DATABASE db_library3;


USE [db_library3]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Populate_db_library3]
AS
BEGIN

	IF EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES tbl_library)
		DROP TABLE tbl_library, library_branch, tbl_publisher, tbl_books, book_authors, book_copies, book_loans, tbl_borrower;
		

/******************************************************
	 * Build tables and define their schema
	 ******************************************************/
CREATE TABLE library_branch (
		BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BranchName VARCHAR(150) NOT NULL,
		Address VARCHAR(150) NOT NULL

	);
SELECT * FROM library_branch;
CREATE TABLE tbl_publisher (

		PublisherID INT PRIMARY KEY NOT NULL IDENTITY (100,1),
		PublisherName VARCHAR(150) NOT NULL,
		Address VARCHAR(150) NOT NULL,
		Phone VARCHAR(150) NOT NULL
	);


CREATE TABLE tbl_books (
		BookID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		Title VARCHAR(500) NOT NULL,
		PublisherID INT NOT NULL CONSTRAINT fk_PublisherID FOREIGN KEY REFERENCES tbl_publisher(PublisherID) ON UPDATE CASCADE ON DELETE CASCADE,
	);


CREATE TABLE book_authors (
		AuthorName VARCHAR(150) NOT NULL,
		BookID INT NOT NULL CONSTRAINT fk_BookID FOREIGN KEY REFERENCES tbl_books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
	);
	

	

CREATE TABLE book_copies (
		BookID INT NOT NULL CONSTRAINT fk_BookID_2 FOREIGN KEY REFERENCES tbl_books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_BranchID FOREIGN KEY REFERENCES library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		Number_Of_Copies INT NOT NULL
	);

CREATE TABLE tbl_borrower (
        BorrowerID INT PRIMARY KEY NOT NULL IDENTITY (300,1),
		CardNo VARCHAR(150) NOT NULL, 
		Name VARCHAR(150) NOT NULL,
		Address VARCHAR(150) NOT NULL,
		Phone VARCHAR(150) NOT NULL
	);

CREATE TABLE book_loans (
		BookID INT NOT NULL CONSTRAINT fk_BookID_3 FOREIGN KEY REFERENCES tbl_books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_BranchID_2 FOREIGN KEY REFERENCES library_branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT NOT NULL,
		DateOut DATE NOT NULL, 
		DateDue DATE NOT NULL
	);

SELECT * FROM book_loans;



/******************************************************
	 * Populate tables
	 ******************************************************/
INSERT INTO library_branch
		(BranchName, Address)
	VALUES 
		('Sharpstown', '1 Hickory St. USA'),
		('North', '5 Elm St. USA'),
		('South', '4 Salem St. USA'),
		('East', '33 Boston Ave. USA'),
		('West', '55 Maple Lane. USA'),
		('Central', '23 Shady Lane, USA')
	;

SELECT * FROM library_branch;

INSERT INTO tbl_publisher
		(PublisherName, Address, Phone)
		VALUES 
		('Scholastic Corporation', '44 Pecos St. USA', '555-555-3333'),
		('Penguin Random House', '1234 Colfax Ave. USA', '333-555-5555'),
		('HarperCollins', '2949 N. Wheeling St. USA', '444-555-7678'),
		('Pearson Education', '4433 Clermont St. USA', '433-555-1939'),
		('Simon & Schuster', '2434 Quitman Way. USA', '345-555-8394'),
		('Hachette', '2978 Dover St. USA', '245-555-6767'),
		('Little Brown and Company', '1122 Flatiron Blvd. USA', '888-555-0098'),
		('Macmillan', '2534 Hyacinth Place. USA', '756-555-3546')
	;
SELECT * FROM tbl_publisher;

INSERT INTO tbl_books
		(Title, PublisherID)
		VALUES 
		('The Lost Tribe', 100),
		('Number the Stars', 101),
		('The Great Gatsby', 100),
		('The Catcher in the Rye', 103),
		('The Hobbit', 103),
		('Atlas Shrugged', 103),
		('The Iliad', 105),
		('The Shining', 103),
		('The Fountainhead', 103),
		('The Picture of Dorian Gray', 103),
		('Secret Window', 103),
		('The Chronicles of Narnia: The Lion, The Witch, and the Wardrobe', 103),
		('The Chronicles of Narnia: The Silver Chair', 103),
		('Twilight', 106),
		('New Moon', 106),
		('Eclipse', 106),
		('Breaking Dawn',106),
		('Harry Potter and the Sorcerers Stone', 100),
		('Harry Potter and the Chamber of Secrets', 100),
		('Harry Potter and the Prisoner of Azkaban', 100),
		('Harry Potter and the Goblet of Fire', 100),
		('Harry Potter and the Order of the Phoenix', 100),
		('Harry Potter and the Half Blood Prince', 100),
		('Harry Potter and the Deathly Hallows', 100),
		('Harry Potter and the Goblet of Fire', 100),
		('The Other Boleyn Girl', 103),
		('The White Queen',103)
	;
SELECT * FROM tbl_books;



INSERT INTO book_authors
		(AuthorName, BookID)
		VALUES
		('Stephen King',10),
		('Stephen King',13),
		('J.K. Rowling', 20),
		('J.K. Rowling', 21),
		('J.K. Rowling', 22),
		('J.K. Rowling', 23),
		('J.K. Rowling', 24),
		('J.K. Rowling', 25),
		('J.K. Rowling', 26),
		('J.K. Rowling', 27),
		('Stephenie Meyer', 16),
		('Stephenie Meyer', 17),
		('Stephenie Meyer',18),
		('Stephenie Meyer',19),
		('Philipa Gregory',28),
		('Philipa Gregory',29),
		('J.D. Salinger', 6),
		('Ayn Rand', 8),
		('Ayn Rand',11),
		('Homer', 9),
		('Oscar Wilde',12),
		('Philipa Gregory',28),
		('Ayn Rand', 8),
		('J.R.R. Tolkien', 7),
		('C.S. Lewis',15),
		('C.S. Lewis',14),
		('F. Scott Fitzgerald', 5),
		('Lois Lowry', 4),
		('Mark Lee', 3)
		;
SELECT * FROM book_authors;

INSERT INTO book_copies

		(BookID,BranchID,Number_Of_Copies)
		VALUES
		(13, 6, 5),
		(10, 6, 2),
		(3, 1, 2),
		(3, 2, 4),
		(5, 3, 2),
		(6, 4, 5),
		(7, 5, 3),
		(8, 5, 2),
		(9, 1, 4),
		(9, 1, 6),
		(10, 1, 9),
		(11, 1, 3),
		(12, 1, 7),
		(13, 1, 3),
		(14, 1, 2),
		(15, 1, 5),
		(16, 1, 7),
		(17, 1, 3),
		(18, 1, 2),
		(19, 1, 5),
		(15, 1, 5),
		(22, 1, 5),
		(25, 1, 5),
		(27, 1, 5),
		(28, 1, 5),
		(29, 1, 5)
	;
SELECT * FROM book_copies;

INSERT INTO book_loans

		(BookID, BranchID, CardNo, DateOut, DateDue)
		VALUES
		(3, 1, 123, '2018-10-03','2018-10-06'),
		(4, 2, 234, '2018-10-07','2018-10-13'),
		(5, 3, 543, '2018-10-07','2018-10-19'),
		(6, 1, 543, '2018-10-03','2018-10-06'),
		(7, 5, 333, '2018-10-06','2018-10-13'),
		(8, 1, 555, '2018-10-07','2018-10-13'),
		(9, 1, 793, '2018-10-03','2018-10-06'),
		(10, 6, 555, '2018-10-03','2018-10-06'),
		(11, 1, 123, '2018-10-06','2018-10-13'),
		(12, 1, 234, '2018-10-06','2018-10-13'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(14, 1, 326, '2018-10-03','2018-10-06'),
		(15, 1, 555, '2018-10-06','2018-10-13'),
		(16, 1, 333, '2018-10-03','2018-10-06'),
		(17, 1, 123, '2018-10-06','2018-10-19'),
		(18, 1, 123, '2018-10-06','2018-10-31'),
		(19, 1, 234, '2018-10-06','2018-10-13'),
		(20, 1, 234, '2018-10-06','2018-10-13'),
		(21, 1, 123, '2018-10-06','2018-10-19'),
		(22, 1, 333, '2018-10-06','2018-10-31'),
		(23, 1, 555, '2018-10-06','2018-10-13'),
		(24, 1, 543, '2018-10-06','2018-10-13'),
		(25, 1, 326, '2018-10-06','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19'),
		(13, 6, 543, '2018-10-07','2018-10-19')
	;
SELECT * FROM book_loans;

INSERT INTO tbl_borrower
		(CardNo, Name, Address, Phone)
		VALUES
		('123', 'Tyrion Lannister', '5 Whitetail Dr. Kings Landing', '239-555-9090'),
		('234', 'Cersei Lannister', '11 City Lane Kings Landing', '553-555-6666'),
		('543', 'Jamie Lannister', '11 City Lane Kings Landing', '553-555-7676'),
		('793', 'Daenerys Targaryen', '8 Dothrak Road 45 Essos', '112-555-2323'),
		('326', 'Jon Snow', '9 Crow Lane Castle Black', '923-555-3990'),
		('444', 'Sansa Stark', '13 Northman Lane Winterfell', '999-555-8776'),
		('555', 'Arya Stark', '13 Northman Lane Winterfell', '999-555-8773'),
		('333', 'Brandon Stark', '13 Northman Lane Winterfell', '999-555-8779')
	;
SELECT * FROM tbl_borrower;




SELECT	book_copies.Number_Of_Copies, tbl_books.Title, library_branch.BranchName
		FROM book_copies 
		INNER JOIN tbl_books  ON book_copies.BookID = tbl_books.BookID
		INNER JOIN library_branch  ON book_copies.BranchID = library_branch.BranchID
		WHERE Title = 'The Lost Tribe' AND BranchName = 'Sharpstown'  
		;

SELECT  book_copies.Number_Of_Copies, tbl_books.Title, library_branch.BranchName
		FROM book_copies 
		INNER JOIN tbl_books  ON book_copies.BookID = tbl_books.BookID
		INNER JOIN library_branch  ON book_copies.BranchID = library_branch.BranchID
		WHERE Title = 'The Lost Tribe'  
		;

SELECT  Name
		FROM tbl_borrower
		FULL OUTER JOIN book_loans ON tbl_borrower.CardNo = book_loans.CardNo
		WHERE book_loans.CardNo IS NULL
		;

SELECT tbl_books.Title, tbl_borrower.Name, tbl_borrower.Address, library_branch.BranchName, book_loans.DateDue
	   FROM tbl_books
	   INNER JOIN book_loans ON book_loans.BookID = tbl_books.BookID
	   INNER JOIN tbl_borrower ON tbl_borrower.CardNo = tbl_borrower.CardNo
	   INNER JOIN library_branch ON library_branch.BranchID = library_branch.BranchID
	   WHERE library_branch.BranchName='Sharpstown' AND book_loans.DateDue = '2018-10-06'
	   ;

SELECT  library_branch.BranchName, COUNT(*)
		FROM book_copies, library_branch
		WHERE book_copies.BranchID=library_branch.BranchID
		GROUP BY library_branch.BranchName
		;

SELECT  tbl_borrower.Name, tbl_borrower.Address, COUNT(*) 
		FROM tbl_borrower, book_loans
		WHERE tbl_borrower.CardNo= book_loans.CardNo
		GROUP BY tbl_borrower.Name, tbl_borrower.Address
		HAVING COUNT(tbl_borrower.CardNo) > 5
		;

SELECT  book_copies.Number_Of_Copies, book_authors.AuthorName, library_branch.BranchName
		FROM book_copies 
		INNER JOIN book_authors  ON book_copies.BookID = book_authors.BookID
		INNER JOIN library_branch  ON book_copies.BranchID = library_branch.BranchID
		WHERE AuthorName = 'Stephen King' AND BranchName = 'Central' 
		;

END

GO

execute [dbo].[Populate_db_library3];