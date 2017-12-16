CREATE TABLE [dbo].[CustomerDetails] (
    [CustomerDetailsID]          INT            IDENTITY (1, 1) NOT NULL,
    [FirstName]   NVARCHAR (500) NULL,
    [LastName]    NVARCHAR (500) NULL,
    [phoneNumber] NVARCHAR (50)  NULL,
    [Zipcode]     NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([CustomerDetailsID] ASC)
);