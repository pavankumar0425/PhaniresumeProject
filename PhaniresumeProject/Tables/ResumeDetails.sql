CREATE TABLE [dbo].[ResumeDetails] (
    [CAREER OBJECTIVE]              NVARCHAR (4000) NULL,
    [HONORS AND REWARDS]            NVARCHAR (4000) NULL,
    [PROFESSIONAL RESPONSIBILITIES] NVARCHAR (4000) NULL,
    [RELATED EXPERIENCE]            NVARCHAR (4000) NULL,
    [CustomerDetailsID]             INT         not  NULL,
	[DisplayStyleId]                 INT        not  NULL,
	[ResumeDetailsId]               INT         IDENTITY (1, 1)  NOT NULL,
	CONSTRAINT [pk_ResumeDetails] PRIMARY KEY clustered
	(	[ResumeDetailsId] asc
	)with (PAD_Index =off, Statistics_Norecompute=off ,Ignore_dup_key =off, Allow_row_locks =on, Allow_Page_locks = on ) on [Primary]
) on [primary]

go

Alter table [dbo].[resumeDetails] with check add constraint [FK_ResumeDetail_Customer] foreign key ([CustomerDetailsID])
references [dbo].CustomerDetails([CustomerDetailsID])
go

Alter table [dbo].[resumeDetails] check constraint [FK_ResumeDetail_Customer]
go


Alter table [dbo].[resumeDetails] with check add constraint [FK_ResumeDetail_Display] foreign key ([DisplayStyleId])
references [dbo].[DisplayStyle]([DisplayStyleId])
go

Alter table  [dbo].[resumeDetails] check constraint [FK_ResumeDetail_Display]


