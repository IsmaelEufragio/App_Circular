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
    [tipUs_Id]              UNIQUEIDENTIFIER DEFAULT NEWID(),
    [tipUs_Descripcion]     NVARCHAR(300) NOT NULL,
    CONSTRAINT PK_Genl_tbTipoUsuario_tipUs_Id PRIMARY KEY(tipUs_Id)
); 
GO
INSERT INTO [Genl].[tbTipoUsuario]	VALUES ('928B1B2A-227A-4E54-9F3C-866930FAFB07','Microempresa');
INSERT INTO [Genl].[tbTipoUsuario]	VALUES ('03AB93B7-84AB-4C9E-BCA9-B241826DA9C1','Usuarios con habilidades');
INSERT INTO [Genl].[tbTipoUsuario]	VALUES ('C3615270-138B-4B56-BCB7-3AD1C5528EF3','ONG');
INSERT INTO [Genl].[tbTipoUsuario]	VALUES ('C45E1F6B-5767-42F0-BD0E-2820EFBBCB73','Empresa');
INSERT INTO [Genl].[tbTipoUsuario]	VALUES ('ED9F065E-9633-46C3-9E71-A272230A1C42','Usuario Particular');
INSERT INTO [Genl].[tbTipoUsuario]	VALUES ('2AE8401C-A871-4450-B431-AAD28EF495D1','Local');
GO

/*Sección #3*/
CREATE TABLE [Genl].tbInfoUnicaUsuario(
	[usInf_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
	[usInf_IgualSubInfo]		BIT NOT NULL DEFAULT 1,
	[usInf_Nombre]				NVARCHAR(300)	NOT NULL,
	[usInf_RutaLogo]			NVARCHAR(2000) NOT NULL DEFAULT '',
	[usInf_RutaPaginaWed]		NVARCHAR(2000) NOT NULL DEFAULT '',
	[usInf_Verificado]			BIT	NOT NULL DEFAULT 0,
	[tipUs_Id]					UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT  PK_Genl_tbInfoUnicaUsuario_usInf_Id	PRIMARY KEY(usInf_Id),
	CONSTRAINT  FK_Genl_tbInfoUnicaUsuario_tbTipoUsuario_tipUs_Id	FOREIGN KEY(tipUs_Id) REFERENCES Genl.tbTipoUsuario(tipUs_Id)
)  
GO

/*Sección #4*/
CREATE TABLE [Genl].tbPais(
	[pais_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[pais_Nombre]					NVARCHAR(500)	NOT NULL,
	[pais_Abrebiatura]				NVARCHAR(10)	NOT NULL DEFAULT '',
	CONSTRAINT  PK_Genl_tbPais_pais_Id	PRIMARY KEY(pais_Id)
)  
GO
INSERT INTO [Genl].[tbPais]	VALUES ('91C17540-D6D0-4036-81EF-27C19C4DA30D','Honduras', 'HN')
INSERT INTO [Genl].[tbPais]	VALUES ('121EE252-8468-457B-93CA-DCB242FACE5B','Guatemala', 'GT')
INSERT INTO [Genl].[tbPais]	VALUES ('8AE202C6-6794-48E8-8B49-56CE5BA57651','El Salvador', 'SLV')
INSERT INTO [Genl].[tbPais]	VALUES ('BE9DBF28-438C-4FE5-AF22-A41A593D797D','Nicaragua', 'NIC')
INSERT INTO [Genl].[tbPais]	VALUES ('776AFB4C-0A59-4AC9-8CAC-577E7B7D21F6','Costa Rica', 'CR')
INSERT INTO [Genl].[tbPais]	VALUES ('9DC7E629-6121-40E8-8A33-065BB0F99565','Panama', 'PM')
INSERT INTO [Genl].[tbPais]	VALUES ('E51924D4-02DB-4A1C-BB8A-CC1717E79B2E','Mexico', 'MX')
GO

/*Sección #5*/
CREATE TABLE [Genl].tbDepartamento(
	[dept_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[dept_Nombre]					NVARCHAR(500)		NOT NULL,
	[pais_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[dept_NuIdentidad]				INT NOT NULL,
	CONSTRAINT  PK_Genl_tbDepartamento_dept_Id			PRIMARY KEY(dept_Id),
	CONSTRAINT  FK_Genl_tbDepartamento_tbPais_pai_Id	FOREIGN KEY(pais_Id) REFERENCES Genl.tbPais(pais_Id)
)  
GO
INSERT INTO [Genl].[tbDepartamento] VALUES ('D9C04392-BF45-4741-9B9D-DD140070A9FA','Atlántida',	'91C17540-D6D0-4036-81EF-27C19C4DA30D', 1)
INSERT INTO [Genl].[tbDepartamento] VALUES ('3B509492-1CC4-43E3-A8F3-6D95B6B60CE2','Choluteca',	'91C17540-D6D0-4036-81EF-27C19C4DA30D', 2)
INSERT INTO [Genl].[tbDepartamento] VALUES ('CFFDC753-CD4C-4617-8D96-D43D41E47B50','Colón',		'91C17540-D6D0-4036-81EF-27C19C4DA30D', 3)
INSERT INTO [Genl].[tbDepartamento] VALUES ('A966DC5A-D80B-46E5-8156-AF59B2017155','Comayagua',	'91C17540-D6D0-4036-81EF-27C19C4DA30D', 4)
INSERT INTO [Genl].[tbDepartamento] VALUES ('5C1CCB34-7633-4CA8-91D0-E37878B9EC3D','Copán',		'91C17540-D6D0-4036-81EF-27C19C4DA30D', 5)
INSERT INTO [Genl].[tbDepartamento] VALUES ('98F1A182-B763-4582-A25B-553E8382CFFB','Cortés',	'91C17540-D6D0-4036-81EF-27C19C4DA30D', 6)
GO

/*Sección #6*/
CREATE TABLE [Genl].tbMunicipio(
	[muni_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[muni_Nombre]					NVARCHAR(500)		NOT NULL,
	[dept_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[muni_NuIdentidad]				INT NOT NULL,
	[muni_ValidaciosTelefono]		NVARCHAR(1000) NOT NULL DEFAULT '',
	[muni_ValidaciosTelefonoFijo]	NVARCHAR(1000) NOT NULL DEFAULT '',
	CONSTRAINT  PK_Genl_tbMunicipio_muni_Id			PRIMARY KEY(muni_Id),
	CONSTRAINT  FK_Genl_tbMunicipio_tbDepartamento_dept_Id	FOREIGN KEY(dept_Id) REFERENCES Genl.tbDepartamento(dept_Id)
)  
GO
INSERT INTO [Genl].[tbMunicipio] VALUES ('2687E8E0-EC7D-401C-BF8C-B455EBA27926','La Ceiba',		 'D9C04392-BF45-4741-9B9D-DD140070A9FA', 1, 'N/A', 'N/A')
INSERT INTO [Genl].[tbMunicipio] VALUES ('402C1738-D344-489F-9B34-0A88ADD6F41A','El Porvenir',	 'D9C04392-BF45-4741-9B9D-DD140070A9FA', 2, 'N/A', 'N/A')
INSERT INTO [Genl].[tbMunicipio] VALUES ('FDD910C1-F5C8-4A41-BFEF-46977F8E5BE6','San Pedro Sula','98F1A182-B763-4582-A25B-553E8382CFFB', 4, 'N/A', 'N/A')
GO

/*Sección #7*/
CREATE TABLE [Genl].tbCategoriaLugar(
	[catLug_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catLug_Nombre]					NVARCHAR(500)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaLugar_catLug_Id			PRIMARY KEY(catLug_Id)
)  
GO
INSERT INTO [Genl].[tbCategoriaLugar] VALUES ('58D4FCA6-2887-47F4-A35A-5B7B3F5F586A','Ciudad')
INSERT INTO [Genl].[tbCategoriaLugar] VALUES ('875BF1FE-F363-45EC-AD95-7136557B6E50','Caserio')
INSERT INTO [Genl].[tbCategoriaLugar] VALUES ('BF2153EC-4900-4ACF-AC45-A31D42C0E6B2','N/A')
GO

/*Sección #8*/
CREATE TABLE [Genl].tbLugar(
	[lug_Id]			UNIQUEIDENTIFIER DEFAULT NEWID(),
	[lug_Nombre]		NVARCHAR(500)		NOT NULL,
	[catLug_Id]			UNIQUEIDENTIFIER	NOT NULL,
	[muni_Id]			UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbLugar_lug_Id			PRIMARY KEY(lug_Id),
	CONSTRAINT  FK_Genl_tbLugar_tbCategoriaLugar_catLug_Id	FOREIGN KEY(catLug_Id) REFERENCES Genl.tbCategoriaLugar(catLug_Id),
	CONSTRAINT  FK_Genl_tbLugar_tbMunicipio_muni_Id			FOREIGN KEY(muni_Id) REFERENCES Genl.tbMunicipio(muni_Id),
)  
GO	
INSERT INTO [Genl].[tbLugar] VALUES ('FCD41A99-8549-4088-B512-0DA0B1185561','Cofradia', '875BF1FE-F363-45EC-AD95-7136557B6E50', 'FDD910C1-F5C8-4A41-BFEF-46977F8E5BE6')
GO

/*Sección #9*/
CREATE TABLE [Genl].tbCategoriaSubdivicion(
	[catSub_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catSub_Nombre]					NVARCHAR(500)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaSubdivicion_catSub_Id	PRIMARY KEY(catSub_Id)
)  
GO
INSERT INTO [Genl].[tbCategoriaSubdivicion] VALUES ('FEFDD3B9-6CBD-437F-9086-739F4A92264E','Colonia')
INSERT INTO [Genl].[tbCategoriaSubdivicion] VALUES ('490186CF-0960-4710-9356-C230F38D0AD6','Aria Rural')
Go

/*Sección #10*/
CREATE TABLE [Genl].tbSubdivicionLugar(
	[subLug_Id]			UNIQUEIDENTIFIER DEFAULT NEWID(),
	[subLug_Nombre]	 	NVARCHAR(500)		NOT NULL,
	[catSub_Id]			UNIQUEIDENTIFIER	NOT NULL,
	[lug_Id]			UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbSubdivicionLugar_subLug_Id			PRIMARY KEY(subLug_Id),
	CONSTRAINT  FK_Genl_tbSubdivicionLugar_tbCategoriaSubdivicion_catSub_Id	FOREIGN KEY(catSub_Id) REFERENCES Genl.tbCategoriaSubdivicion(catSub_Id),
	CONSTRAINT  FK_Genl_tbSubdivicionLugar_tbLugar_lug_Id	FOREIGN KEY(lug_Id) REFERENCES Genl.tbLugar(lug_Id),
)  
GO	
INSERT INTO [Genl].[tbSubdivicionLugar] VALUES ('C37CE24C-35A2-45F5-B699-22CA2C4C604C','24 de abril # 1','FEFDD3B9-6CBD-437F-9086-739F4A92264E','FCD41A99-8549-4088-B512-0DA0B1185561')
GO


/*Sección #11*/
CREATE TABLE [Genl].tbUbicacion(
	[ubc_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[ubc_Latitud]					NVARCHAR(200)		NOT NULL,
	[ubc_Longitub]					NVARCHAR(200)		NOT NULL,
	[subLug_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbUbicacion_ubc_Id			PRIMARY KEY(ubc_Id),
	CONSTRAINT  FK_Genl_tbUbicacion_tbSubdivicionLugar_subLug_Id	FOREIGN KEY(subLug_Id) REFERENCES Genl.tbSubdivicionLugar(subLug_Id),
)  
GO

/*Sección #12*/
CREATE TABLE [Genl].tbTipoIdentificacion(
	[tipIde_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipIde_Descripcion]			NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoIdentificacion_tipIde_Id			PRIMARY KEY(tipIde_Id),
)
GO
INSERT INTO [Genl].[tbTipoIdentificacion] VALUES ('F0932129-5A5C-4B93-AE15-5922C3875E07','No Proporcionada')
GO

/*Sección #13*/
CREATE TABLE [Genl].tbUsuarios(
	[user_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[usInf_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[user_Descripcion]				NVARCHAR(500)		NOT NULL,
	[ubc_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[user_Identificacion]			NVARCHAR(100)		NOT NULL DEFAULT '',
	[tipIde_Id]						UNIQUEIDENTIFIER	NOT NULL DEFAULT 'F0932129-5A5C-4B93-AE15-5922C3875E07',
	[user_NombreUsuario]			NVARCHAR(150)		NOT NULL DEFAULT '',
	[user_Password]					NVARCHAR(1000)		NOT NULL,
	[user_PasswordSal]				NVARCHAR(1000)		NOT NULL,
	[user_FechaCreacion]			DATETIME ,
	[user_Correo]					NVARCHAR(100)		NOT NULL,
	[user_Facebook]					NVARCHAR(100)		NOT NULL DEFAULT '',
	[user_Intagram]					NVARCHAR(100)		NOT NULL DEFAULT '',
	[user_WhatsApp]					BIT					NOT NULL DEFAULT 0,
	[user_Envio]					BIT					NOT NULL DEFAULT 0,
	[user_UsuarioPrincipal]			BIT					NOT NULL DEFAULT 0,
	[user_Verificado]				BIT					NOT NULL DEFAULT 0 
	CONSTRAINT  PK_Genl_tbUsuarios_User_Id			PRIMARY KEY(User_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbInfoUnicaUsuario_usInf_Id		FOREIGN KEY(usInf_Id) REFERENCES Genl.tbInfoUnicaUsuario(usInf_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbUbicacion_ubc_Id				FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbTipoIdentificacion_tipIde_Id	FOREIGN KEY(tipIde_Id) REFERENCES Genl.tbTipoIdentificacion(tipIde_Id)
)  
GO

/*Sección #14*/
CREATE TABLE [Genl].tbTipoTelefono(
	[tipTel_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipTel_Descripcion]			NVARCHAR(300)		NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoTelefono_tipTel_Id		PRIMARY KEY(tipTel_Id),
)  
GO
INSERT INTO [Genl].[tbTipoTelefono] VALUES ('A05A99FE-B038-4F52-AAEF-4667C1741ADD','Fijo')
INSERT INTO [Genl].[tbTipoTelefono] VALUES ('56C02185-4892-4C54-B8D3-7F93CDF241AC','Celular')
GO

/*Sección #15*/
CREATE TABLE [Genl].tbUsuarioTelefono(
	[usTel_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipTel_Id]						UNIQUEIDENTIFIER NOT NULL,
	[user_Id]						UNIQUEIDENTIFIER NOT NULL,
	[usTel_Numero]					NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbUsuarioTelefono_usTel_Id			PRIMARY KEY(usTel_Id),
	CONSTRAINT  FK_Genl_tbUsuarioTelefono_tbTipoTelefono_tipTel_Id	FOREIGN KEY(tipTel_Id) REFERENCES Genl.tbTipoTelefono(tipTel_Id),
	CONSTRAINT  FK_Genl_tbUsuarioTelefono_tbUsuarios_user_Id		FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO

/*Sección #16*/
CREATE TABLE [Genl].tbCategoria(
	[catg_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catg_Nombre]					NVARCHAR(500)		NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoria_catg_Id		PRIMARY KEY(catg_Id)
)  
GO
INSERT INTO [Genl].[tbCategoria] VALUES ('942D1D80-BB02-4609-B821-478165C2E3E9','Comida')
INSERT INTO [Genl].[tbCategoria] VALUES ('75DB0E50-65C6-4C4E-8741-E43DA9B41094','Reposteria')
INSERT INTO [Genl].[tbCategoria] VALUES ('5B997BC8-ED7B-4FB3-AA57-7B2EBF71B83E','Carpinteria')
GO

/*Sección #17*/
CREATE TABLE [Genl].tbSubCategoria(
	[subCat_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catg_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[catg_Nombre]					NVARCHAR(500)		NOT NULL,
	CONSTRAINT  PK_Genl_tbSubCategoria_subCat_Id		PRIMARY KEY(subCat_Id),
	CONSTRAINT  FK_Genl_tbSubCategoria_tbCategoria_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCategoria(catg_Id),
)

/*Sección #18*/
CREATE TABLE [Genl].tbCategoriaItem(
	[catgItem_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catg_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[user_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaItem_catgItem_Id			PRIMARY KEY(catgItem_Id),
	CONSTRAINT  FK_Genl_tbCategoriaItem_tbCategoria_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCategoria(catg_Id),
	CONSTRAINT  FK_Genl_tbCategoriaItem_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

/*Sección #19*/
CREATE TABLE [Genl].tbHorario( 
	[hor_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[hor_DiaNumero]					INT					NOT NULL,
	[user_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[hor_HoraInicio]				TIME				NOT NULL,
	[hor_HoraFin]					TIME				NOT NULL,
	CONSTRAINT  PK_Genl_tbHorario_hor_Id				PRIMARY KEY(hor_Id),
	CONSTRAINT  FK_Genl_tbHorario_tbUsuarios_User_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
	CONSTRAINT CK_Horario_HoraFin_Mayor_Que_Inicio CHECK (hor_HoraFin > hor_HoraInicio)
)  
GO

/*Sección #20*/
CREATE TABLE [Genl].tbTipoCatalogo(
	[tipCatg_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipCatg_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoCatalogo_tipCatg_Id	PRIMARY KEY(tipCatg_Id)
) 
GO
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('A84188B6-7F3E-49A3-8614-1CAA45424C7B','Producto')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('EA25C4AA-0EA1-4F38-A8AC-3FCA098E3B84','Servicio')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('AE8DFDAC-CA8D-407E-879A-A72353B54012','Necesita')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('0C9F9824-EA73-4BEF-B436-CC06BC245994','Desperdicio')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('EC9F252B-7BAA-4E1E-804D-2D61C473CCC7','Habilidades')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('1776A704-2EA4-4256-B882-564FA29C2FB3','Logros')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('13E1F81F-DEEE-4BE2-92E1-BBBF5041B9B3','Eventos')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('900FB4B5-C9AC-4559-BDE5-10918F70EC16','Vacantes')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('BC184B0A-D877-4D72-A8C0-186C149EC3F6','Vende')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('68101492-50ED-4B3E-B0EB-E29A20552BBD','Venta Relámpago')
INSERT INTO [Genl].[tbTipoCatalogo] VALUES ('7793B005-F565-4411-A9A3-CAD02B3502DC','Alquila')
GO

/*Sección #21*/
CREATE TABLE [Genl].tbCatalogoPorUsuario(
	[catUsua_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipCatg_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[tipUs_Id]							UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbCatalogoPorUsuario_catUsua_Id	PRIMARY KEY(catUsua_Id),
	CONSTRAINT  FK_Genl_tbCatalogoPorUsuario_tbTipoCatalogo_tipCatg_Id	FOREIGN KEY(tipCatg_Id) REFERENCES Genl.tbTipoCatalogo(tipCatg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoPorUsuario_tbTipoUsuario_tipUs_Id	FOREIGN KEY(tipUs_Id) REFERENCES Genl.tbTipoUsuario(tipUs_Id)
) 
GO

/*Sección #22*/
CREATE TABLE [Genl].tbFiltroCategoriaTipo(
	[fiCg_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catg_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[tipCatg_Id]					UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbFiltroCategoriaTipo_fiCg_Id	PRIMARY KEY(fiCg_Id),
	CONSTRAINT  FK_Genl_tbFiltroCategoriaTipo_tbTipoCatalogo_tipCatg_Id	FOREIGN KEY(tipCatg_Id) REFERENCES Genl.tbTipoCatalogo(tipCatg_Id),
	CONSTRAINT  FK_Genl_tbFiltroCategoriaTipo_tbCategoria_catg_Id		FOREIGN KEY(catg_Id) REFERENCES Genl.tbCategoria(catg_Id)
)
GO

/*Sección #23*/
CREATE TABLE [Genl].tbTipoTransaccion(
    [tipTran_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [tipTran_Nombre]				NVARCHAR(300)		NOT NULL DEFAULT '',
    CONSTRAINT  PK_Genl_tbTipoTransaccion_tipTran_Id	PRIMARY KEY(tipTran_Id),
)

/*Sección #24*/
CREATE TABLE [Genl].tbTransaccion(
    [tran_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [tipTran_Id]				UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbTransaccion_tran_Id	                    PRIMARY KEY(tran_Id),
    CONSTRAINT  FK_Genl_tbTransaccion_tbTipoTransaccion_tipCatg_Id	FOREIGN KEY(tipTran_Id) REFERENCES Genl.tbTipoTransaccion(tipTran_Id),
)

/*Sección #25*/
CREATE TABLE [Genl].tbTipoImagen(
    [tipImg_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [tipImg_Descripcion]		NVARCHAR(300)		NOT NULL DEFAULT '',
    CONSTRAINT  PK_Genl_tbTipoImagen_tipImg_Id	PRIMARY KEY(tipImg_Id),
)
GO
INSERT INTO [Genl].[tbTipoImagen] VALUES ('514EAF59-038F-498B-BF7C-636E749906C4','Portada')


/*Sección #26*/
CREATE TABLE [Genl].tbCatalogoImagen(
    [catImg_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipImg_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]					UNIQUEIDENTIFIER	NOT NULL,
    [catImg_Ruta]				NVARCHAR(300)		NOT NULL DEFAULT '',
    CONSTRAINT  PK_Genl_tbCatalogoImagen_catImg_Id	PRIMARY KEY(catImg_Id),
	CONSTRAINT  FK_Genl_tbCatalogoImagen_tbTransaccion_tran_Id	FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id),
	CONSTRAINT  FK_Genl_tbCatalogoImagen_tbTipoImagen_tipImg_Id	FOREIGN KEY(tipImg_Id) REFERENCES Genl.tbTipoImagen(tipImg_Id),
)

/*Sección #27*/
CREATE TABLE [Genl].tbCategoriaReaccion(
    [catReac_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [catReac_Descripcion]			NVARCHAR(300)		NOT NULL DEFAULT '',
    CONSTRAINT  PK_Genl_tbCategoriaReaccion_catReac_Id	PRIMARY KEY(catReac_Id),
)

/*Sección #28*/
CREATE TABLE [Genl].tbTipoReaccion(
    [tipReac_Id]				UNIQUEIDENTIFIER DEFAULT NEWID(),
	[catReac_Id]				UNIQUEIDENTIFIER	NOT NULL,
    [tipReac_Descripcion]		NVARCHAR(300)		NOT NULL DEFAULT '',
    CONSTRAINT  PK_Genl_tbTipoReaccion_tipReac_Id				PRIMARY KEY(tipReac_Id),
	CONSTRAINT  FK_Genl_tbTipoReaccion_tbTransaccion_catReac_Id	FOREIGN KEY(catReac_Id) REFERENCES Genl.tbCategoriaReaccion(catReac_Id),
)

/*Sección #29*/
CREATE TABLE [Genl].tbReaccion(
    [reac_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipReac_Id]				UNIQUEIDENTIFIER	NOT NULL,
    [tran_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[user_Id]					UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbReaccion_reac_Id						PRIMARY KEY(reac_Id),
	CONSTRAINT  FK_Genl_tbReaccion_tbTipoReaccion_tipReac_Id	FOREIGN KEY(tipReac_Id) REFERENCES Genl.tbTipoReaccion(tipReac_Id),
	CONSTRAINT  FK_Genl_tbReaccion_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id),
	CONSTRAINT  FK_Genl_tbReaccion_tbUsuarios_user_Id	    	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)

/*Sección #32*/
CREATE TABLE [Genl].tbProducto(
    [prod_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [prod_Nombre]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [prod_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
    [prod_Codigo]               INT                 NOT NULL,
    [prod_Unidades]             INT                 NOT NULL DEFAULT 1,
    [tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
    [prod_ActoParaMenores]      BIT                 NOT NULL DEFAULT 1,
    [prod_FechaCreacion]        DATE                NOT NULL DEFAULT GETDATE(),
    [prod_FechaVencimiento]     DATE                    NULL,
    CONSTRAINT  PK_Genl_tbProducto_prod_Id				    PRIMARY KEY(prod_Id),
    CONSTRAINT  FK_Genl_tbProducto_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbProducto_tbTransaccion_tipCatg_Id	FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
)

/*Sección #33*/
CREATE TABLE [Genl].tbPrecioProducto(
    [prodPrec_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
	[prod_Id]                       UNIQUEIDENTIFIER	NOT NULL,
    [prodPrec_Precio]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
    [prodPrec_CantidadInicio]		INT		            NOT NULL DEFAULT 0,
    [prodPrec_CantidadFin]		    INT		                NULL,
    [prodPrec_FechaInicioDescuento] DATETIME                NULL,
    [prodPrec_FechaFinDescuento]    DATETIME                NULL,
    [prodPrec_Descuento]			DECIMAL(18,2)		    NULL,
    CONSTRAINT  PK_Genl_tbPrecioProducto_prodPrec_Id				PRIMARY KEY(prodPrec_Id),
    CONSTRAINT  FK_Genl_tbPrecioProducto_tbProducto_prod_Id	        FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
)

/*Sección #34*/
CREATE TABLE [Genl].tbCategoriaPorProducto(
    [subCat_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [prod_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [principal]						BIT 				NOT NULL DEFAULT 0,
    CONSTRAINT  PK_Genl_tbCategoriaPorProducto_subCat_Id_prod_Id		PRIMARY KEY(subCat_Id,prod_Id),
    CONSTRAINT  FK_Genl_tbCategoriaPorProducto_tbProducto_prod_Id	    FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
	CONSTRAINT  FK_Genl_tbCategoriaPorProducto_tbSubCategoria_subCat_Id	FOREIGN KEY(subCat_Id) REFERENCES Genl.tbSubCategoria(subCat_Id)
)

/*Sección #35*/
CREATE TABLE [Genl].tbOrigen(
    [origen_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [origen_Descripcion]		NVARCHAR(1000)		NOT NULL DEFAULT '',
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
	[prod_Id]					UNIQUEIDENTIFIER 	NOT NULL,
    CONSTRAINT  PK_Genl_tbOrigen_origen_Id					PRIMARY KEY(origen_Id),
	CONSTRAINT  FK_Genl_tbOrigen_tbTransaccion_tipCatg_Id	FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id),
	CONSTRAINT  FK_Genl_tbOrigen_tbProducto_prod_Id	    	FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
)

/*Sección #36*/
CREATE TABLE [Genl].tbContribuyente(
	[origen_Id]                 UNIQUEIDENTIFIER	NOT NULL,
	[user_Id]					UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbContribuyente_origen_Id_user_Id			PRIMARY KEY(origen_Id,user_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbOrigen_origen_Id			FOREIGN KEY(origen_Id) REFERENCES Genl.tbOrigen(origen_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbUsuarios_user_Id	    	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)

/*Sección #37*/
CREATE TABLE [Genl].tbServicio(
    [serv_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [serv_Nombre]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [serv_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
    [serv_Codigo]               INT                 NOT NULL,
    [tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
    [serv_FechaCreacion]        DATE                NOT NULL DEFAULT GETDATE(),
    CONSTRAINT  PK_Genl_tbServicio_serv_Id				    PRIMARY KEY(serv_Id),
    CONSTRAINT  FK_Genl_tbServicio_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbServicio_tbTransaccion_tipCatg_Id	FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
)


/*Sección #38*/
CREATE TABLE [Genl].tbCategoriaPorServicio(
    [subCat_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [serv_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [principal]						BIT 				NOT NULL DEFAULT 0,
    CONSTRAINT  PK_Genl_tbCategoriaPorServicio_subCat_Id_serv_Id		PRIMARY KEY(subCat_Id,serv_Id),
    CONSTRAINT  FK_Genl_tbCategoriaPorServicio_tbServicio_serv_Id	    FOREIGN KEY(serv_Id) REFERENCES Genl.tbServicio(serv_Id),
	CONSTRAINT  FK_Genl_tbCategoriaPorServicio_tbSubCategoria_subCat_Id	FOREIGN KEY(subCat_Id) REFERENCES Genl.tbSubCategoria(subCat_Id)
)

/*Sección #39*/
CREATE TABLE [Genl].tbDesperdicio(
    [desp_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [desp_Nombre]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [desp_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
    [desp_Codigo]               INT                 NOT NULL,
    [tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
    [serv_FechaCreacion]        DATE                NOT NULL DEFAULT GETDATE(),
	[desp_Gratis]				BIT 				NOT NULL DEFAULT 1,
    CONSTRAINT  PK_Genl_tbDesperdicio_desp_Id				    PRIMARY KEY(desp_Id),
    CONSTRAINT  FK_Genl_tbDesperdicio_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbDesperdicio_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
)

/*Sección #40*/
CREATE TABLE [Genl].tbDesperdicioServicio(
	[desp_Id]               UNIQUEIDENTIFIER	NOT NULL,
	[serv_Id]				UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbDesperdicioServicio_desp_Id_serv_Id			PRIMARY KEY(desp_Id,serv_Id),
	CONSTRAINT  FK_Genl_tbDesperdicioServicio_tbDesperdicio_desp_Id		FOREIGN KEY(desp_Id) REFERENCES Genl.tbDesperdicio(desp_Id),
	CONSTRAINT  FK_Genl_tbDesperdicioServicio_tbServicio_serv_Id	    FOREIGN KEY(serv_Id) REFERENCES Genl.tbServicio(serv_Id),
)

/*Sección #41*/
CREATE TABLE [Genl].tbDesperdicioProducto(
	[desp_Id]               UNIQUEIDENTIFIER	NOT NULL,
	[prod_Id]				UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbDesperdicioProducto_desp_Id_prod_Id			PRIMARY KEY(desp_Id,prod_Id),
	CONSTRAINT  FK_Genl_tbDesperdicioProducto_tbDesperdicio_desp_Id		FOREIGN KEY(desp_Id) REFERENCES Genl.tbDesperdicio(desp_Id),
	CONSTRAINT  FK_Genl_tbDesperdicioProducto_tbProducto_prod_Id	    FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
)


/*Sección #42*/
CREATE TABLE [Genl].tbNecesitan(
	[necs_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [necs_Nombre]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [necs_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbNecesitan_necs_Id					PRIMARY KEY(necs_Id),
	CONSTRAINT  FK_Genl_tbNecesitan_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbNecesitan_tbTransaccion_tran_Id	FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
)

/*Sección #43*/
CREATE TABLE [Genl].tbCategoriaPorNecesidad(
    [subCat_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [necs_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [principal]						BIT 				NOT NULL DEFAULT 0,
    CONSTRAINT  PK_Genl_tbCategoriaPorNecesidad_subCat_Id_necs_Id		PRIMARY KEY(subCat_Id,necs_Id),
    CONSTRAINT  FK_Genl_tbCategoriaPorNecesidad_tbNecesitan_necs_Id	    FOREIGN KEY(necs_Id) REFERENCES Genl.tbNecesitan(necs_Id),
	CONSTRAINT  FK_Genl_tbCategoriaPorNecesidad_tbSubCategoria_subCat_Id	FOREIGN KEY(subCat_Id) REFERENCES Genl.tbSubCategoria(subCat_Id)
)

/*Sección #44*/
CREATE TABLE [Genl].tbHabilidad(
	[hab_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [hab_Titulo]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [hab_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
	[hab_Precio]				DECIMAL(18,2)			NULL DEFAULT 0,
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbHabilidad_hab_Id					PRIMARY KEY(hab_Id),
	CONSTRAINT  FK_Genl_tbHabilidad_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbHabilidad_tbTransaccion_tran_Id	FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
)

/*Sección #45*/
CREATE TABLE [Genl].tbCategoriaPorHabilidad(
    [subCat_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [hab_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [principal]						BIT 				NOT NULL DEFAULT 0,
    CONSTRAINT  PK_Genl_tbCategoriaPorHabilidad_subCat_Id_hab_Id		PRIMARY KEY(subCat_Id,hab_Id),
    CONSTRAINT  FK_Genl_tbCategoriaPorHabilidad_tbHabilidad_hab_Id	    FOREIGN KEY(hab_Id) REFERENCES Genl.tbHabilidad(hab_Id),
	CONSTRAINT  FK_Genl_tbCategoriaPorHabilidad_tbSubCategoria_subCat_Id	FOREIGN KEY(subCat_Id) REFERENCES Genl.tbSubCategoria(subCat_Id)
)

/*Sección #44*/
CREATE TABLE [Genl].tbEstadoEvento(
	[EstEven_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [EstEven_Descripcion]			NVARCHAR(300)		NOT NULL DEFAULT '',
    CONSTRAINT  PK_Genl_tbEstadoEvento_hab_Id			PRIMARY KEY(EstEven_Id),
)

/*Sección #45*/
CREATE TABLE [Genl].tbEvento(
	[even_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [even_Titulo]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [even_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
	[even_FechaInicio]			DATETIME			NOT NULL,
	[even_FechaFin]				DATETIME			NULL,
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
	[EstEven_Id]                UNIQUEIDENTIFIER	NOT NULL,
	[ubc_Id]					UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbEvento_even_Id					PRIMARY KEY(even_Id),
	CONSTRAINT  FK_Genl_tbEvento_tbUsuarios_user_Id	    	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbEvento_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
	CONSTRAINT  FK_Genl_tbEvento_tbEstadoEvento_EstEven_Id	FOREIGN KEY(EstEven_Id) REFERENCES Genl.tbEstadoEvento(EstEven_Id), 
	CONSTRAINT  FK_Genl_tbEvento_tbUbicacion_ubc_Id			FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id),
)

/*Sección #46*/
CREATE TABLE [Genl].tbPosiblePor(
    [user_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [even_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    CONSTRAINT  PK_Genl_tbPosiblePor_user_Id_even_Id		PRIMARY KEY(user_Id,even_Id),
    CONSTRAINT  FK_Genl_tbPosiblePor_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
	CONSTRAINT  FK_Genl_tbPosiblePor_tbEvento_even_Id		FOREIGN KEY(even_Id) REFERENCES Genl.tbEvento(even_Id)
)

/*Sección #45*/
CREATE TABLE [Genl].tbVentaRelampago(
	[ventR_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
    [ventR_Titulo]				NVARCHAR(300)		NOT NULL DEFAULT '',
    [ventR_Descripcion]			NVARCHAR(1000)		NOT NULL DEFAULT '',
	[ventR_Fecha]				DATETIME			NOT NULL,
	[ventR_Precio]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[ventR_Agotado]				BIT 				NOT NULL DEFAULT 0,
    [user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
	[ubc_Id]					UNIQUEIDENTIFIER	NOT NULL,
    CONSTRAINT  PK_Genl_tbVentaRelampago_ventR_Id					PRIMARY KEY(ventR_Id),
	CONSTRAINT  FK_Genl_tbVentaRelampago_tbUsuarios_user_Id	    	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbVentaRelampago_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id), 
	CONSTRAINT  FK_Genl_tbVentaRelampago_tbUbicacion_ubc_Id			FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id),
)


/*Sección #46*/
CREATE TABLE [Genl].tbCategoriaPorVenta(
    [subCat_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [ventR_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [principal]						BIT 				NOT NULL DEFAULT 0,
    CONSTRAINT  PK_Genl_tbCategoriaPorVenta_subCat_Id_ventR_Id			PRIMARY KEY(subCat_Id,ventR_Id),
    CONSTRAINT  FK_Genl_tbCategoriaPorVenta_tbVentaRelampago_ventR_Id	FOREIGN KEY(ventR_Id) REFERENCES Genl.tbVentaRelampago(ventR_Id),
	CONSTRAINT  FK_Genl_tbCategoriaPorVenta_tbSubCategoria_subCat_Id	FOREIGN KEY(subCat_Id) REFERENCES Genl.tbSubCategoria(subCat_Id)
)

/*Sección #47*/
CREATE TABLE [Genl].tbTiempo(
    [tiemp_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [tiemp_Descripcion]				NVARCHAR(300) 		NOT NULL,
    CONSTRAINT  PK_Genl_tbTiempo_tiemp_Id			PRIMARY KEY(tiemp_Id)
)

/*Sección #48*/
CREATE TABLE [Genl].tbEstadoAlquilerServicios(
    [estAlq_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [estAlq_Descripcion]			NVARCHAR(300) 		NOT NULL,
    CONSTRAINT  PK_Genl_tbEstadoAlquilerServicios_estAlq_Id			PRIMARY KEY(estAlq_Id)
)

/*Sección #49*/
CREATE TABLE [Genl].tbAlquilerServicios(
    [alq_Id]					UNIQUEIDENTIFIER 	NOT NULL,
	[alq_Titulo]				NVARCHAR(100) 		NOT NULL,
    [alq_Descripcion]			NVARCHAR(300) 		NOT NULL,
	[alq_Precio]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
	[tiemp_Id]					UNIQUEIDENTIFIER 	NOT NULL,
	[estAlq_Id]					UNIQUEIDENTIFIER 	NOT NULL,
    CONSTRAINT  PK_Genl_tbAlquilerServicios_alq_Id						PRIMARY KEY(alq_Id),
	CONSTRAINT  FK_Genl_tbAlquilerServicios_tbUsuarios_user_Id	    	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbAlquilerServicios_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) REFERENCES Genl.tbTransaccion(tran_Id),
	CONSTRAINT  FK_Genl_tbAlquilerServicios_tbTiempo_tiemp_Id			FOREIGN KEY(tiemp_Id) REFERENCES Genl.tbTiempo(tiemp_Id),
	CONSTRAINT  FK_Genl_tbAlquilerServicios_tbEstadoAlquilerServicios_estAlq_Id	FOREIGN KEY(estAlq_Id) REFERENCES Genl.tbEstadoAlquilerServicios(estAlq_Id),
)

/*Sección #50*/
CREATE TABLE [Genl].tbCategoriaPorAlquilar(
    [subCat_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [alq_Id]						UNIQUEIDENTIFIER 	NOT NULL,
    [principal]						BIT 				NOT NULL DEFAULT 0,
    CONSTRAINT  PK_Genl_tbCategoriaPorAlquilar_subCat_Id_alq_Id			PRIMARY KEY(subCat_Id,alq_Id),
    CONSTRAINT  FK_Genl_tbCategoriaPorAlquilar_tbAlquilerServicios_alq_Id			FOREIGN KEY(alq_Id) REFERENCES Genl.tbAlquilerServicios(alq_Id),
	CONSTRAINT  FK_Genl_tbCategoriaPorAlquilar_tbSubCategoria_subCat_Id	FOREIGN KEY(subCat_Id) REFERENCES Genl.tbSubCategoria(subCat_Id)
)


---------Pedidos---------
/*Sección #51*/
CREATE TABLE [Genl].tbPedido(
	[ped_Id]					UNIQUEIDENTIFIER 	NOT NULL DEFAULT NEWID(),
	[ped_NombreCliente]			NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[ped_FechaCreacio]			DATETIME			NOT NULL DEFAULT GETDATE(),
	[ped_Fecha]					DATETIME			NOT NULL DEFAULT GETDATE(),
	[ped_SubTotal]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[ped_Descuento]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[ped_Impuesto]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[ped_PorcentajeImpuestos]	DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[ped_TotalPagar]			DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[ped_RTN]					NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
	[user_IdCliente]			UNIQUEIDENTIFIER	NULL,
	CONSTRAINT  PK_Genl_tbPedido_ped_Id						PRIMARY KEY(ped_Id),
	CONSTRAINT  FK_Genl_tbPedido_tbUsuarios_user_Id	    	FOREIGN KEY(user_Id) 		REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbPedido_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) 		REFERENCES Genl.tbTransaccion(tran_Id),
	CONSTRAINT  FK_Genl_tbPedido_tbUsuarios_user_IdCliente	FOREIGN KEY(user_IdCliente) REFERENCES Genl.tbUsuarios(user_Id),
)

/*Sección #52*/
CREATE TABLE [Genl].tbPedidoDetalle(
	[pedDet_Id]						UNIQUEIDENTIFIER 	NOT NULL DEFAULT NEWID(),
	[ped_Id]                   		UNIQUEIDENTIFIER	NOT NULL,
	[pedDet_Codigo]					NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[pedDet_Cantidad]				INT					NOT NULL DEFAULT 1,
	[pedDet_Descripcion]			NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[pedDet_PrecioUnitario]			DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[pedDet_Descuento]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[pedDet_Impuesto]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[pedDet_PorcentajeImpuestos]	DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[pedDet_TotalPagar]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[tipCatg_Id]					UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbPedidoDetalle_pedDet_Id					PRIMARY KEY(pedDet_Id),
	CONSTRAINT  FK_Genl_tbPedidoDetalle_tbPedido_ped_Id	    		FOREIGN KEY(ped_Id) REFERENCES Genl.tbPedido(ped_Id),
    CONSTRAINT  FK_Genl_tbPedidoDetalle_tbTipoCatalogo_tipCatg_Id	FOREIGN KEY(tipCatg_Id) REFERENCES Genl.tbTipoCatalogo(tipCatg_Id),
)

/*Sección #53*/
CREATE TABLE [Genl].tbProductoPorPedido(
	[pedDet_Id]						UNIQUEIDENTIFIER,
	[prod_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbProductoPorPedido_pedDet_Id				PRIMARY KEY(pedDet_Id),
	CONSTRAINT  FK_Genl_tbPedidoDetalle_tbPedidoDetalle_pedDet_Id	FOREIGN KEY(pedDet_Id) 	REFERENCES Genl.tbPedidoDetalle(pedDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbPedidoDetalle_tbProducto_prod_Id	    	FOREIGN KEY(prod_Id) 	REFERENCES Genl.tbProducto(prod_Id),
)

/*Sección #54*/
CREATE TABLE [Genl].tbServicioPorPedido(
	[pedDet_Id]						UNIQUEIDENTIFIER,
	[serv_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbServicioPorPedido_pedDet_Id					PRIMARY KEY(pedDet_Id),
	CONSTRAINT  FK_Genl_tbServicioPorPedido_tbPedidoDetalle_pedDet_Id	FOREIGN KEY(pedDet_Id) 	REFERENCES Genl.tbPedidoDetalle(pedDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbServicioPorPedido_tbServicio_serv_Id	    	FOREIGN KEY(serv_Id) 	REFERENCES Genl.tbServicio(serv_Id),
)
GO
--------------FACTURA---------------


/*Sección #55*/
CREATE TABLE [Genl].tbTipoPago(
	[tipPag_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipPag_Descripcion]			NVARCHAR(200)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoPago_tipPag_Id	PRIMARY KEY(tipPag_Id)
)
GO
INSERT INTO [Genl].[tbTipoPago] VALUES ('FEE6AE63-1C1E-43FD-AA4B-2AF2B0F081EB','Efectivo')
INSERT INTO [Genl].[tbTipoPago] VALUES ('6FF34116-62F0-45D8-B550-593C145BA037','Tarjeta')
INSERT INTO [Genl].[tbTipoPago] VALUES ('58CEC735-1E7A-4AA9-BCD6-4E1459CFA665','Transferencia')
GO

/*Sección #56*/
CREATE TABLE [Genl].tbFactura(
	[fac_Id]					UNIQUEIDENTIFIER 	DEFAULT NEWID(),
	[fac_NombreCliente]			NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[fac_FacturaCAI]			NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[fac_FechaCreacio]			DATETIME			NOT NULL DEFAULT GETDATE(),
	[fac_Fecha]					DATETIME			NOT NULL DEFAULT GETDATE(),
	[fac_SubTotal]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[fac_Descuento]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[fac_Impuesto]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[fac_PorcentajeImpuestos]	DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[fac_TotalPagar]			DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[fac_RTN]					NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[user_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[tran_Id]                   UNIQUEIDENTIFIER	NOT NULL,
	[user_IdCliente]			UNIQUEIDENTIFIER	NULL,
	[tipPag_Id]					UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbFactura_fac_Id					PRIMARY KEY(fac_Id),
	CONSTRAINT  FK_Genl_tbFactura_tbUsuarios_user_Id	    FOREIGN KEY(user_Id) 		REFERENCES Genl.tbUsuarios(user_Id),
    CONSTRAINT  FK_Genl_tbFactura_tbTransaccion_tran_Id		FOREIGN KEY(tran_Id) 		REFERENCES Genl.tbTransaccion(tran_Id),
	CONSTRAINT  FK_Genl_tbFactura_tbUsuarios_user_IdCliente	FOREIGN KEY(user_IdCliente) REFERENCES Genl.tbUsuarios(user_Id),
	CONSTRAINT  FK_Genl_tbFactura_tbTipoPago_tipPag_Id		FOREIGN KEY(tipPag_Id) 		REFERENCES Genl.tbTipoPago(tipPag_Id),
)

/*Sección #57*/
CREATE TABLE [Genl].tbFacturaDetalle(
	[facDet_Id]						UNIQUEIDENTIFIER 	NOT NULL,
	[fac_Id]                   		UNIQUEIDENTIFIER	NOT NULL,
	[tipCatg_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[facDet_Codigo]					NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[facDet_Cantidad]				INT					NOT NULL DEFAULT 1,
	[facDet_Descripcion]			NVARCHAR(350) 		NOT NULL DEFAULT (''),
	[facDet_PrecioUnitario]			DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[facDet_Descuento]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[facDet_Impuesto]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[facDet_PorcentajeImpuestos]	DECIMAL(18,2)		NOT NULL DEFAULT 0,
	[facDet_TotalPagar]				DECIMAL(18,2)		NOT NULL DEFAULT 0,
	CONSTRAINT  PK_Genl_tbFacturaDetalle_facDet_Id					PRIMARY KEY(facDet_Id),
	CONSTRAINT  FK_Genl_tbFacturaDetalle_tbFactura_fac_Id	    	FOREIGN KEY(fac_Id) REFERENCES Genl.tbFactura(fac_Id),
    CONSTRAINT  FK_Genl_tbFacturaDetalle_tbTipoCatalogo_tipCatg_Id	FOREIGN KEY(tipCatg_Id) REFERENCES Genl.tbTipoCatalogo(tipCatg_Id),
)

/*Sección #58*/
CREATE TABLE [Genl].tbProductoPorFactura(
	[facDet_Id]						UNIQUEIDENTIFIER,
	[prod_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbProductoPorFactura_facDet_Id					PRIMARY KEY(facDet_Id),
	CONSTRAINT  FK_Genl_tbProductoPorFactura_tbFacturaDetalle_facDet_Id	FOREIGN KEY(facDet_Id) 	REFERENCES Genl.tbFacturaDetalle(facDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbProductoPorFactura_tbProducto_prod_Id	    	FOREIGN KEY(prod_Id) 	REFERENCES Genl.tbProducto(prod_Id),
)

/*Sección #59*/
CREATE TABLE [Genl].tbServicioPorFactura(
	[facDet_Id]						UNIQUEIDENTIFIER,
	[serv_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbServicioPorFactura_facDet_Id					PRIMARY KEY(facDet_Id),
	CONSTRAINT  FK_Genl_tbServicioPorFactura_tbFacturaDetalle_facDet_Id	FOREIGN KEY(facDet_Id) 	REFERENCES Genl.tbFacturaDetalle(facDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbServicioPorFactura_tbServicio_serv_Id	    	FOREIGN KEY(serv_Id) 	REFERENCES Genl.tbServicio(serv_Id),
)

/*Sección #60*/
CREATE TABLE [Genl].tbDesperdicioPorFactura(
	[facDet_Id]						UNIQUEIDENTIFIER,
	[desp_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbDesperdicioPorFactura_facDet_Id					PRIMARY KEY(facDet_Id),
	CONSTRAINT  FK_Genl_tbDesperdicioPorFactura_tbFacturaDetalle_facDet_Id	FOREIGN KEY(facDet_Id) 	REFERENCES Genl.tbFacturaDetalle(facDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbDesperdicioPorFactura_tbDesperdicio_desp_Id	    FOREIGN KEY(desp_Id) 	REFERENCES Genl.tbDesperdicio(desp_Id),
)

/*Sección #61*/
CREATE TABLE [Genl].tbHabilidadPorFactura(
	[facDet_Id]						UNIQUEIDENTIFIER,
	[hab_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbHabilidadPorFactura_facDet_Id						PRIMARY KEY(facDet_Id),
	CONSTRAINT  FK_Genl_tbHabilidadPorFactura_tbFacturaDetalle_facDet_Id	FOREIGN KEY(facDet_Id) 	REFERENCES Genl.tbFacturaDetalle(facDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbHabilidadPorFactura_tbHabilidad_hab_Id	    	FOREIGN KEY(hab_Id) 	REFERENCES Genl.tbHabilidad(hab_Id),
)

/*Sección #62*/
CREATE TABLE [Genl].tbAlquilerServiciosPorFactura(
	[facDet_Id]						UNIQUEIDENTIFIER,
	[alq_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbAlquilerServiciosPorFactura_facDet_Id						PRIMARY KEY(facDet_Id),
	CONSTRAINT  FK_Genl_tbAlquilerServiciosPorFactura_tbFacturaDetalle_facDet_Id	FOREIGN KEY(facDet_Id) 	REFERENCES Genl.tbFacturaDetalle(facDet_Id) ON DELETE CASCADE,
	CONSTRAINT  FK_Genl_tbAlquilerServiciosPorFactura_tbAlquilerServicios_alq_Id	FOREIGN KEY(alq_Id) 	REFERENCES Genl.tbAlquilerServicios(alq_Id),
)

-----------Vacante---------

/*Sección #33*/
CREATE TABLE [Genl].tbAriaPuesto(
	[ariaP_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[ariaP_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbAriaPuesto_ariaP_Id	PRIMARY KEY(ariaP_Id)
)  
GO

/*Sección #34*/
CREATE TABLE [Genl].tbPuesto(
	[puest_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[puest_Descripcion]				NVARCHAR(300)		NOT NULL,
	[ariaP_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbPuesto_puest_Id	PRIMARY KEY(puest_Id),
	CONSTRAINT  FK_Genl_tbPuesto_tbAriaPuesto_ariaP_Id	FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
)  
GO

/*Sección #35*/
CREATE TABLE [Genl].tbTipoContrato(
	[tipC_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[tipC_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoContrato_tipC_Id	PRIMARY KEY(tipC_Id)
)  
GO

/*Sección #36*/
CREATE TABLE [Genl].tbGenero(
	[gene_Id]				UNIQUEIDENTIFIER DEFAULT NEWID(),
	[gene_Descripcion]		NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbGenero_gene_Id	PRIMARY KEY(gene_Id),
)  
GO

/*Sección #37*/
CREATE TABLE [Genl].tbVacante(
	[vac_Id]					UNIQUEIDENTIFIER DEFAULT NEWID(),
	[vac_DescripcionOferta]		NVARCHAR(2000)	NOT NULL,
	[user_Id]					UNIQUEIDENTIFIER	NOT NULL, 
	[ariaP_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[puest_Id]					UNIQUEIDENTIFIER	NOT NULL,	
	[tipC_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[gene_Id]					UNIQUEIDENTIFIER	NOT NULL,
	[vac_Edad]					INT					NOT NULL,
	[vac_SalarioMax]			DECIMAL(18,2)		NOT NULL,
	[vac_SalarioMinio]			DECIMAL(18,2)		NULL,
	[vac_Vahiculo]				BIT					NOT NULL DEFAULT 0,
	CONSTRAINT  PK_Genl_tbVacante_catEd_Id	PRIMARY KEY(vac_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbUsuarios_user_Id		FOREIGN KEY(user_Id)	REFERENCES Genl.tbUsuarios(user_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbAriaPuesto_ariaP_Id		FOREIGN KEY(ariaP_Id)	REFERENCES Genl.tbAriaPuesto(ariaP_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbPuesto_puest_Id			FOREIGN KEY(puest_Id)	REFERENCES Genl.tbPuesto(puest_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbTipoContrato_tipC_Id	FOREIGN KEY(tipC_Id)	REFERENCES Genl.tbTipoContrato(tipC_Id),
	CONSTRAINT  FK_Genl_tbVacante_tbGenero_gene_Id			FOREIGN KEY(gene_Id)	REFERENCES Genl.tbGenero(gene_Id),
)  
GO


/*Sección #38*/
CREATE TABLE [Genl].tbOtrosConocimientos(
	[otrCo_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[otrCo_Descripcion]				NVARCHAR(300)		NOT NULL,
	[vac_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbOtrosConocimientos_otrCo_Id			PRIMARY KEY(otrCo_Id),
	CONSTRAINT  FK_Genl_tbOtrosConocimientos_tbVacante_vac_Id	FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #39*/
CREATE TABLE [Genl].tbCargo(
	[carg_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[carg_Descripcion]				NVARCHAR(300)		NOT NULL,
	[vac_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbCargo_carg_Id				PRIMARY KEY(carg_Id),
	CONSTRAINT  FK_Genl_tbCargo_tbVacante_vac_Id	FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #40*/
CREATE TABLE [Genl].tbExperiencia(
	[exp_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[ariaP_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[exp_Opcional]					BIT					NOT NULL DEFAULT 0,
	[vac_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbExperiencia_exp_Id				PRIMARY KEY(exp_Id),
	CONSTRAINT  FK_Genl_tbExperiencia_tbAriaPuesto_ariaP_Id	FOREIGN KEY(ariaP_Id)	REFERENCES Genl.tbAriaPuesto(ariaP_Id),
	CONSTRAINT  FK_Genl_tbExperiencia_tbVacante_vac_Id		FOREIGN KEY(vac_Id)		REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #41*/
CREATE TABLE [Genl].tbNivelEducativo(
	[nivEd_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[nivEd_Descripcion]				NVARCHAR(300)		NOT NULL,
	CONSTRAINT  PK_Genl_tbNivelEducativo_nivEd_Id	PRIMARY KEY(nivEd_Id)
)  
GO


/*Sección #42*/
CREATE TABLE [Genl].tbTitulo(
	[titu_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[titu_Descripcion]				NVARCHAR(300)		NOT NULL,
	[ariaP_Id]						UNIQUEIDENTIFIER	NULL, 
	[nivEd_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbTitulo_titu_Id					PRIMARY KEY(titu_Id),
	CONSTRAINT  FK_Genl_tbTitulo_tbAriaPuesto_nesCa_Id		FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
	CONSTRAINT  FK_Genl_tbTitulo_tbNivelEducativo_nivEd_Id	FOREIGN KEY(nivEd_Id) REFERENCES Genl.tbNivelEducativo(nivEd_Id),
)  
GO

/*Sección #43*/
CREATE TABLE [Genl].tbProceso(
	[proc_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[proc_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbProceso_proc	PRIMARY KEY(proc_Id),
)  
GO


/*Sección #44*/
CREATE TABLE [Genl].tbTituloProc(
	[tiProc_Id]						UNIQUEIDENTIFIER DEFAULT NEWID(),
	[titu_Id]						UNIQUEIDENTIFIER	NOT NULL,
	[proc_Id]						UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbTituloProc_tiProc_Id	PRIMARY KEY(tiProc_Id),
	CONSTRAINT  FK_Genl_tbTituloProc_tbTitulo_titu_Id	FOREIGN KEY(titu_Id) REFERENCES Genl.tbTitulo(titu_Id),
	CONSTRAINT  FK_Genl_tbTituloProc_tbProceso_proc_Id	FOREIGN KEY(proc_Id) REFERENCES Genl.tbProceso(proc_Id),
)  
GO

/*Sección #45*/
CREATE TABLE [Genl].tbEducacion(
	[ed_Id]				UNIQUEIDENTIFIER DEFAULT NEWID(),
	[ed_Requerido]		BIT					NOT NULL DEFAULT 0,
	[titu_Id]			UNIQUEIDENTIFIER	NOT NULL, 
	[vac_Id]			UNIQUEIDENTIFIER	NOT NULL,
	CONSTRAINT  PK_Genl_tbEducacion_catEd_Id			PRIMARY KEY(Ed_Id),
	CONSTRAINT  FK_Genl_tbEducacion_tbTitulo_titu_Id	FOREIGN KEY(titu_Id)	REFERENCES Genl.tbTitulo(titu_Id),
	CONSTRAINT  FK_Genl_tbEducacion_tbVacante_vac_Id	FOREIGN KEY(vac_Id)		REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #46*/
CREATE TABLE [Genl].tbIdioma(
	[idio_Id]								UNIQUEIDENTIFIER DEFAULT NEWID(),
	[idio_Descripcion]						NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbIdioma_idio_Id	PRIMARY KEY(idio_Id),
)  
GO

/*Sección #47*/
CREATE TABLE [Genl].tbIdiomaItem(
	[idItm_Id]			UNIQUEIDENTIFIER DEFAULT NEWID(),
	[idio_Id]			UNIQUEIDENTIFIER	NOT NULL,
	[vac_Id]			UNIQUEIDENTIFIER NOT NULL,
	CONSTRAINT  PK_Genl_tbIdiomaItem_idItm_Id			PRIMARY KEY(idItm_Id),
	CONSTRAINT  FK_Genl_tbIdiomaItem_tbIdioma_idio_Id	FOREIGN KEY(idio_Id) REFERENCES Genl.tbIdioma(idio_Id),
	CONSTRAINT  FK_Genl_tbIdiomaItem_tbVacante_vac_Id	FOREIGN KEY(vac_Id)  REFERENCES Genl.tbVacante(vac_Id)
)  
GO

/*Sección #48*/
CREATE TABLE [Genl].tbLogroEventoCategoria(
	[logCa_Id]			UNIQUEIDENTIFIER DEFAULT NEWID(),
	[logCa_Descripcion]	NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbLogroEventoCategoria_logCa_Id	PRIMARY KEY(logCa_Id),
)  
GO

/*Sección #49*/
CREATE TABLE [Genl].tbConfiguracion(
	[conf_Id]			UNIQUEIDENTIFIER DEFAULT NEWID(),
	[conf_Nombre]		NVARCHAR(500)	NOT NULL,
	[conf_Valor]		NVARCHAR(500)	NOT NULL,
	[conf_Descripcion]	NVARCHAR(500)	NOT NULL
	CONSTRAINT  PK_Genl_tbConfiguracion_conf_Id	PRIMARY KEY(conf_Id),
	CONSTRAINT [UQ_Genl_tbConfiguracion_conf_Nombre] UNIQUE(conf_Nombre)
)  
GO

INSERT INTO [Genl].[tbConfiguracion] VALUES ('E4980407-ACED-4CC4-B0F0-095EC12C95EE','smtpServer', 'smtp.gmail.com', 'El servidor SMTP para correo')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('FC77BD75-F85A-4412-9FE8-49855C94D76B','smtpPort', '587', ' Puerto SMTP seguro (TLS)')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('D91690D9-E907-4F93-8833-6DE88A23E202','senderEmail', 'appcircular2023@gmail.com', 'Correo para Validacion')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('33F9F5B0-F021-495A-9DEB-7B548B14E7FA','senderPassword', 'lsbuahlrtdgpvdzv', 'Contraseña generada')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('FE21C6C6-340C-4F74-9F8F-CEC4E404DF4D','ApiRutaToken', 'https://localhost:44306/Usuario/ValidacionToken?toke=', 'La ruta de api para correos')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('75EB05FB-D827-41E3-8EED-40A0890769F8','IdTipoUsuarioMicroempresa', '1', 'Validar que el tipo de usuario sea el correcto')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('CA13AAFD-9DE3-47E1-8907-5EE8570BB94A','IdTipoUsuarioConHablidades', '2', 'Validar usuario Con habilidades')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('7F9A8E65-4841-48FA-8647-EE9E444770A9','IdTipoUsuarioONG', '3', 'CalidarONG')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('0A979795-0E1D-476D-90DD-64BEE7E05D33','IdTipoUsuarioEmpresa', '4', 'Validar el usaurio Empresa')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('21746053-FCF8-4A11-BD66-859ADBC9DC21','IdTipoUsuarioParticular', 'ED9F065E-9633-46C3-9E71-A272230A1C42', 'Validar el usuario Particular')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('7B5DE3B8-0AEF-4AB0-963A-ADE19D6AFAAD','IdTipoUsuarioConLocal', '6', 'Son los usarios que tiene un local ')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('DFDA9864-C809-4885-9E12-8DEC90218E26','SubRutaLogo', 'Img\Logos', 'Es la ruta de la carperta donde se guradaran los logos se le concatenara ala raiz del proyecto')
INSERT INTO [Genl].[tbConfiguracion] VALUES ('67468F30-E755-461C-8759-9F6168296A63','TamañoLogo', '1', 'Es para validar el tamaño del logo tiene que sere en para pulpilicarlo 1024 * 1024')
GO

/*Sección #50*/
CREATE TYPE Genl.tbHorarioTableType AS TABLE
(
	hor_DiaNumero INT,
    hor_HoraInicio TINYINT,
    hor_MinutoInicio TINYINT,
    hor_HoraFin TINYINT,
    hor_MinutoFin TINYINT
);

GO

/*Sección #51*/
CREATE TYPE Genl.tbCategoriaItemType AS TABLE(
	catg_Id UNIQUEIDENTIFIER
);
GO

/*Sección #38*/
CREATE TYPE Genl.tbUsuarioTelefonoType AS TABLE(
	tipTel_Id UNIQUEIDENTIFIER,
	tipTel_Descripcion NVARCHAR(100)
);
GO
/*Sección #38*/
CREATE TYPE Genl.tbCatalogoImagen AS TABLE(
	catg_Id UNIQUEIDENTIFIER,
	catImg_Ruta NVARCHAR(2000)
);
GO

CREATE PROCEDURE [Genl].[sp_CrearUsuario]
	@tipUs_Id UNIQUEIDENTIFIER,
	@Nombre NVARCHAR(300),
	@RutaLogo NVARCHAR(2000),
	@RutaPaginaWed NVARCHAR(2000),
	@Descripcion NVARCHAR(500),
	--@FechaFundacion DATE,
	@NombreUsuario NVARCHAR(150),
	@Password NVARCHAR(1000),
	@PasswordSal NVARCHAR(1000),
	@tipIde_Id UNIQUEIDENTIFIER,
	@Identificacion NVARCHAR(100),
	--@TelefonoPricipal NVARCHAR(50),
	--@TelefonoSecundario NVARCHAR(50),
	@Facebook NVARCHAR(300),
	@Intagram NVARCHAR(300),
	@WhatsApp BIT,
	@Envio BIT,
	@Correo NVARCHAR(100),
	@SubdicionLugar UNIQUEIDENTIFIER,
	@Latitud NVARCHAR(200),
	@Longitub NVARCHAR(200),
	--Los Datos De tablas
	@tbHorarios tbHorarioTableType READONLY,
	@tbCategoriaItem tbCategoriaItemType READONLY,
	@tbUsuarioTelefono tbUsuarioTelefonoType READONLY,
	    -- Parámetros de salida
    @Success BIT OUTPUT,
    @Message NVARCHAR(1000) OUTPUT,
	@IdUsuario UNIQUEIDENTIFIER OUTPUT
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
	DECLARE @catg_Id UNIQUEIDENTIFIER;
	DECLARE @ErrorCategoria BIT = 0;
	--Variables del Cursor De Telefono
	DECLARE @tipTel_Id UNIQUEIDENTIFIER,
			@tipTel_Descripcion NVARCHAR(100);

	DECLARE @usInf_Id UNIQUEIDENTIFIER;
	DECLARE @ubc_Id UNIQUEIDENTIFIER;
	DECLARE @user_Id UNIQUEIDENTIFIER;

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
			SET @usInf_Id = NEWID();
			SET @ubc_Id = NEWID();
			SET @user_Id = NEWID();

			SET @tipIde_Id = CASE
								WHEN @Identificacion = '' OR @Identificacion = 'N/A' THEN 'F0932129-5A5C-4B93-AE15-5922C3875E07'
								ELSE @tipIde_Id
							END
			
			INSERT INTO [Genl].[tbInfoUnicaUsuario] ([usInf_Id],[usInf_Nombre],[usInf_RutaPaginaWed],[tipUs_Id],[usInf_RutaLogo]) VALUES (@usInf_Id,@Nombre,NULLIF(@RutaPaginaWed, 'N/A'),@tipUs_Id,NULLIF(@RutaLogo, 'N/A'));
			

			INSERT INTO  [Genl].[tbUbicacion] VALUES(@ubc_Id,@Latitud,@Longitub,@SubdicionLugar);

			INSERT INTO [Genl].[tbUsuarios] 
			([user_Id],[usInf_Id],[user_Descripcion],[user_Correo],[user_Facebook],[user_WhatsApp],[user_Password],[user_PasswordSal],[user_NombreUsuario],[ubc_Id],[user_Intagram],[user_Envio],[tipIde_Id],[user_Identificacion],[user_FechaCreacion],[user_UsuarioPrincipal]) 
				VALUES (@user_Id,@usInf_Id, @Descripcion,@Correo,@Facebook,@WhatsApp,@Password,@PasswordSal,@NombreUsuario,@ubc_Id,@Intagram,@Envio,@tipIde_Id,@Identificacion,GETDATE(),1);
		
		
		---////Inicio Cursor
		OPEN curHorarios;
        FETCH NEXT FROM curHorarios INTO @hor_DiaNumero, @hor_HoraInicio, @hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            BEGIN TRY
                INSERT INTO [Genl].[tbHorario] VALUES (NEWID(),@hor_DiaNumero, @user_Id, @hor_HoraInicio,@hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin);

                FETCH NEXT FROM curHorarios INTO @hor_DiaNumero, @hor_HoraInicio, @hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin;
            END TRY
            BEGIN CATCH
				SET @Success = 0;
					SET @Message = FORMATMESSAGE(
					'Error Ocurrió Al Guardar El Horario: hor_DiaNumero => %d, user_Id => %s, hor_HoraInicio => %d, hor_MinutoInicio => %d, hor_HoraFin => %d, hor_MinutoFin => %d. Error SQL: %s (Línea: %d)',
					@hor_DiaNumero, CAST(@user_Id AS NVARCHAR(50)), @hor_HoraInicio, @hor_MinutoInicio, @hor_HoraFin, @hor_MinutoFin, ERROR_MESSAGE(), ERROR_LINE()
				);


				SET @IdUsuario = '';

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
                INSERT INTO [Genl].[tbCategoriaItem] VALUES (NEWID(),@catg_Id,@user_Id);

                FETCH NEXT FROM curCategoriaItem INTO @catg_Id;
            END TRY
            BEGIN CATCH
				SET @Success = 0;
				SET @Message = 'Error Ocurrio Al Guardar La Categoria: user_Id => '+CONVERT(nvarchar(10),@user_Id)+', aria_Id => '+CONVERT(nvarchar(10),@catg_Id)+'. Error SQL: '+ERROR_MESSAGE() + ' (Línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
				SET @IdUsuario = '';

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
                INSERT INTO Genl.tbUsuarioTelefono VALUES (NEWID(),@tipTel_Id,@user_Id,@tipTel_Descripcion);

                FETCH NEXT FROM curTelefono INTO @tipTel_Id,@tipTel_Descripcion;
            END TRY
            BEGIN CATCH
				SET @Success = 0;
				SET @Message = 'Error Ocurrio Al Guardar El Telefono: user_Id => '+CONVERT(nvarchar(10),@user_Id)+', tipTel_Id => '+CONVERT(nvarchar(10),@tipTel_Id)+', tipTel_Descripcion=> '+CONVERT(nvarchar(100),@tipTel_Descripcion)+'. Error SQL: '+ERROR_MESSAGE() + ' (Línea: ' + CAST(ERROR_LINE() AS NVARCHAR(10)) + ')';
				SET @IdUsuario = '';

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
		SET @IdUsuario = '';
    END CATCH;
END;
GO

CREATE PROCEDURE [Genl].[sp_Login]
	@Correo NVARCHAR(100),
	--Paramatros de salida
	@Success BIT OUTPUT,
    @Message NVARCHAR(1000) OUTPUT,
	@PasswordSal NVARCHAR(1000) OUTPUT,
	@Password NVARCHAR(1000) OUTPUT,
	@IdUsuario UNIQUEIDENTIFIER OUTPUT

AS
BEGIN
	BEGIN TRY
		SET @Password = '';
		SET @PasswordSal = '';
		SET @Correo = UPPER(@Correo);
		DECLARE @TotalInfUsuariosUnico int
		DECLARE @IgualInfo BIT

		DECLARE @Tabla TABLE(
			infUsu_Id UNIQUEIDENTIFIER
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
			SET @Message = 'Parece que existen dos usuarios unicos con el mismo correo';
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
				user_Id UNIQUEIDENTIFIER,
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

GO
CREATE LOGIN ApiCircularNet
WITH PASSWORD = 'aws20056·654&&2ss',
    CHECK_EXPIRATION = OFF,
    CHECK_POLICY = OFF;
GO

USE AppECO
CREATE USER ApiCircularNetBD
FOR LOGIN ApiCircularNet;

GO
-- Permitir que el usuario lea datos
EXEC sp_addrolemember 'db_datareader', 'ApiCircularNetBD';
GO
-- Permitir que el usuario escriba datos
EXEC sp_addrolemember 'db_datawriter', 'ApiCircularNetBD';
GO
-- Asignar más roles si es necesario
EXEC sp_addrolemember 'db_ddladmin', 'ApiCircularNetBD';

GRANT EXECUTE ON SCHEMA::Genl TO ApiCircularNetBD;

/*
GO
GRANT EXECUTE ON TYPE::Genl.tbHorarioTableType TO ApiCircularNetBD;
GO
GRANT EXECUTE ON TYPE::Genl.tbCategoriaItemType TO ApiCircularNetBD;
GO
GRANT EXECUTE ON TYPE::Genl.tbUsuarioTelefonoType TO ApiCircularNetBD;
*/
