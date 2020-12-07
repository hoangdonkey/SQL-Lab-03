USE master

IF EXISTS(SELECT * FROM sys.databases WHERE NAME LIKE 'BookLibary')
	DROP DATABASE BookLibary
GO

CREATE DATABASE BookLibary
GO

USE BookLibary
GO

CREATE TABLE Book
(	BookCode INT,
	BookTitle VARCHAR(100) NOT NULL,
	Author VARCHAR(50) NOT NULL,
	Edition INT,
	BookPrice MONEY,
	Copies INT,
	CONSTRAINT pk_bookid PRIMARY KEY (BookCode))
GO

CREATE TABLE Member
(	MemberCode INT,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(100) NOT NULL,
	PhoneNumber BIGINT,
	CONSTRAINT pk_memberID PRIMARY KEY (MemberCode))
GO

CREATE TABLE IssueDetails
(	BookCode INT,
	MemberCode INT,
	IssueDate DATETIME,
	ReturnDate DATETIME,
	CONSTRAINT fk_bookid FOREIGN KEY (BookCode) REFERENCES Book(BookCode),
	CONSTRAINT fk_memberid FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode))
GO

ALTER TABLE IssueDetails
DROP CONSTRAINT fk_bookid,fk_memberid
GO

ALTER TABLE Book
DROP CONSTRAINT pk_bookid
GO

ALTER TABLE Member
DROP CONSTRAINT pk_memberid
GO

ALTER TABLE Book
ADD CONSTRAINT pk_bookid PRIMARY KEY (BookCode)
GO

ALTER TABLE Member
ADD CONSTRAINT pk_memberid PRIMARY KEY (MemberCode)
GO

ALTER TABLE IssueDetails
ADD CONSTRAINT fk_bookid FOREIGN KEY (BookCode) REFERENCES Book(BookCode)
GO

ALTER TABLE IssueDetails
ADD CONSTRAINT fk_memberid FOREIGN KEY (MemberCode) REFERENCES Member(MemberCode)
GO

ALTER TABLE Book
ADD CONSTRAINT chk_bookprice CHECK (BookPrice > 0 AND BookPrice < 200)
GO

ALTER TABLE Member
ADD CONSTRAINT phonenumber UNIQUE (PhoneNumber)
GO

ALTER TABLE IssueDetails
ALTER COLUMN BookCode INT NOT NULL
GO

ALTER TABLE IssueDetails
ALTER COLUMN MemberCode INT NOT NULL
GO

ALTER TABLE IssueDetails
ADD CONSTRAINT pk_bookmemberid PRIMARY KEY (BookCode,MemberCode)
GO

INSERT INTO Book VALUES (1,'quyen sach duy nhat','tac gia duy nhat',1,100,1)
INSERT INTO Member VALUES (1,'khach hang duy nhat','ha noi',92348732)
INSERT INTO IssueDetails VALUES (1,1,'07-12-2020','08-12-2020')

SELECT * FROM Book
SELECT * FROM Member
SELECT * FROM IssueDetails