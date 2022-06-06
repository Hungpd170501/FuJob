USE master
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'FuJobDB')
BEGIN
    DROP DATABASE FuJobDB;  
END;
CREATE DATABASE FuJobDB;
GO

USE FuJobDB
GO

IF OBJECT_ID('dbo.tblUser', 'u') IS NOT NULL 
   DROP TABLE dbo.tblUser;  
GO

CREATE TABLE tblUser
(
	userID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	username varchar(50) NOT NULL,
	password varchar(500) NOT NULL,
	fullName varchar(50) NOT NULL,
	phone varchar(20),
	email varchar(50),
	roleID varchar(50),
	status tinyint,
	companyID INT,
);
GO

INSERT INTO tblUser(username,password,fullName,email,phone,roleID,status) 
VALUES(N'customer1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Van A', N'abc1@gmail.com', N'0780780789', N'US',1),
      (N'customer2', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Van B', N'abc2@gmail.com', N'0780780790', N'HR',1),
	  (N'admin', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tao la Admin', N'admin@gmail.com', N'0780780791', N'AD',1),
      (N'dev1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev1', N'hungpdse150222@fpt.edu.vn', N'0780780792', N'US',1),
      (N'dev2', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev2', N'baohngse150260@fpt.edu.vn', N'0780780793', N'US',1),
      (N'dev3', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev3', N'duylhse150233@fpt.edu.vn', N'0780780794', N'US',1),
	  (N'dev4', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev4', N'binhlqse150199@fpt.edu.vn', N'0780780795', N'US',1)
GO

IF OBJECT_ID('dbo.tblRole', 'u') IS NOT NULL 
   DROP TABLE dbo.tblUser;  
GO

CREATE TABLE tblRole
(
	roleID varchar(50) NOT NULL PRIMARY KEY CLUSTERED,
	roleName varchar(50) NOT NULL
);
GO

INSERT INTO tblRole(roleID, roleName) 
VALUES(N'AD', N'Admin'),
      (N'US', N'User'),
	  (N'HR', N'Human Resource')
GO

IF OBJECT_ID('dbo.tblCompany', 'u') IS NOT NULL 
   DROP TABLE dbo.tblCompany;  
GO

CREATE TABLE tblCompany
(
	companyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	companyName varchar(50),
	address varchar(50),
	website varchar ( 100 ),
	gmail varchar(50),
	phone varchar(20),
	typeCompany varchar(30),
	establishedYear varchar(30),
	numberOfEmployee int,
	companyOverview varchar(3000),
	avatar varchar ( 2000 )
);
GO
IF OBJECT_ID('dbo.tblResume', 'u') IS NOT NULL 
   DROP TABLE dbo.tblResume;  
GO

CREATE TABLE tblResume
(
	resumeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	userID INT NOT NULL,
	avatar varchar ( 2000 ),
	fullName varchar(50),
	gender varchar(10),
	dateOfBirth date,
	gmail varchar(50),
	phone varchar(20),
	address varchar(50),
	schoolName varchar(50),
	major varchar(50),
	gpa varchar(15),
	experienceYear varchar(50),
	skills varchar(255),
	website varchar ( 100 ),
	overview varchar(3000),
);
GO

IF OBJECT_ID('dbo.tblJob', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJob;  
GO
CREATE TABLE tblJob (
	jobID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	userID INT NOT NULL,
	jobTitle varchar(255),
	ExperienceNeeded varchar(20),
	jobCategoryID INT,
	skill varchar(255),
	deadline date,
	completionTime varchar(20),
	salary varchar(20),
	address varchar(50),
	email varchar(255),
	phone varchar(15),
	description varchar(2000),
	
);
GO

INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, skill, deadline, completionTime, salary, address, email, phone, description) 
VALUES (
'11', 'DESIGNER FREELANCE', 'Less than 1 year', '24', 'Adobe Illustrator, Photography, Adobe Premiere,...', '2022-08-11', '10 days', '100$', 'Distric 9, HCM city', 'designfpt@gmail.com', '123-65-485', 'Support, coordinate with main designer to design products for online advertising and communication channels: banner, cover photo, flash animation, infographic, email marketing, etc.
 Support, coordinate with main designer Design products for offline communication: standee, banner, backdrop, bandroll, invitation, flyer, flyer, voucher, banners for office decoration, etc.
 Edit photos after each Company event
 Support, coordinate with the main designer to design online and offline registration forms
 Design slides, brochures to introduce products for the Company
 Contributing ideas to the Company''s events and Marketing campaigns'
)
GO


IF OBJECT_ID('dbo.tblCategory', 'u') IS NOT NULL 
   DROP TABLE dbo.tblCategory;  
GO
CREATE TABLE tblCategory (
	categoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	categoryName varchar(50) NOT NULL
);
GO

INSERT INTO tblCategory ( categoryName) 
VALUES (N'Clerical / Administrative'),
	(N'QA / QC'),
	(N'HSE'),
	(N'Human Resources'),
	(N'Interpreter / Translator'),
	(N'Legal'),
 	(N'Customer Service'),
	(N'Education'),
	(N'Health Care'),
 	(N'Security'),
 	(N'Accounting / Audit'),
 	(N'Banking / Securities'),
 	(N'Finance / Investment'),
 	(N'Insurance '),
 	(N'Advertising / Promotion / PR'),
 	(N'Consulting'),
	(N'Fashion'),
	(N'Household'),
 	(N'Marketing'),
 	(N'Sales'),
	(N'Export / Import '),
 	(N'Purchasing'),
	(N'Transportation / Logistics / Warehouse'),
 	(N'IT - Hardware'),
 	(N'IT - Software'),
 	(N'Travel '),
 	(N'Restaurant / Food Service'),
 	(N'Hotel'),
 	(N'Electrical / Electronics'),
 	(N'Engineering / Mechanical'),
	(N'Environment / Waste Services'),
	(N'Maintenance '),
	(N'Pharmaceutical / Biotech'),
	(N'Automotive '),
	(N'Agriculture / Forestry'),
	(N'Chemical / Biochemical / Food Science '),
	(N'Fishery '),
 	(N'Manufacturing / Operations '),
	(N'Oil / Gas / Mineral '),
 	(N'Textiles / Garments'),
 	(N'Wood '),
	(N'Architecture'),
 	(N'Construction'),
	(N'Interior / Exterior'),
	(N'Real Estate'),
 	(N'Arts / Entertainment'),
	(N'Newspaper / Editor / Publishing'),
	(N'Telecommunications '),
 	(N'Executive Management'),
 	(N'Other')
GO

IF OBJECT_ID('dbo.tblJobOrder', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJobOrder;  
GO
CREATE TABLE tblJobOrder (
	jobOrderID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	userID INT NOT NULL,
	jobID INT NOT NULL,
	cvFile varchar(MAX),
	salaryDeal varchar(50),
	message varchar(2000),
	jobOrderStatus tinyint NOT NULL,
);
GO

