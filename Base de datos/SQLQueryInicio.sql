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
CREATE SCHEMA [Genl] --Generales
GO
CREATE SCHEMA [User] --Usuarios
GO
CREATE SCHEMA [Prod] --Producto
GO
CREATE SCHEMA [Serv] --Servicio
GO
CREATE SCHEMA [UsPa] --Usuario Particular
GO
CREATE SCHEMA [Empre] --Empresa
GO
CREATE SCHEMA [Ongd] -- ONGD.
GO
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
	[cou_Description]     NVARCHAR(250)		NOT NULL, 

	CONSTRAINT  PK_Genl_tbCountry_cou_Id	PRIMARY KEY (cou_Id)
);
GO

/*Sección #4*/
CREATE TABLE [Genl].tbDepartments
(
	[dep_Id]				INT  IDENTITY(1,1),
	[dep_Code]				NVARCHAR(2)		NOT NULL,
	[dep_Description]		NVARCHAR(250)		NOT NULL,
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
	[mun_Description]     NVARCHAR(250)		NOT NULL,
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
CREATE TABLE [Genl].tbDesperdicioCategoria(
[desCa_Id]					INT IDENTITY(1,1),
[desCa_Descripcion]			NVARCHAR(250)
CONSTRAINT PK_Genl_tbDesperdicioCategoria		PRIMARY KEY(desCa_Id)
);
GO

/*Sección #8*/
CREATE TABLE [User].tbTypeUser
(
	[tyUs_Id]				INT IDENTITY(1,1),
	[tyUs_description]		NVARCHAR(250)		NOT NULL,
	CONSTRAINT  PK_User_tbTypeUser_tyUs_Id					PRIMARY KEY(tyUs_Id),
);
GO

/*Sección #9*/
CREATE TABLE [User].tbUser
(
	[use_Id]				INT IDENTITY(1,1),
	[tyUs_Id]				INT					NOT NULL,
	[user_Name]				NVARCHAR(250)		NOT NULL,
	[user_description]		NVARCHAR(1000)		NOT NULL,
	[user_Image]			NVARCHAR(MAX)		NOT NULL,
	[user_Phone]			NVARCHAR(20)		NOT NULL,
	[sche_Id]				INT					NOT NULL,
	[loc_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbUser_use_Id					PRIMARY KEY(use_Id),
	CONSTRAINT  FK_User__tbLocation_tbUser_loc_Id	FOREIGN KEY(loc_Id) REFERENCES [Genl].tbLocation (loc_Id),
	CONSTRAINT  FK_User_tbSchedule_tbUser_sche_Id	FOREIGN KEY(sche_Id) REFERENCES [Genl].tbSchedule (sche_Id)
);
GO

/*Sección #10*/
CREATE TABLE [User].tbRugro
(
	[rug_Id]				INT IDENTITY(1,1),
	[rug_description]		NVARCHAR(50)		NOT NULL,
	CONSTRAINT  PK_User_tbRugro_rug_Id					PRIMARY KEY(rug_Id)
);
GO

/*Sección #11*/
CREATE TABLE [User].tbEnterprise
(
	[empr_Index]			INT IDENTITY(1,1)	NOT NULL,
	[use_Id]				INT					NOT NULL,
	[enpr_RTN]				NVARCHAR(100)		NOT NULL,
	[enpr_FoundationDate]	DATE				NOT NULL,
	[enpr_WebPage]			NVARCHAR(500)		NOT NULL,
	[enpr_Gmail]			NVARCHAR(200)		NOT NULL,
	[rug_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbEnterprise_use_Id						PRIMARY KEY(use_Id),
	CONSTRAINT  FK_User_tbEnterprise_tbRugro_rug_Id				FOREIGN KEY(rug_Id) REFERENCES [User].tbRugro(rug_Id),
	CONSTRAINT  FK_User_tbEnterprise_tbUser_rug_Id				FOREIGN KEY(use_Id) REFERENCES [User].tbUser(use_Id)
);
GO

/*Sección #112*/
CREATE TABLE [User].tbAriaONGD
(
	[arONG_Id]				INT IDENTITY(1,1),
	[arONG_description]		NVARCHAR(100)		NOT NULL,
	CONSTRAINT  PK_User_tbAriaONGD_arONG_Id					PRIMARY KEY(arONG_Id),
);
GO

/*Sección #13*/
CREATE TABLE [User].tbONGD
(
	[ongd_Index]			INT IDENTITY(1,1)	NOT NULL,
	[use_Id]				INT,
	[arONG_Id]				INT					NOT NULL,
	[ongd_RTNFoundation]	NVARCHAR(100)		NOT NULL,
	[ongd_RTN]				NVARCHAR(100)		NOT NULL,
	[ongd_FoundationDate]	DATE				NOT NULL,
	CONSTRAINT  PK_User_tbONGD_ongd_Id						PRIMARY KEY(use_Id),
	CONSTRAINT  FK_User_tbAriaONGD_tbONGD_loc_Id			FOREIGN KEY(arONG_Id) REFERENCES [User].tbAriaONGD(arONG_Id),
	CONSTRAINT	UK_User_tbONGD_ongd_RTNFoundation_ongd_RTN	UNIQUE(ongd_RTNFoundation,ongd_RTN),
	CONSTRAINT  FK_User_tbONGD_tbUser_rug_Id				FOREIGN KEY(use_Id) REFERENCES [User].tbUser(use_Id)
);
GO 

/*Sección #14*/
CREATE TABLE [User].tbItemUsuarios
(
	[itUser_Id]					INT IDENTITY(1,1),
	[itUser_description]		NVARCHAR(100)		NOT NULL,
	CONSTRAINT  PK_User_tbItemUsuarios_itUser_Id					PRIMARY KEY(itUser_Id),
);
GO

/*Sección #15*/
CREATE TABLE [User].tbUserNormal
(
	[usNor_Index]		INT IDENTITY(1,1)	NOT NULL,
	[use_Id]			INT ,
	[usNor_RTN]			NVARCHAR(50)		NOT NULL,
	[itUser_Id]			INT					NOT NULL
	CONSTRAINT  PK_User_tbUserNormal_usNor_Id					PRIMARY KEY(use_Id),
	CONSTRAINT	UK_User_tbUserNOrmal_usNor_RTN					UNIQUE(usNor_RTN),
	CONSTRAINT  FK_User_tbUserNormal_tbUser_use_Id				FOREIGN KEY(use_Id) REFERENCES [User].tbUser(use_Id),
	CONSTRAINT  FK_User_tbUserNormal_tbItemUsuarios_itUser_Id	FOREIGN KEY(itUser_Id) REFERENCES [User].tbItemUsuarios(itUser_Id)
);
GO

/*Sección #16*/
CREATE TABLE [User].tbMicroenterprise
(
	[micro_Index]			INT IDENTITY(1,1)	NOT NULL,
	[use_Id]				INT ,
	[micro_RTNFoundation]	NVARCHAR(50)		NOT NULL,
	[micro_RTN]				NVARCHAR(50)		NOT NULL,
	[micro_Type]			TINYINT				NOT NULL,
	[micro_Instagram]		NVARCHAR(MAX)		NOT NULL,
	[micro_Facebook]		NVARCHAR(MAX)		NOT NULL,
	[micro_WhatsApp]		BIT,
	[micro_Shipping]		BIT,
	[rug_Id]				INT					NOT NULL,
	[itUser_Id]				INT					NOT NULL,
	CONSTRAINT  PK_User_tbMicroenterprise_use_Id						PRIMARY KEY(use_Id),
	CONSTRAINT	UQ_User_tbMicroenterprise_micro_RTNFoundation_micro_RTN	UNIQUE(micro_RTNFoundation, micro_RTN),
	CONSTRAINT  FK_User_tbMicroenterprise_tbRugro_rug_Id				FOREIGN KEY(rug_Id) REFERENCES [User].tbRugro(rug_Id),
	CONSTRAINT  FK_User_tbMicroenterprise_tbUser_use_Id					FOREIGN KEY(use_Id) REFERENCES [User].tbUser(use_Id),
	CONSTRAINT  FK_User_tbMicroenterprise_tbItemUsuarios_use_Id			FOREIGN KEY(itUser_Id) REFERENCES [User].tbItemUsuarios(itUser_Id)
);
GO

/*Sección #17*/
CREATE TABLE [Prod].tbProductoCAtegoria(
[prodC_Id]					INT IDENTITY(1,1) NOT NULL,
[prodC_Descripcion]			NVARCHAR(250) NOT NULL,
CONSTRAINT PK_tbProductoCAtegoria_prodC_Id	PRIMARY KEY(prodC_Id)
);
GO

/*Sección #18*/
CREATE TABLE [Prod].tbProducto(
[prod_Id]					INT IDENTITY(1,1)	NOT NULL,
[use_Id]					INT					NOT  NULL,
[prod_Nombre]				NVARCHAR(100)		NOT NULL,
[prod_Descripcion]			NVARCHAR(1000)		NOT NULL,
[prod_Precion]				DECIMAL(18,2)		NOT NULL,
[prod_ReaccionBuena]		INT,
[prod_ReaccionMala]			INT,
[prod_ReaccionReporte]		INT,
[prod_Imagen]				NVARCHAR(MAX)		NOT NULL,
[prodC_Id]					INT					NOT NULL,
[prod_Existencia]			BIT,
CONSTRAINT PK_Prod_tbProducto_prod_Id								PRIMARY KEY(prod_Id),
CONSTRAINT FK_Prod_tbProducto_tbMicroenterprise_prodC_Id			FOREIGN KEY(prodC_Id)	REFERENCES [Prod].tbProductoCAtegoria(prodC_Id),
CONSTRAINT FK_Prod_tbProducto_tbProductoCAtegoria_use_Id			FOREIGN KEY(use_Id)		REFERENCES [User].tbMicroenterprise(use_Id)
);
GO

/*Sección #19*/
CREATE TABLE [Prod].tbOrigen(
[orgn_Id]					INT IDENTITY(1,1)	NOT NULL,
[prod_Id]					INT					NOT NULL,
[orgn_Descripcion]			NVARCHAR(1000)		NOT NULL,
[orgn_Imagen]				NVARCHAR(MAX)		NOT NULL,
CONSTRAINT PK_Prod_tbOrigen_orgn_Id						PRIMARY KEY(orgn_Id),
CONSTRAINT FK_Prod_tbOrigen_Prod_tbProducto_prod_Id		FOREIGN KEY(prod_Id)	REFERENCES [Prod].tbProducto(prod_Id)
);
GO


/*Sección #20*/
CREATE TABLE [Serv].tbServicioCategoria(
[serCa_Id]					INT IDENTITY(1,1) NOT NULL,
[serCa_Descripcion]			NVARCHAR(1000) NOT NULL,
CONSTRAINT PK_Serv_tbServicioCategoria_serCa_Id						PRIMARY KEY(serCa_Id),
);
GO

/*Sección #21*/
CREATE TABLE [Genl].tbServicioTipo(
[serTi_Id]					INT IDENTITY(1,1) NOT NULL,
[serTi_Descripcion]			NVARCHAR(1000) NOT NULL,
CONSTRAINT PK_Genl_tbServicioTipo_serCa_Id						PRIMARY KEY(serTi_Id),
);
GO


/*Sección #22*/
CREATE TABLE [Serv].tbServicio(
[ser_Id]					INT IDENTITY(1,1)	NOT NULL,
[ser_Nombre]				NVARCHAR(300)		NOT NULL,
[ser_Descripcion]			NVARCHAR(1000)		NOT NULL,
[ser_Precion]				DECIMAL(18,2)		NOT NULL,
[ser_ReaccionBuena]			INT					NOT NULL,
[ser_ReaccionMala]			INT					NOT NULL,
[ser_ReaccionReporte]		INT					NOT NULL,
[ser_Imagen]				NVARCHAR(MAX),
[micro_Id]					INT					NOT NULL,
[serTi_Id]					INT					NOT NULL,
[serCa_Id]					INT					NOT NULL,
CONSTRAINT PK_Serv_tbServicio_ser_Id								PRIMARY KEY(ser_Id),
CONSTRAINT FK_Serv_tbServicio_Genl_tbServicioTipo_serTi_Id			FOREIGN KEY(serTi_Id)	REFERENCES [Genl].tbServicioTipo(serTi_Id),
CONSTRAINT FK_Serv_tbServicio_Serv_tbServicioCategoria_serCa_Id		FOREIGN KEY(serCa_Id)	REFERENCES [Serv].tbServicioCategoria(serCa_Id),
CONSTRAINT FK_Serv_tbServicio_User_tbMicroenterprise_micro_Id		FOREIGN KEY(micro_Id)	REFERENCES [User].tbMicroenterprise(use_Id)
);
GO

/*Sección #23*/
CREATE TABLE [Prod].tbDesperdicio(
[prodDes_Id]				INT IDENTITY(1,1),
[prod_Id]					INT,
[ser_Id]					INT,
[desCa_Id]					INT					NOT NULL,
[prodDes_Nombre]			NVARCHAR(100)		NOT NULL,
[prodDes_Descripcion]		NVARCHAR(MAX)		NOT NULL,
[prodDes_Gratis]			BIT,
[prodDes_Imagen]			NVARCHAR(MAX)		NOT NULL,
CONSTRAINT PK_Prod_tbProductoDesperdicio										PRIMARY KEY(prodDes_Id),
CONSTRAINT FK_Prod_tbProductoDesperdicio_Genl_tbDesperdicioCategoria_desCa_Id	FOREIGN KEY(desCa_Id)	REFERENCES [Genl].tbDesperdicioCategoria(desCa_Id),
CONSTRAINT FK_Prod_tbProductoDesperdicio_Prod_tbDesperdicio_ser_Id				FOREIGN KEY(ser_Id)		REFERENCES [Serv].tbServicio(ser_Id),
CONSTRAINT FK_Prod_tbProductoDesperdicio_Prod_tbProducto_prod_Id				FOREIGN KEY(prod_Id)	REFERENCES [Prod].tbProducto(prod_Id)
);
GO

/*Sección #24*/
CREATE TABLE [UsPa].tbHabilidades(
[serDe_Id]					INT IDENTITY(1,1) NOT NULL,
[habi_Nombre]				NVARCHAR(250) NOT NULL,
[habi_Descripcion]			NVARCHAR(1000) NOT NULL,
[habi_Precio]				DECIMAL(18,2) NOT NULL,
[habi_ReccionBuena]			INT NOT NULL,
[habi_ReccionMala]			INT NOT NULL,
[habi_ReccionReporte]		INT NOT NULL,
[serDe_Imagen]				NVARCHAR(MAX) NOT NULL,
[serTi_Id]					INT NOT NULL,
[usNor_Id]					INT NOT NULL
CONSTRAINT PK_UsPa_tbHabilidades_serCa_Id						PRIMARY KEY(serDe_Id),
CONSTRAINT FK_UsPa_tbHabilidades_Genl_tbServicioTipo_serTi_Id	FOREIGN KEY(serTi_Id)	REFERENCES [Genl].tbServicioTipo(serTi_Id),
CONSTRAINT FK_UsPa_tbHabilidades_User_tbUserNormal_usNor_Id		FOREIGN KEY(usNor_Id)	REFERENCES [User].tbUserNormal(use_Id)
);
GO

/*Sección #25*/
CREATE TABLE [UsPa].tbCatgNecesita(
[catNec_Id]					INT IDENTITY(1,1),
[catNec_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_UsPa_tbCatgNecesita_catNec_Id						PRIMARY KEY(catNec_Id)
);
GO

/*Sección #26*/
CREATE TABLE [UsPa].tbFormaPago(
[forPa_Id]					INT IDENTITY(1,1),
[forPa_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_UsPa_tbFormaPago_forPa_Id						PRIMARY KEY(forPa_Id)
);
GO

/*Sección #27*/
CREATE TABLE [UsPa].tbNecesita(
[necs_Id]					INT IDENTITY(1,1),
[necs_Nombre]				NVARCHAR(150) NOT NULL,
[catNec_Id]					INT NOT NULL,
[necs_Descripcion]			NVARCHAR(1000),
[necs_Reporte]				INT,
[necs_imegen]				NVARCHAR(MAX),
[necs_Cantidad]				INT,
[forPa_Id]					INT NOT NULL,
CONSTRAINT PK_UsPa_tbNecesita_necs_Id						PRIMARY KEY(necs_Id),
CONSTRAINT FK_UsPa_tbNecesita_tbCatgNecesita_usNor_Id		FOREIGN KEY(catNec_Id)	REFERENCES [UsPa].tbCatgNecesita(catNec_Id),
CONSTRAINT FK_UsPa_tbNecesita_tbFormaPago_forPa_Id			FOREIGN KEY(forPa_Id)	REFERENCES [UsPa].tbFormaPago(forPa_Id)
);
GO

/*Sección #28*/
CREATE TABLE [Empre].tbCatEducacion(
[catEd_Id]					INT IDENTITY(1,1),
[catEd_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_Empre_tbCatEducacion_catEd_Id						PRIMARY KEY(catEd_Id)
);
GO

/*Sección #29*/
CREATE TABLE [Empre].tbNivelEducativo(
[niEd_Id]					INT IDENTITY(1,1),
[niEd_Nombre]				NVARCHAR(350) NOT NULL,
[niEd_Numero]				INT NOT NULL,
CONSTRAINT PK_Empre_tbNivelEducativo_niEd_Id						PRIMARY KEY(niEd_Id)
);
GO


/*Sección #30*/
CREATE TABLE [Empre].tbEducacion(
[educ_Id]					INT IDENTITY(1,1),
[educ_Requerido]			NVARCHAR(1) NOT NULL,
[catEd_Id]					INT NOT NULL,
[niEd_Id]					INT NOT NULL,
CONSTRAINT PK_Empre_tbCatEducacion_catEd_Id						PRIMARY KEY(educ_Id),
CONSTRAINT CK_Empre_tbEducacion_educ_Requerido					CHECK(educ_Requerido IN ('1', '0')),
CONSTRAINT PK_Empre_tbEducacion_catEd_Id_tbCatEducacion			FOREIGN KEY(catEd_Id)	REFERENCES [Empre].tbCatEducacion(catEd_Id),
CONSTRAINT PK_Empre_tbEducacion_niEd_Id_tbNivelEducativo		FOREIGN KEY(niEd_Id)	REFERENCES [Empre].tbNivelEducativo(niEd_Id)
);
GO

/*Sección #31*/
CREATE TABLE [Empre].tbIdiomas(
[idom_Id]					INT IDENTITY(1,1),
[idom_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_Empre_tbIdiomas_idom_Id							PRIMARY KEY(idom_Id),
);
GO

/*Sección #32*/
CREATE TABLE [Empre].tbAriaPuesto(
[arPu_Id]					INT IDENTITY(1,1),
[arPu_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_Empre_tbAriaPuesto_arPu_Id						PRIMARY KEY(arPu_Id),
);
GO

/*Sección #33*/
CREATE TABLE [Empre].tbCargo(
[carg_Id]					INT IDENTITY(1,1),
[carg_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_Empre_tbCargo_carg_Id								PRIMARY KEY(carg_Id),
);
GO

/*Sección #34*/
CREATE TABLE [Empre].tbTipoContrato(
[tipCon_Id]					INT IDENTITY(1,1),
[tipCon_Nombre]				NVARCHAR(150) NOT NULL,
CONSTRAINT PK_Empre_tbTipoContrato_tipCon_Id					PRIMARY KEY(tipCon_Id),
);
GO

/*Sección #35*/
CREATE TABLE [Empre].tbMoneda(
[mone_Id]					INT IDENTITY(1,1),
[mone_Descripcion]			NVARCHAR(150) NOT NULL,
[mone_Simbolo]				NVARCHAR(10),
CONSTRAINT PK_Empre_tbMoneda_tipCon_Id					PRIMARY KEY(mone_Id),
);
GO

/*Sección #36*/
CREATE TABLE [Empre].tbExperiencia(
[expr_Id]					INT IDENTITY(1,1),
[expr_OpcionRequerida]		NVARCHAR(1) NOT NULL,
[carg_Id]					INT NOT NULL,
CONSTRAINT PK_Empre_tbExperiencia_expr_Id						PRIMARY KEY(expr_Id),
CONSTRAINT CK_Empre_tbExperiencia_expr_OpcionRequerida			CHECK(expr_OpcionRequerida IN ('1', '0')),
CONSTRAINT FK_Empre_tbExperiencia_tbCargo_carg_Id				FOREIGN KEY(carg_Id) REFERENCES [Empre].tbCargo(carg_Id),
);
GO

/*Sección #37*/
CREATE TABLE [Empre].tbVacante(
[vact_Id]					INT IDENTITY(1,1),
[arPu_Id]					INT NOT NULL,
[enpr_Id]					INT NOT NULL,
[carg_Id]					INT NOT NULL,
[vact_PuestoVacante]		NVARCHAR(350),
[tipCon_Id]					INT NOT NULL,
[vact_Genero]				NVARCHAR(1),
[vact_Edad]					INT NOT NULL,
[vact_SalarioMax]			DECIMAL(18,2) NOT NULL,
[vact_SalarioMim]			DECIMAL(18,2) NOT NULL,
[mone_Id]					INT NOT NULL,
[vact_Vehiculo]				NVARCHAR(1) NOT NULL,
[vact_DescripcionDeOferta]	NVARCHAR(MAX) NOT NULL,
[vact_OtrosConocimentos]	NVARCHAR(MAX),
[expr_Id]					INT NOT NULL,
[educ_Id]					INT NOT NULL,
[idom_Id]					INT NOT NULL,
CONSTRAINT PK_Empre_tbVacante_vact_Id						PRIMARY KEY(vact_Id),
CONSTRAINT CK_Empre_tbVacante_vact_Genero					CHECK(vact_Genero IN ('M', 'F')),
CONSTRAINT FK_Empre_tbVacante_tbAriaPuesto_arPu_Id			FOREIGN KEY(arPu_Id) REFERENCES [Empre].tbAriaPuesto(arPu_Id),
CONSTRAINT FK_Empre_tbVacante_User_tbEnterprise_enpr_Id		FOREIGN KEY(enpr_Id) REFERENCES [User].tbEnterprise(enpr_Id),
CONSTRAINT FK_Empre_tbVacante_tbCargo_carg_Id				FOREIGN KEY(carg_Id) REFERENCES [Empre].tbCargo(carg_Id),
CONSTRAINT FK_Empre_tbVacante_tbTipoContrato_tipCon_Id		FOREIGN KEY(tipCon_Id) REFERENCES [Empre].tbTipoContrato(tipCon_Id),
CONSTRAINT FK_Empre_tbVacante_tbExperiencia_expr_Id			FOREIGN KEY(expr_Id) REFERENCES [Empre].tbExperiencia(expr_Id),
CONSTRAINT FK_Empre_tbVacante_tbEducacion_educ_Id			FOREIGN KEY(educ_Id) REFERENCES [Empre].tbEducacion(educ_Id),
CONSTRAINT FK_Empre_tbVacante_tbIdiomas_idom_Id				FOREIGN KEY(idom_Id) REFERENCES [Empre].tbIdiomas(idom_Id),
);
GO

/*Sección #38*/
CREATE TABLE [Genl].tbConecNecesit(
[coNe_Id]					INT IDENTITY(1,1),
[use_Id]					INT NOT NULL,
[vact_Id]					INT,
[necs_Id]					INT,
CONSTRAINT PK_Genl_tbConecNecesit_coNe_Id					PRIMARY KEY(coNe_Id),
CONSTRAINT FK_Genl_tbConecNecesit_User_tbUser_use_Id		FOREIGN KEY(use_Id) REFERENCES [User].tbUser(use_Id),
CONSTRAINT FK_Genl_tbConecNecesit_Empre_tbVacante_vact_Id	FOREIGN KEY(vact_Id) REFERENCES [Empre].tbVacante(vact_Id),
CONSTRAINT FK_Genl_tbConecNecesit_tbNecesita_necs_Id		FOREIGN KEY(necs_Id) REFERENCES [UsPa].tbNecesita(necs_Id)
);
GO


/*Sección #39*/
CREATE TABLE [Ongd].tbOngEvenCatg(
[onEvC_Id]					INT IDENTITY(1,1),
[onEvC_Nombre]				NVARCHAR(250) NOT NULL,
CONSTRAINT PK_Ongd_tbOngEvenCatg_onEvC_Id					PRIMARY KEY(onEvC_Id)
);
GO

/*Sección #40*/
CREATE TABLE [Ongd].tbOngEven(
[onEv_Id]					INT IDENTITY(1,1),
[onEv_Nombre]				NVARCHAR(100) NOT NULL,
[onEv_Descripcion]			NVARCHAR(1000) NOT NULL,
[onEv_Reporte]				INT,
[onEv_Imegen]				NVARCHAR(MAX) NOT NULL,
[loc_Id]					INT NOT NULL,
[onEv_Fecha]				DATE,
[onEv_RecionBuena]			INT,
[onEv_RecionMala]			INT,
[onEvC_Id]					INT NOT NULL,
[onEv_HoraInicio]			TIME,
[onEv_HoraFin]				TIME,
[onEv_Evento]				BIT,
[use_Id]					INT NOT NULL,
CONSTRAINT PK_Ongd_tbOngEven_onEvC_Id							PRIMARY KEY(onEvC_Id),
CONSTRAINT FK_Ongd_tbOngEven_User_tbUser_use_Id					FOREIGN KEY(use_Id) REFERENCES [User].tbONGD(use_Id),
CONSTRAINT FK_Ongd_tbOngEven_Genl_tbLocation_loc_Id				FOREIGN KEY(loc_Id) REFERENCES [Genl].tbLocation(loc_Id),
CONSTRAINT FK_Genl_tbConecNecesit_Ongd_tbOngEvenCatg_onEvC_Id	FOREIGN KEY(onEvC_Id) REFERENCES [Ongd].tbOngEvenCatg(onEvC_Id)
);
GO

/*Sección #41*/
CREATE TABLE [Ongd].tbLisImagenesOng(
[imgOng_Id]					INT IDENTITY(1,1),
[onEv_Id]					INT NOT NULL,
[imgOng_Ruta]				NVARCHAR(MAX) NOT NULL,
CONSTRAINT PK_Ongd_tbLisImagenesOng_imgOng_Id					PRIMARY KEY(imgOng_Id),
CONSTRAINT FK_Ongd_tbLisImagenesOng_tbOngEven_onEv_Id			FOREIGN KEY(onEv_Id) REFERENCES [Genl].tbOngEven(onEv_Id)
);
GO