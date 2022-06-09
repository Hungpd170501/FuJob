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
	deadline date,
	completionTime varchar(20),
	salary varchar(20),
	address varchar(50),
	email varchar(255),
	phone varchar(15),
	description varchar(2000),
	lastDateUpdate datetime NULL,
	jobStatus tinyint NULL
);
GO

CREATE TRIGGER lastUpdate on dbo.tblJob
	FOR UPDATE, INSERT AS 
	UPDATE dbo.tblJob
SET lastDateUpdate = GetDate()
WHERE jobID IN (SELECT jobID FROM inserted);

INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, deadline, completionTime, salary, address, email, phone, description) 
VALUES (
'11', 'DESIGNER FREELANCE', 'Less than 1 year', '24', '2022-08-11', '10 days', '100$', 'Distric 9, HCM city', 'designfpt@gmail.com', '123-65-485', 'Support, coordinate with main designer to design products for online advertising and communication channels: banner, cover photo, flash animation, infographic, email marketing, etc.
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

IF OBJECT_ID('dbo.tblSkill', 'u') IS NOT NULL 
   DROP TABLE dbo.tblSkill;  
GO

CREATE TABLE tblSkill (
	skillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	skillName varchar(50),
);
GO
IF OBJECT_ID('dbo.tblSkillRequire', 'u') IS NOT NULL 
   DROP TABLE dbo.tblSkillRequire;  
GO

CREATE TABLE tblSkillRequire (
	SkillRequireID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[hrID] [int] NOT NULL,
	[skillID] [int] NOT NULL
);
GO

IF OBJECT_ID('dbo.tblStudentSkill', 'u') IS NOT NULL 
   DROP TABLE dbo.tblStudentSkill;  
GO

CREATE TABLE tblStudentSkill (
	StudentSkillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[StudentID] [int] NOT NULL,
	[skillID] [int] NOT NULL
);
GO

INSERT INTO tblSkill ( skillName) 
VALUES ('.NET'),('2D'),('2D Animation'),('3D'),('3D Animation'),('3D CAD'),('A/B Testing'),
	('ABAP'),('Actionscript'),('Adobe Dreamweaver'),('Adobe Illustrator'),('Adobe InDesign'),('Adobe Photoshop'),
	('After Effect'),('AI'),('AJAX'),('Music'),('Amplitude'),('Android'),('Angular'),('Angular 2'),('Angular 5'),('Angular 6'),
	('Angular 7'),('Angular 8'),('Angular Material Design'),('AngularJS'),('Photoionization'),('App development'),('Archicad'),
	('ASP'),('ASP.NET'),('Aura'),('Aurelia.js'),('AutoCAD'),('Automation Testing'),('AWS'),('Babylon.js'),('Backbone.js'),
	('Cartography & Maps'),('Sales'),('License of Invention'),('Packing'),('Financial Report'),('Tax report'),('Newspapers'),('Insurance'),
	('Social Insurance based on State Regulations'),('Real estate'),('Translators and interpreters'),('Editor'),('Book Editing'),('Web Content Editor'),
	('Big Data'),('Bitbucket'),('Bizweb'),('Bizweb App'),('Bizweb theme'),('Blender'),('Blockchain'),('Book KOL'),('Bootstrap'),('Branding'),
	('Brochure'),('Business Analysis'),('Business Intelligence'),('C#'),('C++'),('CakePHP'),('Calq.io'),('Content Update'),('Captcha'),('Cut HTML/CSS'),
	('Lyrics Rewriting'),('Corporate Strategy'),('HR Strategy'),('Brand Strategy'),('Video Broadcasting'),('Photo Edit'),('Edit Photos'),('Photography'),
	('Wedding Photography'),('Baby Photography'),('Food Photography'),('Interior Photography'),('Event Photography'),('Product Photography'),
	('Model Photography'),('Landscape Photography'),('Clip'),('CMS'),('Mechatronics'),('Cocos2D'),('Code'),('CodeIgniter'),('Space Technology'),
	('Nanotechnology'),('Clean Technology'),('Biotechnology'),('Copywriting'),('CorelDraw'),('CRM'),('Cryptocurrency'),('CS-Cart'),('CSS'),('CSS3'),
	('Wedding'),('cURL'),('D3.js'),('MC'),('Business Card'),('Data Driven'),('Data Insights'),('Data Processing'),('Data Visualisation'),('Datadog'),
	('Design'),('Genetic'),('Articles Translation'),('Subtitles'),('Book Translation'),('Technical Document Translation'),('Translation'),
	('Audio Service'),('Amazon Website Services'),('Video Service'),('Digital Marketing'),('Nutrition'),('Django'),('Docker'),('Draw.io'),('Drupal'),
	('Negotiation'),('Forum Posting'),('Newspaper Posting'),('Ads Posting'),('Video Uploading'),('Review'),('Evaluation & Appraisal'),('Typing'),
	('Typing Text'),('Director'),('Training'),('Sales Skills Training'),('Soft skills Training'),('Customer Service Training'),('Sales Training'),
	('Accounting Training'),('Other Professional Training' ),('PR Training '),('HR Training'),('Financial Training'),('Geological'),('Light Electricity'),
	('Cloud Computing'),('Electronic'),( 'Market Research'),('Positioning'),('Motions Graphics'),('Computer Graphics'),('Correction'),('Editing'),('EFY'),
	('Elasticsearch'), ('Email Marketing'),('Ember.js'),('Erlang'),('Etabs'),('Excel'),('Facebook Ad'),('Facebook Analytics'),('Facebook API'),
	('Facebook Fanpage'),('Figma'),('Final Cut Pro X'),('Firebase'),('Flash'),('Flex'),('Flutter'), ('Fontlab'),('Fortran'),('Forum seeding'),
	('FuelPHP'),('Game Design'),('Fundraising'),('GDN'),('Project Supervision') ,('Christmas'),('Education & Tutor'),('Git'),('Golang'),
	('Google Adwords'),('Google Analytics'),('Google API'),( 'Google Cloud'),('Google Sheets'),('Grails'),('Graphic Design'),('Groovy'),('Growth Hacking'),
	('Grunt & Gulp'),('Hara van'),('Dating'),('Phone Support'),('Customer Support'),('Technical Assistance'),('Screen Support'),('Seminar'),('Contract'),
	('Hosting'),('HTML'),('HTML5'),('Hubspot'),('Illustration'),('Printing'),('Infographics'),('Internet marketing'),( 'Invision'),('iOS'),('Java'),('Javascript'),
	('Joomla'),('Joomla Extensions'),('JoomlArt'),('jQuery'),('JSF'),('JSON'),('JSP'),('K2'),('Business Plan'),('Accountant'),('Management Accounting'),
	('Tax Accounting'),( 'General Accounting'),('Kentico'),('Data Mining'),('Mining'),('Market Survey'),('Slogan'),('Robotics Science'),('Humanities') ,
	('Climate Science'),('Startup'),('Wireless'),('Geospatial'),('Technical'),('Structural Engineering'),('Mechanical Engineering'),('Industrial Engineering '),
	('Civil Engineering'),('Petroleum Engineering'),('Textile Art'),('Genetic Engineering'),('Electrical Engineering'),('Chemical Engineering'),
	('Material Engineering' ),('Telecommunications Engineering'),('Quality Assurance'),('Audit'),('Internal Audit'),('Automated Techn ical Testing'),
	('Software Testing'),('Testing/QA'),('Software Architecture'),('Architectural Building'),('Kohana'),('Konakart'),('Jewelry'),('Radio Engineering'),
	('Video Techniques'),('Bookkeeping'),('LAMP'),('Landing Pages'),('Contracting'),('Project Planning'),( 'Event Planning'),('Photoshop Coding'),('Assemble'),
	('Access Programming'),('Action-script Programming'),('C Programming'),('C# Programming'),( 'C++ Programming'),('Software Programming'),
	('Application Programming'),('VBA Autocad Programming'),('Web Programming'),('Laravel'),('History'),('Liferay '),('Lightroom'),('Linux'),('Civil Law'),
	('Criminal Law'),('Economic Law'),('Labor Law'),('Real estate Law') ,('Tax Law'),('Quantum'),('Magento'),('Magestore'),('Social Network'),('Viral Marketing'),
	('Affiliate Marketing'),('Cipher'),('Matlab'),('Mautic'),('Meteor'),('Meteor.js'),('Arts'),('Microsoft Office'),('Illustrations'),('Mixpanel'),
	('Fashion Model'),('Product Description'),('Mobile application'),('Mocha & Chai'),('Mockup'), ('MongoDB'),('Moodle'),('Motion graphics'),('MS Excel'),
	('MSSQL'),('Ads Planning'),('MVC'),('MySQL'),('Capture the psyche'),('Energy'),('Cooking and Recipes'),('Nette'),('Neural network'),('Research'),
	('Scientific Research'),('Legal Research'),('Financial Research'),('Market Analysis'),('Nginx'),('Natural Language'),('Face Recognition'),('Brand Identity' ),
	('Personnel'),('Data entry'),('Import Data'),('Photographers'),('Node.js'),('Nopcommerce'),('Objective-C'), ('Odoo'),('OpenCart'),('OpenCV'),('OXID eSales'),
	('Barista'),('Sketching Ideas'),('Phalcon (PHP framework)'),('CRM Software'),('ERP Software'),('Accounting Software'),('HR Software'),('Management Software'),
	('Analysis'),('Business Analytical '),('Training Needs Analysis (TNA)'),('Finite Element Analysis'),('PhantomJS'),('Juridical'),
	('Sketching Samples with Autocad 2D'),('Real estate Development'),('Personal Development' ),('Software Development'),('interpreter'),
	('Mixing & Mastering'),('Photo editing'),('PHP'),('PHPixie'),('Play 2'), ('Plugins'),('Polymer'),('Polymer.js'),('PostgreSQL'),('PR'),
	('Presentation Design '),('PrestaShop'),('Prototype'),('PSD'),('Python'),('Public Relations'),('Media Relations'),('Manager'),('Project Manager'),
	('Real estate Management'),('Fan Page Management'),('Warehouse Management'),('Product Management'),('Entertainment Event Management'),('Website Management'),
	( 'Database Administrator'),('System Management'),('Advertisement'),('Print Advertising'),('Facebook Ads'),('Google Ads'),('Outdoor Advertising'),
	('Online Advertising'),('TVC Advertising'),('Filming'),('Linear Programming'),('Tax Settlement'),('React Native'),('React.js'),('Responsive' ),('Retouching'),
	('Ruby on Rails'),('Salesforce CRM'),('Manufacture'),('Animation Production'),('After Production'),('Scala'),( 'Scrum'),('Selenium'),('SEM'),('Sendy'),('SEO'),
	('Sharepoint'),('Shopify'),('Silex'),('Simicart '),('Slideshow'),('Slim'),('Smarty'),('Social Networking'),('Socket.io'),('Spine'),('Spring Framework'),
	( 'Spring MVC'),('SQL'),('SQL server'),('SQLite'),('Storyboard'),('Trust'),('Struts 1'),('Struts 2') ,('Swift' ),('Symfony'),('Business Finance'),
	('Financial Accounting'),('Psychology'),('Blogging'),('3D Modeling'),('Templates Creation'),('Brand Building'),('Telesale'),('Testing'),('Sport'),
	('Commercial Market'),('Designer'),('2D Design'),('3D Design'), ('Sound Design'),('Signboard design'),('Banner Design'),('html5. Banner Design'),
	('Industrial Packaging Design'),('Letter Cover Design'),('Icon Design'),('Blog Design'),('Brochure Design'),('Landscape Design'),( 'Industrial Design'),
	('Graphic Designing'),('Flash Design'),('Theme Design'),('Sticker Design'),('Digital Design'),('House Design'),('Office Design'),('Logo Desgin'),
	('Logo Design'),('Product Design'),('Exterior Design'),('Brand design'),('Character Design'),('Interior Design'),('Photoshop'),('Poster Design'),
	('Profile Design'),('Advertising Design'),('Book Design'),('Products Design'),('Production Design' ),('Creative Design'),('Invitation Card Design'),
	('Fashion Designer'),('Flyer Design'),('Website Design'),('Games Design'),('UML Design' ),('Microchips Design'),('Web Design'),('Poem'),('Press Release'),
	('Three.js'),('Recording'),('Crafts'),( 'Website Testing'),('Visa / Immigration Procedures'),('Algorithm'),('Tax'),('Presentation'),('Arabic'),
	('Afrikaans'),('Albanian' ),('English'),('Polish'),('Basque'),('Bengali'),('Portuguese'),('Bosnian'), ('Bulgarian'),('Catalan'),('Croatian'),('Danish'),
	('German'),('Dutch'),('Korean'),('Hebrew'),('Hindi'),('Chinese Language'),('Hungarian'),('Greek'),('Indonesian'),('Kannada'),('Latvian'),('Lithuanian'),
	('Macedonian'),('Malayalam'),('Malaysian'),('Norwegian'),('Russian'),('Japanese'),('Finnish'),('French'),('Filipino') ,('Punjabi'),('Roumanian'),('Czech'),
	('Serbian'),('Slovak'),('Slovenian'),('Tamil'),('Spanish'),( 'Telugu'),('Thai'),('Turkish'),('Swedish'),('Chinese'),('Simplified Chinese'),
	('Traditional Chinese'),('Urdu'),( 'Vietnamese'),('Welsh'),('Italian'),('Marketing'),('Mass Marketing'),('Mail Marketing'),('Network Marketing'),
	('Telemarketing'), ('Web Search'),('Sourcing'),('Product Sourcing'),('Sourcing Buyers'),('Office Information'),('Event Organization'),('Math'),
	('Server Optimization'),('Tomcat'),('Trados'),('Landing Page'),('Caricatures & Cartoons'),('ERP Implementation'),('Present'),('Online Assistant' ),
	('Pre-production'),('Short Story'),('Media'),('Automation'),('Managem ent Consulting'),('Psychological Consulting'),('Taxes Consulting'),('Recruitment'),
	('TV Advertising'),('Twitter API'),('Twitter Marketing'),('Typescript' ),('TYPO3 Flow'),('Typography'),('Underscore'),('Sales Apps'),('Unity 2D'),
	('Unreal engine'),('Unreal engine 4'), ('User flow'),('User research'),('User story'),('Vaadin'),('Physics'),('Astrophysics'),('VBA'),('Book Cover Drawing '),
	('Chibi Drawing'),('Technical Drawing'),('Illustrator'),('Hand Painting'),('Drawing'),('Caricature Drawing'),('Comic Drawing'), ('Wacom Drawing'),
	('Microcontrollers'),('Video Editing'),('Product Video'),('Explore'),('Fiction'),('Write articles'),('Articles Writing '),('Report Writing'),
	('Blog Writing'),('Write Blog/Forum'),('Speech Writing'),('Travel Writing'),('Funding Proposal Writing'),('Proposal Writing'),('Academic Writing'),
	('Technical Writing' ),('Script Writing'),('Video Script'),('Ads Script Writing'),('Essay Writing'),('Press Release Writing'),('Website Content Writing'),
	('Ads Writing'),('Review Writing'),('Book Writing'),('Creative Writing'),('Stories Writing'),('Medical Writing'),
	('Medical Writing Visual Basic for Applications'), ('Viral Content'),('Visual Basic for Applications'),('VPS'),('VR tour'),
	('Vray'),('Vue.js' ),('Vue.js and express.js'),('WCF'),('Web content'),('Websites Design'),('Web Scraping'),('Webbnc'),('Website Analytics'),('Websocket'),
	('Wireframe'),('Woocommerce'),('Wordpress'),('Xamarin'),('Aviation Construction'),('Bookkeeping System Building'),( 'Salary Scale Building'), ('Other')
GO


