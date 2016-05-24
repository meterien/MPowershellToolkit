IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddComputer]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AddComputer]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteComputer]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteComputer]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteComputerByID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteComputerByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetComputer]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetComputer]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetComputers]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetComputers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetComputerID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetComputerID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateComputer]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UpdateComputer]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateComputerByID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UpdateComputerByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynchronizeComputers]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[SynchronizeComputers]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddLocation]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AddLocation]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteLocation]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteLocation]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteLocationByID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteLocationByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLocation]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetLocation]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLocations]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetLocations]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetLocationID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetLocationID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateLocation]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UpdateLocation]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynchronizeLocations]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[SynchronizeLocations]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddDefaultGateway]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AddDefaultGateway]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteDefaultGateway]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteDefaultGateway]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDefaultGateways]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetDefaultGateways]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetDefaultGatewaysForLocation]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetDefaultGatewaysForLocation]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddMakeModel]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[AddMakeModel]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteMakeModel]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteMakeModel]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteMakeModelByID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[DeleteMakeModelByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMakeModel]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMakeModel]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMakeModels]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMakeModels]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetMakeModelID]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[GetMakeModelID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateMakeModel]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[UpdateMakeModel]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynchronizeMakeModels]') AND type in (N'P', N'PC'))
	DROP PROCEDURE [dbo].[SynchronizeMakeModels]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddRole]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddRoleToObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddRoleToObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddRoleToObjectByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddRoleToObjectByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllRolesFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllRolesFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteRole]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRoleByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteRoleByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRoleFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteRoleFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRoleFromObjectByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteRoleFromObjectByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRole]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRoleID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRoleID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRoles]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynchronizeRoles]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SynchronizeRoles]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateRole]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddRoleMapping]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddRoleMapping]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteRoleMapping]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteRoleMapping]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllRoleMappings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllRoleMappings]
GO

IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[RoleMappings]'))
DROP VIEW [dbo].[RoleMappings]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRoleMappings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRoleMappings]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetRoleMappingsForRole]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetRoleMappingsForRole]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddPackage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddPackage]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddPackageToObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddPackageToObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddPackageToObjectByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddPackageToObjectByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllPackagesFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllPackagesFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletePackage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeletePackage]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletePackageByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeletePackageByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletePackageFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeletePackageFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletePackageFromObjectByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeletePackageFromObjectByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPackage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPackage]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPackageID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPackageID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetPackages]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetPackages]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynchronizePackages]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SynchronizePackages]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdatePackage]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdatePackage]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddPackageMapping]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddPackageMapping]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeletePackageMapping]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeletePackageMapping]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllPackageMappings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllPackageMappings]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddDefaultSettings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddDefaultSettings]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateSettings]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateSettings]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetSetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetSetting]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SetSetting]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SetSetting]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteSettingsFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteSettingsFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddApplication]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddApplication]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddApplicationToObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddApplicationToObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddApplicationToObjectByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddApplicationToObjectByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllApplicationsFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllApplicationsFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteApplication]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteApplication]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteApplicationByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteApplicationByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteApplicationFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteApplicationFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteApplicationFromObjectByID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteApplicationFromObjectByID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetApplication]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetApplication]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetApplicationID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetApplicationID]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetApplications]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetApplications]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SynchronizeApplications]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SynchronizeApplications]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UpdateApplication]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[UpdateApplication]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AddAdministratorToObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[AddAdministratorToObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAllAdministratorsFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAllAdministratorsFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAdministrator]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAdministrator]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DeleteAdministratorFromObject]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[DeleteAdministratorFromObject]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GetAdministrators]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[GetAdministrators]
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PackageIdentity]') AND type in (N'U'))
DROP TABLE [dbo].[PackageIdentity]
GO

/* Add a Role mapping Table and corresponding View */

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleMapping]') AND type in (N'U'))
CREATE TABLE [dbo].[RoleMapping](
	[RoleID] [int] NOT NULL,
	[ARPName] [nvarchar](255) NOT NULL,
 CONSTRAINT [PK_RoleMapping] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[ARPName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE VIEW [dbo].[RoleMappings]
AS
SELECT     dbo.RoleIdentity.ID, dbo.RoleIdentity.Role, dbo.RoleMapping.ARPName
FROM         dbo.RoleIdentity INNER JOIN
                      dbo.RoleMapping ON dbo.RoleIdentity.ID = dbo.RoleMapping.RoleID

GO

/* Create PackageIdentity Table if necessary as it is not part of the original MDT Database */
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PackageIdentity]') AND type in (N'U'))
CREATE TABLE [dbo].[PackageIdentity](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Package] [nvarchar](255) NULL,
 CONSTRAINT [PK_PackageIdentity] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Koster, Maik
-- Description:	Creates a new computer
-- =============================================
CREATE PROCEDURE [dbo].[AddComputer]
	@SerialNumber nvarchar(255),
	@AssetTag nvarchar(255),
	@MacAddress nvarchar(50),
	@UUID nvarchar(50),
	@Description nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	/* Add only if computer does not exist.
	SerialNumber, AssetTag, MacAddress and UUID should be unique */
	IF NOT EXISTS (SELECT * FROM dbo.ComputerIdentity 
		WHERE (SerialNumber = @SerialNumber AND @SerialNumber <> '') 
		OR (AssetTag = @AssetTag AND @AssetTag <> '') 
		OR (MacAddress = @MacAddress AND @MacAddress <> '') 
		OR (UUID = @UUID AND @UUID <> ''))

		BEGIN	
		INSERT INTO dbo.ComputerIdentity
		(SerialNumber,
		AssetTag,
		MacAddress,
		UUID,
		[Description])
		OUTPUT Inserted.ID
		VALUES
		(@SerialNumber,
		@AssetTag,
		@MacAddress,
		@UUID,
		@Description)
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a computer
-- =============================================
CREATE PROCEDURE [dbo].[DeleteComputerByID]
	@ComputerID int
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete only if Computer exists */
	IF @ComputerID > 0 
		BEGIN
		/* Delete from referencing Tables */
		/* Settings */
		DELETE FROM dbo.Settings
		WHERE [Type] = 'C'
		AND ID = @ComputerID

		/* Custom Settings if used 
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomSettings]') AND type in (N'U'))
		DELETE FROM dbo.CustomSettings
		WHERE [Type] = 'C'
		AND ID = @ComputerID*/

		/* Administrators */
		DELETE FROM dbo.Settings_Administrators
		WHERE [Type] = 'C'
		AND ID = @ComputerID

		/* Applications */
		DELETE FROM dbo.Settings_Applications
		WHERE [Type] = 'C'
		AND ID = @ComputerID

		/* Packages */
		DELETE FROM dbo.Settings_Packages
		WHERE [Type] = 'C'
		AND ID = @ComputerID

		/* Roles */
		DELETE FROM dbo.Settings_Roles
		WHERE [Type] = 'C'
		AND ID = @ComputerID
		
		/* Delete Computer */
		DELETE FROM dbo.ComputerIdentity
		WHERE ID = @ComputerID

		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a computer
-- =============================================
CREATE PROCEDURE [dbo].[DeleteComputer]
	@SerialNumber nvarchar(255),
	@AssetTag nvarchar(255),
	@MacAddress nvarchar(50),
	@UUID nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

    /* Get Computer ID */
	DECLARE @ComputerID as int
	
	SET @ComputerID = (SELECT ID FROM dbo.ComputerIdentity 
		WHERE (SerialNumber = @SerialNumber AND @SerialNumber <> '') 
		OR (AssetTag = @AssetTag AND @AssetTag <> '') 
		OR (MacAddress = @MacAddress AND @MacAddress <> '') 
		OR (UUID = @UUID AND @UUID <> ''))

	/* Delete only if Computer exists */
	IF @ComputerID > 0 
		EXEC dbo.DeleteComputerByID @ComputerID

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns the Computer ID
-- =============================================
CREATE PROCEDURE [dbo].[GetComputerID]
	@SerialNumber nvarchar(255),
	@AssetTag nvarchar(255),
	@MacAddress nvarchar(50),
	@UUID nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID FROM dbo.ComputerIdentity 
		WHERE (SerialNumber = @SerialNumber AND @SerialNumber <> '') 
		OR (AssetTag = @AssetTag AND @AssetTag <> '') 
		OR (MacAddress = @MacAddress AND @MacAddress <> '') 
		OR (UUID = @UUID AND @UUID <> '')
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a Computer
-- =============================================
CREATE PROCEDURE [dbo].[GetComputer]
	@ComputerID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, SerialNumber, AssetTag, MacAddress, UUID, [Description] FROM dbo.ComputerIdentity 
	WHERE ID = @ComputerID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a list of Computers
-- =============================================
CREATE PROCEDURE [dbo].[GetComputers]

AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, SerialNumber, AssetTag, MacAddress, UUID, [Description] FROM dbo.ComputerIdentity 
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a computer record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateComputerByID]
	@ComputerID int,
	@SerialNumber nvarchar(255),
	@AssetTag nvarchar(255),
	@MacAddress nvarchar(50),
	@UUID nvarchar(50),
	@Description nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Update record if computer exists */
	IF @ComputerID > 0 
		BEGIN
		UPDATE dbo.ComputerIdentity
		SET SerialNumber = @SerialNumber,
		AssetTag = @AssetTag,
		MacAddress = @MacAddress,
		UUID = @UUID,
		[Description] = @Description
		WHERE ID = @ComputerID
		SELECT @ComputerID
		END
	ELSE
		/* Computer does not exist, Add it to the database */
		BEGIN	
		INSERT INTO dbo.ComputerIdentity
		(SerialNumber,
		AssetTag,
		MacAddress,
		UUID,
		[Description])
		OUTPUT Inserted.ID
		VALUES
		(@SerialNumber,
		@AssetTag,
		@MacAddress,
		@UUID,
		@Description)
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a computer record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateComputer]
	@SerialNumber nvarchar(255),
	@AssetTag nvarchar(255),
	@MacAddress nvarchar(50),
	@UUID nvarchar(50),
	@Description nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Get Computer ID */
	DECLARE @ComputerID as int
	
	SET @ComputerID = (SELECT ID FROM dbo.ComputerIdentity 
		WHERE (SerialNumber = @SerialNumber AND @SerialNumber <> '') 
		OR (AssetTag = @AssetTag AND @AssetTag <> '') 
		OR (MacAddress = @MacAddress AND @MacAddress <> '') 
		OR (UUID = @UUID AND @UUID <> ''))

	/* Update record if computer exists */
	IF @ComputerID > 0 
		BEGIN
		UPDATE dbo.ComputerIdentity
		SET SerialNumber = @SerialNumber,
		AssetTag = @AssetTag,
		MacAddress = @MacAddress,
		UUID = @UUID,
		[Description] = @Description
		WHERE ID = @ComputerID
		SELECT @ComputerID
		END
	ELSE
		/* Computer does not exist, Add it to the database */
		BEGIN	
		INSERT INTO dbo.ComputerIdentity
		(SerialNumber,
		AssetTag,
		MacAddress,
		UUID,
		[Description])
		OUTPUT Inserted.ID
		VALUES
		(@SerialNumber,
		@AssetTag,
		@MacAddress,
		@UUID,
		@Description)
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Synchronizes all computer objects
-- =============================================
CREATE PROCEDURE [dbo].[SynchronizeComputers]
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete obsolete computer entries from referencing tables */
	/* Settings */
	DELETE FROM dbo.Settings
	WHERE [Type] = 'C' 
	AND ID NOT IN (SELECT ID FROM dbo.ComputerIdentity)

	/* Custom Settings if used 
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomSettings]') AND type in (N'U'))
	DELETE FROM dbo.CustomSettings
	WHERE [Type] = 'C' 
	AND ID NOT IN (SELECT ID FROM dbo.ComputerIdentity) */

	/* Administrators */
	DELETE FROM dbo.Settings_Administrators
	WHERE [Type] = 'C' 
	AND ID NOT IN (SELECT ID FROM dbo.ComputerIdentity)

	/* Applications */
	DELETE FROM dbo.Settings_Applications
	WHERE [Type] = 'C' 
	AND ID NOT IN (SELECT ID FROM dbo.ComputerIdentity)

	/* Packages */
	DELETE FROM dbo.Settings_Packages
	WHERE [Type] = 'C' 
	AND ID NOT IN (SELECT ID FROM dbo.ComputerIdentity)

	/* Roles */
	DELETE FROM dbo.Settings_Roles
	WHERE [Type] = 'C' 
	AND ID NOT IN (SELECT ID FROM dbo.ComputerIdentity)

END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Creates a new Location
-- =============================================
CREATE PROCEDURE [dbo].[AddLocation]
	@Location nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	/* Add only if Location does not exist */
	IF NOT EXISTS (SELECT * FROM dbo.LocationIdentity 
				WHERE (Location = @Location AND @Location <> '')) 
		
		BEGIN	
		INSERT INTO dbo.LocationIdentity
		(Location)
		OUTPUT Inserted.ID
		VALUES
		(@Location)
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Location
-- =============================================
CREATE PROCEDURE [dbo].[DeleteLocationByID]
	@LocationID int
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete only if Location exists */
	IF @LocationID > 0 
		BEGIN
		/* Delete from referencing Tables */
		/* Settings */
		DELETE FROM dbo.Settings
		WHERE [Type] = 'L'
		AND ID = @LocationID

		/* Custom Settings if used 
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomSettings]') AND type in (N'U'))
		DELETE FROM dbo.CustomSettings
		WHERE [Type] = 'L'
		AND ID = @LocationID */

		/* Administrators */
		DELETE FROM dbo.Settings_Administrators
		WHERE [Type] = 'L'
		AND ID = @LocationID

		/* Applications */
		DELETE FROM dbo.Settings_Applications
		WHERE [Type] = 'L'
		AND ID = @LocationID

		/* Packages */
		DELETE FROM dbo.Settings_Packages
		WHERE [Type] = 'L'
		AND ID = @LocationID

		/* Roles */
		DELETE FROM dbo.Settings_Roles
		WHERE [Type] = 'L'
		AND ID = @LocationID
		
		/* Delete Location */
		DELETE FROM dbo.LocationIdentity
		WHERE ID = @LocationID

		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Location
-- =============================================
CREATE PROCEDURE [dbo].[DeleteLocation]
	@Location nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

    /* Get Location ID */
	DECLARE @LocationID as int
	
	SET @LocationID = (SELECT ID FROM dbo.LocationIdentity 
		WHERE (Location = @Location AND @Location <> ''))

	/* Delete only if Location exists */
	IF @LocationID > 0 
		EXEC dbo.DeleteLocationByID @LocationID

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns the Location ID
-- =============================================
CREATE PROCEDURE [dbo].[GetLocationID]
	@Location nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID FROM dbo.LocationIdentity 
	WHERE (Location = @Location AND @Location <> '')
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a Location
-- =============================================
CREATE PROCEDURE [dbo].[GetLocation]
	@LocationID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, Location FROM dbo.LocationIdentity 
	WHERE ID = @LocationID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns all Locations
-- =============================================
CREATE PROCEDURE [dbo].[GetLocations]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, Location FROM dbo.LocationIdentity
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a Location record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateLocation]
	@LocationID int,
	@Location nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Update record if Location exists */
	IF @LocationID > 0 
		BEGIN
		UPDATE dbo.LocationIdentity
		SET Location = @Location
		WHERE ID = @LocationID
		END
	
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Synchronizes all Location objects
-- =============================================
CREATE PROCEDURE [dbo].[SynchronizeLocations]
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete obsolete Location entries from referencing tables */
	/* Settings */
	DELETE FROM dbo.Settings
	WHERE [Type] = 'L' 
	AND ID NOT IN (SELECT ID FROM dbo.LocationIdentity)

	/* Custom Settings if used 
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomSettings]') AND type in (N'U'))
	DELETE FROM dbo.CustomSettings
	WHERE [Type] = 'L' 
	AND ID NOT IN (SELECT ID FROM dbo.LocationIdentity)*/

	/* Administrators */
	DELETE FROM dbo.Settings_Administrators
	WHERE [Type] = 'L' 
	AND ID NOT IN (SELECT ID FROM dbo.LocationIdentity)

	/* Applications */
	DELETE FROM dbo.Settings_Applications
	WHERE [Type] = 'L' 
	AND ID NOT IN (SELECT ID FROM dbo.LocationIdentity)

	/* Packages */
	DELETE FROM dbo.Settings_Packages
	WHERE [Type] = 'L' 
	AND ID NOT IN (SELECT ID FROM dbo.LocationIdentity)

	/* Roles */
	DELETE FROM dbo.Settings_Roles
	WHERE [Type] = 'L' 
	AND ID NOT IN (SELECT ID FROM dbo.LocationIdentity)

	
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a new gateway to a location
-- =============================================
CREATE PROCEDURE dbo.AddDefaultGateway
	@LocationID int,
	@DefaultGateway nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* New Gateway needs to be unique */
	IF @DefaultGateway <> '' AND EXISTS (SELECT * FROM dbo.LocationIdentity WHERE ID = @LocationID)
		AND @DefaultGateway NOT IN (SELECT DefaultGateway FROM dbo.LocationIdentity_DefaultGateway)
	INSERT INTO dbo.LocationIdentity_DefaultGateway
	(ID, DefaultGateway)
	VALUES
	(@LocationID, @DefaultGateway)
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a gateway from a location
-- =============================================
CREATE PROCEDURE dbo.DeleteDefaultGateway
	@DefaultGateway nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

    DELETE FROM dbo.LocationIdentity_DefaultGateway
	WHERE DefaultGateway = @DefaultGateway
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns all Default Gateways
-- =============================================
CREATE PROCEDURE [dbo].[GetDefaultGateways]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, DefaultGateway FROM dbo.LocationIdentity_DefaultGateway
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns all Default Gateways 
--              for the specified Location
-- =============================================
CREATE PROCEDURE [dbo].[GetDefaultGatewaysForLocation]
	@LocationID as int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, DefaultGateway FROM dbo.LocationIdentity_DefaultGateway
	WHERE ID = @LocationID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Creates a new MakeModel
-- =============================================
CREATE PROCEDURE [dbo].[AddMakeModel]
	@Make nvarchar(255),
	@Model nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	/* Add only if MakeModel does not exist */
	IF NOT EXISTS (SELECT * FROM dbo.MakeModelIdentity 
				WHERE (Make = @Make AND Model = @Model)) 
		
		BEGIN	
		INSERT INTO dbo.MakeModelIdentity
		(Make, Model)
		OUTPUT Inserted.ID
		VALUES
		(@Make, @Model)
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a MakeModel
-- =============================================
CREATE PROCEDURE [dbo].[DeleteMakeModelByID]
	@MakeModelID int
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete only if MakeModel exists */
	IF @MakeModelID > 0 
		BEGIN
		/* Delete from referencing Tables */
		/* Settings */
		DELETE FROM dbo.Settings
		WHERE [Type] = 'M'
		AND ID = @MakeModelID

		/* Custom Settings if used 
		IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomSettings]') AND type in (N'U'))
		DELETE FROM dbo.CustomSettings
		WHERE [Type] = 'M'
		AND ID = @MakeModelID */

		/* Administrators */
		DELETE FROM dbo.Settings_Administrators
		WHERE [Type] = 'M'
		AND ID = @MakeModelID

		/* Applications */
		DELETE FROM dbo.Settings_Applications
		WHERE [Type] = 'M'
		AND ID = @MakeModelID

		/* Packages */
		DELETE FROM dbo.Settings_Packages
		WHERE [Type] = 'M'
		AND ID = @MakeModelID

		/* Roles */
		DELETE FROM dbo.Settings_Roles
		WHERE [Type] = 'M'
		AND ID = @MakeModelID
		
		/* Delete MakeModel */
		DELETE FROM dbo.MakeModelIdentity
		WHERE ID = @MakeModelID

		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a MakeModel
-- =============================================
CREATE PROCEDURE [dbo].[DeleteMakeModel]
	@Make nvarchar(255),
	@Model nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

    /* Get MakeModel ID */
	DECLARE @MakeModelID as int
	
	SET @MakeModelID = (SELECT ID FROM dbo.MakeModelIdentity 
		WHERE (Make = @Make AND Model = @Model))

	/* Delete only if MakeModel exists */
	IF @MakeModelID > 0 
		EXEC dbo.DeleteMakeModelByID @MakeModelID

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns the MakeModel ID
-- =============================================
CREATE PROCEDURE [dbo].[GetMakeModelID]
	@Make nvarchar(255),
	@Model nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID FROM dbo.MakeModelIdentity 
	WHERE (Make = @Make AND Model = @Model)
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a MakeModel
-- =============================================
CREATE PROCEDURE [dbo].[GetMakeModel]
	@MakeModelID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, Make, Model FROM dbo.MakeModelIdentity 
	WHERE ID = @MakeModelID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a List of MakeModels
-- =============================================
CREATE PROCEDURE [dbo].[GetMakeModels]

AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, Make, Model FROM dbo.MakeModelIdentity 
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a MakeModel record
-- =============================================
CREATE PROCEDURE [dbo].[UpdateMakeModel]
	@MakeModelID int,
	@Make nvarchar(255),
	@Model nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Update record if MakeModel exists */
	IF @MakeModelID > 0 
		BEGIN
		UPDATE dbo.MakeModelIdentity
		SET Make = @Make, Model = @Model
		WHERE ID = @MakeModelID
		END
	
END
GO


-- ===============================================
-- Author:		Koster, Maik
-- Description:	Synchronizes all MakeModel objects
-- ===============================================
CREATE PROCEDURE [dbo].[SynchronizeMakeModels]
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete obsolete MakeModel entries from referencing tables */
	/* Settings */
	DELETE FROM dbo.Settings
	WHERE [Type] = 'M' 
	AND ID NOT IN (SELECT ID FROM dbo.MakeModelIdentity)

	/* Custom Settings if used 
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CustomSettings]') AND type in (N'U'))
	DELETE FROM dbo.CustomSettings
	WHERE [Type] = 'M' 
	AND ID NOT IN (SELECT ID FROM dbo.MakeModelIdentity)*/

	/* Administrators */
	DELETE FROM dbo.Settings_Administrators
	WHERE [Type] = 'M' 
	AND ID NOT IN (SELECT ID FROM dbo.MakeModelIdentity)

	/* Applications */
	DELETE FROM dbo.Settings_Applications
	WHERE [Type] = 'M' 
	AND ID NOT IN (SELECT ID FROM dbo.MakeModelIdentity)

	/* Packages */
	DELETE FROM dbo.Settings_Packages
	WHERE [Type] = 'M' 
	AND ID NOT IN (SELECT ID FROM dbo.MakeModelIdentity)

	/* Roles */
	DELETE FROM dbo.Settings_Roles
	WHERE [Type] = 'M' 
	AND ID NOT IN (SELECT ID FROM dbo.MakeModelIdentity)

	
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a new Role
-- =============================================
CREATE PROCEDURE [dbo].[AddRole]
	@Role as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.RoleIdentity
	([Role])
	OUTPUT Inserted.ID
	VALUES
	(@Role)
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Role to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddRoleToObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Role as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* Check if the supplied Role exists and has not been added before*/
	IF EXISTS(SELECT 0 FROM dbo.RoleIdentity WHERE [Role] = @Role) AND NOT EXISTS(SELECT 0 FROM dbo.Settings_Roles WHERE ID = @MDTID AND [Type] = @Type AND [Role] = @Role)
		BEGIN
		/* If object has already a role, get maximum sequence to add new role */
		IF EXISTS(SELECT 0 FROM dbo.Settings_Roles WHERE ID = @MDTID AND [Type] = @Type)
			BEGIN
			SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Roles WHERE ID = @MDTID AND [Type] = @Type) + 1
			
			INSERT INTO dbo.Settings_Roles
			([Type],
			 ID,
			 Sequence,
			 [Role])
			VALUES
			(@Type,
			 @MDTID,
			 @MaxSequence,
			 @Role)
			END
		ELSE
			BEGIN
			INSERT INTO dbo.Settings_Roles
			([Type],
			 ID,
			 Sequence,
			 [Role])
			VALUES
			(@Type,
			 @MDTID,
			 1,
			 @Role)
			END
		END
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Role to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddRoleToObjectByID] 
	@MDTID as int,
	@Type as nvarchar(50),
	@RoleID as int
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* Check if the supplied Role exists and has not been added before*/
	IF EXISTS(SELECT 0 FROM dbo.RoleIdentity WHERE ID = @RoleID) 
		AND NOT EXISTS(SELECT 0 FROM dbo.Settings_Roles WHERE ID = @MDTID AND [Type] = @Type 
		AND [Role] = (SELECT [Role] FROM dbo.RoleIdentity WHERE ID = @RoleID))
		BEGIN
		DECLARE @Role as nvarchar(50)
		
		SET @Role = (SELECT [Role] FROM dbo.RoleIdentity WHERE ID = @RoleID)

		/* If object has already a role, get maximum sequence to add new role */
		IF EXISTS(SELECT 0 FROM dbo.Settings_Roles WHERE ID = @MDTID AND [Type] = @Type)
			BEGIN
			SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Roles WHERE ID = @MDTID AND [Type] = @Type) + 1
			
			INSERT INTO dbo.Settings_Roles
			([Type],
			 ID,
			 Sequence,
			 [Role])
			VALUES
			(@Type,
			 @MDTID,
			 @MaxSequence,
			 @Role)
			END
		ELSE
			BEGIN
			INSERT INTO dbo.Settings_Roles
			([Type],
			 ID,
			 Sequence,
			 [Role])
			VALUES
			(@Type,
			 @MDTID,
			 1,
			 @Role)
			END
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllRolesFromObject] 
	@MDTID as int,
	@Type as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Roles
	WHERE ID = @MDTID 
	AND [Type] = @Type

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRole]
	@Role as Nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Role from the Settings_Roles table */
	DELETE FROM dbo.Settings_Roles
	WHERE [Role] = @Role

	/* Delete all mappings if custom RoleMapping table is used */
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleMapping]') AND type in (N'U'))
	DELETE FROM dbo.RoleMapping
	WHERE RoleID = (SELECT ID FROM dbo.RoleIdentity WHERE [Role] = @Role)

	/* Delete the Role from the RoleIdentity table */
	DELETE FROM dbo.RoleIdentity
	WHERE [Role] = @Role

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRoleByID]
	@RoleID as int
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Role from the Settings_Roles table */
	DELETE FROM dbo.Settings_Roles
	WHERE [Role] = (SELECT [Role] FROM dbo.RoleIdentity WHERE ID = @RoleID)

	/* Delete all mappings if custom RoleMapping table is used */
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleMapping]') AND type in (N'U'))
	DELETE FROM dbo.RoleMapping
	WHERE RoleID = @RoleID

	/* Delete the Role from the RoleIdentity table */
	DELETE FROM dbo.RoleIdentity
	WHERE ID = @RoleID
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRoleFromObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Role as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Roles
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND [Role] = @Role
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRoleFromObjectByID] 
	@MDTID as int,
	@Type as nvarchar(50),
	@RoleID as int
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Roles
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND [Role] = (SELECT [Role] FROM dbo.RoleIdentity 
					 WHERE ID = @RoleID)
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a Role 
-- =============================================
CREATE PROCEDURE [dbo].[GetRole]
	@RoleID as int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, [Role] FROM dbo.RoleIdentity 
	WHERE ID = @RoleID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns the RoleID of the specified Role
-- =============================================
CREATE PROCEDURE [dbo].[GetRoleID]
	@Role as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ID FROM dbo.RoleIdentity
	WHERE Role LIKE '%' + @Role + '%'

END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns all Roles
-- =============================================
CREATE PROCEDURE [dbo].[GetRoles]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, [Role] FROM dbo.RoleIdentity
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Removes outdated Role Entries from Settings_Roles Table
-- =============================================
CREATE PROCEDURE [dbo].[SynchronizeRoles]
	
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete all Roles from dbo.Settings_Roles
	   without an appropiate entry in RoleIdentiy */
	DELETE FROM dbo.Settings_Roles
	WHERE [Role] NOT IN (SELECT [Role] FROM dbo.RoleIdentity)


	/* Delete all mappings if custom RoleMapping table is used and the Role no longer exists */
	IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RoleMapping]') AND type in (N'U'))
	DELETE FROM dbo.RoleMapping
	WHERE RoleID NOT IN (SELECT ID FROM dbo.RoleIdentity)

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a Role 
-- =============================================
CREATE PROCEDURE [dbo].[UpdateRole] 
	@RoleID as int,
	@Role as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Check if RoleID exists */
	IF EXISTS (SELECT 0 FROM dbo.RoleIdentity WHERE ID = @RoleID)
		BEGIN
		/* Get the old Role */
		DECLARE @OldRole as nvarchar(50)
		SET @OldRole = (SELECT [Role] FROM dbo.RoleIdentity WHERE ID = @RoleID)

		/* Update Settings_Roles */
		UPDATE dbo.Settings_Roles
		SET [Role] = @Role
		WHERE [Role] = @OldRole		

		/* Update RoleIdentiy to new value */
		UPDATE dbo.RoleIdentity
		SET [Role] = @Role
		WHERE ID = @RoleID
		
		END
	
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a new Role mapping entry
-- =============================================
CREATE PROCEDURE [dbo].[AddRoleMapping]
	@RoleID int,
	@ARPName nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Insert only if corresponding Role exists and a value for ARPName has been supplied */ 
	IF @ARPName <> '' AND EXISTS (SELECT * FROM dbo.RoleIdentity  WHERE ID = @RoleID)
	INSERT INTO dbo.RoleMapping
	(RoleID, ARPName)
	VALUES
	(@RoleID, @ARPName)
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role mapping entry
-- =============================================
CREATE PROCEDURE [dbo].[DeleteRoleMapping]
	@RoleID as int,
	@ARPName nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM dbo.RoleMapping
	WHERE RoleID = @RoleID AND ARPName = @ARPName
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Role mapping entry
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllRoleMappings]
	@RoleID as int
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM dbo.RoleMapping
	WHERE RoleID = @RoleID 
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a List of all Role Mappings
-- =============================================
CREATE PROCEDURE dbo.GetRoleMappings
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, [Role], ARPName FROM dbo.RoleMappings
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a List of all Role Mappings
--              For a specific Role
-- =============================================
CREATE PROCEDURE dbo.GetRoleMappingsForRole
	@RoleID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, [Role], ARPName FROM dbo.RoleMappings
	WHERE ID = @RoleID
END
GO



-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a new Package
-- =============================================
CREATE PROCEDURE [dbo].[AddPackage]
	@Package as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.PackageIdentity
	(Package)
	OUTPUT Inserted.ID
	VALUES
	(@Package)
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Package to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddPackageToObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Package as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* Check if the supplied Package exists */
	IF EXISTS(SELECT 0 FROM dbo.PackageIdentiy WHERE Package = @Package)
		BEGIN
		/* If object has already a Package, get maximum sequence to add new Package */
		IF EXISTS(SELECT 0 FROM dbo.Settings_Packages WHERE ID = @MDTID AND [Type] = @Type)
			BEGIN
			SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Packages WHERE ID = @MDTID AND [Type] = @Type) + 1
			
			INSERT INTO dbo.Settings_Packages
			([Type],
			 ID,
			 Sequence,
			 Packages)
			VALUES
			(@Type,
			 @MDTID,
			 @MaxSequence,
			 @Package)
			END
		ELSE
			BEGIN
			INSERT INTO dbo.Settings_Packages
			([Type],
			 ID,
			 Sequence,
			 Packages)
			VALUES
			(@Type,
			 @MDTID,
			 1,
			 @Package)
			END
		END
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Package to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddPackageToObjectByID] 
	@MDTID as int,
	@Type as nvarchar(50),
	@PackageID as int
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* Check if the supplied Package exists */
	IF EXISTS(SELECT 0 FROM dbo.PackageIdentity WHERE ID = @PackageID)
		BEGIN
		DECLARE @Package as nvarchar(50)
		
		SET @Package = (SELECT Package FROM dbo.PackageIdentity WHERE ID = @PackageID)

		/* If object has already a Package, get maximum sequence to add new Package */
		IF EXISTS(SELECT 0 FROM dbo.Settings_Packages WHERE ID = @MDTID AND [Type] = @Type)
			BEGIN
			SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Packages WHERE ID = @MDTID AND [Type] = @Type) + 1
			
			INSERT INTO dbo.Settings_Packages
			([Type],
			 ID,
			 Sequence,
			 Packages)
			VALUES
			(@Type,
			 @MDTID,
			 @MaxSequence,
			 @Package)
			END
		ELSE
			BEGIN
			INSERT INTO dbo.Settings_Packages
			([Type],
			 ID,
			 Sequence,
			 Packages)
			VALUES
			(@Type,
			 @MDTID,
			 1,
			 @Package)
			END
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Package from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllPackagesFromObject] 
	@MDTID as int,
	@Type as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Packages
	WHERE ID = @MDTID 
	AND [Type] = @Type

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Package from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeletePackage]
	@Package as Nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Package from the Settings_Packages table */
	DELETE FROM dbo.Settings_Packages
	WHERE Packages = @Package

	/* Delete the Package from the dbo.PackageMapping table */
	DELETE FROM dbo.PackageMapping
	WHERE Packages = @Package

	/* Delete the Package from the PackageIdentity table */
	DELETE FROM dbo.PackageIdentity
	WHERE Package = @Package

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Package from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeletePackageByID]
	@PackageID as int
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Package from the Settings_Packages table */
	DELETE FROM dbo.Settings_Packages
	WHERE Packages = (SELECT Package FROM dbo.PackageIdentity WHERE ID = @PackageID)

	/* Delete the Package from the dbo.PackageMapping table */
	DELETE FROM dbo.PackageMapping
	WHERE Packages = (SELECT Package FROM dbo.PackageIdentity WHERE ID = @PackageID)

	/* Delete the Package from the PackageIdentity table */
	DELETE FROM dbo.PackageIdentity
	WHERE ID = @PackageID
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Package from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeletePackageFromObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Package as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Packages
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND Packages = @Package
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Package from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeletePackageFromObjectByID] 
	@MDTID as int,
	@Type as nvarchar(50),
	@PackageID as int
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Packages
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND Packages = (SELECT Package FROM dbo.PackageIdentity 
					 WHERE ID = @PackageID)
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a Package
-- =============================================
CREATE PROCEDURE [dbo].[GetPackage]
	@PackageID as int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ID, Package FROM dbo.PackageIdentity 
	WHERE ID = @PackageID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns the PackageID of the specified Package
-- =============================================
CREATE PROCEDURE [dbo].[GetPackageID]
	@Package as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ID FROM dbo.PackageIdentity
	WHERE Package LIKE '%' + @Package + '%'

END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns all Packages
-- =============================================
CREATE PROCEDURE [dbo].[GetPackages]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM dbo.PackageIdentity
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Removes outdated Package Entries from Settings_Packages Table
-- =============================================
CREATE PROCEDURE [dbo].[SynchronizePackages]
	
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete all Packages from dbo.Settings_Packages
	   without an appropiate entry in PackageIdentiy */
	DELETE FROM dbo.Settings_Packages
	WHERE Packages NOT IN (SELECT Package FROM dbo.PackageIdentity)

	/* Delete all Packages from dbo.PackageMapping
	   without an appropiate entry in PackageIdentiy */
	DELETE FROM dbo.PackageMapping
	WHERE Packages NOT IN (SELECT Package FROM dbo.PackageIdentity)

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a Package 
-- =============================================
CREATE PROCEDURE [dbo].[UpdatePackage] 
	@PackageID as int,
	@Package as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Check if PackageID exists */
	IF EXISTS (SELECT 0 FROM dbo.PackageIdentity WHERE ID = @PackageID)
		BEGIN
		/* Get the old Package */
		DECLARE @OldPackage as nvarchar(50)
		SET @OldPackage = (SELECT Package FROM dbo.PackageIdentity WHERE ID = @PackageID)

		/* Update Settings_Packages */
		UPDATE dbo.Settings_Packages
		SET Packages = @Package
		WHERE Packages = @OldPackage	
		
		/* Update PackageMapping */
		UPDATE dbo.PackageMapping
		SET Packages = @Package
		WHERE Packages = @OldPackage

		/* Update PackageIdentiy to new value */
		UPDATE dbo.PackageIdentity
		SET Package = @Package
		WHERE ID = @PackageID
		
		END
	
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a new package mapping entry
-- =============================================
CREATE PROCEDURE dbo.AddPackageMapping
	@ARPName nvarchar(255),
	@Package nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Insert only if values have been supplied and it is a unique value pair */ 
	IF @ARPName <> '' AND @Package <> '' 
		AND NOT EXISTS (SELECT * FROM dbo.PackageMapping WHERE ARPName = @ARPName AND Packages = @Package)
		/* AND @Package IN (SELECT Package FROM dbo.PackageIdentity) */
    INSERT INTO dbo.PackageMapping
	(ARPName, Packages)
	VALUES
	(@ARPName, @Package)
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a package mapping entry
-- =============================================
CREATE PROCEDURE dbo.DeletePackageMapping
	@ARPName nvarchar(255),
	@Package nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM dbo.PackageMapping
	WHERE ARPName = @ARPName AND Packages = @Package
	
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes all Package Mappings
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllPackageMappings]
	@Package as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	DELETE FROM dbo.PackageMapping
	WHERE Packages = @Package 
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Ensures that a set of settings exist
--              for an object to avoid NULL problems
-- =============================================
CREATE PROCEDURE [dbo].[AddDefaultSettings]
	@MDTID as int,
	@Type as nvarchar(50) 
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	/* We just add an "empty" Settings entry to the Settings table to be used later */
	IF NOT EXISTS (SELECT * FROM dbo.Settings WHERE ID = @MDTID AND [Type] = @Type)
		BEGIN
		INSERT INTO dbo.Settings
		(ID, [Type])
		VALUES
		(@MDTID, @Type)
		END

END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a Set of Settings to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[UpdateSettings] 
	@MDTID as int,
	@Type char(1),
	@UserID nvarchar(255),
	@UserDomain nvarchar(255),
	@UserPassword nvarchar(255),
	@UDShare nvarchar(255),
	@UDDir nvarchar(255),
	@UDProfiles nvarchar(255),
	@SLShare nvarchar(255),
	@EventShare nvarchar(255),
	@OSInstall nvarchar(50),
	@ComputerName nvarchar(50),
	@Home_Page nvarchar(255),
	@JoinDomain nvarchar(50),
	@JoinWorkGroup nvarchar(50),
	@DomainAdmin nvarchar(255),
	@DomainAdminDomain nvarchar(255),
	@DomainAdminPassword nvarchar(255),
	@MachineObjectOU nvarchar(255),
	@OSDINSTALLSILENT char(1),
	@OSDINSTALLPACKAGE nvarchar(50),
	@OSDINSTALLPROGRAM nvarchar(50),
	@OSDNEWMACHINENAME nvarchar(50),
	@ScanStateArgs nvarchar(255),
	@LoadStateArgs nvarchar(255),
	@ComputerBackupLocation nvarchar(255),
	@BackupShare nvarchar(255),
	@BackupDir nvarchar(255),
	@UserDataLocation nvarchar(255),
	@DoCapture nvarchar(50),
	@ProductKey nvarchar(255),
	@OverrideProductKey nvarchar(255),
	@WDSServer nvarchar(255),
	@CaptureGroups nvarchar(255),
	@AdminPassword nvarchar(255),
	@OrgName nvarchar(255),
	@FullName nvarchar(255),
	@TimeZone nvarchar(50),
	@TimeZoneName nvarchar(255),
	@BuildID nvarchar(50),
	@KeyboardLocale nvarchar(255),
	@InputLocale nvarchar(255),
	@UserLocale nvarchar(255),
	@UILanguage nvarchar(255),
	@Xresolution nvarchar(50),
	@Yresolution nvarchar(50),
	@BitsPerPel nvarchar(50),
	@Vrefresh nvarchar(50),
	@AreaCode nvarchar(50),
	@CountryCode nvarchar(50),
	@LongDistanceAccess nvarchar(50),
	@Dialing nvarchar(50),
	@BdeInstall nvarchar(50),
	@BdeDriveLetter nvarchar(50),
	@BdeDriveSize nvarchar(50),
	@BdePin nvarchar(50),
	@BdeRecoveryKey nvarchar(50),
	@BdeKeyLocation nvarchar(50),
	@TpmOwnerPassword nvarchar(50),
	@OSDMP nvarchar(255),
	@OSDSITECODE nvarchar(50),
	@DriverGroup nvarchar(255),
	@ServerA nvarchar(255),
	@ServerB nvarchar(255),
	@ServerC nvarchar(255),
	@ResourceRoot nvarchar(255),
	@SkipWizard nvarchar(50),
	@SkipCapture nvarchar(50),
	@SkipAdminPassword nvarchar(50),
	@SkipApplications nvarchar(50),
	@SkipAppsOnUpgrade nvarchar(50),
	@SkipComputerBackup nvarchar(50),
	@SkipDomainMembership nvarchar(50),
	@SkipComputerName nvarchar(50),
	@SkipDeploymentType nvarchar(50),
	@SkipUserData nvarchar(50),
	@SkipPackageDisplay nvarchar(50),
	@SkipLocaleSelection nvarchar(50),
	@SkipProductKey nvarchar(50),
	@SkipSummary nvarchar(50),
	@SkipFinalSummary nvarchar(50),
	@SkipBDDWelcome nvarchar(50),
	@SkipTimeZone nvarchar(50),
	@SkipBuild nvarchar(50),
	@SkipBitLocker nvarchar(50),
	@SkipBitLockerDetails nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	/* There can only be one Set of Settings per object in the Database.
	   If it doesn`t exist, we will create it */

	IF NOT EXISTS (SELECT * FROM dbo.Settings WHERE ID = @MDTID AND [Type] = @Type)
		BEGIN
		INSERT INTO dbo.Settings
		(ID,
		[Type],
		UserID,
		UserDomain,
		UserPassword,
		UDShare,
		UDDir,
		UDProfiles,
		SLShare,
		EventShare,
		OSInstall,
		ComputerName,
		Home_Page,
		JoinDomain,
		JoinWorkGroup,
		DomainAdmin,
		DomainAdminDomain,
		DomainAdminPassword,
		MachineObjectOU,
		OSDINSTALLSILENT,
		OSDINSTALLPACKAGE,
		OSDINSTALLPROGRAM,
		OSDNEWMACHINENAME,
		ScanStateArgs,
		LoadStateArgs,
		ComputerBackupLocation,
		BackupShare,
		BackupDir,
		UserDataLocation,
		DoCapture,
		ProductKey,
		OverrideProductKey,
		WDSServer,
		CaptureGroups,
		AdminPassword,
		OrgName,
		FullName,
		TimeZone,
		TimeZoneName,
		BuildID,
		KeyboardLocale,
		InputLocale,
		UserLocale,
		UILanguage,
		Xresolution,
		Yresolution,
		BitsPerPel,
		Vrefresh,
		AreaCode,
		CountryCode,
		LongDistanceAccess,
		Dialing,
		BdeInstall,
		BdeDriveLetter,
		BdeDriveSize,
		BdePin,
		BdeRecoveryKey,
		BdeKeyLocation,
		TpmOwnerPassword,
		OSDMP,
		OSDSITECODE,
		DriverGroup,
		ServerA,
		ServerB,
		ServerC,
		ResourceRoot,
		SkipWizard,
		SkipCapture,
		SkipAdminPassword,
		SkipApplications,
		SkipAppsOnUpgrade,
		SkipComputerBackup,
		SkipDomainMembership,
		SkipComputerName,
		SkipDeploymentType,
		SkipUserData,
		SkipPackageDisplay,
		SkipLocaleSelection,
		SkipProductKey,
		SkipSummary,
		SkipFinalSummary,
		SkipBDDWelcome,
		SkipTimeZone,
		SkipBuild,
		SkipBitLocker,
		SkipBitLockerDetails)
		OUTPUT Inserted.ID
		VALUES
		(@MDTID,
		@Type,
		@UserID,
		@UserDomain,
		@UserPassword,
		@UDShare,
		@UDDir,
		@UDProfiles,
		@SLShare,
		@EventShare,
		@OSInstall,
		@ComputerName,
		@Home_Page,
		@JoinDomain,
		@JoinWorkGroup,
		@DomainAdmin,
		@DomainAdminDomain,
		@DomainAdminPassword,
		@MachineObjectOU,
		@OSDINSTALLSILENT,
		@OSDINSTALLPACKAGE,
		@OSDINSTALLPROGRAM,
		@OSDNEWMACHINENAME,
		@ScanStateArgs,
		@LoadStateArgs,
		@ComputerBackupLocation,
		@BackupShare,
		@BackupDir,
		@UserDataLocation,
		@DoCapture,
		@ProductKey,
		@OverrideProductKey,
		@WDSServer,
		@CaptureGroups,
		@AdminPassword,
		@OrgName,
		@FullName,
		@TimeZone,
		@TimeZoneName,
		@BuildID,
		@KeyboardLocale,
		@InputLocale,
		@UserLocale,
		@UILanguage,
		@Xresolution,
		@Yresolution,
		@BitsPerPel,
		@Vrefresh,
		@AreaCode,
		@CountryCode,
		@LongDistanceAccess,
		@Dialing,
		@BdeInstall,
		@BdeDriveLetter,
		@BdeDriveSize,
		@BdePin,
		@BdeRecoveryKey,
		@BdeKeyLocation,
		@TpmOwnerPassword,
		@OSDMP,
		@OSDSITECODE,
		@DriverGroup,
		@ServerA,
		@ServerB,
		@ServerC,
		@ResourceRoot,
		@SkipWizard,
		@SkipCapture,
		@SkipAdminPassword,
		@SkipApplications,
		@SkipAppsOnUpgrade,
		@SkipComputerBackup,
		@SkipDomainMembership,
		@SkipComputerName,
		@SkipDeploymentType,
		@SkipUserData,
		@SkipPackageDisplay,
		@SkipLocaleSelection,
		@SkipProductKey,
		@SkipSummary,
		@SkipFinalSummary,
		@SkipBDDWelcome,
		@SkipTimeZone,
		@SkipBuild,
		@SkipBitLocker,
		@SkipBitLockerDetails)
		END
	ELSE
		BEGIN
		/* Update the set of settings */
		UPDATE dbo.Settings
		SET [Type] = @Type,
		ID = @MDTID,
		UserID = @UserID,
		UserDomain = @UserDomain,
		UserPassword = @UserPassword,
		UDShare = @UDShare,
		UDDir = @UDDir,
		UDProfiles = @UDProfiles,
		SLShare = @SLShare,
		EventShare = @EventShare,
		OSInstall = @OSInstall,
		ComputerName = @ComputerName,
		Home_Page = @Home_Page,
		JoinDomain = @JoinDomain,
		JoinWorkGroup = @JoinWorkGroup,
		DomainAdmin = @DomainAdmin,
		DomainAdminDomain = @DomainAdminDomain,
		DomainAdminPassword = @DomainAdminPassword,
		MachineObjectOU = @MachineObjectOU,
		OSDINSTALLSILENT = @OSDINSTALLSILENT,
		OSDINSTALLPACKAGE = @OSDINSTALLPACKAGE,
		OSDINSTALLPROGRAM = @OSDINSTALLPROGRAM,
		OSDNEWMACHINENAME = @OSDNEWMACHINENAME,
		ScanStateArgs = @ScanStateArgs,
		LoadStateArgs = @LoadStateArgs,
		ComputerBackupLocation = @ComputerBackupLocation,
		BackupShare = @BackupShare,
		BackupDir = @BackupDir,
		UserDataLocation = @UserDataLocation,
		DoCapture = @DoCapture,
		ProductKey = @ProductKey,
		OverrideProductKey = @OverrideProductKey,
		WDSServer = @WDSServer,
		CaptureGroups = @CaptureGroups,
		AdminPassword = @AdminPassword,
		OrgName = @OrgName,
		FullName = @FullName,
		TimeZone = @TimeZone,
		TimeZoneName = @TimeZoneName,
		BuildID = @BuildID,
		KeyboardLocale = @KeyboardLocale,
		InputLocale = @InputLocale,
		UserLocale = @UserLocale,
		UILanguage = @UILanguage,
		Xresolution = @Xresolution,
		Yresolution = @Yresolution,
		BitsPerPel = @BitsPerPel,
		Vrefresh = @Vrefresh,
		AreaCode = @AreaCode,
		CountryCode = @CountryCode,
		LongDistanceAccess = @LongDistanceAccess,
		Dialing = @Dialing,
		BdeInstall = @BdeInstall,
		BdeDriveLetter = @BdeDriveLetter,
		BdeDriveSize = @BdeDriveSize,
		BdePin = @BdePin,
		BdeRecoveryKey = @BdeRecoveryKey,
		BdeKeyLocation = @BdeKeyLocation,
		TpmOwnerPassword = @TpmOwnerPassword,
		OSDMP = @OSDMP,
		OSDSITECODE = @OSDSITECODE,
		DriverGroup = @DriverGroup,
		ServerA = @ServerA,
		ServerB = @ServerB,
		ServerC = @ServerC,
		ResourceRoot = @ResourceRoot,
		SkipWizard = @SkipWizard,
		SkipCapture = @SkipCapture,
		SkipAdminPassword = @SkipAdminPassword,
		SkipApplications = @SkipApplications,
		SkipAppsOnUpgrade = @SkipAppsOnUpgrade,
		SkipComputerBackup = @SkipComputerBackup,
		SkipDomainMembership = @SkipDomainMembership,
		SkipComputerName = @SkipComputerName,
		SkipDeploymentType = @SkipDeploymentType,
		SkipUserData = @SkipUserData,
		SkipPackageDisplay = @SkipPackageDisplay,
		SkipLocaleSelection = @SkipLocaleSelection,
		SkipProductKey = @SkipProductKey,
		SkipSummary = @SkipSummary,
		SkipFinalSummary = @SkipFinalSummary,
		SkipBDDWelcome = @SkipBDDWelcome,
		SkipTimeZone = @SkipTimeZone,
		SkipBuild = @SkipBuild,
		SkipBitLocker = @SkipBitLocker,
		SkipBitLockerDetails = @SkipBitLockerDetails
		WHERE ID = @MDTID and [Type] = @Type
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Gets the value of setting 
-- =============================================
CREATE PROCEDURE [dbo].[GetSetting] 
	@MDTID as int,
	@Setting as nvarchar(50),
	@Type as nvarchar(20)
AS
BEGIN
	SET NOCOUNT ON;

	/* First we need to check if the Requested Value exists */
	IF EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects o ON c.id = o.id 
			   WHERE o.name LIKE 'Settings' AND c.name LIKE @Setting)
		BEGIN
		/* Do some manipulation on the Type */
		IF LEN(@Type) > 0
			SET @Type = UPPER(LEFT(@Type,1))
		ELSE
			SET @Type = 'C'

		/* Ensure a Settings entry exists */
		EXECUTE dbo.AddDefaultSettings @MDTID, @Type

		/* Declare additional variables */
		DECLARE @Query as nvarchar(500)
		DECLARE @ParameterDefinition AS NVARCHAR(100)

		/* Prepare the Select statement */
		SET @Query = 'SELECT ' + @Setting + ' FROM dbo.Settings WHERE [Type] = ''' + @Type + ''' AND ID = @MDTID'
		SET @ParameterDefinition = '@MDTID INT'
		
		/* Execute the select statement including the parameter definition for the MDTID */
		EXECUTE sp_executesql @Query, @ParameterDefinition, @MDTID

		END
	ELSE
		/* Requested value does not exist. Return -1 */
		RETURN -1
			
    
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates a Setting 
-- =============================================
CREATE PROCEDURE [dbo].[SetSetting] 
	@MDTID as int,
	@Setting as nvarchar(50),
	@Value as nvarchar(255),
	@Type as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* First we need to check if the Requested Value exists */
	IF EXISTS (SELECT * FROM syscolumns c INNER JOIN sysobjects o ON c.id = o.id 
			   WHERE o.name LIKE 'Settings' AND c.name LIKE @Setting)
		BEGIN

		/* Do some manipulation on the Type */
		IF LEN(@Type) > 0
			SET @Type = UPPER(LEFT(@Type,1))
		ELSE
			SET @Type = 'C'

		/* Ensure a Settings entry exists */
		EXECUTE dbo.AddDefaultSettings @MDTID, @Type

		/* Declare additional variables */
		DECLARE @Query as nvarchar(500)
		DECLARE @ParameterDefinition AS NVARCHAR(100)

		/* Prepare the update statement */
		SET @Query = 'UPDATE dbo.Settings SET ' + @Setting + ' = ''' + @Value + ''' WHERE [Type] = ''' + @Type + ''' AND ID = @MDTID'
		SET @ParameterDefinition = '@MDTID INT'
		
		/* Execute the update statement including the parameter definition for the MDTID */
		EXECUTE sp_executesql @Query, @ParameterDefinition, @MDTID

		END
	ELSE
		/* Requested value does not exist. Return -1 */
		RETURN -1
			
    
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Settings Entry 
-- =============================================
CREATE PROCEDURE dbo.DeleteSettingsFromObject
	@MDTID as int,
	@Type as nvarchar(50) 
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	IF EXISTS (SELECT * FROM dbo.Settings WHERE ID = @MDTID AND [Type] = @Type)
		BEGIN
		DELETE FROM dbo.Settings
		WHERE ID = @MDTID
		AND [Type] = @Type
		END

END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a new Application
-- =============================================
CREATE PROCEDURE [dbo].[AddApplication]
	@Application as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	INSERT INTO dbo.ApplicationIdentity
	(Application)
	OUTPUT Inserted.ID
	VALUES
	(@Application)
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Application to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddApplicationToObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Application as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* Check if the supplied Application exists */
	/* IF EXISTS(SELECT 0 FROM dbo.ApplicationIdentity WHERE Application = @Application) - removed for publishing */
		BEGIN
		/* If object has already a Application, get maximum sequence to add new Application */
		IF EXISTS(SELECT 0 FROM dbo.Settings_Applications WHERE ID = @MDTID AND [Type] = @Type)
			BEGIN
			SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Applications WHERE ID = @MDTID AND [Type] = @Type) + 1
			
			INSERT INTO dbo.Settings_Applications
			([Type],
			 ID,
			 Sequence,
			 Applications)
			VALUES
			(@Type,
			 @MDTID,
			 @MaxSequence,
			 @Application)
			END
		ELSE
			BEGIN
			INSERT INTO dbo.Settings_Applications
			([Type],
			 ID,
			 Sequence,
			 Applications)
			VALUES
			(@Type,
			 @MDTID,
			 1,
			 @Application)
			END
		END
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Application to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddApplicationToObjectByID] 
	@MDTID as int,
	@Type as nvarchar(50),
	@ApplicationID as int
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* Check if the supplied Application exists */
	IF EXISTS(SELECT 0 FROM dbo.ApplicationIdentity WHERE ID = @ApplicationID)
		BEGIN
		DECLARE @Application as nvarchar(50)
		
		SET @Application = (SELECT Application FROM dbo.ApplicationIdentity WHERE ID = @ApplicationID)

		/* If object has already a Application, get maximum sequence to add new Application */
		IF EXISTS(SELECT 0 FROM dbo.Settings_Applications WHERE ID = @MDTID AND [Type] = @Type)
			BEGIN
			SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Applications WHERE ID = @MDTID AND [Type] = @Type) + 1
			
			INSERT INTO dbo.Settings_Applications
			([Type],
			 ID,
			 Sequence,
			 Applications)
			VALUES
			(@Type,
			 @MDTID,
			 @MaxSequence,
			 @Application)
			END
		ELSE
			BEGIN
			INSERT INTO dbo.Settings_Applications
			([Type],
			 ID,
			 Sequence,
			 Applications)
			VALUES
			(@Type,
			 @MDTID,
			 1,
			 @Application)
			END
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Application from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllApplicationsFromObject] 
	@MDTID as int,
	@Type as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Applications
	WHERE ID = @MDTID 
	AND [Type] = @Type

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Application from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeleteApplication]
	@Application as Nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Application from the Settings_Applications table */
	DELETE FROM dbo.Settings_Applications
	WHERE Applications = @Application

	/* Delete the Application from the ApplicationIdentity table */
	DELETE FROM dbo.ApplicationIdentity
	WHERE Application = @Application

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Application from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeleteApplicationByID]
	@ApplicationID as int
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Application from the Settings_Applications table */
	DELETE FROM dbo.Settings_Applications
	WHERE Applications = (SELECT Application FROM dbo.ApplicationIdentity WHERE ID = @ApplicationID)

	/* Delete the Application from the ApplicationIdentity table */
	DELETE FROM dbo.ApplicationIdentity
	WHERE ID = @ApplicationID
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Application from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteApplicationFromObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Application as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Applications
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND Applications = @Application
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Application from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteApplicationFromObjectByID] 
	@MDTID as int,
	@Type as nvarchar(50),
	@ApplicationID as int
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Applications
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND Applications = (SELECT Application FROM dbo.ApplicationIdentity 
					 WHERE ID = @ApplicationID)
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns an Application
-- =============================================
CREATE PROCEDURE [dbo].[GetApplication]
	@ApplicationID as int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Application FROM dbo.ApplicationIdentity 
	WHERE ID = @ApplicationID
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns the ApplicationID of the specified Application
-- =============================================
CREATE PROCEDURE [dbo].[GetApplicationID]
	@Application as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT ID FROM dbo.ApplicationIdentity
	WHERE Application LIKE '%' + @Application + '%'

END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns all Applications
-- =============================================
CREATE PROCEDURE [dbo].[GetApplications]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT * FROM dbo.ApplicationIdentity
END
GO

-- =============================================
-- Author:		Koster, Maik
-- Description:	Removes outdated Application Entries from Settings_Applications Table
-- =============================================
CREATE PROCEDURE [dbo].[SynchronizeApplications]
	
AS
BEGIN
	SET NOCOUNT ON;

	/* Delete all Applications from dbo.Settings_Applications
	   without an appropiate entry in ApplicationIdentiy */
	DELETE FROM dbo.Settings_Applications
	WHERE Applications NOT IN (SELECT Application FROM dbo.ApplicationIdentity)

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Updates an Application 
-- =============================================
CREATE PROCEDURE [dbo].[UpdateApplication] 
	@ApplicationID as int,
	@Application as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Check if ApplicationID exists */
	IF EXISTS (SELECT 0 FROM dbo.ApplicationIdentity WHERE ID = @ApplicationID)
		BEGIN
		/* Get the old Application */
		DECLARE @OldApplication as nvarchar(50)
		SET @OldApplication = (SELECT Application FROM dbo.ApplicationIdentity WHERE ID = @ApplicationID)

		/* Update Settings_Applications */
		UPDATE dbo.Settings_Applications
		SET Applications = @Application
		WHERE Applications = @OldApplication		

		/* Update ApplicationIdentiy to new value */
		UPDATE dbo.ApplicationIdentity
		SET Application = @Application
		WHERE ID = @ApplicationID
		
		END
	
END
GO
-- =============================================
-- Author:		Koster, Maik
-- Description:	Adds a Administrator to an MDT Object
-- =============================================
CREATE PROCEDURE [dbo].[AddAdministratorToObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Administrator as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'

	DECLARE @MaxSequence AS Int

	/* If object has already a Administrator, get maximum sequence to add new Administrator */
	IF EXISTS(SELECT 0 FROM dbo.Settings_Administrators WHERE ID = @MDTID AND [Type] = @Type)
		BEGIN
		SET @MaxSequence = (SELECT MAX(Sequence) FROM dbo.Settings_Administrators WHERE ID = @MDTID AND [Type] =  @Type) + 1
			
		INSERT INTO dbo.Settings_Administrators
		([Type],
		 ID,
		 Sequence,
		 Administrators)
		VALUES
		(@Type,
		 @MDTID,
		 @MaxSequence,
		 @Administrator)
		END
	ELSE
		BEGIN
		INSERT INTO dbo.Settings_Administrators
		([Type],
		 ID,
		 Sequence,
		 Administrators)
		VALUES
		(@Type,
		 @MDTID,
		 1,
		 @Administrator)
		END
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Administrator from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAllAdministratorsFromObject] 
	@MDTID as int,
	@Type as nvarchar(50)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Administrators
	WHERE ID = @MDTID 
	AND [Type] = @Type

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Administrator from the Database
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAdministrator]
	@Administrator as Nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;
	
	/* Delete the Administrator from the Settings_Administrators table */
	DELETE FROM dbo.Settings_Administrators
	WHERE Administrators = @Administrator

END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Deletes a Administrator from an object
-- =============================================
CREATE PROCEDURE [dbo].[DeleteAdministratorFromObject] 
	@MDTID as int,
	@Type as nvarchar(50),
	@Administrator as nvarchar(255)
AS
BEGIN
	SET NOCOUNT ON;

	/* Do some manipulation on the Type */
	IF LEN(@Type) > 0
		SET @Type = UPPER(LEFT(@Type,1))
	ELSE
		SET @Type = 'C'


	DELETE FROM dbo.Settings_Administrators
	WHERE ID = @MDTID 
	AND [Type] = @Type
	AND Administrators = @Administrator
END
GO


-- =============================================
-- Author:		Koster, Maik
-- Description:	Returns a unique list of Administrators used in the Database
-- =============================================
CREATE PROCEDURE [dbo].[GetAdministrators]
	
AS
BEGIN
	SET NOCOUNT ON;

	SELECT DISTINCT Administrators FROM dbo.Settings_Administrators
END
GO
