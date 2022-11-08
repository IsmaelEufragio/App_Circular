--========================================================
----IMPORTANTE
----1. CREAR LA BASE DE DATOS Y NO DESCOMENTARLO.
----2. EJECUTAR EL USE.
----3  EJECUTAR EL ALTER DATABASE Y NO DESCOMENTARLO.
----4. EJECUTAR TODO EL SCRIPTS.
--========================================================

/*CONFIGURACI�N INICIAL DEL SISTEMA*/
/*Sección INICIO*/

CREATE DATABASE [AppECO]   
GO 
USE [AppECO] 
GO	
ALTER DATABASE [AppECO]  SET ENABLE_BROKER
GO 
--===============ESQUEMAS================
/*Sección #1*/
GO
CREATE SCHEMA [Genl]
GO
CREATE SCHEMA [User]
GO
--CREATE SCHEMA [Prod]
--GO
--CREATE SCHEMA [Serv]
--GO
--CREATE SCHEMA [Nest]
--GO
--CREATE SCHEMA [Desp]
--GO
--CREATE SCHEMA [Habi]
--GO
--CREATE SCHEMA [Ongd]
--GO
--CREATE SCHEMA [Vact]
--GO
--CREATE SCHEMA [VeRe]
--GO
--CREATE SCHEMA [Vent]

--===============TABLAS==================
/*Sección #2*/
CREATE TABLE [Genl].tbSchedule(
	[sche_Id]           INT IDENTITY(1,1),
	[sche_DayNumber]	TINYINT			NOT NULL,
	[sche_nameDay]		NVARCHAR(10)	NOT NULL,
	[sche_startTime]	TIME			NOT NULL,
	[sche_endTime]		TIME			NOT NULL,

	CONSTRAINT  PK_Genl_tbSchedule_sche_ID  PRIMARY KEY(sche_Id)
);
GO

/*Sección #3*/
CREATE TABLE [Genl].tbCountry(
	[cou_Id]              INT  IDENTITY(1,1),
	[cou_Description]     NVARCHAR(100)		NOT NULL, 

	CONSTRAINT  PK_Genl_tbCountry_cou_Id	PRIMARY KEY (cou_Id)
);
GO

/*Sección #4*/
CREATE TABLE [Genl].tbDepartments
(
	[dep_Id]				INT  IDENTITY(1,1),
	[dep_Code]				NVARCHAR(2)		NOT NULL,
	[dep_Description]		NVARCHAR(100)		NOT NULL,
	[cou_Id]				INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbDepartments_depto_Id			 PRIMARY KEY (dep_Id),
	CONSTRAINT  FK_Genl_tbDepartments_tbCountry_pai_Id		 FOREIGN KEY(cou_Id) REFERENCES Genl.tbCountry(cou_Id)
);
GO

/*Sección #5*/
CREATE TABLE [Genl].tbMunicipalities
(
	[mun_Id]              INT IDENTITY(1,1),
	[mun_Code]            VARCHAR(4)		NOT NULL,
	[mun_Description]     NVARCHAR(100)		NOT NULL,
	[dep_Id]              INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbMunicipalities_mun_Id				  PRIMARY KEY(mun_Id, dep_Id),
	CONSTRAINT  FK_Genl_tbDepartments_tbMunicipalities_dep_Id FOREIGN KEY(dep_Id) REFERENCES [Genl].tbDepartments(dep_Id)
);
GO

/*Sección #6*/
CREATE TABLE [Genl].tbLocation
(
	[loc_Id]				INT IDENTITY(1,1),
	[loc_Suburb]			NVARCHAR(300)		NOT NULL,
	[loc_Latitude]			NVARCHAR(MAX)		NOT NULL,
	[loc_length]			NVARCHAR(MAX)		NOT NULL,
	[dep_Id]				INT					NOT NULL,
	[mun_Id]				INT					NOT NULL,
	CONSTRAINT  PK_Genl_tbLocation_loc_Id					PRIMARY KEY(loc_Id),
	CONSTRAINT  FK_Genl_tbMunicipalities_tbLocation_mun_Id	FOREIGN KEY(mun_Id,dep_Id) REFERENCES [Genl].tbMunicipalities(mun_Id,dep_Id)
);
GO

/*Sección #7*/
CREATE TABLE [User].tbTypeUser
(
	[tyUs_Id]				INT IDENTITY(1,1),
	[tyUs_description]		NVARCHAR(50)		NOT NULL,
	CONSTRAINT  PK_User_tbTypeUser_tyUs_Id					PRIMARY KEY(tyUs_Id),
);
GO

/*Sección #8*/
CREATE TABLE [User].tbUser
(
	[use_Id]				INT IDENTITY(1,1),
	[tyUs_Id]				INT					NOT NULL,
	[user_Name]				NVARCHAR(250)		NOT NULL,
	[user_description]		NVARCHAR(50)		NOT NULL,
	[user_Image]			NVARCHAR(MAX)		NOT NULL,
	[user_Phone]			NVARCHAR(20)		NOT NULL,
	[sche_Id]				INT					NOT NULL,
	[loc_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbUser_use_Id					PRIMARY KEY(use_Id),
	CONSTRAINT  FK_User__tbLocation_tbUser_loc_Id	FOREIGN KEY(loc_Id) REFERENCES [Genl].tbLocation (loc_Id),
	CONSTRAINT  FK_User_tbSchedule_tbUser_sche_Id	FOREIGN KEY(sche_Id) REFERENCES [Genl].tbSchedule (sche_Id)
);
GO

/*Sección #9*/
CREATE TABLE [User].tbRugro
(
	[rug_Id]				INT IDENTITY(1,1),
	[rug_description]		NVARCHAR(50)		NOT NULL,
	CONSTRAINT  PK_User_tbRugro_rug_Id					PRIMARY KEY(rug_Id)
);
GO

/*Sección #10*/
CREATE TABLE [User].tbEnterprise
(
	[empr_Index]			INT IDENTITY(1,1)	NOT NULL,
	[enpr_Id]				INT,
	[enpr_RTN]				NVARCHAR(100)		NOT NULL,
	[enpr_FoundationDate]	DATE				NOT NULL,
	[enpr_WebPage]			NVARCHAR(500)		NOT NULL,
	[enpr_Gmail]			NVARCHAR(200)		NOT NULL,
	[rug_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbEnterprise_enpr_Id					PRIMARY KEY(enpr_Id),
	CONSTRAINT  FK_User_tbEnterprise_tbRugro_rug_Id				FOREIGN KEY(rug_Id) REFERENCES [User].tbRugro(rug_Id)
);
GO

/*Sección #11*/
CREATE TABLE [User].tbAriaONGD
(
	[arONG_Id]				INT IDENTITY(1,1),
	[arONG_description]		NVARCHAR(100)		NOT NULL,
	CONSTRAINT  PK_User_tbAriaONGD_arONG_Id					PRIMARY KEY(arONG_Id),
);
GO

/*Sección #12*/
CREATE TABLE [User].tbONGD
(
	[ongd_Index]			INT IDENTITY(1,1)	NOT NULL,
	[ongd_Id]				INT,
	[ongd_RTNFoundation]	NVARCHAR(100)		NOT NULL,
	[ongd_RTN]				NVARCHAR(100)		NOT NULL,
	[ongd_FoundationDate]	DATE				NOT NULL,
	[arONG_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbONGD_ongd_Id					PRIMARY KEY(ongd_Id),
	CONSTRAINT  FK_User__tbAriaONGD_tbONGD_loc_Id	FOREIGN KEY(arONG_Id) REFERENCES [User].tbAriaONGD (arONG_Id),
	CONSTRAINT	UK_User_tbONGD_ongd_RTNFoundation_ongd_RTN					UNIQUE(ongd_RTNFoundation,ongd_RTN)
);
GO 

/*Sección #13*/
CREATE TABLE [User].tbUserNormal
(
	[usNor_Index]		INT IDENTITY(1,1)	NOT NULL,
	[usNor_Id]			INT ,
	[usNor_RTN]			NVARCHAR(50)		NOT NULL,
	[usNor_Type]		TINYINT				NOT NULL,
	CONSTRAINT  PK_User_tbUserNormal_usNor_Id					PRIMARY KEY(usNor_Id),
	CONSTRAINT	UK_User_tbUserNOrmal_usNor_RTN					UNIQUE(usNor_Id,usNor_RTN)
);
GO

/*Sección #14*/
CREATE TABLE [User].tbMicroenterprise
(
	[micro_Index]			INT IDENTITY(1,1)	NOT NULL,
	[micro_Id]				INT ,
	[micro_RTNFoundation]	NVARCHAR(50)		NOT NULL,
	[micro_RTN]				NVARCHAR(50)		NOT NULL,
	[micro_Type]			TINYINT				NOT NULL,
	[micro_Instagram]		NVARCHAR(MAX)		NOT NULL,
	[micro_Facebook]		NVARCHAR(MAX)		NOT NULL,
	[micro_WhatsApp]		NVARCHAR(1)			NOT NULL,
	[micro_Shipping]		NVARCHAR(1)			NOT NULL,
	[rug_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbMicroenterprise_micro_Id						PRIMARY KEY(micro_Id),
	CONSTRAINT	UQ_User_tbMicroenterprise_micro_RTNFoundation_micro_RTN	UNIQUE(micro_RTNFoundation, micro_RTN),
	CONSTRAINT	CK_User_tbMicroenterprise_micro_WhatsApp				CHECK(micro_WhatsApp IN ('1', '0')),
	CONSTRAINT	CK_User_tbMicroenterprise_micro_Shipping				CHECK(micro_Shipping IN ('1', '0')),
	CONSTRAINT  FK_User_tbMicroenterprise_tbRugro_rug_Id				FOREIGN KEY(rug_Id) REFERENCES [User].tbRugro(rug_Id)
);
GO

