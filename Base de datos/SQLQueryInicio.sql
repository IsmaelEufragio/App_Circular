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
ALTER DATABASE [AppECO] COLLATE SQL_Latin1_General_CP1_CI_AS;
GO

GO
CREATE  SCHEMA [Genl] --Generales
GO

/*Sección #2*/
CREATE TABLE [Genl].tbTipoUsuario(
	[tipUs_Id]				INT IDENTITY(1,1),
	[tipUs_Descripcion]		NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoUsuario_tipUs_Id	PRIMARY KEY(tipUs_Id)
)  
GO
INSERT INTO [Genl].[tbTipoUsuario] ([tipUs_Descripcion]) VALUES ('Microempresa')
INSERT INTO [Genl].[tbTipoUsuario] ([tipUs_Descripcion]) VALUES ('Usuarios con habilidades')
INSERT INTO [Genl].[tbTipoUsuario] ([tipUs_Descripcion]) VALUES ('ONG')
INSERT INTO [Genl].[tbTipoUsuario] ([tipUs_Descripcion]) VALUES ('Empresa')
INSERT INTO [Genl].[tbTipoUsuario] ([tipUs_Descripcion]) VALUES ('Usuario Particular')
INSERT INTO [Genl].[tbTipoUsuario] ([tipUs_Descripcion]) VALUES ('Local')
GO

/*Sección #3*/
CREATE TABLE [Genl].tbInfoUnicaUsuario(
	[usInf_Id]					INT IDENTITY(1,1),
	[usInf_IgualSubInfo]		BIT NOT NULL DEFAULT 1,
	[usInf_Nombre]				NVARCHAR(300)	NOT NULL,
	[usInf_RutaLogo]			NVARCHAR(2000) NOT NULL DEFAULT '',
	[usInf_RutaPaginaWed]		NVARCHAR(2000) NOT NULL DEFAULT '',
	[usInf_Verificado]			BIT	NOT NULL DEFAULT 0,
	[tipUs_Id]					INT NOT NULL,
	CONSTRAINT  PK_Genl_tbInfoUnicaUsuario_usInf_Id	PRIMARY KEY(usInf_Id),
	CONSTRAINT  FK_Genl_tbInfoUnicaUsuario_tbTipoUsuario_tipUs_Id	FOREIGN KEY(tipUs_Id) REFERENCES Genl.tbTipoUsuario(tipUs_Id)
)  
GO

/*Sección #4*/
CREATE TABLE [Genl].tbPais(
	[pais_Id]						INT IDENTITY(1,1),
	[pais_Nombre]					NVARCHAR(500)	NOT NULL,
	[pais_Abrebiatura]				NVARCHAR(10)	NOT NULL DEFAULT '',
	CONSTRAINT  PK_Genl_tbPais_pais_Id	PRIMARY KEY(pais_Id)
)  
GO
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('Honduras', 'HN')
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('Guatemala', 'GT')
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('El Salvador', 'SLV')
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('Nicaragua', 'NIC')
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('Costa Rica', 'CR')
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('Panama', 'PM')
INSERT INTO [Genl].[tbPais] ([pais_Nombre], [pais_Abrebiatura]) VALUES ('Mexico', 'MX')
GO

/*Sección #5*/
CREATE TABLE [Genl].tbDepartamento(
	[dept_Id]						INT IDENTITY(1,1),
	[dept_Nombre]					NVARCHAR(500)	NOT NULL,
	[pais_Id]						INT	NOT NULL,
	[dept_NuIdentidad]				INT NOT NULL,
	CONSTRAINT  PK_Genl_tbDepartamento_dept_Id			PRIMARY KEY(dept_Id),
	CONSTRAINT  FK_Genl_tbDepartamento_tbPais_pai_Id	FOREIGN KEY(pais_Id) REFERENCES Genl.tbPais(pais_Id)
)  
GO
INSERT INTO [Genl].[tbDepartamento] ([dept_Nombre], [pais_Id], [dept_NuIdentidad]) VALUES ('Atlántida', 1, 1)
INSERT INTO [Genl].[tbDepartamento] ([dept_Nombre], [pais_Id], [dept_NuIdentidad]) VALUES ('Choluteca', 1, 2)
INSERT INTO [Genl].[tbDepartamento] ([dept_Nombre], [pais_Id], [dept_NuIdentidad]) VALUES ('Colón', 1, 3)
INSERT INTO [Genl].[tbDepartamento] ([dept_Nombre], [pais_Id], [dept_NuIdentidad]) VALUES ('Comayagua', 1, 4)
INSERT INTO [Genl].[tbDepartamento] ([dept_Nombre], [pais_Id], [dept_NuIdentidad]) VALUES ('Copán', 1, 5)
INSERT INTO [Genl].[tbDepartamento] ([dept_Nombre], [pais_Id], [dept_NuIdentidad]) VALUES ('Cortés', 1, 6)
GO

/*Sección #6*/
CREATE TABLE [Genl].tbMunicipio(
	[muni_Id]						INT IDENTITY(1,1),
	[muni_Nombre]					NVARCHAR(500)	NOT NULL,
	[dept_Id]						INT	NOT NULL,
	[muni_NuIdentidad]				INT NOT NULL,
	[muni_ValidaciosTelefono]		NVARCHAR(1000) NOT NULL DEFAULT '',
	[muni_ValidaciosTelefonoFijo]	NVARCHAR(1000) NOT NULL DEFAULT '',
	CONSTRAINT  PK_Genl_tbMunicipio_muni_Id			PRIMARY KEY(muni_Id),
	CONSTRAINT  FK_Genl_tbMunicipio_tbDepartamento_dept_Id	FOREIGN KEY(dept_Id) REFERENCES Genl.tbDepartamento(dept_Id)
)  
GO
INSERT INTO [Genl].[tbMunicipio] ([muni_Nombre], [dept_Id], [muni_NuIdentidad], [muni_ValidaciosTelefono], [muni_ValidaciosTelefonoFijo]) VALUES ('La Ceiba', 1, 1, 'N/A', 'N/A')
INSERT INTO [Genl].[tbMunicipio] ([muni_Nombre], [dept_Id], [muni_NuIdentidad], [muni_ValidaciosTelefono], [muni_ValidaciosTelefonoFijo]) VALUES ('El Porvenir', 1, 2, 'N/A', 'N/A')
INSERT INTO [Genl].[tbMunicipio] ([muni_Nombre], [dept_Id], [muni_NuIdentidad], [muni_ValidaciosTelefono], [muni_ValidaciosTelefonoFijo]) VALUES ('San Pedro Sula', 6, 4, 'N/A', 'N/A')
GO

/*Sección #7*/
CREATE TABLE [Genl].tbCategoriaLugar(
	[catLug_Id]						INT IDENTITY(1,1),
	[catLug_Nombre]					NVARCHAR(500)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaLugar_catLug_Id			PRIMARY KEY(catLug_Id)
)  
GO
INSERT INTO [Genl].[tbCategoriaLugar] ([catLug_Nombre]) VALUES ('Ciudad')
INSERT INTO [Genl].[tbCategoriaLugar] ([catLug_Nombre]) VALUES ('Caserio')
INSERT INTO [Genl].[tbCategoriaLugar] ([catLug_Nombre]) VALUES ('N/A')
GO

/*Sección #8*/
CREATE TABLE [Genl].tbLugar(
	[lug_Id]						INT IDENTITY(1,1),
	[lug_Nombre]					NVARCHAR(500)	NOT NULL,
	[catLug_Id]						INT				NOT NULL,
	[muni_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbLugar_lug_Id			PRIMARY KEY(lug_Id),
	CONSTRAINT  FK_Genl_tbLugar_tbCategoriaLugar_catLug_Id	FOREIGN KEY(catLug_Id) REFERENCES Genl.tbCategoriaLugar(catLug_Id),
	CONSTRAINT  FK_Genl_tbLugar_tbMunicipio_muni_Id			FOREIGN KEY(muni_Id) REFERENCES Genl.tbMunicipio(muni_Id),
)  
GO	
INSERT INTO [Genl].[tbLugar] ([lug_Nombre], [catLug_Id], [muni_Id]) VALUES ('Cofradia', 2, 3)
GO

/*Sección #9*/
CREATE TABLE [Genl].tbCategoriaSubdivicion(
	[catSub_Id]						INT IDENTITY(1,1),
	[catSub_Nombre]					NVARCHAR(500)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaSubdivicion_catSub_Id	PRIMARY KEY(catSub_Id)
)  
GO
INSERT INTO [Genl].[tbCategoriaSubdivicion] ([catSub_Nombre]) VALUES ('Colonia')
INSERT INTO [Genl].[tbCategoriaSubdivicion] ([catSub_Nombre]) VALUES ('Aria Rural')
Go

/*Sección #10*/
CREATE TABLE [Genl].tbSubdivicionLugar(
	[subLug_Id]						INT IDENTITY(1,1),
	[subLug_Nombre]	 				NVARCHAR(500)	NOT NULL,
	[catSub_Id]						INT				NOT NULL,
	[lug_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbSubdivicionLugar_subLug_Id			PRIMARY KEY(subLug_Id),
	CONSTRAINT  FK_Genl_tbSubdivicionLugar_tbCategoriaSubdivicion_catSub_Id	FOREIGN KEY(catSub_Id) REFERENCES Genl.tbCategoriaSubdivicion(catSub_Id),
	CONSTRAINT  FK_Genl_tbSubdivicionLugar_tbLugar_lug_Id	FOREIGN KEY(lug_Id) REFERENCES Genl.tbLugar(lug_Id),
)  
GO	
INSERT INTO [Genl].[tbSubdivicionLugar] ([subLug_Nombre], [catSub_Id], [lug_Id]) VALUES ('24 de abril # 1', 1, 1)
GO


/*Sección #11*/
CREATE TABLE [Genl].tbUbicacion(
	[ubc_Id]						INT IDENTITY(1,1),
	[ubc_Latitud]					NVARCHAR(200)	NOT NULL,
	[ubc_Longitub]					NVARCHAR(200)	NOT NULL,
	[subLug_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbUbicacion_ubc_Id			PRIMARY KEY(ubc_Id),
	CONSTRAINT  FK_Genl_tbUbicacion_tbSubdivicionLugar_subLug_Id	FOREIGN KEY(subLug_Id) REFERENCES Genl.tbSubdivicionLugar(subLug_Id),
)  
GO

/*Sección #12*/
CREATE TABLE [Genl].tbTipoIdentificacion(
	[tipIde_Id]						INT IDENTITY(1,1),
	[tipIde_Descripcion]			NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoIdentificacion_tipIde_Id			PRIMARY KEY(tipIde_Id),
)  
GO
INSERT INTO [Genl].[tbTipoIdentificacion] ([tipIde_Descripcion]) VALUES ('No Proporcionada')
GO

/*Sección #13*/
CREATE TABLE [Genl].tbUsuarios(
	[user_Id]						INT IDENTITY(1,1),
	[usInf_Id]						INT				NOT NULL,
	[user_Descripcion]				NVARCHAR(500)	NOT NULL,
	[ubc_Id]						INT				NOT NULL,
	[user_Identificacion]			NVARCHAR(100)	NOT NULL DEFAULT '',
	[tipIde_Id]						INT	NOT NULL DEFAULT 1,
	[user_NombreUsuario]			NVARCHAR(150)	NOT NULL DEFAULT '',
	[user_Password]					NVARCHAR(1000)	NOT NULL,
	[user_PasswordSal]				NVARCHAR(1000)	NOT NULL,
	[user_FechaCreacion]			DATETIME ,
	[user_Correo]					NVARCHAR(100)	NOT NULL,
	[user_Facebook]					NVARCHAR(100)	NOT NULL DEFAULT '',
	[user_Intagram]					NVARCHAR(100)	NOT NULL DEFAULT '',
	[user_WhatsApp]					BIT NOT NULL DEFAULT 0,
	[user_Envio]					BIT NOT NULL DEFAULT 0,
	[user_UsuarioPrincipal]			BIT NOT NULL DEFAULT 0,
	[user_Verificado]					BIT NOT NULL DEFAULT 0 
	CONSTRAINT  PK_Genl_tbUsuarios_User_Id			PRIMARY KEY(User_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbInfoUnicaUsuario_usInf_Id		FOREIGN KEY(usInf_Id) REFERENCES Genl.tbInfoUnicaUsuario(usInf_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbUbicacion_ubc_Id				FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id)
)  
GO

/*Sección #14*/
CREATE TABLE [Genl].tbTipoTelefono(
	[tipTel_Id]						INT IDENTITY(1,1),
	[tipTel_Descripcion]			NVARCHAR(300)		NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoTelefono_tipTel_Id		PRIMARY KEY(tipTel_Id),
)  
GO
INSERT INTO [Genl].[tbTipoTelefono] ([tipTel_Descripcion]) VALUES ('Fijo')
INSERT INTO [Genl].[tbTipoTelefono] ([tipTel_Descripcion]) VALUES ('Celular')
GO

/*Sección #15*/
CREATE TABLE [Genl].tbUsuarioTelefono(
	[usTel_Id]						INT IDENTITY(1,1),
	[tipTel_Id]						INT NOT NULL,
	[user_Id]						INT NOT NULL,
	[usTel_Numero]					NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbUsuarioTelefono_usTel_Id			PRIMARY KEY(usTel_Id),
	CONSTRAINT  FK_Genl_tbUsuarioTelefono_tbTipoTelefono_tipTel_Id		FOREIGN KEY(tipTel_Id) REFERENCES Genl.tbTipoTelefono(tipTel_Id),
	CONSTRAINT  FK_Genl_tbUsuarioTelefono_tbUsuarios_user_Id		FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

/*Sección #16*/
CREATE TABLE [Genl].tbCategoria(
	[catg_Id]						INT IDENTITY(1,1),
	[catg_Nombre]					NVARCHAR(500)		NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoria_catg_Id		PRIMARY KEY(catg_Id)
)  
GO
INSERT INTO [Genl].[tbCategoria] ([catg_Nombre]) VALUES ('Comida')
INSERT INTO [Genl].[tbCategoria] ([catg_Nombre]) VALUES ('Reposteria')
INSERT INTO [Genl].[tbCategoria] ([catg_Nombre]) VALUES ('Carpinteria')
GO

/*Sección #17*/
CREATE TABLE [Genl].tbCategoriaItem(
	[catgItem_Id]					INT IDENTITY(1,1),
	[catg_Id]						INT				NOT NULL,
	[user_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaItem_catgItem_Id			PRIMARY KEY(catgItem_Id),
	CONSTRAINT  FK_Genl_tbCategoriaItem_tbCategoria_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCategoria(catg_Id),
	CONSTRAINT  FK_Genl_tbCategoriaItem_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

/*Sección #18*/
CREATE TABLE [Genl].tbHorario( 
	[hor_Id]						INT IDENTITY(1,1),
	[hor_DiaNumero]					INT				NOT NULL,
	[user_Id]						INT				NOT NULL,
	[hor_HoraInicio]				TINYINT			NOT NULL,
	[hor_MinutoInicio]				TINYINT			NOT NULL,
	[hor_HoraFin]					TINYINT			NOT NULL,
	[hor_MinutoFin]					TINYINT			NOT NULL,
	CONSTRAINT  PK_Genl_tbHorario_hor_Id				PRIMARY KEY(hor_Id),
	CONSTRAINT  FK_Genl_tbHorario_tbUsuarios_User_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

/*Sección #19*/
CREATE TABLE [Genl].tbTipoCatalogo(
	[tipCatg_Id]						INT IDENTITY(1,1),
	[tipCatg_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoCatalogo_tipCatg_Id	PRIMARY KEY(tipCatg_Id)
) 
GO
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Producto')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Servicio')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Necesita')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Desperdicio')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Habilidades')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Logros')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Eventos')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Vacantes')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Vende')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Venta Relámpago')
INSERT INTO [Genl].[tbTipoCatalogo] ([tipCatg_Descripcion]) VALUES ('Alquila')
GO

/*Sección #20*/
CREATE TABLE [Genl].tbCatalogoPorUsuario(
	[catUsua_Id]						INT IDENTITY(1,1),
	[tipCatg_Id]						INT	NOT NULL,
	[tipUs_Id]							INT NOT NULL,
	CONSTRAINT  PK_Genl_tbCatalogoPorUsuario_catUsua_Id	PRIMARY KEY(catUsua_Id),
	CONSTRAINT  FK_Genl_tbCatalogoPorUsuario_tbTipoCatalogo_tipCatg_Id	FOREIGN KEY(tipCatg_Id) REFERENCES Genl.tbTipoCatalogo(tipCatg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoPorUsuario_tbTipoUsuario_tipUs_Id	FOREIGN KEY(tipUs_Id) REFERENCES Genl.tbTipoUsuario(tipUs_Id)
) 
GO

/*Sección #21*/
CREATE TABLE [Genl].tbFiltroCategoriaTipo(
	[fiCg_Id]						INT IDENTITY(1,1),
	[catg_Id]						INT	NOT NULL,
	[tipCatg_Id]					INT NOT NULL,
	CONSTRAINT  PK_Genl_tbFiltroCategoriaTipo_fiCg_Id	PRIMARY KEY(fiCg_Id),
	CONSTRAINT  FK_Genl_tbFiltroCategoriaTipo_tbTipoCatalogo_tipCatg_Id	FOREIGN KEY(tipCatg_Id) REFERENCES Genl.tbTipoCatalogo(tipCatg_Id),
	CONSTRAINT  FK_Genl_tbFiltroCategoriaTipo_tbCategoria_catg_Id		FOREIGN KEY(catg_Id) REFERENCES Genl.tbCategoria(catg_Id)
)
GO

/*Sección #22*/
CREATE TABLE [Genl].tbCatalogo(
	[catg_Id]						INT IDENTITY(1,1),
	[catg_Nombre]					NVARCHAR(300)	NOT NULL DEFAULT '',
	[catg_Descripcion]				NVARCHAR(1000)	NOT NULL DEFAULT '',
	[catg_JsonReaccion]				NVARCHAR(MAX)	NOT NULL DEFAULT '',
	[catg_IdDesperdicio]			INT,
	[categ_Id]						INT		NOT NULL,
	[user_Id]						INT		NOT NULL,
	[catg_EdadActaParaVer]			TINYINT		NOT NULL DEFAULT 0,
	[catg_FechaCreacion]			DATETIME 	NOT NULL ,
	[catag_EsGratis]				BIT 	NOT NULL DEFAULT 0,
	CONSTRAINT  PK_Genl_tbCatalogo_catg_Id				PRIMARY KEY(catg_Id),
	CONSTRAINT  FK_Genl_tbCatalogo_tbCatalogo_catg_IdDesperdicio	FOREIGN KEY(catg_IdDesperdicio) REFERENCES Genl.tbCatalogo(catg_Id),
	CONSTRAINT  FK_Genl_tbCatalogo_tbCategoria_catg_Id	FOREIGN KEY(categ_Id) REFERENCES Genl.tbCategoria(catg_Id),
	CONSTRAINT  FK_Genl_tbCatalogo_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

/*Sección #23*/
CREATE TABLE [Genl].tbTipoImagen(
	[tipImg_Id]						INT IDENTITY(1,1),
	[tipImg_Descripcion]			NVARCHAR(200)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoImagen_tipImg_Id	PRIMARY KEY(tipImg_Id)
)
GO
INSERT INTO [Genl].[tbTipoImagen] ([tipImg_Descripcion]) VALUES ('Portada')


/*Sección #24*/
CREATE TABLE [Genl].tbCatalogoImagen(
	[catImg_Id]						INT IDENTITY(1,1),
	[catg_Id]						INT	NOT NULL,
	[tipImg_Id]						INT	NOT NULL,
	[catImg_RutaImagen]				NVARCHAR(2000)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCatalogoImagen_catImg_Id					PRIMARY KEY(catImg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoImagen_tbCatalogo_catg_Id			FOREIGN KEY(catg_Id) REFERENCES Genl.tbCatalogo(catg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoImagen_tbTipoImagen_tipImg_Id		FOREIGN KEY(tipImg_Id) REFERENCES Genl.tbTipoImagen(tipImg_Id)
)  
GO
/*Sección #25*/
CREATE TABLE [Genl].tbTipoReaccion(
	[tipRea_Id]						INT IDENTITY(1,1),
	[tipRea_Descripcion]			NVARCHAR(200)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoReaccion_tipRea_Id	PRIMARY KEY(tipRea_Id)
)
GO
INSERT INTO [Genl].[tbTipoReaccion] ([tipRea_Descripcion]) VALUES ('Me Encanta')
INSERT INTO [Genl].[tbTipoReaccion] ([tipRea_Descripcion]) VALUES ('No me gusta')
GO

/*Sección #26*/
CREATE TABLE [Genl].tbCatalogoReaccion(
	[catRea_Id]						INT IDENTITY(1,1),
	[catg_Id]						INT	NOT NULL,
	[user_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbCatalogoReaccion_catRea_Id				PRIMARY KEY(catRea_Id),
	CONSTRAINT  FK_Genl_tbCatalogoReaccion_tbCatalogo_catg_Id		FOREIGN KEY(catg_Id) REFERENCES Genl.tbCatalogo(catg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoReaccion_tbUsuarios_user_Id		FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

/*Sección #27*/
CREATE TABLE [Genl].tbTipoPago(
	[tipPag_Id]						INT IDENTITY(1,1),
	[tipPag_Descripcion]			NVARCHAR(200)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoPago_tipPag_Id	PRIMARY KEY(tipPag_Id)
)
GO
INSERT INTO [Genl].[tbTipoPago] ([tipPag_Descripcion]) VALUES ('Precio Fijo')
INSERT INTO [Genl].[tbTipoPago] ([tipPag_Descripcion]) VALUES ('Negociable')
INSERT INTO [Genl].[tbTipoPago] ([tipPag_Descripcion]) VALUES ('Por Mes')
INSERT INTO [Genl].[tbTipoPago] ([tipPag_Descripcion]) VALUES (' por Dia')
INSERT INTO [Genl].[tbTipoPago] ([tipPag_Descripcion]) VALUES (' por Quincena')
INSERT INTO [Genl].[tbTipoPago] ([tipPag_Descripcion]) VALUES ('Por Año')
GO

/*Sección #29*/
CREATE TABLE [Genl].tbPrecio(
	[prec_Id]						INT IDENTITY(1,1),
	[prec_Inicial]					DECIMAL(18,2)	NOT NULL DEFAULT 0,
	[prec_Final]					DECIMAL(18,2)	NOT NULL DEFAULT 0,
	[prec_Cantidad]					INT	NOT NULL DEFAULT 0,
	[tipPag_Id]						INT	NOT NULL,
	[catg_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbPrecio_prec_Id			PRIMARY KEY(prec_Id),
	CONSTRAINT  FK_Genl_tbPrecio_tbTipoPago_user_Id	FOREIGN KEY(tipPag_Id) REFERENCES Genl.tbTipoPago(tipPag_Id),
	CONSTRAINT  FK_Genl_tbPrecio_tbCatalogo_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCatalogo(catg_Id),
)  
GO

/*Sección #30*/
CREATE TABLE [Genl].tbContribuyente(
	[contr_Id]						INT IDENTITY(1,1),
	[contr_Descripcion]				NVARCHAR(300)   NOT NULL DEFAULT '',
	[contr_Varificado]				BIT	NOT NULL DEFAULT 0,
	[user_Id]						INT	NOT NULL,
	[catg_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbContribuyente_contr_Id			PRIMARY KEY(contr_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbCatalogo_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCatalogo(catg_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

/*Sección #31*/
CREATE TABLE [Genl].tbCatalogoOng(
	[ctgOng_Id]						INT IDENTITY(1,1),
	[ctgOng_Fecha]					DATETIME ,
	[ctgOng_HoraInicio]				TINYINT NOT NULL DEFAULT 0,
	[ctgOng_HoraFin]				TINYINT	NOT NULL DEFAULT 0,
	[ubc_Id]						INT,
	[catg_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbCatalogoOng_ctgOng_Id				PRIMARY KEY(ctgOng_Id),
	CONSTRAINT  FK_Genl_tbCatalogoOng_tbCatalogo_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCatalogo(catg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoOng_tbUbicacion_ubc_Id	FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id)
)  
GO

/*Sección #32*/
CREATE TABLE [Genl].tbGuardar(
	[guard_Id]						INT IDENTITY(1,1),
	[user_Id]						INT	NOT NULL,
	[guard_RutaPublicacion]			NVARCHAR(2000)	NOT NULL DEFAULT '',
	[catg_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbGuardar_guard_Id				PRIMARY KEY(guard_Id),
	CONSTRAINT  FK_Genl_tbGuardar_tbCatalogo_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCatalogo(catg_Id),
	CONSTRAINT  FK_Genl_tbGuardar_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

--Vacante---------

/*Sección #33*/
CREATE TABLE [Genl].tbAriaPuesto(
	[ariaP_Id]						INT IDENTITY(1,1),
	[ariaP_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbAriaPuesto_ariaP_Id	PRIMARY KEY(ariaP_Id)
)  
GO

/*Sección #34*/
CREATE TABLE [Genl].tbPuesto(
	[puest_Id]						INT IDENTITY(1,1),
	[puest_Descripcion]				NVARCHAR(300)	NOT NULL,
	[ariaP_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbPuesto_puest_Id	PRIMARY KEY(puest_Id),
	CONSTRAINT  FK_Genl_tbPuesto_tbAriaPuesto_ariaP_Id	FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
)  
GO

/*Sección #35*/
CREATE TABLE [Genl].tbTipoContrato(
	[tipC_Id]						INT IDENTITY(1,1),
	[tipC_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoContrato_tipC_Id	PRIMARY KEY(tipC_Id)
)  
GO

/*Sección #36*/
CREATE TABLE [Genl].tbGenero(
	[gene_Id]				INT IDENTITY(1,1),
	[gene_Descripcion]		NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbGenero_gene_Id	PRIMARY KEY(gene_Id),
)  
GO

/*Sección #37*/
CREATE TABLE [Genl].tbVacante(
	[vac_Id]					INT IDENTITY(1,1),
	[vac_DescripcionOferta]		NVARCHAR(2000)	NOT NULL,
	[user_Id]					INT				NOT NULL, 
	[ariaP_Id]					INT				NOT NULL,
	[puest_Id]					INT				NOT NULL,	
	[tipC_Id]					INT				NOT NULL,
	[gene_Id]					INT				NOT NULL,
	[vac_Edad]					DECIMAL(18,2)	NOT NULL,
	[vac_SalarioMax]			DECIMAL(18,2),
	[vac_SalarioMinio]			INT				NOT NULL,
	[vac_Vahiculo]				BIT				NOT NULL DEFAULT 0,
	CONSTRAINT  PK_Genl_tbVacante_catEd_Id	PRIMARY KEY(vac_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbUsuarios_user_Id			FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbAriaPuesto_ariaP_Id			FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbPuesto_puest_Id			FOREIGN KEY(puest_Id) REFERENCES Genl.tbPuesto(puest_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbTipoContrato_tipC_Id			FOREIGN KEY(tipC_Id) REFERENCES Genl.tbTipoContrato(tipC_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbGenero_gene_Id			FOREIGN KEY(gene_Id) REFERENCES Genl.tbGenero(gene_Id),
)  
GO


/*Sección #38*/
CREATE TABLE [Genl].tbOtrosConocimientos(
	[otrCo_Id]						INT IDENTITY(1,1),
	[otrCo_Descripcion]				NVARCHAR(300)	NOT NULL,
	[vac_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbOtrosConocimientos_otrCo_Id	PRIMARY KEY(otrCo_Id),
	CONSTRAINT  FK_Genl_tbOtrosConocimientos_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #39*/
CREATE TABLE [Genl].tbCargo(
	[carg_Id]						INT IDENTITY(1,1),
	[carg_Descripcion]				NVARCHAR(300)	NOT NULL,
	[vac_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbCargo_carg_Id	PRIMARY KEY(carg_Id),
	CONSTRAINT  FK_Genl_tbCargo_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #40*/
CREATE TABLE [Genl].tbExperiencia(
	[exp_Id]						INT IDENTITY(1,1),
	[ariaP_Id]						INT	NOT NULL,
	[exp_Opcional]					BIT NOT NULL DEFAULT 0,
	[vac_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbExperiencia_exp_Id	PRIMARY KEY(exp_Id),
	CONSTRAINT  FK_Genl_tbExperiencia_tbAriaPuesto_ariaP_Id			FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
	CONSTRAINT  FK_Genl_tbExperiencia_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #41*/
CREATE TABLE [Genl].tbNivelEducativo(
	[nivEd_Id]						INT IDENTITY(1,1),
	[nivEd_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbNivelEducativo_nivEd_Id	PRIMARY KEY(nivEd_Id)
)  
GO


/*Sección #42*/
CREATE TABLE [Genl].tbTitulo(
	[titu_Id]						INT IDENTITY(1,1),
	[titu_Descripcion]				NVARCHAR(300)	NOT NULL,
	[ariaP_Id]						INT, 
	[nivEd_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbTitulo_titu_Id	PRIMARY KEY(titu_Id),
	CONSTRAINT  FK_Genl_tbTitulo_tbAriaPuesto_nesCa_Id	FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
	CONSTRAINT  FK_Genl_tbTitulo_tbNivelEducativo_nivEd_Id	FOREIGN KEY(nivEd_Id) REFERENCES Genl.tbNivelEducativo(nivEd_Id),
)  
GO

/*Sección #43*/
CREATE TABLE [Genl].tbProceso(
	[proc_Id]						INT IDENTITY(1,1),
	[proc_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbProceso_proc	PRIMARY KEY(proc_Id),
)  
GO


/*Sección #44*/
CREATE TABLE [Genl].tbTituloProc(
	[tiProc_Id]						INT IDENTITY(1,1),
	[titu_Id]						INT	NOT NULL,
	[proc_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbTituloProc_tiProc_Id	PRIMARY KEY(tiProc_Id),
	CONSTRAINT  FK_Genl_tbTituloProc_tbTitulo_titu_Id	FOREIGN KEY(titu_Id) REFERENCES Genl.tbTitulo(titu_Id),
	CONSTRAINT  FK_Genl_tbTituloProc_tbProceso_proc_Id	FOREIGN KEY(proc_Id) REFERENCES Genl.tbProceso(proc_Id),
)  
GO

/*Sección #45*/
CREATE TABLE [Genl].tbEducacion(
	[ed_Id]				INT IDENTITY(1,1),
	[ed_Requerido]		BIT NOT NULL DEFAULT 0,
	[titu_Id]			INT				NOT NULL, 
	[vac_Id]			INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbEducacion_catEd_Id	PRIMARY KEY(Ed_Id),
	CONSTRAINT  FK_Genl_tbEducacion_tbTitulo_titu_Id	FOREIGN KEY(titu_Id) REFERENCES Genl.tbTitulo(titu_Id),
	CONSTRAINT  FK_Genl_tbEducacion_tbVacante_vac_Id		FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #46*/
CREATE TABLE [Genl].tbIdioma(
	[idio_Id]						INT IDENTITY(1,1),
	[idio_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbIdioma_idio_Id	PRIMARY KEY(idio_Id),
)  
GO

/*Sección #47*/
CREATE TABLE [Genl].tbIdiomaItem(
	[idItm_Id]			INT IDENTITY(1,1),
	[idio_Id]			INT	NOT NULL,
	[vac_Id]			INT NOT NULL,
	CONSTRAINT  PK_Genl_tbIdiomaItem_idItm_Id	PRIMARY KEY(idItm_Id),
	CONSTRAINT  FK_Genl_tbIdiomaItem_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #48*/
CREATE TABLE [Genl].tbLogroEventoCategoria(
	[logCa_Id]			INT IDENTITY(1,1),
	[logCa_Descripcion]	NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbLogroEventoCategoria_logCa_Id	PRIMARY KEY(logCa_Id),
)  
GO

/*Sección #49*/
CREATE TABLE [Genl].tbConfiguracion(
	[conf_Id]			INT IDENTITY(1,1),
	[conf_Nombre]		NVARCHAR(500)	NOT NULL,
	[conf_Valor]		NVARCHAR(500)	NOT NULL,
	[conf_Descripcion]	NVARCHAR(500)	NOT NULL
	CONSTRAINT  PK_Genl_tbConfiguracion_conf_Id	PRIMARY KEY(conf_Id),
	CONSTRAINT [UQ_Genl_tbConfiguracion_conf_Nombre] UNIQUE(conf_Nombre)
)  
GO

INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('smtpServer', 'smtp.gmail.com', 'El servidor SMTP para correo')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('smtpPort', '587', ' Puerto SMTP seguro (TLS)')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('senderEmail', 'appcircular2023@gmail.com', 'Correo para Validacion')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('senderPassword', 'lsbuahlrtdgpvdzv', 'Contraseña generada')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('ApiRutaToken', 'https://localhost:44306/Usuario/ValidacionToken?toke=', 'La ruta de api para correos')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioMicroempresa', '1', 'Validar que el tipo de usuario sea el correcto')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioConHablidades', '2', 'Validar usuario Con habilidades')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioONG', '3', 'CalidarONG')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioEmpresa', '4', 'Validar el usaurio Empresa')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioParticular', '5', 'Validar el usuario Particular')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioConLocal', '6', 'Son los usarios que tiene un local ')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('SubRutaLogo', 'Img\Logos', 'Es la ruta de la carperta donde se guradaran los logos se le concatenara ala raiz del proyecto')
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('TamañoLogo', '1', 'Es para validar el tamaño del logo tiene que sere en para pulpilicarlo 1024 * 1024')
GO

/*Sección #50*/
CREATE TYPE dbo.tbHorarioTableType AS TABLE
(
	hor_DiaNumero INT,
    hor_HoraInicio TINYINT,
    hor_MinutoInicio TINYINT,
    hor_HoraFin TINYINT,
    hor_MinutoFin TINYINT
);
GO

/*Sección #51*/
CREATE TYPE dbo.tbCategoriaItemType AS TABLE(
	catg_Id INT
);
GO

/*Sección #38*/
CREATE TYPE dbo.tbUsuarioTelefonoType AS TABLE(
	tipTel_Id INT,
	tipTel_Descripcion NVARCHAR(100)
);
GO
/*Sección #38*/
CREATE TYPE dbo.tbCatalogoImagen AS TABLE(
	catg_Id INT,
	catImg_Ruta NVARCHAR(2000)
);
GO

CREATE PROCEDURE [dbo].[sp_CrearUsuario]
	@tipUs_Id INT,
	@Nombre NVARCHAR(300),
	@RutaLogo NVARCHAR(2000),
	@RutaPaginaWed NVARCHAR(2000),
	@Descripcion NVARCHAR(500),
	--@FechaFundacion DATE,
	@NombreUsuario NVARCHAR(150),
	@Password NVARCHAR(1000),
	@PasswordSal NVARCHAR(1000),
	@tipIde_Id INT,
	@Identificacion NVARCHAR(100),
	--@TelefonoPricipal NVARCHAR(50),
	--@TelefonoSecundario NVARCHAR(50),
	@Facebook NVARCHAR(300),
	@Intagram NVARCHAR(300),
	@WhatsApp BIT,
	@Envio BIT,
	@Correo NVARCHAR(100),
	@SubdicionLugar INT,
	@Latitud NVARCHAR(200),
	@Longitub NVARCHAR(200),
	--Los Datos De tablas
	@tbHorarios tbHorarioTableType READONLY,
	@tbCategoriaItem tbCategoriaItemType READONLY,
	@tbUsuarioTelefono tbUsuarioTelefonoType READONLY,
	    -- Parámetros de salida
    @Success BIT OUTPUT,
    @Message NVARCHAR(1000) OUTPUT,
	@IdUsuario INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION; -- Inicia la transacción
	--Donde se guardara la informacion de la tabla.
	SET @Success = 1;
	--variables de Cursor De Horario
	DECLARE @hor_DiaNumero INT,
            @hor_HoraInicio TINYINT,
            @hor_MinutoInicio TINYINT,
            @hor_HoraFin TINYINT,
            @hor_MinutoFin TINYINT;

    DECLARE @ErrorHorarioInsertar BIT = 0;
	--Variables del Cursor de Categoria
	DECLARE @catg_Id INT;
	DECLARE @ErrorCategoria BIT = 0;
	--Variables del Cursor De Telefono
	DECLARE @tipTel_Id INT,
			@tipTel_Descripcion NVARCHAR(100);

	DECLARE @usInf_Id INT;
	DECLARE @ubc_Id INT;
	DECLARE @user_Id INT;

	--///Declaraciones de los cursores INICIO
	DECLARE curHorarios CURSOR FOR
			SELECT hor_DiaNumero, hor_HoraInicio, hor_MinutoInicio, hor_HoraFin, hor_MinutoFin
			FROM @tbHorarios;

	DECLARE curCategoriaItem CURSOR FOR
		SELECT catg_Id 
		FROM @tbCategoriaItem;

	DECLARE curTelefono CURSOR FOR
		SELECT tipTel_Id, tipTel_Descripcion
		FROM @tbUsuarioTelefono
	--//Fin de la Declaracion

    BEGIN TRY
			
			SET @tipIde_Id = CASE
								WHEN @Identificacion = '' OR @Identificacion = 'N/A' THEN 1
								ELSE @tipIde_Id
							END
			
			INSERT INTO [Genl].[tbInfoUnicaUsuario] ([usInf_Nombre],[usInf_RutaPaginaWed],[tipUs_Id],[usInf_RutaLogo]) VALUES (@Nombre,NULLIF(@RutaPaginaWed, 'N/A'),@tipUs_Id,NULLIF(@RutaLogo, 'N/A'));
			SET @usInf_Id = SCOPE_IDENTITY();
			

			INSERT INTO  [Genl].[tbUbicacion] VALUES(@Latitud,@Longitub,@SubdicionLugar);
			SET @ubc_Id = SCOPE_IDENTITY();

			INSERT INTO [Genl].[tbUsuarios] 
			([usInf_Id],[user_Descripcion],[user_Correo],[user_Facebook],[user_WhatsApp],[user_Password],[user_PasswordSal],[user_NombreUsuario],[ubc_Id],[user_Intagram],[user_Envio],[tipIde_Id],[user_Identificacion],[user_FechaCreacion],[user_UsuarioPrincipal]) 
				VALUES (@usInf_Id, @Descripcion,@Correo,@Facebook,@WhatsApp,@Password,@PasswordSal,@NombreUsuario,@ubc_Id,@Intagram,@Envio,@tipIde_Id,@Identificacion,GETDATE(),1);
			SET @user_Id = SCOPE_IDENTITY();
		
		
		---////Inicio Cursor
		OPEN curHorarios;
        FETCH NEXT FROM curHorarios INTO @hor_DiaNumero, @hor_HoraInicio, @hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                INSERT INTO [Genl].[tbHorario] VALUES (@hor_DiaNumero, @user_Id, @hor_HoraInicio,@hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin);

                FETCH NEXT FROM curHorarios INTO @hor_DiaNumero, @hor_HoraInicio, @hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin;
            END TRY
            BEGIN CATCH
				SET @Success = 0;
				SET @Message = 'Error Ocurrio Al Guardar El Horario: hor_DiaNumero => '+ @hor_DiaNumero+', user_Id => '+@user_Id+', hor_HoraInicio => '+@hor_HoraInicio+', hor_MinutoInicio => '+@hor_MinutoInicio+', hor_HoraFin => '+@hor_HoraFin+', hor_MinutoFin => '+@hor_MinutoFin+'. Error SQL: '+ ERROR_MESSAGE() + ' (Línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
				SET @IdUsuario = 0;

				BREAK;
            END CATCH;
        END;

        CLOSE curHorarios;
        DEALLOCATE curHorarios;
		--//////Fin Cursor
		--//INICIO//
		OPEN curCategoriaItem;
        FETCH NEXT FROM curCategoriaItem INTO @catg_Id;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                INSERT INTO [Genl].[tbCategoriaItem] VALUES (@catg_Id,@user_Id);

                FETCH NEXT FROM curCategoriaItem INTO @catg_Id;
            END TRY
            BEGIN CATCH
				SET @Success = 0;
				SET @Message = 'Error Ocurrio Al Guardar La Categoria: user_Id => '+CONVERT(nvarchar(10),@user_Id)+', aria_Id => '+CONVERT(nvarchar(10),@catg_Id)+'. Error SQL: '+ERROR_MESSAGE() + ' (Línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
				SET @IdUsuario = 0;

				BREAK;
				--ROLLBACK
            END CATCH;
        END;

        CLOSE curCategoriaItem;
        DEALLOCATE curCategoriaItem;
		--//FIN//
		--//INICIO//
		OPEN curTelefono;
        FETCH NEXT FROM curTelefono INTO @tipTel_Id,@tipTel_Descripcion ;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                INSERT INTO Genl.tbUsuarioTelefono VALUES (@tipTel_Id,@user_Id,@tipTel_Descripcion);

                FETCH NEXT FROM curTelefono INTO @tipTel_Id,@tipTel_Descripcion;
            END TRY
            BEGIN CATCH
				SET @Success = 0;
				SET @Message = 'Error Ocurrio Al Guardar El Telefono: user_Id => '+CONVERT(nvarchar(10),@user_Id)+', tipTel_Id => '+CONVERT(nvarchar(10),@tipTel_Id)+', tipTel_Descripcion=> '+CONVERT(nvarchar(100),@tipTel_Descripcion)+'. Error SQL: '+ERROR_MESSAGE() + ' (Línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
				SET @IdUsuario = 0;

				BREAK;
				--ROLLBACK
            END CATCH;
        END;

        CLOSE curTelefono;
        DEALLOCATE curTelefono;
		--//

		IF @Success = 1
		BEGIN
			COMMIT;
			SET @Success = 1;
			SET @Message = 'Transacción completada exitosamente.';
			SET @IdUsuario = @user_Id;
			-- Otras operaciones de manejo de errores si es necesario
		END
		ELSE
		BEGIN
			ROLLBACK;
		END

    END TRY
    BEGIN CATCH
	ROLLBACK; -- Deshace la transacción si hay algún error
        
        -- Cerrar y desasignar el cursor de horarios
        IF CURSOR_STATUS('global', 'curHorarios') >= 0
        BEGIN
            CLOSE curHorarios;
            DEALLOCATE curHorarios;
        END

        -- Cerrar y desasignar el cursor de categorías
        IF CURSOR_STATUS('global', 'curCategoriaItem') >= 0
        BEGIN
            CLOSE curCategoriaItem;
            DEALLOCATE curCategoriaItem;
        END
        
        SET @Success = 0;
        SET @Message = 'Ocurrió un error durante la transacción: ' + ERROR_MESSAGE() + ' (Línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
		SET @IdUsuario = 0;
    END CATCH;
END;
GO

CREATE PROCEDURE [dbo].[sp_Login]
	@Correo NVARCHAR(100),
	--Paramatros de salida
	@Success BIT OUTPUT,
    @Message NVARCHAR(1000) OUTPUT,
	@PasswordSal NVARCHAR(1000) OUTPUT,
	@Password NVARCHAR(1000) OUTPUT,
	@IdUsuario INT OUTPUT

AS
BEGIN
	BEGIN TRY
		SET @Password = '';
		SET @PasswordSal = '';
		SET @IdUsuario = 0;
		SET @Correo = UPPER(@Correo);
		DECLARE @TotalInfUsuariosUnico int
		DECLARE @IgualInfo BIT

		DECLARE @Tabla TABLE(
			infUsu_Id int
		)

		INSERT INTO @Tabla (infUsu_Id)
		 SELECT DISTINCT
				InfUS.usInf_Id
		FROM Genl.tbInfoUnicaUsuario AS InfUS
		INNER JOIN Genl.tbUsuarios AS US 
		ON InfUS.usInf_Id = US.usInf_Id AND InfUS.usInf_Verificado = 1 AND US.user_Verificado = 1 AND UPPER(US.user_Correo) = @Correo
	
		SET @TotalInfUsuariosUnico = (select COUNT(*) from @Tabla);
		IF @TotalInfUsuariosUnico > 1
		BEGIN
		--Falta validar que si el usuario creo otra cuanta con el mismo correo.  
			SET @Success = 0;
			SET @Message = 'Parece que existen dos usuarios unicos con el mismi correo';
			RETURN;
		END
		IF @TotalInfUsuariosUnico = 0
		BEGIN
			SET @Success = 0;
			SET @Message = 'No Existe Un usuario con ese correo';
			RETURN;
		END

		SET @IgualInfo = (SELECT	InfUS.usInf_IgualSubInfo
		FROM Genl.tbInfoUnicaUsuario AS InfUS
		where InfUS.usInf_Id = (select top 1 * from @Tabla))

		DECLARE @UsuarioTable TABLE(
				user_Id int,
				user_Password NVARCHAR(1000),
				user_PasswordSal NVARCHAR(1000),
				user_UsuarioPrincipal BIT
			)
			INSERT INTO @UsuarioTable(user_Id, user_Password, user_PasswordSal, user_UsuarioPrincipal)
		SELECT us.user_Id, us.user_Password, us.user_PasswordSal, us.user_UsuarioPrincipal FROM Genl.tbUsuarios AS us where us.usInf_Id = (select top 1 * from @Tabla)

		IF @IgualInfo = 1
		BEGIN
			SET @IdUsuario = (select top 1 us.user_Id from @UsuarioTable as us)
			SET @Password = (select top 1 us.user_Password from @UsuarioTable as us)
			SET @PasswordSal = (select top 1 us.user_PasswordSal from @UsuarioTable as us)
			SET @Success = 1;
			SET @Message = 'El usuario Fue encontrado';
		END
		ELSE 
		BEGIN
			SET @IdUsuario = (select top 1 us.user_Id from @UsuarioTable as us where us.user_UsuarioPrincipal = 1)
			SET @Password = (select top 1 us.user_Password from @UsuarioTable as us where us.user_UsuarioPrincipal = 1)
			SET @PasswordSal = (select top 1 us.user_PasswordSal from @UsuarioTable as us where us.user_UsuarioPrincipal = 1)
			SET @Success = 1;
			SET @Message = 'El usuario Fue encontrado';
		END
	END TRY
	BEGIN CATCH
			SET @Success = 0;
			SET @Message = 'Ocurrio un error inesperado Error=>'+ERROR_MESSAGE() + ' (Linia: '+ CAST(ERROR_LINE() AS NVARCHAR(10))+')';
	END CATCH
END;

GO
CREATE TRIGGER Trigger_VerificarUsuario
ON [Genl].tbUsuarios
AFTER UPDATE
AS
BEGIN
    IF UPDATE(user_Verificado)  -- Comprueba si user_Verificado se actualizó
    BEGIN
      DECLARE @ExistingUserVerificado INT;

		-- Verifica si todavía existen registros con user_Verificado igual a 1 para el mismo usInf_Id
		SELECT @ExistingUserVerificado = COUNT(*)
		FROM [Genl].tbUsuarios AS u
		INNER JOIN inserted AS i ON u.usInf_Id = i.usInf_Id
		WHERE u.user_Verificado = 1;

        -- Actualiza usInf_Verificado solo si user_Verificado se establece en 0 y no hay otros registros con 1

        UPDATE u
        SET u.usInf_Verificado = CASE WHEN @ExistingUserVerificado = 0 THEN 0 ELSE 1 END
        FROM [Genl].tbInfoUnicaUsuario AS u
        INNER JOIN inserted AS i ON u.usInf_Id = i.usInf_Id
    END
END;
