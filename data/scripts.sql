USE master
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'FuJobDB_1')
BEGIN
    DROP DATABASE FuJobDB_1;  
END;
CREATE DATABASE FuJobDB_1;
GO

USE FuJobDB_1
GO

IF OBJECT_ID('dbo.tblUsers', 'u') IS NOT NULL 
   DROP TABLE dbo.tblUsers;  
GO

CREATE TABLE tblUsers
(
	userID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	password varchar(500) NOT NULL,
	fullName varchar(50) NOT NULL,
	email varchar(50),
	roleID varchar(50),
	companyID INT,
	createdDate datetime,
	lastModifiedDate datetime,
	userStatus tinyint,
);
GO

IF OBJECT_ID('dbo.tblRoles', 'u') IS NOT NULL 
   DROP TABLE dbo.tblRoles;  
GO
CREATE TABLE tblRoles
(
	roleID varchar(50) NOT NULL PRIMARY KEY CLUSTERED,
	roleName varchar(50) NOT NULL,
	createdDate datetime,
	lastModifiedDate datetime,
	roleStatus bit
);
GO


IF OBJECT_ID('dbo.tblSkills', 'u') IS NOT NULL 
   DROP TABLE dbo.tblSkills;  
GO

CREATE TABLE tblSkills (
	skillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	skillName varchar (50),
	createdDate datetime,
	lastModifiedDate datetime,
	skillStatus bit,
);
GO

IF OBJECT_ID('dbo.tblCompanies', 'u') IS NOT NULL 
   DROP TABLE dbo.tblCompanies;  
GO

CREATE TABLE tblCompanies
(
	companyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	companyName Nvarchar(50),
	address Nvarchar(50),
	website varchar (100),
	gmail varchar(50),
	phone varchar(20),
	typeCompany varchar(30),
	establishedYear int,
	numberOfEmployee int,
	companyOverview Nvarchar(3000),
	avatar varchar (2000),
	createdDate datetime,
	lastModifiedDate datetime,
	businessLicense varchar(2000),
	companyStatus tinyint,
);
GO
IF OBJECT_ID('dbo.tblResumes', 'u') IS NOT NULL 
   DROP TABLE dbo.tblResumes;  
GO

CREATE TABLE tblResumes
(
	resumeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	userID INT NOT NULL,
	avatar varchar (2000),
	fullName Nvarchar(50),
	gender varchar(10),
	dateOfBirth date,
	gmail varchar(50),
	phone varchar(20),
	address Nvarchar(50),
	major varchar(50),
	gpa varchar(15),
	website varchar ( 100 ),
	gitHub varchar(3000),
	linkedIn varchar(3000),
	overview Nvarchar(3000),
	createdDate datetime,
	lastModifiedDate datetime,
	resumeStatus tinyint,

);
GO

IF OBJECT_ID('dbo.tblCategories', 'u') IS NOT NULL 
   DROP TABLE dbo.tblCategories;  
GO
CREATE TABLE tblCategories (
	categoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	categoryName varchar(50) NOT NULL,
	img varchar(2000),
	createdDate datetime,
	lastModifiedDate datetime,
	categoryStatus bit,
);
GO

IF OBJECT_ID('dbo.tblJobs', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJobs;  
GO
CREATE TABLE tblJobs(
	jobID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	userID INT NOT NULL,
	jobTitle varchar(255),
	jobCategoryID INT,
	budget float,
	paymentMethodID INT,
	address varchar(100),
	email varchar(255),
	phone varchar(15),
	description varchar(2000),
	createdDate datetime,
	lastModifiedDate datetime,
	expiriedDate datetime,
	jobStatus tinyint NOT NULL
);
GO

IF OBJECT_ID('dbo.tblJobApplications', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJobApplications;  
GO
CREATE TABLE tblJobApplications (
	jobApplicationID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	resumeID INT NOT NULL,
	jobID INT NOT NULL,
	cvFile varchar(MAX),
	priceDeal varchar(50),
	message varchar(2000),
	createdDate datetime,
	lastModifiedDate datetime,
	jobApplicationStatus tinyint NOT NULL,
);
GO

IF OBJECT_ID('dbo.tblJobSkills', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJobSkills;  
GO

CREATE TABLE tblJobSkills(
	jobSkillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[jobID] [int] NOT  NULL ,
	[skillID] [int] NOT NULL
);
GO

IF OBJECT_ID('dbo.tblResumeSkills', 'u') IS NOT NULL 
   DROP TABLE dbo.tblResumeSkills;  
GO

CREATE TABLE tblResumeSkills (
	resumeSkillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[resumeID] [int] NOT NULL,
	[skillID] [int] NOT NULL
);
GO

IF OBJECT_ID('dbo.tblPaymentMethods', 'u') IS NOT NULL 
   DROP TABLE dbo.tblPaymentMethods;  
GO
CREATE TABLE tblPaymentMethods (
	paymentMethodID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	paymentMethodName nvarchar(50) NOT NULL
);
GO






IF OBJECT_ID('dbo.tblEvaluateCompletion', 'u') IS NOT NULL 
   DROP TABLE dbo.tblEvaluateCompletion;  
GO

CREATE TABLE tblEvaluateCompletion (
	evaluateCompletionID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	reviewerID INT NOT NULL,
	jobID INT NOT NULL,
	resumeID INT NOT NULL,
	ratingValue INT,
	content Nvarchar(3000),
	createdDate datetime,
	lastModifiedDate datetime,
	evaluateCompletionStatus tinyint,
);

-----------------
ALTER TABLE tblEvaluateCompletion ADD CONSTRAINT fk_EvaluateCompletion_reviewerID
FOREIGN KEY(reviewerID) REFERENCES tblUsers(userID)
GO
ALTER TABLE tblEvaluateCompletion ADD CONSTRAINT fk_EvaluateCompletion_jobID
FOREIGN KEY(jobID) REFERENCES tblJobs(jobID)
GO
ALTER TABLE tblEvaluateCompletion ADD CONSTRAINT fk_EvaluateCompletion_resumeID
FOREIGN KEY(resumeID) REFERENCES tblResumes (resumeID)
GO

----------------
IF OBJECT_ID(N'lastUpdateEvaluateCompletion', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateSkill;  
GO
CREATE TRIGGER lastUpdateEvaluateCompletion on dbo.tblEvaluateCompletion
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblEvaluateCompletion
SET lastModifiedDate = GetDate()
WHERE evaluateCompletionID IN (SELECT evaluateCompletionID FROM inserted);
GO

IF OBJECT_ID(N'createdDateEvaluateCompletion', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateSkill;  
GO
CREATE TRIGGER createdDateEvaluateCompletion on dbo.tblEvaluateCompletion
	FOR INSERT  AS 
	UPDATE dbo.tblEvaluateCompletion
SET createdDate = GetDate()
WHERE evaluateCompletionID IN (SELECT evaluateCompletionID FROM inserted);
GO




--Referential Integrity Constraints
ALTER TABLE tblJobs ADD CONSTRAINT fk_Jobs_paymentMethodID
FOREIGN KEY(paymentMethodID) REFERENCES tblPaymentMethods(paymentMethodID)
GO
ALTER TABLE tblJobs ADD CONSTRAINT fk_Jobs_jobCategoryID
FOREIGN KEY(jobCategoryID) REFERENCES tblCategories(categoryID)
GO
ALTER TABLE tblJobs ADD CONSTRAINT fk_Jobs_userID
FOREIGN KEY(userID) REFERENCES tblUsers(userID)
GO
ALTER TABLE tblUsers ADD CONSTRAINT fk_Users_roleID
FOREIGN KEY(roleID) REFERENCES tblRoles(roleID)
GO
ALTER TABLE tblUsers ADD CONSTRAINT fk_Users_companyID
FOREIGN KEY(companyID) REFERENCES tblCompanies(companyID)
GO
ALTER TABLE tblResumes ADD CONSTRAINT fk_Resumes_userID
FOREIGN KEY(userID) REFERENCES tblUsers(userID)
GO
ALTER TABLE tblJobApplications ADD CONSTRAINT fk_JobApplications_resumeID
FOREIGN KEY(resumeID) REFERENCES tblResumes(resumeID)
GO
ALTER TABLE tblJobApplications ADD CONSTRAINT fk_JobApplications_jobID
FOREIGN KEY(jobID) REFERENCES tblJobs(jobID)
GO
ALTER TABLE tblJobSkills ADD CONSTRAINT fk_JobSkills_jobID
FOREIGN KEY(jobID) REFERENCES tblJobs(jobID)
GO
ALTER TABLE tblJobSkills ADD CONSTRAINT fk_JobSkills_skillID
FOREIGN KEY(skillID) REFERENCES tblSkills(skillID)
GO
ALTER TABLE tblResumeSkills ADD CONSTRAINT fk_ResumeSkills_resumeID
FOREIGN KEY(resumeID) REFERENCES tblResumes(resumeID)
GO
ALTER TABLE tblResumeSkills ADD CONSTRAINT fk_ResumeSkills_skillID
FOREIGN KEY(skillID) REFERENCES tblSkills(skillID)
GO


--TRIGGERS
	--tblRoles
IF OBJECT_ID(N'lastUpdateRole', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateRole;  
GO 
CREATE TRIGGER lastUpdateRole on dbo.tblRoles
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblRoles
SET lastModifiedDate = GetDate()
WHERE roleID IN (SELECT roleID FROM inserted);
GO

IF OBJECT_ID(N'createdDateRole', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateRole;  
GO 
CREATE TRIGGER createdDateRole on dbo.tblRoles
	FOR INSERT  AS 
	UPDATE dbo.tblRoles
SET createdDate = GetDate()
WHERE roleID IN (SELECT roleID FROM inserted);
GO
	--tblUsers
IF OBJECT_ID(N'lastUpdateUser', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateUser;  
GO 
CREATE TRIGGER lastUpdateUser on dbo.tblUsers
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblUsers
SET lastModifiedDate = GetDate()
WHERE userID IN (SELECT userID FROM inserted);
GO

IF OBJECT_ID(N'createdDateUser', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateUser;  
GO
CREATE TRIGGER createdDateUser on dbo.tblUsers
	FOR INSERT  AS 
	UPDATE dbo.tblUsers
SET createdDate = GetDate()
WHERE userID IN (SELECT userID FROM inserted);
GO

	--tblSkills
IF OBJECT_ID(N'lastUpdateSkill', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateSkill;  
GO
CREATE TRIGGER lastUpdateSkill on dbo.tblSkills
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblSkills
SET lastModifiedDate = GetDate()
WHERE skillID IN (SELECT skillID FROM inserted);
GO

IF OBJECT_ID(N'createdDateSkill', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateSkill;  
GO
CREATE TRIGGER createdDateSkill on dbo.tblSkills
	FOR INSERT  AS 
	UPDATE dbo.tblSkills
SET createdDate = GetDate()
WHERE skillID IN (SELECT skillID FROM inserted);
GO

	--tblJobs
IF OBJECT_ID(N'lastUpdateJob', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateJob;  
GO
CREATE TRIGGER lastUpdateJob on dbo.tblJobs
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblJobs
SET lastModifiedDate = GetDate()
WHERE jobID IN (SELECT jobID FROM inserted);
GO

IF OBJECT_ID(N'createdDateJob', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateJob;  
GO
CREATE TRIGGER createdDateJob on dbo.tblJobs
	FOR INSERT  AS 
	UPDATE dbo.tblJobs
SET createdDate = GetDate()
WHERE jobID IN (SELECT jobID FROM inserted);
GO

	--tblCompanies
IF OBJECT_ID(N'lastUpdateCompany', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateCompany;  
GO
CREATE TRIGGER lastUpdateCompany on dbo.tblCompanies
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblCompanies
SET lastModifiedDate = GetDate()
WHERE companyID IN (SELECT companyID FROM inserted);
GO

IF OBJECT_ID(N'createdDateCompany', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateCompany;  
GO
CREATE TRIGGER createdDateCompany on dbo.tblCompanies
	FOR INSERT  AS 
	UPDATE dbo.tblCompanies
SET createdDate = GetDate()
WHERE companyID IN (SELECT companyID FROM inserted);
GO	

	--tblResumes
IF OBJECT_ID(N'lastUpdateResume', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateResume;  
GO
CREATE TRIGGER lastUpdateResume on dbo.tblResumes
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblResumes
SET lastModifiedDate = GetDate()
WHERE resumeID IN (SELECT resumeID FROM inserted);
GO

IF OBJECT_ID(N'createdDateResume', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateResume;  
GO
CREATE TRIGGER createdDateResume on dbo.tblResumes
	FOR INSERT  AS 
	UPDATE dbo.tblResumes
SET createdDate = GetDate()
WHERE resumeID IN (SELECT resumeID FROM inserted);
GO

	--tblCategories
IF OBJECT_ID(N'lastUpdateCategory', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateCategory;  
GO
CREATE TRIGGER lastUpdateCategory on dbo.tblCategories
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblCategories
SET lastModifiedDate = GetDate()
WHERE categoryID IN (SELECT categoryID FROM inserted);
GO

IF OBJECT_ID(N'createdDateCategory', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateCategory;  
GO
CREATE TRIGGER createdDateCategory on dbo.tblCategories
	FOR INSERT  AS 
	UPDATE dbo.tblCategories
SET createdDate = GetDate()
WHERE categoryID IN (SELECT categoryID FROM inserted);
GO

	--tblJobApplications
IF OBJECT_ID(N'lastUpdateJobApplication', N'TR') IS NOT NULL  
    DROP TRIGGER lastUpdateJobApplication;  
GO
CREATE TRIGGER lastUpdateJobApplication on dbo.tblJobApplications
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblJobApplications
SET lastModifiedDate = GetDate()
WHERE jobApplicationID IN (SELECT jobApplicationID FROM inserted);
GO

IF OBJECT_ID(N'createdDateApplication', N'TR') IS NOT NULL  
    DROP TRIGGER createdDateApplication;  
GO
CREATE TRIGGER createdDateApplication on dbo.tblJobApplications
	FOR INSERT  AS 
	UPDATE dbo.tblJobApplications
SET createdDate = GetDate()
WHERE jobApplicationID IN (SELECT jobApplicationID FROM inserted);
GO


--INSERT DATA

INSERT INTO tblRoles(roleID, roleName) 
VALUES	(N'AD', N'Admin'),
      	(N'US', N'User'),
	(N'HR', N'Human Resource'),
	(N'HRM', N'Human Resource Management')
GO


INSERT INTO tblPaymentMethods(paymentMethodName) 
VALUES	(N'Pay fixed Price'),
      	(N'Pay by Hour')
GO

INSERT INTO tblCompanies(companyName, address, website, gmail, phone, typeCompany, establishedYear, numberOfEmployee, companyOverview, companyStatus)
VALUES	('FPT SOFTWARE', ' District 9, Ho Chi Minh City', 'https://www.fpt-software.com', 'fhcm.contact@fsoft.com.vn', '+84 (28) 3 736 2323', 'Company Limited', 1999, 21000, 'FPT Software is a member company of FPT Corporation. Established in 1999, FPT Software is currently a company specializing in providing software services and solutions to international customers, with more than 21,000 employees, present in 27 countries around the globe. For many years in a row, FPT Software has been voted as the most favorite Employer and in the TOP of companies with the best working environment in Asia.', 1),
		('VINAMILK', 'District 7, Ho Chi Minh City', 'https://www.vinamilk.com.vn/', 'vinamilk@vinamilk.com.vn', '(028) 54 155 555', 'Joint Stock Company', 1976, 11000, 'Vinamilk was born on August 20, 1976. This is a company established on the basis of taking over 3 dairy factories, left by the old regime. Since then, when successively awarded the Labor Medal by the State, the title of Labor Hero in the renovation period... Vinamilk has built dairy farms in all parts of the country. Not only developing in the domestic market, Vinamilk also expanded its brand to New Zealand and more than 20 other countries, including the US. In addition, Vinamilk is also a pioneer brand opening the way to the high-end organic food market in Vietnam, with fresh dairy products that meet USDA standards in the United States.', 1),
		('GARENA', 'Ba Dinh District, Hanoi Capital', 'https://www.garena.vn/', 'garenahr@ved.com.vn', '024 73053939', 'Joint Stock Company', 2009, 3000, 'We are gamers. We are proud to say that. We play games with the same passion as you, so we also want to create amazing and unforgettable experiences. We are builders. We don''t just make games, we build communities. Our games connect millions of people from all over the world, creating a huge community of shared interests and passions. Our mission is to create and give you the opportunity to join us - where we consider our second family. At Garena, community is everything to us.', 1),
		('KMS TECHNOLOGY', 'Tan Binh District, Ho Chi Minh City', 'https://kms-technology.com/', 'mkt@kms-technology.com', '(08) 3811 9977', 'Company Limited', 2009, 1018,'KMS Technology was founded by a veteran IT team in the US and Vietnam with the vision of building an agile, innovative, and efficient organization to increase customer shareholder value. KMS provides services throughout the software development lifecycle through partnerships with clients ranging from startups to large technology companies. We provide two main lines of services: overseas product development and independent software testing. Our infrastructure, methodology, design team, staff profile and customer relationship models are designed to maximize the customer success that we can. Helps to reduce time to market and improve quality.', 1),
		('KATALON', 'District 10, Ho Chi Minh City', 'https://katalon.com/', 'partner@katalon.com', '0982369322', 'Company Limited', 2015, 1000, 'We are a global team with various backgrounds and cultures yet with the common desire to help make better software easier. We work with the community to truly understand obstacles and roadblocks in software quality and then collaborate with others to create innovative and practical solutions. We at Katalon help teams build better software faster with our innovative, programmatic, and tenacious testing tools.  Over 100k individuals use our products to write, execute, and analyze tests, and over 10k teams of all sizes use Katalon’s platform to organize, orchestrate, and scale their DevOps and test automation.', 1)

INSERT INTO tblUsers(password,fullName,email,roleID,userStatus, companyID) 
VALUES (N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW' , N'Tao la Admin' , N'admin@gmail.com',N'AD', 1, NULL),
	--Student
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Van A', N'abc@fpt.edu.vn', N'US',1, NULL),
     	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Pham Duc Hung', N'hungpdse150222@fpt.edu.vn', N'US',1, NULL),
	(N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Ngo Gia Bao', N'baohngse150260@fpt.edu.vn', N'US',1, NULL),
      	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Le Ha Duy', N'duylhse150233@fpt.edu.vn', N'US',1, NULL),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Le Quoc Binh', N'binhlqse150199@fpt.edu.vn', N'US',1, NULL),
	--HRM 7
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Tot', N'hrm1@gmail.com', N'HRM',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Lai Van Huynh', N'hrm2@gmail.com', N'HRM',1, 2),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Quoc Sang', N'hrm3@gmail.com', N'HRM',1, 3),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Tuan Tu', N'hrm4@gmail.com', N'HRM',1, 4),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Huu Tai', N'hrm5@gmail.com', N'HRM',1, 5),
	--HR 12
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Van', N'hr1@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Tu Van', N'hr2@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Gia Tuan', N'hr3@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Duc Hung', N'hr4@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Anh Hoang', N'hr5@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Van Quoc Van', N'hr26@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Xa Tri', N'hr27@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Gia Hao', N'hr28@gmail.com', N'HR',0, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Tung Hung', N'hr29@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Anh Hoa', N'hr30@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Vang Ong', N'hr31@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Ha Ha', N'hr32@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Gia Uyen', N'hr33@gmail.com', N'HR',0, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Duc Sang', N'hr34@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Hoang', N'hr35@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Tuan Ung', N'hr36@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Le Tu Tuan', N'hr37@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Ho Gia Ta', N'hr38@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Toan', N'hr39@gmail.com', N'HR',1, 1),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Duc Gia', N'hr40@gmail.com', N'HR',1, 1),
	--32
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Tran Phong', N'hr6@gmail.com', N'HR',1, 2),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Dang Tra Quang', N'hr7@gmail.com', N'HR',1, 2),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Hai Phong', N'hr8@gmail.com', N'HR',1, 2),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Quang Hai', N'hr9@gmail.com', N'HR',1, 2),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Thanh Van', N'hr10@gmail.com', N'HR',1, 2),
	--37
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Tran Sang', N'hr11@gmail.com', N'HR',1, 3),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Hoai Niem', N'hr12@gmail.com', N'HR',1, 3),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Giong Cao', N'hr13@gmail.com', N'HR',1, 3),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Tran Phu', N'hr14@gmail.com', N'HR',1, 3),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Phong', N'hr15@gmail.com', N'HR',1, 3),
	--42
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Tran Nen', N'hr16@gmail.com', N'HR',1, 4),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Luong Xuan Truong ', N'hr17@gmail.com', N'HR',1, 4),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Do Duy Manh', N'hr18@gmail.com', N'HR',1, 4),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Tien Dung', N'hr19@gmail.com', N'HR',1, 4),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Bui Tan Truong', N'hr20@gmail.com', N'HR',1, 4),
	--47
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Tuan Anh', N'hr21@gmail.com', N'HR',1, 5),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Luong Hoang Duc', N'hr22@gmail.com', N'HR',1, 5),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Do Hung Dung', N'hr23@gmail.com', N'HR',1, 5),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Dinh Trong', N'hr24@gmail.com', N'HR',1, 5),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Vu Van Thanh', N'hr25@gmail.com', N'HR',1, 5),
	--52 student
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Bao Toan', N'toannbse150270@fpt.edu.vn', N'US',1, NULL),
	( N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Le Thai Phong', N'phonglt150407@fpt.edu.vn', N'US',1, NULL)
	
	
GO

INSERT  INTO tblSkills (skillName, skillStatus)
VALUES ('.NET', 1),('2D', 1),('2D Animation',1),('3D',1),('3D Animation',1),('3D CAD',1),('A/B Testing',1),
	('ABAP',1),('Actionscript',1),('Adobe Dreamweaver',1),('Adobe Illustrator',1),('Adobe InDesign',1),('Adobe Photoshop',1),
	('After Effect',1),('AI',1),('AJAX',1),('Music',1),('Amplitude',1),('Android',1),('Angular',1),('Angular 2',1),('Angular 5',1),('Angular 6',1),
	('Angular 7',1),('Angular 8',1),('Angular Material Design',1),('AngularJS',1),('Photoionization',1),('App development',1),('Archicad',1),
	('ASP',1),('ASP.NET',1),('Aura',1),('Aurelia.js',1),('AutoCAD',1),('Automation Testing',1),('AWS',1),('Babylon.js',1),('Backbone.js',1),
	('Cartography & Maps',1),('Sales',1),('License of Invention',1),('Packing',1),('Financial Report',1),('Tax report',1),('Newspapers',1),('Insurance',1),
	('Social Insurance based on State Regulations',1),('Real estate',1),('Translators and interpreters',1),('Editor',1),('Book Editing',1),('Web Content Editor',1),
	('Big Data',1),('Bitbucket',1),('Bizweb',1),('Bizweb App',1),('Bizweb theme',1),('Blender',1),('Blockchain',1),('Book KOL',1),('Bootstrap',1),('Branding',1),
	('Brochure',1),('Business Analysis',1),('Business Intelligence',1),('C#',1),('C++',1),('CakePHP',1),('Calq.io',1),('Content Update',1),('Captcha',1),('Cut HTML/CSS',1),
	('Lyrics Rewriting',1),('Corporate Strategy',1),('HR Strategy',1),('Brand Strategy',1),('Video Broadcasting',1),('Photo Edit',1),('Edit Photos',1),('Photography',1),
	('Wedding Photography',1),('Baby Photography',1),('Food Photography',1),('Interior Photography',1),('Event Photography',1),('Product Photography',1),
	('Model Photography',1),('Landscape Photography',1),('Clip',1),('CMS',1),('Mechatronics',1),('Cocos2D',1),('Code',1),('CodeIgniter',1),('Space Technology',1),
	('Nanotechnology',1),('Clean Technology',1),('Biotechnology',1),('Copywriting',1),('CorelDraw',1),('CRM',1),('Cryptocurrency',1),('CS-Cart',1),('CSS',1),('CSS3',1),
	('Wedding',1),('cURL',1),('D3.js',1),('MC',1),('Business Card',1),('Data Driven',1),('Data Insights',1),('Data Processing',1),('Data Visualisation',1),('Datadog',1),
	('Design',1),('Genetic',1),('Articles Translation',1),('Subtitles',1),('Book Translation',1),('Technical Document Translation',1),('Translation',1),
	('Audio Service',1),('Amazon Website Services',1),('Video Service',1),('Digital Marketing',1),('Nutrition',1),('Django',1),('Docker',1),('Draw.io',1),('Drupal',1),
	('Negotiation',1),('Forum Posting',1),('Newspaper Posting',1),('Ads Posting',1),('Video Uploading',1),('Review',1),('Evaluation & Appraisal',1),('Typing',1),
	('Typing Text',1),('Director',1),('Training',1),('Sales Skills Training',1),('Soft skills Training',1),('Customer Service Training',1),('Sales Training',1),
	('Accounting Training',1),('Other Professional Training',1 ),('PR Training',1),('HR Training',1),('Financial Training',1),('Geological',1),('Light Electricity',1),
	('Cloud Computing',1),('Electronic',1),( 'Market Research',1),('Positioning',1),('Motions Graphics',1),('Computer Graphics',1),('Correction',1),('Editing',1),('EFY',1),
	('Elasticsearch',1), ('Email Marketing',1),('Ember.js',1),('Erlang',1),('Etabs',1),('Excel',1),('Facebook Ad',1),('Facebook Analytics',1),('Facebook API',1),
	('Facebook Fanpage',1),('Figma',1),('Final Cut Pro X',1),('Firebase',1),('Flash',1),('Flex',1),('Flutter',1), ('Fontlab',1),('Fortran',1),('Forum seeding',1),
	('FuelPHP',1),('Game Design',1),('Fundraising',1),('GDN',1),('Project Supervision',1) ,('Christmas',1),('Education & Tutor',1),('Git',1),('Golang',1),
	('Google Adwords',1),('Google Analytics',1),('Google API',1),( 'Google Cloud',1),('Google Sheets',1),('Grails',1),('Graphic Design',1),('Groovy',1),('Growth Hacking',1),
	('Grunt & Gulp',1),('Hara van',1),('Dating',1),('Phone Support',1),('Customer Support',1),('Technical Assistance',1),('Screen Support',1),('Seminar',1),('Contract',1),
	('Hosting',1),('HTML',1),('HTML5',1),('Hubspot',1),('Illustration',1),('Printing',1),('Infographics',1),('Internet marketing',1),( 'Invision',1),('iOS',1),('Java',1),('Javascript',1),
	('Joomla',1),('Joomla Extensions',1),('JoomlArt',1),('jQuery',1),('JSF',1),('JSON',1),('JSP',1),('K2',1),('Business Plan',1),('Accountant',1),('Management Accounting',1),
	('Tax Accounting',1),( 'General Accounting',1),('Kentico',1),('Data Mining',1),('Mining',1),('Market Survey',1),('Slogan',1),('Robotics Science',1),('Humanities',1) ,
	('Climate Science',1),('Startup',1),('Wireless',1),('Geospatial',1),('Technical',1),('Structural Engineering',1),('Mechanical Engineering',1),('Industrial Engineering',1),
	('Civil Engineering',1),('Petroleum Engineering',1),('Textile Art',1),('Genetic Engineering',1),('Electrical Engineering',1),('Chemical Engineering',1),
	('Material Engineering',1),('Telecommunications Engineering',1),('Quality Assurance',1),('Audit',1),('Internal Audit',1),('Automated Techn ical Testing',1),
	('Software Testing',1),('Testing/QA',1),('Software Architecture',1),('Architectural Building',1),('Kohana',1),('Konakart',1),('Jewelry',1),('Radio Engineering',1),
	('Video Techniques',1),('Bookkeeping',1),('LAMP',1),('Landing Pages',1),('Contracting',1),('Project Planning',1),( 'Event Planning',1),('Photoshop Coding',1),('Assemble',1),
	('Access Programming',1),('Action-script Programming',1),('C Programming',1),('C# Programming',1),( 'C++ Programming',1),('Software Programming',1),
	('Application Programming',1),('VBA Autocad Programming',1),('Web Programming',1),('Laravel',1),('History',1),('Liferay',1),('Lightroom',1),('Linux',1),('Civil Law',1),
	('Criminal Law',1),('Economic Law',1),('Labor Law',1),('Real estate Law',1) ,('Tax Law',1),('Quantum',1),('Magento',1),('Magestore',1),('Social Network',1),('Viral Marketing',1),
	('Affiliate Marketing',1),('Cipher',1),('Matlab',1),('Mautic',1),('Meteor',1),('Meteor.js',1),('Arts',1),('Microsoft Office',1),('Illustrations',1),('Mixpanel',1),
	('Fashion Model',1),('Product Description',1),('Mobile application',1),('Mocha & Chai',1),('Mockup',1), ('MongoDB',1),('Moodle',1),('Motion graphics',1),('MS Excel',1),
	('MSSQL',1),('Ads Planning',1),('MVC',1),('MySQL',1),('Capture the psyche',1),('Energy',1),('Cooking and Recipes',1),('Nette',1),('Neural network',1),('Research',1),
	('Scientific Research',1),('Legal Research',1),('Financial Research',1),('Market Analysis',1),('Nginx',1),('Natural Language',1),('Face Recognition',1),('Brand Identity',1),
	('Personnel',1),('Data entry',1),('Import Data',1),('Photographers',1),('Node.js',1),('Nopcommerce',1),('Objective-C',1), ('Odoo',1),('OpenCart',1),('OpenCV',1),('OXID eSales',1),
	('Barista',1),('Sketching Ideas',1),('Phalcon (PHP framework)',1),('CRM Software',1),('ERP Software',1),('Accounting Software',1),('HR Software',1),('Management Software',1),
	('Analysis',1),('Business Analytical ',1),('Training Needs Analysis (TNA)',1),('Finite Element Analysis',1),('PhantomJS',1),('Juridical',1),
	('Sketching Samples with Autocad 2D',1),('Real estate Development',1),('Personal Development',1),('Software Development',1),('interpreter',1),
	('Mixing & Mastering',1),('Photo editing',1),('PHP',1),('PHPixie',1),('Play 2',1), ('Plugins',1),('Polymer',1),('Polymer.js',1),('PostgreSQL',1),('PR',1),
	('Presentation Design ',1),('PrestaShop',1),('Prototype',1),('PSD',1),('Python',1),('Public Relations',1),('Media Relations',1),('Manager',1),('Project Manager',1),
	('Real estate Management',1),('Fan Page Management',1),('Warehouse Management',1),('Product Management',1),('Entertainment Event Management',1),('Website Management',1),
	( 'Database Administrator',1),('System Management',1),('Advertisement',1),('Print Advertising',1),('Facebook Ads',1),('Google Ads',1),('Outdoor Advertising',1),
	('Online Advertising',1),('TVC Advertising',1),('Filming',1),('Linear Programming',1),('Tax Settlement',1),('React Native',1),('React.js',1),('Responsive',1),('Retouching',1),
	('Ruby on Rails',1),('Salesforce CRM',1),('Manufacture',1),('Animation Production',1),('After Production',1),('Scala',1),( 'Scrum',1),('Selenium',1),('SEM',1),('Sendy',1),('SEO',1),
	('Sharepoint',1),('Shopify',1),('Silex',1),('Simicart ',1),('Slideshow',1),('Slim',1),('Smarty',1),('Social Networking',1),('Socket.io',1),('Spine',1),('Spring Framework',1),
	( 'Spring MVC',1),('SQL',1),('SQL server',1),('SQLite',1),('Storyboard',1),('Trust',1),('Struts 1',1),('Struts 2',1) ,('Swift' ,1),('Symfony',1),('Business Finance',1),
	('Financial Accounting',1),('Psychology',1),('Blogging',1),('3D Modeling',1),('Templates Creation',1),('Brand Building',1),('Telesale',1),('Testing',1),('Sport',1),
	('Commercial Market',1),('Designer',1),('2D Design',1),('3D Design',1), ('Sound Design',1),('Signboard design',1),('Banner Design',1),('html5. Banner Design',1),
	('Industrial Packaging Design',1),('Letter Cover Design',1),('Icon Design',1),('Blog Design',1),('Brochure Design',1),('Landscape Design',1),( 'Industrial Design',1),
	('Graphic Designing',1),('Flash Design',1),('Theme Design',1),('Sticker Design',1),('Digital Design',1),('House Design',1),('Office Design',1),('Logo Desgin',1),
	('Logo Design',1),('Product Design',1),('Exterior Design',1),('Brand design',1),('Character Design',1),('Interior Design',1),('Photoshop',1),('Poster Design',1),
	('Profile Design',1),('Advertising Design',1),('Book Design',1),('Products Design',1),('Production Design',1),('Creative Design',1),('Invitation Card Design',1),
	('Fashion Designer',1),('Flyer Design',1),('Website Design',1),('Games Design',1),('UML Design',1),('Microchips Design',1),('Web Design',1),('Poem',1),('Press Release',1),
	('Three.js',1),('Recording',1),('Crafts',1),( 'Website Testing',1),('Visa / Immigration Procedures',1),('Algorithm',1),('Tax',1),('Presentation',1),('Arabic',1),
	('Afrikaans',1),('Albanian',1 ),('English',1),('Polish',1),('Basque',1),('Bengali',1),('Portuguese',1),('Bosnian',1), ('Bulgarian',1),('Catalan',1),('Croatian',1),('Danish',1),
	('German',1),('Dutch',1),('Korean',1),('Hebrew',1),('Hindi',1),('Chinese Language',1),('Hungarian',1),('Greek',1),('Indonesian',1),('Kannada',1),('Latvian',1),('Lithuanian',1),
	('Macedonian',1),('Malayalam',1),('Malaysian',1),('Norwegian',1),('Russian',1),('Japanese',1),('Finnish',1),('French',1),('Filipino',1) ,('Punjabi',1),('Roumanian',1),('Czech',1),
	('Serbian',1),('Slovak',1),('Slovenian',1),('Tamil',1),('Spanish',1),( 'Telugu',1),('Thai',1),('Turkish',1),('Swedish',1),('Chinese',1),('Simplified Chinese',1),
	('Traditional Chinese',1),('Urdu',1),( 'Vietnamese',1),('Welsh',1),('Italian',1),('Marketing',1),('Mass Marketing',1),('Mail Marketing',1),('Network Marketing',1),
	('Telemarketing',1), ('Web Search',1),('Sourcing',1),('Product Sourcing',1),('Sourcing Buyers',1),('Office Information',1),('Event Organization',1),('Math',1),
	('Server Optimization',1),('Tomcat',1),('Trados',1),('Landing Page',1),('Caricatures & Cartoons',1),('ERP Implementation',1),('Present',1),('Online Assistant',1),
	('Pre-production',1),('Short Story',1),('Media',1),('Automation',1),('Managem ent Consulting',1),('Psychological Consulting',1),('Taxes Consulting',1),('Recruitment',1),
	('TV Advertising',1),('Twitter API',1),('Twitter Marketing',1),('Typescript',1),('TYPO3 Flow',1),('Typography',1),('Underscore',1),('Sales Apps',1),('Unity 2D',1),
	('Unreal engine',1),('Unreal engine 4',1), ('User flow',1),('User research',1),('User story',1),('Vaadin',1),('Physics',1),('Astrophysics',1),('VBA',1),('Book Cover Drawing ',1),
	('Chibi Drawing',1),('Technical Drawing',1),('Illustrator',1),('Hand Painting',1),('Drawing',1),('Caricature Drawing',1),('Comic Drawing',1), ('Wacom Drawing',1),
	('Microcontrollers',1),('Video Editing',1),('Product Video',1),('Explore',1),('Fiction',1),('Write articles',1),('Articles Writing ',1),('Report Writing',1),
	('Blog Writing',1),('Write Blog/Forum',1),('Speech Writing',1),('Travel Writing',1),('Funding Proposal Writing',1),('Proposal Writing',1),('Academic Writing',1),
	('Technical Writing',1),('Script Writing',1),('Video Script',1),('Ads Script Writing',1),('Essay Writing',1),('Press Release Writing',1),('Website Content Writing',1),
	('Ads Writing',1),('Review Writing',1),('Book Writing',1),('Creative Writing',1),('Stories Writing',1),('Medical Writing',1),
	('Medical Writing Visual Basic for Applications',1), ('Viral Content',1),('Visual Basic for Applications',1),('VPS',1),('VR tour',1),
	('Vray',1),('Vue.js',1),('Vue.js and express.js',1),('WCF',1),('Web content',1),('Websites Design',1),('Web Scraping',1),('Webbnc',1),('Website Analytics',1),('Websocket',1),
	('Wireframe',1),('Woocommerce',1),('Wordpress',1),('Xamarin',1),('Aviation Construction',1),('Bookkeeping System Building',1),( 'Salary Scale Building',1),('IoT', 1),('Arduino',1)
GO

INSERT INTO tblCategories ( categoryName,img, categoryStatus) 
VALUES  
	('International Business', 'https://cdn.dribbble.com/users/7031637/screenshots/15591230/gig-8_4x.jpg',1),
	('Software Engineering', 'https://www.logopik.com/wp-content/uploads/edd/2018/10/Software-Engineering-Vector-Logo.png',1),
	('Information Assurance', 'https://media.istockphoto.com/vectors/quick-key-logo-design-template-vector-id1013496226?b=1&k=20&m=1013496226&s=612x612&w=0&h=sywpjBFewebZRb7U9LbpfuNRChgg0oPXHUrWhEkAubE=',1),
	('Multimedia Communication', 'https://i.pinimg.com/736x/77/7f/3e/777f3e9f89ac6e127882d31199faee20.jpg',1),
	('Graphic Design', 'https://cdn.dribbble.com/users/5246557/screenshots/12263175/media/f9210e3bf7a485987a931a3a54c8b70c.jpg?compress=1&resize=400x300&vertical=top',1),
	('Hotel Management', 'https://www.pngkey.com/png/detail/376-3765477_hospitality-management-icon-logo-hospitality-management.png',1),
	('Tourism service and Travel Management', 'https://www.nicepng.com/png/detail/370-3705541_gtifavi2-travel-insurance-logo-png.png',1),
	('English language', 'https://w7.pngwing.com/pngs/230/768/png-transparent-english-world-foreign-language-colloquialism-england-miscellaneous-blue-text.png',1),
	('Japanese language', 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Japanese-language.jpg',1),
	('Digital Marketing', 'https://banner2.cleanpng.com/20181210/jsb/kisspng-digital-marketing-marketing-strategy-social-media-internet-png-images-png-mart-5c0e7c2c9723e1.5757274415444531646191.jpg',1),
	('Information System', 'https://www.logolynx.com/images/logolynx/s_7b/7bd3f19896635439f5d9f4cc08086934.gif',1),
	('Artificial Intelligence', 'https://i.pinimg.com/736x/f6/fa/4e/f6fa4e259c05252ba32cd12e98061b11.jpg',1),
	('Korean Language', 'https://charuzu.files.wordpress.com/2015/09/korea_south_640.png',1),
	('Internet of Things', 'https://lumihaiphong.vn/Data/images/IOT_Internet_of_Things_2017.jpg',1),
	(N'Other', 'https://seeklogo.com/images/U/undefined-logo-FE82D12763-seeklogo.com.gif',1)
GO

INSERT INTO tblJobs (userID, jobTitle, jobCategoryID, budget, paymentMethodID, address, email, phone, description, expiriedDate, jobStatus)
VALUES 
	(12, 'International situation analysis', 1, 2000, 1, 'Ho Chi Minh City', 'timkinhdoanhquocte@gmail.com', '0988234654', 'Use All Source Intelligence to analysis international conflict/trade/business/affair/relation.', '2022-08-17', 1),
	(12, 'Need Facebook Live Veiw Increase Bot', 2, 20, 1, 'Da Nang City', 'timsw@gmail.com', '0988214454', 'Need Facebook Live View Increase Bot simple tool easy to use', '2022-09-17', 1),
	(12, 'Cyber security expert needed for a database application analysis', 3, 20, 1,'Ho Chi Minh City', 'timia@gmail.com', '0988215654', 'I need a person to look at my issue to resolve it in a timely manner, Please let me know if you are available to handle this. I am very excited to work with you guys. Please contact me and I would love to provide you with more context about the task.','2022-09-17', 1),
	(12, 'Graphic Design', 5, 20, 1, 'Ha Noi Capital', 'timgd@gmail.com', '0988219654', 'We are needing someone to create social media graphics in various sizes. The output will be in PNG files saved with transparency.  We will need square format and story format images.  We will be able to give complete direction with sample work to be modified and created.  We will be available via email and zoom to give direction. This project is more redesigning existing collateral media with direction than creating content from scratch.', '2022-09-10', 1),
	(12, 'Sales Staff (Selling Tickets at Counters/ Stations, Concierge)', 6, 1, 2, 'Ho Chi Minh', 'timhm@gmail.com', '0982314454', 'Ticket sales, customer support at the counter at the Independence Palace in District 1: shifts 8am to 3pm every day; and/or: assisting customers at Hop on Hop off double-decker bus (stops at pedestrian street 92 Nguyen Hue, District 1 and at City Post Office No. 2 Paris Commune District 1): shift 8:30am - 4:00pm or 15:30-22:30', '2022-09-17', 1),
	
	(32, 'Multimedia Coordinator', 4, 20, 1, 'Ha Noi Capital', 'timmc@gmail.com', '0988212254', 'The Multimedia Coordinator will work under the direction of the Associate Athletic Director, External Affairs, in preparing video packages for the Athletics Department’s website and LED video boards. This position is responsible for generating social media content and assisting the administrative staff with special projects. There are currently two openings available for this position.', '2022-09-15', 1),
	(32, 'Tour Operator', 7, 20, 1, 'Hoi An City', 'timtour@gmail.com', '0988212254', 'Find someone who can lead the delegation to visit Hoi An. Required to be agile, energetic, funny, understand the characteristics needed for the tour. Able to control, manage the delegation, handle unexpected incidents. The trip lasts 3 days and 3 nights, with accommodation and food allowance available.', '2022-09-15', 1),
	(32, 'Blog article Englishr', 8, 100, 1, 'Toan Quoc', 'timta@gmail.com', '098821254', 'I need to find a freelancer who can write English well for long-term cooperation. Especially good at copywriting in English to write blog articles (about 1000 words). The job will be writing a blog article for a website about student life, job seeking experience, how to get high scores...You are encouraged to bid for the project: You have studied abroad in English speaking countries, IELTS 7.5-8.0 or higher or similar TOEFL, You are teaching English', '2022-10-15', 1),
	(32, 'Write articles in Japanese', 9, 200, 1, 'Toan Quoc', 'timtn@gmail.com', '0934212254', 'Writing Japanese articles for IT companies based on ideas and available information will be provided. Various topics: internal company events, product introduction, articles related to IT a bit (if you have IT knowledge),...', '2022-09-15', 1),
	(32, 'Google Ads Optimization for Selling AI Book',10 , 50, 1, 'Toan Quoc', 'timdm@gmail.com', '0703309128', 'Our AI book has sold more than 1000 copies using another ad platform. The point is the product is surely saleable. We have started using Google Ads. We need some optimizations of our Google Ads to give good conversion. We take care of the ads budget for sure. If with your optimized google ads we succeed to sell 5 copies, within the agreed ads budget, 5 STAR is guaranteed', '2022-08-23', 1),
	
	(37, 'Business Analyst For A Mini Project',11 , 30, 1, 'Can Tho City', 'timba@gmail.com', '0703308333', 'Working as a BA for a group of students, meeting, analyzing and understanding the software requirements for a small project at school. Ability to speak both English and Vietnamese fluently. Ability to conduct general desk research activities. Have a "can do" attitude, agile, and resilient. Does not afraid to ask questions when necessary', '2022-09-23', 1),
	(37, 'Clothes Customization Software For Ecommerce', 12, 2500, 1, 'Ho Chi Minh City', 'timai@gmail.com', '0703239128', 'A web application developed in either Python Django or Ruby on Rails  that will be mainly for customization of the clothes in an e-commerce for example suit, shirts, pants etc... the admin user should be able to scan fabric, sleeve, collar, cuff, placket etc... so that the end user will be able to customize the clothes he want as he likes, will send similar websites for the developer that will be working on this project, the candidate should have an experience in developing such websites.', '2022-09-23', 1),
	(37, 'Korean translation collaborator, in the fields of Automotive',13, 200, 1, 'Ha Noi Capital', 'timth@gmail.com', '0890309128', 'Need someone to translate some car sales contracts in Korean. Requires final year Korean language students or TOPIK 5 or higher, know some automotive terms. Fun, sociable, agile, good appearance is an advantage.It is possible to give extra tips if the contract is smooth and favorable.', '2022-10-23', 1),
	(37, 'Configure IOT Project', 14, 100, 1,'Ben Tre City', 'timiot@gmail.com', '0703345128', 'Dear we are looking for someone with hands on experience in IOT to configure and run this project. The basis architecture is to have one Nodemcu that connect multiple   devices together that are connect to wireless connection and to measure the stability of the network. The task is to help on how to configure and run the projects and we will buy all necessary hardware.', '2022-11-23', 1),
	(37, 'IoT Developerr', 14, 1000, 1,'Ha Noi Capital', 'tỉmesd@gmail.com', '0234409128', 'Participating in programming of pic, arm, esp, family of microcontrollers..Developing Desktop applications, managing production for customer projects. Requires proficiency in programming languages C#, DotNet, MSSQL Server database. Knowledge of industry communication standards. Need to be smart, industrious, cheerful, sociable.', '2022-08-23', 1),
	
	(42, 'Japanese teacher',9 , 1000, 1,'Toan Quoc', 'timrr@gmail.com', '0703309128', ' If you are a person who is passionate about teaching, loves Japanese language and Japanese culture, wants to pass on knowledge, experience, and passion for Japanese to students through effective teaching methods. of KaizenYoshidaSchool, you will definitely succeed in your "teaching career" in Esuhai. ', '2022-08-23', 1),
	(42, 'Japanese interviewer',9, 1200, 1,'Ha Noi Capital', 'namnd@gmail.com', '0703309128', ' Assistant Translator for Japanese - Vietnamese, Vietnamese - Japanese for Japanese Managers, Translating documents, reports, meetings, seminars... according to work requirements. Create a bridge between the Japanese Management level and the personnel in the Department, Departments/Branches and the Company. Support reception, work contact with customers, partners inside and outside the company. Participate in meetings with Senior Managers, receptions. Grasp the Manager''s working schedule; Organize and support work reasonably and effectively. Perform other duties as assigned by the department manager. ', '2022-08-23', 1),
	(42, 'Merchandising Garment Industry',9, 1000, 1,'Da Nang City', 'hungld@gmail.com' , '0703309128', ' Process customer orders. Receive orders from existing customers. Track order progress from sample to delivery. Other tasks as required by the department head. Sample development process, working with related departments. Control and solve all problems related to order progress. Track customer deliveries and payments', '2022-08-23', 1),
	(42, 'Men Recruitment consulting',9, 500, 1, 'Ho Chi Minh City', 'kiencv@gmail.com', '0703309128', ' Create a source of candidates for foreign recruitment applications (Writing articles, editing, posting job ads, interviewing candidates). Takecare candidates during the CV interview process, exchange questions about the job), set up the interview. Data management, data entry, instructions for making records, medical examination. Support interview translation. Projects to develop overseas customers (contact by mail or in person) ', '2022-08-23', 1),
	(42, 'Japanese business assistance',9, 700, 1, 'Can Tho City', 'tottd@gmail.com', '0703309128', 'Dealing with customers and partners, from receiving orders to completing deliveries (Confront with customers and partners, from handle order to delivery). Handling problems arising on orders (Handle in order). Follow up and plan delivery on schedule (Follow arrange devilery on time as requirement). Prepare a list of liabilities and report at the end of the month (Preparing specified list and monthly report). Daily Japanese communication via email with the Japanese side (Daily Japanese communication with Japan side). Support team members if needed or other task from Director', '2022-08-23', 1),
	(42, 'Editor Japanese',9, 600, 1, 'Ca Mau City', 'ngocttm@gmail.com', '0703309128', 'Plan content and write content for the entire website and other communication channels of the company (fanpage,...). Manage all social networking sites. Seeding groups on social networks. Writing content for media publications such as advertising pages, leaflets, online and offline documents for marketing activities, branding, external communication marketing, etc. Writing PR articles. Support team in video projects. Working and building relationships with the media', '2022-08-23', 1),
	(42, 'Programmer (JavaScript, Jquery)',9, 2000, 1, 'Binh Duong City', 'vantt@gmail.com', '0703309128', 'Develop Web Application, using Intra-mart(IM-FormaDesigner、IM-LogicDesigner). Intra-mart is a product package providing IT solutions for businesses, built on the Java programming language with the support of Java frameworks such as seasar, terasoluna global. Before participating in development, there will be training support', '2022-08-23', 1),
	(42, 'Japanese Nursing N2',9, 1200, 1, 'Nghe An City', 'phongvt@gmail.com', '0703309128', 'Support doctors such as taking blood, injecting, giving fluids,...', '2022-08-23', 1),
	(42, 'N2 - Bridge Engineer',9, 2500, 1, 'Quang Tri City', 'hoangnt@gmail.com', '0703309128', 'Support Japanese PM to design the system, write detailed design documents and communicate to the project team in Vietnam. Solve problems arising in the project, and problems after handover. Technical support for team members. Check the quality of the project''s output products before handing over to customers.Manage project implementation progress, coordinate with customers and CEO in project management.', '2022-08-23', 1),
	(42, 'Staff',9, 300, 1, 'Da Lat City', 'longnn@gmail.com', '0703309128', 'Customer reception. Arrange for seating for customers. Place orders for customers. Serve food and drinks to guests. Support customer payments. Other tasks as assigned by management', '2022-08-23', 1),
	
	(47, 'Make Video Introduction of Educational Products (Korea)', 13, 300, 1, 'Toan Quoc', 'timsrdm@gmail.com', '0703309238', 'Hello everyone, my company is currently looking to hire a freelancer for video design for an educational product introduction project in Korea. The video is 5 minutes long. Required to edit clips, voiceover, edit effects, be a Korean language student or have TOPIK 4 certificate (The plan is sent in Korean). You can work from home online.', '2022-09-23', 1),
	(47, 'AI Machine Leaning App for Android', 12, 30, 1, 'Toan Quoc', 'timqqdm@gmail.com', '0703309238', 'I need an object detection app that allows me to take a picture with my phone camera and the app detects the desired object, crops the detected image/object using the bounding boxes coordinates and then , save the cropped image. I''ve got a well trained dataset. Requires a person with good AI skills, progressive spirit, fun sociable, responsible. If you are interested in the project, please contact me, we will discuss more.', '2022-11-23', 1),
	(47, 'Google APP developer', 2, 2000, 1,'Ho Chi Minh City', 'timdm22d@gmail.com', '0703908128', ' To sync the order details (Oderid,Email,Mobile number, quantity, price, skuid, Customer name, payment method, city, province) from shopify store and update it on google sheet. Update the order status of the courier (Despatch date, tracking id, courier name, delivery status, delivery date) in the same google sheet by getting the details from picked with the help of shopify order id and pickrr tracking number', '2022-09-25', 1),
	(47, 'Logo design for new brand', 5, 50, 1, 'Toan Quoc', 's1123imdm@gmail.com', '0703342428', 'I am looking for a designer to help create a logo for a new brand. We are launching a sustainable golf brand. We will be targeting the premium end of the marketing with the most sustainable, natural materials and processes. Our initial product offering will be very small, with subtle, memorable branding. We need a logo that can adorn products and marketing materials.', '2022-10-25', 1),
	(47, 'Primary school English tutor', 8, 3, 2, 'Ha Noi Capital', 'timdm3232@gmail.com', '0709009128', 'Teaching English online 1 on 1 or 1 on 2 for elementary students through Class-In software. Teaching according to the company''s documents and textbooks. Encourage teachers to contribute ideas and adjust the curriculum to suit students. Length of 1 class: 25 minutes/class. Teachers need to meet a minimum of 5 classes / week and commit to accompany students to the end of the course cycle (3 or 6 months). Briefly comment on the student''s learning situation after each lesson. Report the work situation to the Quality Manager as required & when required.', '2022-9-23', 1)
GO
	
INSERT INTO tblJobSkills (jobID, skillID)
VALUES 	(1, 65), (1, 66), 
	(2, 173), (2, 1), (2, 54),
	(3, 200), (3, 396),
	(4, 198), (4, 302), (4, 456),
	(5, 41),
	(6, 388), (6, 644), (6,100),
	(7, 146),
	(8, 512), (8, 625), (8, 622),
	(9, 539), (9, 625), (9,622),
	(10, 401), (10, 324),
	(11, 65), (11, 658),
	(12, 15), (12, 385), (12, 287),
	(13, 524), (13, 123),
	(14, 667), (14, 67), (14, 668),
	(15, 667), (15, 67),
	(16, 539), (16, 189),
	(17, 539), (17, 123),
	(18, 539), (18, 123),
	(19, 539), (19, 123),
	(20, 539), (20, 123), (20, 230), (20, 65),
	(21, 539), (21, 123), (21, 51), (21, 584),
	(22, 539), (22, 221), (22, 225), (22, 287),
	(23, 539), (22, 123),
	(24, 539), (24, 123), (24, 284),
	(25, 539), (25, 123), (25, 146),
	(26, 524), (26, 123), (26, 618), 
	(27, 15), (27, 19),
	(28, 193), (28, 194), (28, 29),
	(29, 476), (29, 456),
	(30, 512), (30, 189)	
GO

INSERT INTO tblResumes (userID, avatar, fullName, gender, dateOfBirth, gmail, phone, address, major, gpa, website, gitHub, linkedIn, overview, resumeStatus)
VALUES 	(2, 'https://static.vecteezy.com/system/resources/thumbnails/004/773/280/small/the-happy-girl-laughs-human-emotions-avatar-with-a-happy-woman-vector.jpg', 'Nguyen Van A', 'Female', '2000-01-01', 'anvse140222@fpt.edu.vn', '0987789987', 'District 6, Ho Chi Minh City', 'Software Engineering', '8/10', NULL, NULL, NULL, 'I am Nguyen Van A. I come from Nghe An, I want to become a full-stack development', 1),
	(3, 'https://media.istockphoto.com/vectors/portrait-of-an-asian-boy-the-face-of-an-asian-child-avatar-of-a-vector-id1222359540?k=20&m=1222359540&s=612x612&w=0&h=G8qwIjQmbCq3hbg0ny9i0Hx5zoS1bIB5U3vEb7RVWZE=', 'Pham Duc Hung', 'Male', '2001-06-02', 'hungpdse150222@fpt.edu.vn', '0987534987', 'District 9, Ho Chi Minh City', 'Software Engineering', '8/10', NULL, 'https://github.com/Hungpd170501', NULL, 'I want to become a back-end development', 1),
	(4, 'https://cdn5.vectorstock.com/i/thumb-large/69/94/smiling-boy-portrait-in-casual-clothing-in-cartoon-vector-36386994.jpg', 'Huynh Ngo Gia Bao', 'Male', '2001-11-22', 'baohngse150260@fpt.edu.vn', '0987534237', 'District 9, Ho Chi Minh City', 'Software Engineering', '8/10', NULL, 'https://github.com/HNGB', NULL, 'I want to become a back-end development', 1),
	(5, 'https://image.shutterstock.com/image-vector/cute-white-boy-asian-vector-260nw-1758651497.jpg', 'Le Ha Duy', 'Male', '2001-11-11', 'duylhse150233@fpt.edu.vn', '0983434237', 'District 9, Ho Chi Minh City', 'Software Engineering', '8/10', NULL, 'https://github.com/HuDery', NULL, 'I want to become a back-end development', 1),
	(6, 'https://static.vecteezy.com/system/resources/previews/004/059/941/non_2x/young-man-wearing-glasses-free-vector.jpg', 'Le Quoc Binh', 'Male', '2001-11-19', 'binhlqse150199@fpt.edu.vn', '0983436757', 'District 9, Ho Chi Minh City', 'Software Engineering', '8/10', NULL, 'https://github.com/BinhJim', NULL, 'I want to become a back-end development', 1)
GO	

INSERT INTO tblResumeSkills(resumeID, skillID)
VALUES 	(1, 220), (1, 212), (2, 105),
	(2, 220), (2, 212), (2, 105), (2, 176),
	(3, 220), (3, 212), (3, 105), (3, 62),
	(4, 220), (4, 212), (4, 105), (4, 221),
	(5, 220), (5, 212), (5, 105), (5, 436)
