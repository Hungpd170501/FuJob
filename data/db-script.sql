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

IF OBJECT_ID('dbo.tblRole', 'u') IS NOT NULL 
   DROP TABLE dbo.tblUser;  
GO
CREATE TABLE tblRole
(
	roleID varchar(50) NOT NULL PRIMARY KEY CLUSTERED,
	roleName varchar(50) NOT NULL
);
GO


IF OBJECT_ID('dbo.tblSkill', 'u') IS NOT NULL 
   DROP TABLE dbo.tblSkill;  
GO

CREATE TABLE tblSkill (
	skillID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	skillName varchar ( 50 ),
);
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
	major varchar(50),
	gpa varchar(15),
	website varchar ( 100 ),
	overview varchar(3000),
);
GO

IF OBJECT_ID('dbo.tblCategory', 'u') IS NOT NULL 
   DROP TABLE dbo.tblCategory;  
GO
CREATE TABLE tblCategory (
	categoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	categoryName varchar(50) NOT NULL,
	img varchar(MAX)
);
GO

IF OBJECT_ID('dbo.tblJob', 'u') IS NOT NULL 
   DROP TABLE dbo.tblJob;  
GO
CREATE TABLE tblJob (
	jobID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	userID INT NOT NULL,
	jobTitle varchar(255),
	jobCategoryID INT,
	deadline date,
	budged float,
	address varchar(50),
	email varchar(255),
	phone varchar(15),
	description varchar(2000),
	createdDate datetime,
	lastDateUpdate datetime,
	expiriedDate datetime,
	jobStatus tinyint NOT NULL
);
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
	dateApplied datetime,
	jobOrderStatus tinyint NOT NULL,
);
GO

IF OBJECT_ID('dbo.tblSkillRequire', 'u') IS NOT NULL 
   DROP TABLE dbo.tblSkillRequire;  
GO

CREATE TABLE tblSkillRequire (
	SkillRequireID INT IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED,
	[jobID] [int] NOT NULL,
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




--TRIGGERS
CREATE TRIGGER lastUpdate on dbo.tblJob
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblJob
SET lastDateUpdate = GetDate()
WHERE jobID IN (SELECT jobID FROM inserted);
GO

CREATE TRIGGER createdDate on dbo.tblJob
	FOR INSERT  AS 
	UPDATE dbo.tblJob
SET createdDate = GetDate()
WHERE jobID IN (SELECT jobID FROM inserted);
GO

CREATE TRIGGER lastApplied on dbo.tblJobOrder
	FOR  UPDATE , INSERT  AS 
	UPDATE dbo.tblJobOrder
SET dateApplied = GetDate()
WHERE jobOrderID IN (SELECT jobOrderID FROM inserted);
GO




--Referential Integrity Constraints
ALTER TABLE tblJob ADD CONSTRAINT fk_Job_jobCategoryID
FOREIGN KEY(jobCategoryID) REFERENCES tblCategory(categoryID)
GO
ALTER TABLE tblJob ADD CONSTRAINT fk_Job_userID
FOREIGN KEY(userID) REFERENCES tblUser(userID)
GO
ALTER TABLE tblUser ADD CONSTRAINT fk_User_roleID
FOREIGN KEY(roleID) REFERENCES tblRole(roleID)
GO
ALTER TABLE tblUser ADD CONSTRAINT fk_User_companyID
FOREIGN KEY(companyID) REFERENCES tblCompany(companyID)
GO
ALTER TABLE tblResume ADD CONSTRAINT fk_Resume_userID
FOREIGN KEY(userID) REFERENCES tblUser(userID)
GO
ALTER TABLE tblJobOrder ADD CONSTRAINT fk_JobOrder_userID
FOREIGN KEY(userID) REFERENCES tblUser(userID)
GO
ALTER TABLE tblJobOrder ADD CONSTRAINT fk_JobOrder_jobID
FOREIGN KEY(jobID) REFERENCES tblJob(jobID)
GO
ALTER TABLE tblSkillRequire ADD CONSTRAINT fk_SkillRequire_jobID
FOREIGN KEY(jobID) REFERENCES tblJob(jobID)
GO
ALTER TABLE tblSkillRequire ADD CONSTRAINT fk_SkillRequire_skillID
FOREIGN KEY(skillID) REFERENCES tblSkill(skillID)
GO
ALTER TABLE tblStudentSkill ADD CONSTRAINT fk_StudentSkille_StudentID
FOREIGN KEY(StudentID) REFERENCES tblUser(userID)
GO
ALTER TABLE tblStudentSkill ADD CONSTRAINT fk_StudentSkille_skillID
FOREIGN KEY(skillID) REFERENCES tblSkill(skillID)
GO





--Retrieve Data
INSERT INTO tblRole(roleID, roleName) 
VALUES(N'AD', N'Admin'),
      (N'US', N'User'),
	  (N'HR', N'Human Resource')
GO

INSERT INTO tblUser(username,password,fullName,email,phone,roleID,status) 
VALUES(N'customer1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Van A', N'abc1@gmail.com', N'0780780789', N'US',1),
      (N'customer2', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Van B', N'abc2@gmail.com', N'0780780790', N'HR',1),
	  (N'admin', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW' , N'Tao la Admin' , N'admin@gmail.com' , N'0780780791' ,N'AD', 1 ),
      (N'dev1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev1', N'hungpdse150222@fpt.edu.vn', N'0780780792', N'US',1),
      (N'dev2', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev2', N'baohngse150260@fpt.edu.vn', N'0780780793', N'US',1),
      (N'dev3', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev3', N'duylhse150233@fpt.edu.vn', N'0780780794', N'US',1),
	  (N'dev4', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev4', N'binhlqse150199@fpt.edu.vn', N'0780780795', N'US',1)
GO

INSERT  INTO tblSkill (skillName)
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

INSERT INTO tblCategory ( categoryName,img) 
VALUES (N'Clerical / Administrative', N'https://thumbs.dreamstime.com/b/data-entry-clerk-black-glyph-icon-administrative-professional-clerical-tasks-keyboarding-skills-entering-computer-system-200376656.jpg'),
	(N'QA / QC', N'data:image/png;base64,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'),
 	(N'HSE', N'https://www.smh.ie/assets/img/2020/02/158080759138820652.jpg'),
	(N'Human Resources', N'https://static.vecteezy.com/system/resources/previews/005/231/016/original/human-resource-logo-design-inspiration-illustration-vector.jpg'),
 	(N'Interpreter / Translator', N'https://t3.ftcdn.net/jpg/03/00/73/04/360_F_300730426_Ga0NR4wdRVKPwSWm9JHVUIUm713xAUFH.jpg'),
 	(N'Legal', N'https://previews.123rf.com/images/sejalanart/sejalanart2006/sejalanart200600531/149402994-law-firm-legal-logo-template-design.jpg'),
	(N'Customer Service', N'https://www.seekpng.com/png/detail/765-7656728_consultative-support-customer-care-logo-png.png'),
 	(N'Education', N'https://cdn2.vectorstock.com/i/1000x1000/63/61/education-logo-vector-11136361.jpg'),
 	(N'Health Care', N'https://thumbs.dreamstime.com/z/medical-health-heart-care-clinic-healthy-life-logo-design-icon-white-background-ai-illustration-158387498.jpg'),
 	(N'Security', N'https://i.pinimg.com/736x/22/be/e7/22bee7a03097351a98de0918c787e99f.jpg'),
 	(N'Accounting / Audit', N'https://png.pngtree.com/template/20191218/ourlarge/pngtree-bookkeeping-accounting-solution-logo-design-template-isolated-image_340867.jpg'),
 	(N'Banking / Securities', N'https://thumbs.dreamstime.com/b/simple-banking-logo-abstract-building-simple-banking-logo-abstract-building-flat-linear-trend-modern-logotype-106026416.jpg'),
 	(N'Finance / Investment', N'https://cdn2.vectorstock.com/i/1000x1000/25/01/logo-icon-for-financial-investment-business-vector-19172501.jpg'),
 	(N'Insurance ', N'https://www.creativefabrica.com/wp-content/uploads/2018/11/Life-insurance-logo-by-Friendesign-Acongraphic-18-580x386.jpg'),
 	(N'Advertising / Promotion / PR', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_5Xf9Bte08pdxaAlsFJB42NmiWgQYqfQsjF2A59RZbMURO8oash4z6R1QGPrj5ISw8Cw&usqp=CAU'),
 	(N'Consulting', N'https://cdn2.vectorstock.com/i/1000x1000/74/66/business-consulting-logo-vector-28447466.jpg'),
 	(N'Fashion', N'https://cdn2.vectorstock.com/i/1000x1000/80/46/fashion-logo-symbol-vector-5458046.jpg'),
 	(N'Household', N'data:image/png;base64,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'),
 	(N'Marketing' , N'https://img.freepik.com/free-vector/marketing-logo-template_416562-615.jpg' ),
 	(N'Sales', N'https://www.vippng.com/png/detail/187-1872902_summer-clipart-for-sale-transparent-background-sale-logo.png'),
 	(N'Export / Import ', N'https://thumbs.dreamstime.com/z/import-export-logo-isolated-white-background-your-web-mo-mobile-app-design-133876315.jpg'),
 	(N'Purchasing', N'https://images.assetsdelivery.com/compings_v2/putracetol/putracetol1706/putracetol170603994.jpg'),
 	(N'Transportation / Logistics / Warehouse', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBhePU_FYImIDHIGDfIUCgDs7ZRDD5l_BrQnY7OolmCMkhnBynbdw7h8fwEpwp-Y7vgCE&usqp=CAU'),
 	(N'IT - Hardware', N'https://www.logopik.com/wp-content/uploads/edd/2018/06/Hardware-Logo-Design.png'),
 	(N'IT - Software', N'https://www.logopik.com/wp-content/uploads/edd/2018/10/Software-Vector-Logo-Dowanlod-Free.png'),
 	(N'Travel ', N'data:image/png;base64,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 + PZNEwaqVY4HdEnHIWhyQ + 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'),
 	(N'Restaurant / Food Service', N'https://thumbs.dreamstime.com/z/restaurant-logo-label-menu-food-service-symbol-vector-illustration-restaurant-logo-label-menu-food-service-symbol-vector-134861170.jpg'),
 	(N'Hotel', N'https://cdn2.vectorstock.com/i/1000x1000/61/61/building-hotel-icon-graphic-download-template-vector-24426161.jpg'),
 	(N'Electrical / Electronics', N'https://t3.ftcdn.net/jpg/00/94/24/70/360_F_94247033_54db9vsZBwG8gzvUwaVb0hLr2lAT5U31.jpg'),
 	(N'Engineering / Mechanical', N'https://t4.ftcdn.net/jpg/02/92/53/15/360_F_292531541_8t6gplsraim2A67wbtPI4Scz2wy1SnwQ.jpg'),
 	(N'Environment / Waste Services', N'https://e7.pngegg.com/pngimages/485/316/png-clipart-reuse-reduce-recycle-logo-environmental-management-system-waste-management-natural-environment-recycle-bin-leaf-logo.png'),
 	(N'Maintenance ', N'https://cdn1.vectorstock.com/i/1000x1000/31/65/home-maintenance-logo-design-template-vector-21283165.jpg'),
 	(N'Pharmaceutical / Biotech', N'https://p.kindpng.com/picc/s/485-4851779_life-science-hero-image-bio-pharma-icon-png.png'),
 	(N'Automotive ', N'https://cdn5.vectorstock.com/i/1000x1000/65/59/automotive-logo-2-vector-25496559.jpg'),
 	(N'Agriculture / Forestry', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShsSxvA6y1yJWkhRwsyLYy9Ykhoga4PsM11g&usqp=CAU'),
 	(N'Chemical / Biochemical / Food Science ', N'https://reelchemstore.cc/wp-content/uploads/2021/08/pngtree-science-chemical-logo-image_80132.jpg'),
 	(N'Fishery ', N'https://i.pinimg.com/474x/03/73/20/037320a904677e3ddd6d89a9e8460a29.jpg'),
 	(N'Manufacturing / Operations ', N'https://as2.ftcdn.net/v2/jpg/02/13/01/57/500_F_213015700_0qEhDAVWIg2pu90ArKnWGg17HLLg0CCq.jpg'),
 	(N'Oil / Gas / Mineral ', N'https://cdn1.vectorstock.com/i/1000x1000/83/50/oil-and-gas-industry-logo-vector-27378350.jpg'),
 	(N'Textiles / Garments', N'https://png.pngtree.com/png-vector/20191123/ourlarge/pngtree-manual-sew-machine-icon-simple-illustration-of-manual-sew-machine-icon-png-image_2017083.jpg?fbclid=IwAR10mUBpvMi2BOwjkBkQ2l-Uyw5kCWSwosClpuU--4ZVM6W1L9GKp7KkGWU'),
 	(N'Wood ', N'https://thumbs.dreamstime.com/b/wood-logo-vector-graphics-come-file-types-very-easy-to-apply-any-software-download-contains-jpg-file-eps-file-138452336.jpg'),
 	(N'Architecture', N'https://i.pinimg.com/originals/ee/07/c3/ee07c36619a9c680d3c0f21b1d3d35bd.png'),
 	(N'Construction', N'https://media.istockphoto.com/vectors/construction-build-repair-with-home-vector-icon-vector-id1200096999?k=20&m=1200096999&s=612x612&w=0&h=FGpKSpXO9EcpQTTn4cWxatkp7xcr2kzhzEFJ6JBlK7A='),
 	(N'Interior / Exterior', N'https://dcassetcdn.com/design_img/1240797/506657/506657_6527780_1240797_71ff035c_image.jpg'),
 	(N'Real Estate', N'https://c8.alamy.com/comp/2A1TMJY/real-estate-vector-logo-design-real-estate-logo-building-logo-design-property-logo-home-logo-sign-house-logo-2A1TMJY.jpg'),
 	(N'Arts / Entertainment', N'https://cdn5.vectorstock.com/i/1000x1000/22/89/box-gift-art-entertainment-colorful-creative-logo-vector-28432289.jpg'),
 	(N'Newspaper / Editor / Publishing', N'https://png.pngtree.com/element_our/md/20180516/md_5afc4cd0dcaca.jpg?fbclid=IwAR0lXJCcbngyMb47JrdmJhcL1aU-4NAnZ6c-hyGcTgAKxBg7WzNSnyO7GQQ'),
 	(N'Telecommunications ', N'https://www.pngitem.com/pimgs/m/634-6342219_media-signal-tower-signal-tower-icon-hd-png.png?fbclid=IwAR0kFVPVHGNkIWm4XdI4n53jsicCrJFbkeVjpHcPta8k5d4IRPFvq28BOco'),
 	(N'Executive Management', N'https://www.kindpng.com/picc/m/80-803498_if-vector-65-02-47377820170731-7640-1two28t-board.png'),
 	(N'Other', N'${pageContext.request.contextPath}/asset/images/Logo/Logo/Untitled-1.png'),
	('International Business', 'https://cdn.dribbble.com/users/7031637/screenshots/15591230/gig-8_4x.jpg'),
	('Software Engineering', 'https://www.logopik.com/wp-content/uploads/edd/2018/10/Software-Engineering-Vector-Logo.png'),
	('Information Assurance', 'https://media.istockphoto.com/vectors/quick-key-logo-design-template-vector-id1013496226?b=1&k=20&m=1013496226&s=612x612&w=0&h=sywpjBFewebZRb7U9LbpfuNRChgg0oPXHUrWhEkAubE='),
	('Multimedia Communication', 'https://i.pinimg.com/736x/77/7f/3e/777f3e9f89ac6e127882d31199faee20.jpg'),
	('Graphic Design', 'https://cdn.dribbble.com/users/5246557/screenshots/12263175/media/f9210e3bf7a485987a931a3a54c8b70c.jpg?compress=1&resize=400x300&vertical=top'),
	('Hotel Management', 'https://www.pngkey.com/png/detail/376-3765477_hospitality-management-icon-logo-hospitality-management.png'),
	('Tourism service and Travel Management', 'https://www.nicepng.com/png/detail/370-3705541_gtifavi2-travel-insurance-logo-png.png'),
	('English language', 'https://w7.pngwing.com/pngs/230/768/png-transparent-english-world-foreign-language-colloquialism-england-miscellaneous-blue-text.png'),
	('Japanese language', 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Japanese-language.jpg'),
	('Digital Marketing', 'https://banner2.cleanpng.com/20181210/jsb/kisspng-digital-marketing-marketing-strategy-social-media-internet-png-images-png-mart-5c0e7c2c9723e1.5757274415444531646191.jpg'),
	('Information System', 'https://www.logolynx.com/images/logolynx/s_7b/7bd3f19896635439f5d9f4cc08086934.gif'),
	('Artificial Intelligence', 'https://i.pinimg.com/736x/f6/fa/4e/f6fa4e259c05252ba32cd12e98061b11.jpg'),
	('Korean Language', 'https://charuzu.files.wordpress.com/2015/09/korea_south_640.png'),
	('Internet of Things', 'https://lumihaiphong.vn/Data/images/IOT_Internet_of_Things_2017.jpg')
GO

INSERT INTO tblJob(userID, jobTitle, experienceNeeded, jobCategoryID, deadline, completionTime, salary, address, email, phone, description, jobStatus) 
VALUES (
'1', 'DESIGNER FREELANCE', 'Less than 1 year', '24', '2022-08-11', '10 days', '100$', 'Distric 9, HCM city', 'designfpt@gmail.com', '123-65-485', 'Support, coordinate with main designer to design products for online advertising and communication channels: banner, cover photo, flash animation, infographic, email marketing, etc.
 Support, coordinate with main designer Design products for offline communication: standee, banner, backdrop, bandroll, invitation, flyer, flyer, voucher, banners for office decoration, etc.
 Edit photos after each Company event
 Support, coordinate with the main designer to design online and offline registration forms
 Design slides, brochures to introduce products for the Company
 Contributing ideas to the Company''s events and Marketing campaigns',1
)
GO


INSERT INTO tblUser(username,password,fullName,email,phone,roleID,status, companyID) 
VALUES (N'admin', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW' , N'Tao la Admin' , N'admin@gmail.com' , N'0780780791' ,N'AD', 1, NULL),
	--Student
	(N'customer1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Van A', N'abc1@gmail.com', N'0780780789', N'US',1, NULL),
     	(N'dev1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev1', N'hungpdse150222@fpt.edu.vn', N'0780780792', N'US',1, NULL),
	(N'dev2', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev2', N'baohngse150260@fpt.edu.vn', N'0780780793', N'US',1, NULL),
      	(N'dev3', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev3', N'duylhse150233@fpt.edu.vn', N'0780780794', N'US',1, NULL),
	(N'dev4', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'dev4', N'binhlqse150199@fpt.edu.vn', N'0780780795', N'US',1, NULL),
	--HRM 7
	(N'HRManagement1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Tot', N'hrm1@gmail.com', N'0780780790', N'HRM',1, 1),
	(N'HRManagement1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Lai Van Huynh', N'hrm2@gmail.com', N'0780785790', N'HRM',1, 2),
	(N'HRManagement1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Quoc Sang', N'hrm3@gmail.com', N'0783780790', N'HRM',1, 3),
	(N'HRManagement1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Tuan Tu', N'hrm4@gmail.com', N'0780788790', N'HRM',1, 4),
	(N'HRManagement1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Huu Tai', N'hrm5@gmail.com', N'0780083790', N'HRM',1, 5),
	--HR 12
	(N'HumanResource1', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Van', N'hr1@gmail.com', N'0707554123', N'HR',1, 1),
	(N'HumanResource2', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Tu Van', N'hr2@gmail.com', N'0707654123', N'HR',1, 1),
	(N'HumanResource3', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Gia Tuan', N'hr3@gmail.com', N'0777554123', N'HR',1, 1),
	(N'HumanResource4', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Duc Hung', N'hr4@gmail.com', N'0707534123', N'HR',1, 1),
	(N'HumanResource5', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Anh Hoang', N'hr5@gmail.com', N'0707551123', N'HR',1, 1),
	
	(N'HumanResource6', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Tran Phong', N'hr6@gmail.com', N'0707514123', N'HR',1, 2),
	(N'HumanResource7', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Dang Tra Quang', N'hr7@gmail.com', N'0797554123', N'HR',1, 2),
	(N'HumanResource8', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Hai Phong', N'hr8@gmail.com', N'0707514123', N'HR',1, 2),
	(N'HumanResource9', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Quang Hai', N'hr9@gmail.com', N'0707554623', N'HR',1, 2),
	(N'HumanResource10', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Thanh Van', N'hr10@gmail.com', N'0708554123', N'HR',1, 2),
	
	(N'HumanResource11', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Tran Sang', N'hr11@gmail.com', N'0707554823', N'HR',1, 3),
	(N'HumanResource12', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Hoai Niem', N'hr12@gmail.com', N'0707554523', N'HR',1, 3),
	(N'HumanResource13', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Giong Cao', N'hr13@gmail.com', N'0707552323', N'HR',1, 3),
	(N'HumanResource14', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Quach Tran Phu', N'hr14@gmail.com', N'0707551223', N'HR',1, 3),
	(N'HumanResource15', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Van Phong', N'hr15@gmail.com', N'0701254123', N'HR',1, 3),
	
	(N'HumanResource16', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Huynh Tran Nen', N'hr16@gmail.com', N'0703454823', N'HR',1, 4),
	(N'HumanResource17', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Luong Xuan Truong ', N'hr17@gmail.com', N'0907554523', N'HR',1, 4),
	(N'HumanResource18', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Do Duy Manh', N'hr18@gmail.com', N'0707552233', N'HR',1, 4),
	(N'HumanResource19', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Cao Tien Dung', N'hr19@gmail.com', N'0707598223', N'HR',1, 4),
	(N'HumanResource20', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Bui Tan Truong', N'hr20@gmail.com', N'0701454123', N'HR',1, 4),
	
	(N'HumanResource21', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Nguyen Tuan Anh', N'hr21@gmail.com', N'0233454823', N'HR',1, 5),
	(N'HumanResource22', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Luong Hoang Duc', N'hr22@gmail.com', N'0945554523', N'HR',1, 5),
	(N'HumanResource23', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Do Hung Dung', N'hr23@gmail.com', N'0707511233', N'HR',1, 5),
	(N'HumanResource24', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Tran Dinh Trong', N'hr24@gmail.com', N'0733598223', N'HR',1, 5),
	(N'HumanResource25', N'$2a$10$83AJjXb7xGqD6LhpEQRSkeQcq25CbSFONzvlBw5Dj2GRr5VhXs4kW', N'Vu Van Thanh', N'hr25@gmail.com', N'0701456123', N'HR',1, 5),
GO

INSERT INTO tblCategory ( categoryName,img) 
VALUES  
	('International Business', 'https://cdn.dribbble.com/users/7031637/screenshots/15591230/gig-8_4x.jpg'),
	('Software Engineering', 'https://www.logopik.com/wp-content/uploads/edd/2018/10/Software-Engineering-Vector-Logo.png'),
	('Information Assurance', 'https://media.istockphoto.com/vectors/quick-key-logo-design-template-vector-id1013496226?b=1&k=20&m=1013496226&s=612x612&w=0&h=sywpjBFewebZRb7U9LbpfuNRChgg0oPXHUrWhEkAubE='),
	('Multimedia Communication', 'https://i.pinimg.com/736x/77/7f/3e/777f3e9f89ac6e127882d31199faee20.jpg'),
	('Graphic Design', 'https://cdn.dribbble.com/users/5246557/screenshots/12263175/media/f9210e3bf7a485987a931a3a54c8b70c.jpg?compress=1&resize=400x300&vertical=top'),
	('Hotel Management', 'https://www.pngkey.com/png/detail/376-3765477_hospitality-management-icon-logo-hospitality-management.png'),
	('Tourism service and Travel Management', 'https://www.nicepng.com/png/detail/370-3705541_gtifavi2-travel-insurance-logo-png.png'),
	('English language', 'https://w7.pngwing.com/pngs/230/768/png-transparent-english-world-foreign-language-colloquialism-england-miscellaneous-blue-text.png'),
	('Japanese language', 'https://upload.wikimedia.org/wikipedia/commons/a/a2/Japanese-language.jpg'),
	('Digital Marketing', 'https://banner2.cleanpng.com/20181210/jsb/kisspng-digital-marketing-marketing-strategy-social-media-internet-png-images-png-mart-5c0e7c2c9723e1.5757274415444531646191.jpg'),
	('Information System', 'https://www.logolynx.com/images/logolynx/s_7b/7bd3f19896635439f5d9f4cc08086934.gif'),
	('Artificial Intelligence', 'https://i.pinimg.com/736x/f6/fa/4e/f6fa4e259c05252ba32cd12e98061b11.jpg'),
	('Korean Language', 'https://charuzu.files.wordpress.com/2015/09/korea_south_640.png'),
	('Internet of Things', 'https://lumihaiphong.vn/Data/images/IOT_Internet_of_Things_2017.jpg'),
	(N'Other', 'https://seeklogo.com/images/U/undefined-logo-FE82D12763-seeklogo.com.gif')
GO


insert into tblJobs (userID, jobTitle, jobCategoryID, budged, address, email, phone, description, expiriedDate, jobStatus)
VALUES ('7', 'International situation analysis', 1, 2000, 'Ho Chi Minh', 'timkinhdoanhquocte@gmail.com', '0988234654', 'Use All Source Intelligence to analysis international conflict/trade/business/affair/relation.', '2022-08-17', 1),
	('7', 'Need Facebook Live Veiw Increase Bot', 2, 20, 'Da Nang', 'timsw@gmail.com', '0988214454', 'Need Facebook Live View Increase Bot simple tool easy to use', '2022-09-17', 1)
	('7', 'Cyber security expert needed for a database application analysis', 3, 20, 'Ho Chi Minh City', 'timia@gmail.com', '0988215654', 'I need a person to look at my issue to resolve it in a timely manner, Please let me know if you are available to handle this. I am very excited to work with you guys. Please contact me and I would love to provide you with more context about the task.', 1)
	('7', 'Graphic Design', 5, 20, 'Ha Noi City', 'timgd@gmail.com', '0988219654', 'We are needing someone to create social media graphics in various sizes. The output will be in PNG files saved with transparency.  We will need square format and story format images.  We will be able to give complete direction with sample work to be modified and created.  We will be available via email and zoom to give direction. This project is more redesigning existing collateral media with direction than creating content from scratch.', '2022-09-10', 1),
	('7', 'Sales Staff (Selling Tickets at Counters/ Stations, Concierge)', 6, 1, 'Ho Chi Minh', 'timhm@gmail.com', '0982314454', 'Ticket sales, customer support at the counter at the Independence Palace in District 1: shifts 8am to 3pm every day; and/or: assisting customers at Hop on Hop off double-decker bus (stops at pedestrian street 92 Nguyen Hue, District 1 and at City Post Office No. 2 Paris Commune District 1): shift 8:30am - 4:00pm or 15:30-22:30', '2022-09-17', 1),
	
	('8', 'jobTitle',10 , budged, 'Toan Quoc', 'timdm@gmail.com', '0703309128', 'description', 2022-08-23, 1),
	
	('12', 'Multimedia Coordinator', 4, 20, 'Ha Noi', 'timmc@gmail.com', '0988212254', 'The Multimedia Coordinator will work under the direction of the Associate Athletic Director, External Affairs, in preparing video packages for the Athletics Department’s website and LED video boards. This position is responsible for generating social media content and assisting the administrative staff with special projects. There are currently two openings available for this position.', '2022-09-15', 1),
	('12', 'Tour Operator', 7, 20, 'Hoi An', 'timtour@gmail.com', '0988212254', 'Find someone who can lead the delegation to visit Hoi An. Required to be agile, energetic, funny, understand the characteristics needed for the tour. Able to control, manage the delegation, handle unexpected incidents. The trip lasts 3 days and 3 nights, with accommodation and food allowance available.', '2022-09-15', 1),
	('12', 'blog article Englishr', 8, 100, 'Toan Quoc', 'timta@gmail.com', '098821254', 'I need to find a freelancer who can write English well for long-term cooperation. Especially good at copywriting in English to write blog articles (about 1000 words). The job will be writing a blog article for a website about student life, job seeking experience, how to get high scores...You are encouraged to bid for the project: You have studied abroad in English speaking countries, IELTS 7.5-8.0 or higher or similar TOEFL, You are teaching English', '2022-10-15', 1),
	('12', 'write articles in Japanese', 9, 200, 'Toan Quoc', 'timtn@gmail.com', '0934212254', 'Writing Japanese articles for IT companies based on ideas and available information will be provided. Various topics: internal company events, product introduction, articles related to IT a bit (if you have IT knowledge),...', '2022-09-15', 1),
	('12', 'Google Ads Optimization for Selling AI Book',10 , 50, 'Toan Quoc', 'timdm@gmail.com', '0703309128', 'Our AI book has sold more than 1000 copies using another ad platform. The point is the product is surely saleable. We have started using Google Ads. We need some optimizations of our Google Ads to give good conversion. We take care of the ads budget for sure. If with your optimized google ads we succeed to sell 5 copies, within the agreed ads budget, 5 STAR is guaranteed', 2022-08-23, 1),
	
	('17', 'Business Analyst For A Mini Project',11 , 30, 'Can Tho', 'timba@gmail.com', '0703308333', 'Working as a BA for a group of students, meeting, analyzing and understanding the software requirements for a small project at school. Ability to speak both English and Vietnamese fluently. Ability to conduct general desk research activities. Have a "can do" attitude, agile, and resilient. Does not afraid to ask questions when necessary', 2022-09-23, 1),
	('17', 'Clothes Customization Software For Ecommerce', 12, 2500, 'Ho Chi Minh', 'timai@gmail.com', '0703239128', 'A web application developed in either Python Django or Ruby on Rails  that will be mainly for customization of the clothes in an e-commerce for example suit, shirts, pants etc... the admin user should be able to scan fabric, sleeve, collar, cuff, placket etc... so that the end user will be able to customize the clothes he want as he likes, will send similar websites for the developer that will be working on this project, the candidate should have an experience in developing such websites.', 2022-09-23, 1),
	('17', 'Korean translation collaborator, in the fields of Automotive',13, 200, 'Ha Noi', 'timth@gmail.com', '0890309128', 'Need someone to translate some car sales contracts in Korean. Requires final year Korean language students or TOPIK 5 or higher, know some automotive terms. Fun, sociable, agile, good appearance is an advantage.It is possible to give extra tips if the contract is smooth and favorable.', 2022-10-23, 1),
	('17', 'configure IOT Project', 14, 100, 'Ben Tre', 'timiot@gmail.com', '0703345128', 'Dear we are looking for someone with hands on experience in IOT to configure and run this project. The basis architecture is to have one Nodemcu that connect multiple   devices together that are connect to wireless connection and to measure the stability of the network. The task is to help on how to configure and run the projects and we will buy all necessary hardware.', 2022-11-23, 1),
	('17', 'IoT Developerr', 14, 1000, 'Ha Noi', 'tỉmesd@gmail.com', '0234409128', 'Participating in programming of pic, arm, esp, family of microcontrollers..Developing Desktop applications, managing production for customer projects. Requires proficiency in programming languages C#, DotNet, MSSQL Server database. Knowledge of industry communication standards. Need to be smart, industrious, cheerful, sociable.', 2022-08-23, 1),
	
	('22', ‘Japanese teacher’,9 , 1000, 'Toan Quoc', 'timrr@gmail.com', '0703309128', ' If you are a person who is passionate about teaching, loves Japanese language and Japanese culture, wants to pass on knowledge, experience, and passion for Japanese to students through effective teaching methods. of KaizenYoshidaSchool, you will definitely succeed in your "teaching career" in Esuhai. ', 2022-08-23, 1),
	('22', 'Japanese interviewer',9, 1200, 'Ha Noi', 'namnd@gmail.com', '0703309128', ' Assistant Translator for Japanese - Vietnamese, Vietnamese - Japanese for Japanese Managers, Translating documents, reports, meetings, seminars... according to work requirements. Create a bridge between the Japanese Management level and the personnel in the Department, Departments/Branches and the Company. Support reception, work contact with customers, partners inside and outside the company. Participate in meetings with Senior Managers, receptions. Grasp the Manager's working schedule; Organize and support work reasonably and effectively. Perform other duties as assigned by the department manager. ', 2022-08-23, 1),
	('22', 'Merchandising Garment Industry',9, 1000, 'Da Nang’, 'hungld@gmail.com', '0703309128', ' Process customer orders. Receive orders from existing customers. Track order progress from sample to delivery. Other tasks as required by the department head. Sample development process, working with related departments. Control and solve all problems related to order progress. Track customer deliveries and payments', 2022-08-23, 1),
	('22', 'Men Recruitment consulting',9, 500, ‘Ho Chi Minh’, 'kiencv@gmail.com', '0703309128', ' Create a source of candidates for foreign recruitment applications (Writing articles, editing, posting job ads, interviewing candidates). Takecare candidates during the CV interview process, exchange questions about the job), set up the interview. Data management, data entry, instructions for making records, medical examination. Support interview translation. Projects to develop overseas customers (contact by mail or in person) ', 2022-08-23, 1),
	('22', 'Japanese business assistance',9, 700, 'Can Tho', 'tottd@gmail.com', '0703309128', 'Dealing with customers and partners, from receiving orders to completing deliveries (Confront with customers and partners, from handle order to delivery). Handling problems arising on orders (Handle in order). Follow up and plan delivery on schedule (Follow arrange devilery on time as requirement). Prepare a list of liabilities and report at the end of the month (Preparing specified list and monthly report). Daily Japanese communication via email with the Japanese side (Daily Japanese communication with Japan side). Support team members if needed or other task from Director', 2022-08-23, 1),
	('22', 'Editor Japanese',9, 600, ‘Ca Mau’, 'ngocttm@gmail.com', '0703309128', 'Plan content and write content for the entire website and other communication channels of the company (fanpage,...). Manage all social networking sites. Seeding groups on social networks. Writing content for media publications such as advertising pages, leaflets, online and offline documents for marketing activities, branding, external communication marketing, etc. Writing PR articles. Support team in video projects. Working and building relationships with the media', 2022-08-23, 1),
	('22', 'Programmer (JavaScript, Jquery)',9, 2000, ‘Binh Duong’, 'vantt@gmail.com', '0703309128', 'Develop Web Application, using Intra-mart(IM-FormaDesigner、IM-LogicDesigner). Intra-mart is a product package providing IT solutions for businesses, built on the Java programming language with the support of Java frameworks such as seasar, terasoluna global. Before participating in development, there will be training support', 2022-08-23, 1),
	('22', ‘Japanese Nursing N2’,9, 1200, ‘Nghe An’, 'phongvt@gmail.com', '0703309128', 'Support doctors such as taking blood, injecting, giving fluids,...', 2022-08-23, 1),
	('22', 'N2 . Bridge Engineer',9, 2500, ‘Quang Tri’, 'hoangnt@gmail.com', '0703309128', 'Support Japanese PM to design the system, write detailed design documents and communicate to the project team in Vietnam. Solve problems arising in the project, and problems after handover. Technical support for team members. Check the quality of the project's output products before handing over to customers.Manage project implementation progress, coordinate with customers and CEO in project management.', 2022-08-23, 1),
	('22', 'Staff',9, 300, ‘Da Lat’, 'longnn@gmail.com', '0703309128', 'Customer reception. Arrange for seating for customers. Place orders for customers. Serve food and drinks to guests. Support customer payments. Other tasks as assigned by management', 2022-08-23, 1),

	('27', 'Make Video Introduction of Educational Products (Korea)', 13, 300, 'Toan Quoc', 'timsrdm@gmail.com', '0703309238', 'Hello everyone, my company is currently looking to hire a freelancer for video design for an educational product introduction project in Korea. The video is 5 minutes long. Required to edit clips, voiceover, edit effects, be a Korean language student or have TOPIK 4 certificate (The plan is sent in Korean). You can work from home online.', 2022-09-23, 1),
	('27', 'AI Machine Leaning App for Android', 12, 30, 'Toan Quoc', 'timqqdm@gmail.com', '0703309238', 'I need an object detection app that allows me to take a picture with my phone camera and the app detects the desired object, crops the detected image/object using the bounding boxes coordinates and then , save the cropped image. I've got a well trained dataset. Requires a person with good AI skills, progressive spirit, fun sociable, responsible. If you are interested in the project, please contact me, we will discuss more.', 2022-11-23, 1),
	('27', 'Google APP developer', 2, 2000, 'Ho Chi Minh', 'timdm22d@gmail.com', '0703908128', ' To sync the order details (Oderid,Email,Mobile number, quantity, price, skuid, Customer name, payment method, city, province) from shopify store and update it on google sheet. Update the order status of the courier (Despatch date, tracking id, courier name, delivery status, delivery date) in the same google sheet by getting the details from picked with the help of shopify order id and pickrr tracking number', 2022-09-25, 1),
GO
