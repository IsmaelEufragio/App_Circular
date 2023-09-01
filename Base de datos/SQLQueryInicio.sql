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

/*Sección #3*/
CREATE TABLE [Genl].tbInfoUnicaUsuario(
	[ipInf_Id]					INT IDENTITY(1,1),
	[tInf_Nombre]				NVARCHAR(300)	NOT NULL,
	[tInf_RutaLogo]				NVARCHAR(2000),
	[tInf_RutaPaginaWed]		NVARCHAR(2000),
	[tInf_IgualSubInfo]			BIT NOT NULL DEFAULT 1,
	[tInf_Verificado]			BIT			DEFAULT 0,
	[tipUs_Id]					INT NOT NULL,
	CONSTRAINT  PK_Genl_tbInfoUnicaUsuario_tipInfUs_Id	PRIMARY KEY(ipInf_Id),
	CONSTRAINT  FK_Genl_tbInfoUnicaUsuario_tbTipoUsuario_tipUs_Id	FOREIGN KEY(tipUs_Id) REFERENCES Genl.tbTipoUsuario(tipUs_Id)
)  
GO

/*Sección #4*/
CREATE TABLE [Genl].tbPais(
	[pais_Id]						INT IDENTITY(1,1),
	[pais_Nombre]					NVARCHAR(500)	NOT NULL,
	[pais_Abrebiatura]				NVARCHAR(10),
	CONSTRAINT  PK_Genl_tbPais_pais_Id	PRIMARY KEY(pais_Id)
)  
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

/*Sección #6*/
CREATE TABLE [Genl].tbMunicipio(
	[muni_Id]						INT IDENTITY(1,1),
	[muni_Nombre]					NVARCHAR(500)	NOT NULL,
	[dept_Id]						INT	NOT NULL,
	[muni_NuIdentidad]				INT NOT NULL,
	[muni_ValidaciosTelefono]		NVARCHAR(1000),
	[muni_ValidaciosTelefonoFijo]	NVARCHAR(1000),
	CONSTRAINT  PK_Genl_tbMunicipio_muni_Id			PRIMARY KEY(muni_Id),
	CONSTRAINT  FK_Genl_tbMunicipio_tbDepartamento_dept_Id	FOREIGN KEY(dept_Id) REFERENCES Genl.tbDepartamento(dept_Id)
)  
GO

/*Sección #7*/
CREATE TABLE [Genl].tbCategoriaLugar(
	[catLug_Id]						INT IDENTITY(1,1),
	[catLug_Nombre]					NVARCHAR(500)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaLugar_catLug_Id			PRIMARY KEY(catLug_Id)
)  
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

/*Sección #7*/
CREATE TABLE [Genl].tbCategoriaSubdivicion(
	[sub_Id]						INT IDENTITY(1,1),
	[sub_Nombre]					NVARCHAR(500)	NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaSubdivicion_sub_Id		PRIMARY KEY(sub_Id)
)  
GO

/*Sección #8*/
CREATE TABLE [Genl].tbSubdivicionLugar(
	[subLug_Id]						INT IDENTITY(1,1),
	[subLug_Nombre]	 				NVARCHAR(500)	NOT NULL,
	[sub_Id]						INT				NOT NULL,
	[lug_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbSubdivicionLugar_subLug_Id			PRIMARY KEY(subLug_Id),
	CONSTRAINT  FK_Genl_tbSubdivicionLugar_tbCategoriaSubdivicion_sub_Id	FOREIGN KEY(sub_Id) REFERENCES Genl.tbCategoriaSubdivicion(sub_Id),
	CONSTRAINT  FK_Genl_tbSubdivicionLugar_tbLugar_lug_Id	FOREIGN KEY(lug_Id) REFERENCES Genl.tbLugar(lug_Id),
)  
GO	

/*Sección #9*/
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
CREATE TABLE [Genl].tbUsuarios(
	[user_Id]						INT IDENTITY(1,1),
	[ipInf_Id]						INT				NOT NULL,
	[user_Descripcion]				NVARCHAR(500)	NOT NULL,
	[user_TelefonoPrincipal]		NVARCHAR(50)	NOT NULL,
	[user_TelefonoSecundario]		NVARCHAR(50),
	[ubc_Id]						INT				NOT NULL,
	[user_RTNPersona]				NVARCHAR(100),
	[user_RTNInstitucion]			NVARCHAR(100),
	[user_NombreUsuario]			NVARCHAR(150)	NOT NULL DEFAULT 'N/A',
	[user_Password]					NVARCHAR(1000),
	[user_PasswordSal]				NVARCHAR(1000),
	[user_FechaFundacion]			DATE,
	[user_Correo]					NVARCHAR(100)	NOT NULL,
	[user_Facebook]					NVARCHAR(100),
	[user_Intagram]					NVARCHAR(100),
	[user_WhatsApp]					BIT NOT NULL DEFAULT 0,
	[user_Envio]					BIT NOT NULL DEFAULT 0,

	CONSTRAINT  PK_Genl_tbUsuarios_User_Id			PRIMARY KEY(User_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbInfoUnicaUsuario_ipInf_Id	FOREIGN KEY(ipInf_Id) REFERENCES Genl.tbInfoUnicaUsuario(ipInf_Id),
	CONSTRAINT  FK_Genl_tbUsuarios_tbUbicacion_ubc_Id				FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id)
)  

GO

/*Sección #10     ===*/
CREATE TABLE [Genl].tbCategoria(
	[catg_Id]						INT IDENTITY(1,1),
	[catg_Nombre]					NVARCHAR(200)		NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoria_catg_Id			PRIMARY KEY(catg_Id)
)  
GO

/*Sección #11    ===*/
CREATE TABLE [Genl].tbCategoriaItem(
	[catgItem_Id]					INT IDENTITY(1,1),
	[catg_Id]						INT				NOT NULL,
	[user_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbCategoriaItem_catgItem_Id			PRIMARY KEY(catgItem_Id),
	CONSTRAINT  FK_Genl_tbCategoriaItem_tbCategoria_catg_Id	FOREIGN KEY(catg_Id) REFERENCES Genl.tbCategoria(catg_Id),
	CONSTRAINT  FK_Genl_tbCategoriaItem_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

/*Sección #13*/
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

/*Sección #14*/
CREATE TABLE [Genl].tbTipoPublicacion(
	[tiPub_Id]						INT IDENTITY(1,1),
	[tiPub_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoPublicacion_tiPub_Id	PRIMARY KEY(tiPub_Id)
)  
GO

/*Sección #15*/
CREATE TABLE [Genl].tbGuardar(
	[guard_Id]						INT IDENTITY(1,1),
	[user_Id]						INT	NOT NULL,
	[guard_RutaPublicacion]			INT	NOT NULL,
	[guard_Publicacion]				INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbGuardar_guard_Id				PRIMARY KEY(guard_Id),
	CONSTRAINT  FK_Genl_tbGuardar_tbUsuarios_user_Id	FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id)
)  
GO


/*Sección #16*/
CREATE TABLE [Genl].tbProdCategoria(
	[proCa_Id]						INT IDENTITY(1,1),
	[proCa_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbProdCategoria_proCa_Id	PRIMARY KEY(proCa_Id)
)  
GO

/*Sección #17*/
CREATE TABLE [Genl].tbProducto(
	[prod_Id]						INT IDENTITY(1,1),
	[prod_Nombre]					NVARCHAR(100)	NOT NULL,
	[prod_Descripcion]				NVARCHAR(300)	NOT NULL,
	[prod_Precio]					DECIMAL(18,2)	NOT NULL,
	[prod_Reporte]					BIT NOT NULL DEFAULT 0,
	[prod_JsonReaccion]			NVARCHAR(MAX),
	[prod_JsonReporte]				NVARCHAR(MAX),
	[prod_Imagen]					NVARCHAR(3000),
	[prod_Existencia]				BIT NOT NULL DEFAULT 0,
	[prod_Negociado]				BIT NOT NULL DEFAULT 0,
	[proCa_Id]						INT NOT NULL,
	[user_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbProducto_prod_Id	PRIMARY KEY(prod_Id),
	CONSTRAINT  FK_Genl_tbProducto_tbProdCategoria_proCa_Id		FOREIGN KEY(proCa_Id) REFERENCES Genl.tbProdCategoria(proCa_Id),
	CONSTRAINT  FK_Genl_tbProducto_tbUsuarios_user_Id			FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

/*Sección #18*/
CREATE TABLE [Genl].tbProductoImagen(
	[proIm_Id]						INT IDENTITY(1,1),
	[proIm_Ruta]					NVARCHAR(1000)	NOT NULL,
	[prod_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbContribuyente_proIm_Id	PRIMARY KEY(proIm_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbProducto_user_Id			FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
)  
GO

/*Sección #19*/
CREATE TABLE [Genl].tbOrigen(
	[orig_Id]						INT IDENTITY(1,1),
	[orig_Descripcion]				NVARCHAR(300)	NOT NULL,
	[orig_Imagen]					NVARCHAR(3000)	NOT NULL,
	[prod_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbOrigen_orig_Id	PRIMARY KEY(orig_Id),
	CONSTRAINT  FK_Genl_tbOrigen_tbProducto_prod_Id			FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
)  
GO


/*Sección #19*/
CREATE TABLE [Genl].tbContribuyente(
	[contr_Id]						INT IDENTITY(1,1),
	[contr_Descripcion]				NVARCHAR(1000)	NOT NULL,
	[prod_Id]						INT NOT NULL,
	[user_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbContribuyente_contr_Id	PRIMARY KEY(contr_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbProducto_prod_Id			FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
	CONSTRAINT  FK_Genl_tbContribuyente_tbUsuarios_user_Id			FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

/*Sección #20*/
CREATE TABLE [Genl].tbTipoServicio(
	[tipSe_Id]						INT IDENTITY(1,1),
	[tipSe_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoServicio_tipSe_Id	PRIMARY KEY(tipSe_Id)
)  
GO

/*Sección #21*/
CREATE TABLE [Genl].tbServicioCategoria(
	[serCa_Id]						INT IDENTITY(1,1),
	[serCa_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbServicioCategoria_serCa_Id	PRIMARY KEY(serCa_Id)
)  
GO

/*Sección #22*/
CREATE TABLE [Genl].tbOrigenServicio(
	[oriS_Id]						INT IDENTITY(1,1),
	[oriS_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbOrigenServicio_oriS_Id	PRIMARY KEY(oriS_Id)
)  
GO


/*Sección y servicio #23*/
CREATE TABLE [Genl].tbServicio(
	[serv_Id]						INT IDENTITY(1,1),
	[serv_Nombre]					NVARCHAR(200)	NOT NULL,
	[serv_Descripcion]				NVARCHAR(1000)	NOT NULL,
	[serv_Precio]					DECIMAL(18,2)	NOT NULL DEFAULT 0,
	[serv_Negociado]				BIT NOT NULL DEFAULT 0,
	[serv_JsonReaccion]			NVARCHAR(MAX),
	[serv_Reporte]					BIT NOT NULL DEFAULT 0,
	[serv_JsonReporte]				NVARCHAR(MAX),
	[serv_Imagen]					NVARCHAR(3000),
	[oriS_Id]						INT NOT NULL,
	[serCa_Id]						INT NOT NULL,
	[tipSe_Id]						INT NOT NULL,
	[user_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbServicio_serv_Id	PRIMARY KEY(serv_Id),
	CONSTRAINT  FK_Genl_tbServicio_tbOrigenServicio_oriS_Id		FOREIGN KEY(oriS_Id) REFERENCES Genl.tbOrigenServicio(oriS_Id),
	CONSTRAINT  FK_Genl_tbServicio_tbServicioCategoria_serCa_Id		FOREIGN KEY(serCa_Id) REFERENCES Genl.tbServicioCategoria(serCa_Id),
	CONSTRAINT  FK_Genl_tbServicio_tbTipoServicio_tipSe_Id		FOREIGN KEY(tipSe_Id) REFERENCES Genl.tbTipoServicio(tipSe_Id),
	CONSTRAINT  FK_Genl_tbServicio_tbUsuarios_user_Id			FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

/*Sección #24*/
CREATE TABLE [Genl].tbServicioImagen(
	[serIm_Id]				INT IDENTITY(1,1),
	[serIm_Ruta]			NVARCHAR(3000)	NOT NULL,
	[serv_Id]				INT NOT NULL,
	CONSTRAINT  PK_Genl_tbServicioImagen_serIm_Id	PRIMARY KEY(serIm_Id),
	CONSTRAINT  FK_Genl_tbServicioImagen_tbServicio_serv_Id		FOREIGN KEY(serv_Id) REFERENCES Genl.tbServicio(serv_Id),
)  
GO

/*Sección #24*/
CREATE TABLE [Genl].tbDesperdicioCatedoria(
	[desCa_Id]						INT IDENTITY(1,1),
	[desCa_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbDesperdicioCatedoria_desCa_Id	PRIMARY KEY(desCa_Id)
)  
GO


/*Sección #25*/
CREATE TABLE [Genl].tbOrigeDesperdicio(
	[oriDe_Id]						INT IDENTITY(1,1),
	[oriDe_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbOrigeDesperdicio_oriDe_Id	PRIMARY KEY(oriDe_Id)
)  
GO


/*Sección y servicio #26*/
CREATE TABLE [Genl].tbDesperdicio(
	[desp_Id]						INT IDENTITY(1,1),
	[desp_Nombre]					NVARCHAR(200)	NOT NULL,
	[desp_Descripcion]				NVARCHAR(1000)	NOT NULL,
	[desp_Precio]					DECIMAL(18,2) NOT NULL DEFAULT 0,
	[desp_Negociado]				BIT NOT NULL DEFAULT 0,
	[desp_Gratis]					BIT NOT NULL DEFAULT 0,
	[desp_JsonReaccion]			NVARCHAR(MAX),
	[desp_Reporte]					BIT NOT NULL DEFAULT 0,
	[desp_JsonReporte]				NVARCHAR(MAX),
	[desp_Imagen]					NVARCHAR(3000),
	[desCa_Id]						INT NOT NULL,
	[oriDe_Id]						INT NOT NULL,
	[prod_Id]						INT,
	[serv_Id]						INT,
	[user_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbDesperdicio_desp_Id	PRIMARY KEY(desp_Id),
	CONSTRAINT  FK_Genl_tbDesperdicio_tbOrigeDesperdicio_oriDe_Id		FOREIGN KEY(oriDe_Id) REFERENCES Genl.tbOrigeDesperdicio(oriDe_Id),
	CONSTRAINT  FK_Genl_tbDesperdicio_tbDesperdicioCatedoria_desCa_Id	FOREIGN KEY(desCa_Id) REFERENCES Genl.tbDesperdicioCatedoria(desCa_Id),
	CONSTRAINT  FK_Genl_tbDesperdicio_tbServicio_serv_Id			FOREIGN KEY(serv_Id) REFERENCES Genl.tbServicio(serv_Id),
	CONSTRAINT  FK_Genl_tbDesperdicio_tbProducto_prod_Id			FOREIGN KEY(prod_Id) REFERENCES Genl.tbProducto(prod_Id),
	CONSTRAINT  FK_Genl_tbDesperdicio_tbUsuarios_user_Id			FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO


/*Sección #27*/
CREATE TABLE [Genl].tbDesperdicioImagen(
	[despIm_Id]					INT IDENTITY(1,1),
	[despIm_Ruta]				NVARCHAR(300)	NOT NULL,
	[desp_Id]					INT NOT NULL,
	CONSTRAINT  PK_Genl_tbDesperdicioImagen_despIm_Id	PRIMARY KEY(despIm_Id),
	CONSTRAINT  FK_Genl_tbDesperdicioImagen_tbDesperdicio_desp_Id		FOREIGN KEY(desp_Id) REFERENCES Genl.tbDesperdicio(desp_Id),
)  
GO

/*Sección #27*/
CREATE TABLE [Genl].tbFormaAdquirir(
	[forAd_Id]						INT IDENTITY(1,1),
	[forAd_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbFormaAdquirir_forAd_Id	PRIMARY KEY(forAd_Id)
)  
GO

/*Sección #28*/
CREATE TABLE [Genl].tbNeceitaCatedoria(
	[nesCa_Id]						INT IDENTITY(1,1),
	[nesCa_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbNeceitaCatedoria_nesCa_Id	PRIMARY KEY(nesCa_Id)
)  
GO


/*Sección y servicio #29*/
CREATE TABLE [Genl].tbNecesita(
	[nece_Id]						INT IDENTITY(1,1),
	[nece_Nombre]					NVARCHAR(200)	NOT NULL,
	[nece_Descripcion]				NVARCHAR(1000)	NOT NULL,
	[nece_Reporte]					BIT NOT NULL DEFAULT 0,
	[nece_Estado]					BIT NOT NULL DEFAULT 0,
	[nece_JsonReporte]				NVARCHAR(MAX),
	[nece_Imagen]					NVARCHAR(3000),
	[nece_Cantidad]					INT,
	[nece_RandoInicial]				DECIMAL(18,2)	NOT NULL DEFAULT 0,
	[nece_RangoFinal]				DECIMAL(18,2)	NOT NULL DEFAULT 0,
	[nesCa_Id]						INT,
	[forAd_Id]						INT NOT NULL,
	[user_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbNecesita_desp_Id	PRIMARY KEY(nece_Id),
	CONSTRAINT  FK_Genl_tbNecesita_tbNeceitaCatedoria_nesCa_Id	FOREIGN KEY(nesCa_Id) REFERENCES Genl.tbNeceitaCatedoria(nesCa_Id),
	CONSTRAINT  FK_Genl_tbNecesita_tbFormaAdquirir_forAd_Id		FOREIGN KEY(forAd_Id) REFERENCES Genl.tbFormaAdquirir(forAd_Id),
	CONSTRAINT  FK_Genl_tbNecesita_tbUsuarios_user_Id			FOREIGN KEY(user_Id) REFERENCES Genl.tbUsuarios(user_Id),
)  
GO

--Vacante---------

/*Sección #30*/
CREATE TABLE [Genl].tbAriaPuesto(
	[ariaP_Id]						INT IDENTITY(1,1),
	[ariaP_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbAriaPuesto_ariaP_Id	PRIMARY KEY(ariaP_Id)
)  
GO

CREATE TABLE [Genl].tbPuesto(
	[puest_Id]						INT IDENTITY(1,1),
	[puest_Descripcion]				NVARCHAR(300)	NOT NULL,
	[ariaP_Id]						INT NOT NULL,
	CONSTRAINT  PK_Genl_tbPuesto_puest_Id	PRIMARY KEY(puest_Id),
	CONSTRAINT  FK_Genl_tbPuesto_tbAriaPuesto_ariaP_Id	FOREIGN KEY(ariaP_Id) REFERENCES Genl.tbAriaPuesto(ariaP_Id),
)  
GO

/*Sección #32*/
CREATE TABLE [Genl].tbTipoContrato(
	[tipC_Id]						INT IDENTITY(1,1),
	[tipC_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbTipoContrato_tipC_Id	PRIMARY KEY(tipC_Id)
)  
GO

/*Sección #33*/
CREATE TABLE [Genl].tbGenero(
	[gene_Id]				INT IDENTITY(1,1),
	[gene_Descripcion]		NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbGenero_gene_Id	PRIMARY KEY(gene_Id),
)  
GO

/*Sección #33*/
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


/*Sección #31*/
CREATE TABLE [Genl].tbOtrosConocimientos(
	[otrCo_Id]						INT IDENTITY(1,1),
	[otrCo_Descripcion]				NVARCHAR(300)	NOT NULL,
	[vac_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbOtrosConocimientos_otrCo_Id	PRIMARY KEY(otrCo_Id),
	CONSTRAINT  FK_Genl_tbOtrosConocimientos_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #31*/
CREATE TABLE [Genl].tbCargo(
	[carg_Id]						INT IDENTITY(1,1),
	[carg_Descripcion]				NVARCHAR(300)	NOT NULL,
	[vac_Id]						INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbCargo_carg_Id	PRIMARY KEY(carg_Id),
	CONSTRAINT  FK_Genl_tbCargo_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #31*/
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

/*Sección #34*/
CREATE TABLE [Genl].tbNivelEducativo(
	[nivEd_Id]						INT IDENTITY(1,1),
	[nivEd_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbNivelEducativo_nivEd_Id	PRIMARY KEY(nivEd_Id)
)  
GO


/*Sección #33*/
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

/*Sección #34*/
CREATE TABLE [Genl].tbProceso(
	[proc_Id]						INT IDENTITY(1,1),
	[proc_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbProceso_proc	PRIMARY KEY(proc_Id),
)  
GO


/*Sección #34*/
CREATE TABLE [Genl].tbTituloProc(
	[tiProc_Id]						INT IDENTITY(1,1),
	[titu_Id]						INT	NOT NULL,
	[proc_Id]						INT	NOT NULL,
	CONSTRAINT  PK_Genl_tbTituloProc_tiProc_Id	PRIMARY KEY(tiProc_Id),
	CONSTRAINT  FK_Genl_tbTituloProc_tbTitulo_titu_Id	FOREIGN KEY(titu_Id) REFERENCES Genl.tbTitulo(titu_Id),
	CONSTRAINT  FK_Genl_tbTituloProc_tbProceso_proc_Id	FOREIGN KEY(proc_Id) REFERENCES Genl.tbProceso(proc_Id),
)  
GO

/*Sección #33*/
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

/*Sección #34*/
CREATE TABLE [Genl].tbIdioma(
	[idio_Id]						INT IDENTITY(1,1),
	[idio_Descripcion]				NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbIdioma_idio_Id	PRIMARY KEY(idio_Id),
)  
GO

/*Sección #34*/
CREATE TABLE [Genl].tbIdiomaItem(
	[idItm_Id]			INT IDENTITY(1,1),
	[idio_Id]			INT	NOT NULL,
	[vac_Id]			INT NOT NULL,
	CONSTRAINT  PK_Genl_tbIdiomaItem_idItm_Id	PRIMARY KEY(idItm_Id),
	CONSTRAINT  FK_Genl_tbIdiomaItem_tbVacante_vac_Id			FOREIGN KEY(vac_Id) REFERENCES Genl.tbVacante(vac_Id),
)  
GO

/*Sección #34*/
CREATE TABLE [Genl].tbLogroEventoCategoria(
	[logCa_Id]			INT IDENTITY(1,1),
	[logCa_Descripcion]	NVARCHAR(300)	NOT NULL,
	CONSTRAINT  PK_Genl_tbLogroEventoCategoria_logCa_Id	PRIMARY KEY(logCa_Id),
)  
GO


/*Sección #34*/
CREATE TABLE [Genl].tbOngEvento(
	[ongEv_Id]				INT IDENTITY(1,1),
	[ongEv_Nombre]			NVARCHAR(300)	NOT NULL,
	[ongEv_Descripcion]		NVARCHAR(1000)	NOT NULL,
	[ongEv_Ruta]			NVARCHAR(3000),
	[ubc_Id]				INT		NOT NULL,
	[ongEv_Fecha]			DATE	NOT NULL,
	[ongEv_Reporte]			BIT NOT NULL DEFAULT 0,
	[ongEv_JsonReaccion]	NVARCHAR(MAX),
	[ongEv_JsonReporte]		NVARCHAR(MAX),
	[ongEv_HoraInicio]		INT	NOT NULL,
	[ongEv_HoraFin]			INT	NOT NULL DEFAULT 0,
	[ongEv_Logro]			BIT	NOT NULL DEFAULT 0,
	[logCa_Id]				INT NOT NULL,
	CONSTRAINT  PK_Genl_tbOngEvento_ongEv_Id	PRIMARY KEY(ongEv_Id),
	CONSTRAINT  FK_Genl_tbOngEvento_tbUbicacion_ubc_Id	FOREIGN KEY(ubc_Id) REFERENCES Genl.tbUbicacion(ubc_Id),
	CONSTRAINT  FK_Genl_tbOngEvento_tbLogroEventoCategoria_logCa_Id	FOREIGN KEY(logCa_Id) REFERENCES Genl.tbLogroEventoCategoria(logCa_Id),
)  
GO

/*Sección #34*/
CREATE TABLE [Genl].tbOngEventoImagen(
	[ongIm_Id]			INT IDENTITY(1,1),
	[ongIm_Ruta]		NVARCHAR(3000)	NOT NULL,
	[ongEv_Id]			INT				NOT NULL,
	CONSTRAINT  PK_Genl_tbOngEventoImagen_logCa_Id	PRIMARY KEY(ongIm_Id),
	CONSTRAINT  FK_Genl_tbOngEventoImagen_tbOngEvento_ongEv_Id	FOREIGN KEY(ongEv_Id) REFERENCES Genl.tbOngEvento(ongEv_Id),
)  
GO

/*Sección #35*/
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
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('smtpPort', '587', ' Puerto SMTP seguro (TLS)')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('senderEmail', 'appcircular2023@gmail.com', 'Correo para Validacion')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('senderPassword', 'lsbuahlrtdgpvdzv', 'Contraseña generada')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('ApiRutaToken', 'https://localhost:44306/Usuario/ValidacionToken?toke=', 'La ruta de api para correos')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioMicroempresa', '1', 'Validar que el tipo de usuario sea el correcto')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioConHablidades', '2', 'Validar usuario Con habilidades')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioONG', '3', 'CalidarONG')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioEmpresa', '4', 'Validar el usaurio Empresa')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioParticular', '5', 'Validar el usuario Particular')
GO
INSERT INTO [Genl].[tbConfiguracion] ([conf_Nombre], [conf_Valor], [conf_Descripcion]) VALUES ('IdTipoUsuarioConLocal', '6', 'Son los usarios que tiene un local ')
GO
/*Sección #36*/
CREATE TYPE dbo.tbHorarioTableType AS TABLE
(
	hor_DiaNumero INT,
    hor_HoraInicio TINYINT,
    hor_MinutoInicio TINYINT,
    hor_HoraFin TINYINT,
    hor_MinutoFin TINYINT
);
GO

/*Sección #37*/
CREATE TYPE dbo.tbCategoriaItemType AS TABLE(
	catg_Id INT
);
GO

/*Sección #38*/
CREATE PROC [dbo].[sp_CrearUsuario]
	@tipUs_Id INT,
	@Nombre NVARCHAR(300),
	@RutaLogo NVARCHAR(2000),
	@RutaPaginaWed NVARCHAR(2000),
	@Descripcion NVARCHAR(500),
	@FechaFundacion DATE,
	@NombreUsuario NVARCHAR(150),
	@Password NVARCHAR(1000),
	@PasswordSal NVARCHAR(100),
	@TelefonoPricipal NVARCHAR(50),
	@TelefonoSecundario NVARCHAR(50),
	@Facebook NVARCHAR(100),
	@Intagram NVARCHAR(100),
	@WhatsApp BIT,
	@Envio BIT,
	@Correo NVARCHAR(100),
	@SubdicionLugar INT,
	@Latitud NVARCHAR(200),
	@Longitub NVARCHAR(200),
	--Los Datos De tablas
	@tbHorarios tbHorarioTableType READONLY,
	@tbCategoriaItem tbCategoriaItemType READONLY,
	    -- Parámetros de salida
    @Success BIT OUTPUT,
    @Message NVARCHAR(1000) OUTPUT,
	@IdUsuario INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION; -- Inicia la transacción
	--Donde se guardara la informacion de la tabla.
	SET @Success = 1;
	DECLARE @hor_DiaNumero INT,
            @hor_HoraInicio TINYINT,
            @hor_MinutoInicio TINYINT,
            @hor_HoraFin TINYINT,
            @hor_MinutoFin TINYINT;

    DECLARE @ErrorHorarioInsertar BIT = 0;

	DECLARE @catg_Id INT;
	DECLARE @ErrorCategoria BIT = 0;

	DECLARE @ipInfo_Id INT;
	DECLARE @ubc_Id INT;
	DECLARE @user_Id INT;

	DECLARE curHorarios CURSOR FOR
			SELECT hor_DiaNumero, hor_HoraInicio, hor_MinutoInicio, hor_HoraFin, hor_MinutoFin
			FROM @tbHorarios;

	DECLARE curCategoriaItem CURSOR FOR
		SELECT catg_Id 
		FROM @tbCategoriaItem;
    BEGIN TRY
			
			INSERT INTO [Genl].[tbInfoUnicaUsuario] ([tInf_Nombre],[tInf_RutaLogo],[tInf_RutaPaginaWed],[tipUs_Id]) VALUES (@Nombre, @RutaLogo,NULLIF(@RutaPaginaWed, ''),@tipUs_Id);
			SET @ipInfo_Id = SCOPE_IDENTITY();
			

			INSERT INTO  [Genl].[tbUbicacion] VALUES(@Latitud,@Longitub,@SubdicionLugar);
			SET @ubc_Id = SCOPE_IDENTITY();

			INSERT INTO [Genl].[tbUsuarios] 
			([ipInf_Id],[user_Descripcion],[user_TelefonoPrincipal],[user_TelefonoSecundario],[user_FechaFundacion],[user_Correo],[user_Facebook],[user_WhatsApp],[user_Password],[user_PasswordSal],[user_NombreUsuario],[ubc_Id],[user_Intagram],[user_Envio]) 
				VALUES (@ipInfo_Id, @Descripcion,@TelefonoPricipal,@TelefonoSecundario,@FechaFundacion,@Correo,@Facebook,@WhatsApp,@Password,@PasswordSal,@NombreUsuario,@ubc_Id,@Intagram,@Envio);
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
GO;

