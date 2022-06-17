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

IF OBJECT_ID('dbo.tblUsers', 'u') IS NOT NULL 
   DROP TABLE dbo.tblUsers;  
GO

CREATE TABLE tblUsers
(
	userID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	username varchar(50) NOT NULL,
	password varchar(500) NOT NULL,
	fullName varchar(50) NOT NULL,
	phone varchar(20),
	email varchar(50),
	roleID varchar(50),
	companyID INT,
	createdDate datetime,
	lastModifiedDate datetime,
	status tinyint,
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
	status bit,
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
	status bit,
);
GO

IF OBJECT_ID('dbo.tblCompanies', 'u') IS NOT NULL 
   DROP TABLE dbo.tblCompanies;  
GO

CREATE TABLE tblCompanies
(
	companyID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	companyName varchar(50),
	address varchar(50),
	website varchar (100),
	gmail varchar(50),
	phone varchar(20),
	typeCompany varchar(30),
	establishedYear varchar(30),
	numberOfEmployee int,
	companyOverview varchar(3000),
	avatar varchar (2000),
	createdDate datetime,
	lastModifiedDate datetime,
	status tinyint,
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
	fullName varchar(50),
	gender varchar(10),
	dateOfBirth date,
	gmail varchar(50),
	phone varchar(20),
	address varchar(50),
	major varchar(50),
	gpa varchar(15),
	website varchar ( 100 ),
	overview varchar(3000),
	createdDate datetime,
	lastModifiedDate datetime,
	status tinyint,

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
	status bit,
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
	deadline date,
	budget float,
	address varchar(50),
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
	salaryDeal varchar(50),
	message varchar(2000),
	createdDate datetime,
	lastModifiedDate datetime,
	jobOrderStatus tinyint NOT NULL,
);
GO

IF OBJECT_ID('dbo.tblJobsSkills', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJobsSkills;  
GO

CREATE TABLE tblJobsSkills(
	jobSkillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[jobID] [int] NOT  NULL ,
	[skillID] [int] NOT NULL
);
GO

IF OBJECT_ID('dbo.tblResumesSkills', 'u') IS NOT NULL 
   DROP TABLE dbo.tblResumesSkills;  
GO

CREATE TABLE tblResumesSkills (
	resumeSkillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[resumeID] [int] NOT NULL,
	[skillID] [int] NOT NULL
);
GO




--Referential Integrity Constraints
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
ALTER TABLE tblJobsSkills ADD CONSTRAINT fk_JobsSkills_jobID
FOREIGN KEY(jobID) REFERENCES tblJobs(jobID)
GO
ALTER TABLE tblJobsSkills ADD CONSTRAINT fk_JobsSkills_skillID
FOREIGN KEY(skillID) REFERENCES tblSkills(skillID)
GO
ALTER TABLE tblResumesSkills ADD CONSTRAINT fk_ResumesSkills_resumeID
FOREIGN KEY(resumeID) REFERENCES tblResumes(resumeID)
GO
ALTER TABLE tblResumesSkills ADD CONSTRAINT fk_ResumesSkills_skillID
FOREIGN KEY(skillID) REFERENCES tblSkills(skillID)
GO
