USE Logement

CREATE TABLE AGENCY
(
	ID INT IDENTITY(1,1) CONSTRAINT pkAgencyId PRIMARY KEY,
	NAME NVARCHAR(100) CONSTRAINT uAgencyName UNIQUE NOT NULL,
	RESPONSIBLE NVARCHAR(100) NOT NULL,
	TEL NVARCHAR(10) NULL,
	EMAIL NVARCHAR(50) NOT NULL,
	LOGO NVARCHAR(100) NULL,	
	DESCRIPTION NVARCHAR(100) NOT NULL,
	CREATED_DATE DATETIME DEFAULT GetDate() NOT NULL,	
	MODIFIED_DATE DATETIME NULL
)

CREATE TABLE "USER"
(
	ID	INT IDENTITY(1,1) CONSTRAINT pkUserId PRIMARY KEY,
	"LOGIN" NVARCHAR(50) CONSTRAINT uUserLogin UNIQUE NOT NULL,
	"PASSWORD" BINARY(64) NOT NULL,
	EMAIL NVARCHAR(50) CONSTRAINT uUserMail UNIQUE NOT NULL,
	SALT UNIQUEIDENTIFIER NOT NULL,
	TEL NVARCHAR(50)  NULL,
	AGENCY_ID INT REFERENCES AGENCY(ID) NULL,
	CREATED_DATE DATETIME DEFAULT GetDate() NOT NULL,	
	MODIFIED_DATE DATETIME NULL
)
ALTER TABLE dbo.[User] ADD Salt UNIQUEIDENTIFIER 

CREATE TABLE "ROLE"
(
	ID	INT	IDENTITY(1,1) CONSTRAINT pkRoleId PRIMARY KEY,
	NAME	NVARCHAR(50) NOT NULL
)
CREATE TABLE USERROLE
(
	ID	INT IDENTITY(1,1) CONSTRAINT pkUserRoleId PRIMARY KEY,
	ID_USER INT REFERENCES "USER"(ID) NOT NULL,
	ID_ROLE INT REFERENCES "ROLE"(ID) NOT NULL
)
CREATE TABLE LOCALITY
(
	ID	INT IDENTITY(1,1) CONSTRAINT pkLocalityId PRIMARY KEY,
	NAME NVARCHAR(100) CONSTRAINT uLocalityName UNIQUE NOT NULL,
	RANGE_MIN INT NOT NULL,
	RANGE_MAX INT NOT NULL,
	LEVEL INT NOT NULL,
	CREATED_DATE DATETIME DEFAULT GetDate() NOT NULL,	
	MODIFIED_DATE DATETIME NULL
)
CREATE TABLE AD
(
	ID	INT IDENTITY(1,1) CONSTRAINT pkAdId PRIMARY KEY,
	AD_TYPE INT	NOT NULL,
	OPERATION_TYPE INT NOT NULL,
	PRICE DECIMAL NOT NULL,
	SURFACE DECIMAL NOT NULL,
	NB_ROOM INT NOT NULL,
	NB_BEDROOM INT NOT NULL,
	NB_BATHROOM INT NOT NULL,
	ID_USER INT REFERENCES "USER"(ID) NOT NULL,
	ID_LOCALITY INT REFERENCES LOCALITY(ID) NOT NULL,
	CREATED_DATE DATETIME DEFAULT GetDate() NOT NULL,	
	MODIFIED_DATE DATETIME NULL,
	EXPIRED_DATE DATETIME NULL,	
	VALIDATED_DATE DATETIME NULL,	
	IS_VALIDATED BIT NOT NULL
)
CREATE TABLE PHOTO
(
	ID INT IDENTITY(1,1) CONSTRAINT pkPhotoId PRIMARY KEY,
	URL NVARCHAR(200) NOT NULL,
	DEFAUT BIT NOT NULL,
	AD_ID INT REFERENCES AD(ID) NOT NULL,
	IMAGE VARBINARY NULL 
)
GO