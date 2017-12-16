﻿/*
Deployment script for C:\USERS\PAVANKUMAR\DOCUMENTS\VISUAL STUDIO 2017\PROJECTS\PHANIRESUMEAPI\PHANIRESUMEAPI\APP_DATA\PHANIRESUMEDB.MDF

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "C:\USERS\PAVANKUMAR\DOCUMENTS\VISUAL STUDIO 2017\PROJECTS\PHANIRESUMEAPI\PHANIRESUMEAPI\APP_DATA\PHANIRESUMEDB.MDF"
:setvar DefaultFilePrefix "C_\USERS\PAVANKUMAR\DOCUMENTS\VISUAL STUDIO 2017\PROJECTS\PHANIRESUMEAPI\PHANIRESUMEAPI\APP_DATA\PHANIRESUMEDB.MDF_"
:setvar DefaultDataPath "C:\Users\PavanKumar\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"
:setvar DefaultLogPath "C:\Users\PavanKumar\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
PRINT N'Dropping [dbo].[FK_DisplayResume]...';


GO
ALTER TABLE [dbo].[ResumeDetails] DROP CONSTRAINT [FK_DisplayResume];


GO
PRINT N'Dropping [dbo].[FK_CustomerResume]...';


GO
ALTER TABLE [dbo].[ResumeDetails] DROP CONSTRAINT [FK_CustomerResume];


GO
PRINT N'Starting rebuilding table [dbo].[DisplayStyle]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_DisplayStyle] (
    [DisplayStyleID] INT            IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (500) NULL,
    [Description]    NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([DisplayStyleID] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[DisplayStyle])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DisplayStyle] ON;
        INSERT INTO [dbo].[tmp_ms_xx_DisplayStyle] ([DisplayStyleID], [Name], [Description])
        SELECT   [DisplayStyleID],
                 [Name],
                 [Description]
        FROM     [dbo].[DisplayStyle]
        ORDER BY [DisplayStyleID] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_DisplayStyle] OFF;
    END

DROP TABLE [dbo].[DisplayStyle];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_DisplayStyle]', N'DisplayStyle';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Starting rebuilding table [dbo].[ResumeDetails]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [dbo].[tmp_ms_xx_ResumeDetails] (
    [ResumeDetailsId]               INT             IDENTITY (1, 1) NOT NULL,
    [CAREER OBJECTIVE]              NVARCHAR (4000) NULL,
    [HONORS AND REWARDS]            NVARCHAR (4000) NULL,
    [PROFESSIONAL RESPONSIBILITIES] NVARCHAR (4000) NULL,
    [RELATED EXPERIENCE]            NVARCHAR (4000) NULL,
    [CustomerDetailsID]             INT             NULL,
    [DisplayStyleId]                INT             NULL,
    PRIMARY KEY CLUSTERED ([ResumeDetailsId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [dbo].[ResumeDetails])
    BEGIN
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_ResumeDetails] ON;
        INSERT INTO [dbo].[tmp_ms_xx_ResumeDetails] ([ResumeDetailsId], [CAREER OBJECTIVE], [HONORS AND REWARDS], [PROFESSIONAL RESPONSIBILITIES], [RELATED EXPERIENCE], [CustomerDetailsID], [DisplayStyleId])
        SELECT   [ResumeDetailsId],
                 [CAREER OBJECTIVE],
                 [HONORS AND REWARDS],
                 [PROFESSIONAL RESPONSIBILITIES],
                 [RELATED EXPERIENCE],
                 [CustomerDetailsID],
                 [DisplayStyleId]
        FROM     [dbo].[ResumeDetails]
        ORDER BY [ResumeDetailsId] ASC;
        SET IDENTITY_INSERT [dbo].[tmp_ms_xx_ResumeDetails] OFF;
    END

DROP TABLE [dbo].[ResumeDetails];

EXECUTE sp_rename N'[dbo].[tmp_ms_xx_ResumeDetails]', N'ResumeDetails';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating [dbo].[FK_DisplayResume]...';


GO
ALTER TABLE [dbo].[ResumeDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_DisplayResume] FOREIGN KEY ([DisplayStyleId]) REFERENCES [dbo].[DisplayStyle] ([DisplayStyleID]);


GO
PRINT N'Creating [dbo].[FK_CustomerResume]...';


GO
ALTER TABLE [dbo].[ResumeDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_CustomerResume] FOREIGN KEY ([CustomerDetailsID]) REFERENCES [dbo].[CustomerDetails] ([CustomerDetailsID]);


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[ResumeDetails] WITH CHECK CHECK CONSTRAINT [FK_DisplayResume];

ALTER TABLE [dbo].[ResumeDetails] WITH CHECK CHECK CONSTRAINT [FK_CustomerResume];


GO
PRINT N'Update complete.';


GO
