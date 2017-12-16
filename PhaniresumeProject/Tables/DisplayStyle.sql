CREATE TABLE [dbo].[DisplayStyle] (
    [DisplayStyleID]          INT           IDENTITY (1, 1)   NOT NULL,
    [Name]        NVARCHAR (500) NULL,
    [Description] NVARCHAR (500) NULL,
    PRIMARY KEY CLUSTERED ([DisplayStyleID] ASC)
);

