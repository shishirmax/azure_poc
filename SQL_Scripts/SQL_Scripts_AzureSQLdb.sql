CREATE TABLE [xmlBookDataImport] (
    [id] nvarchar(255),
    [author] nvarchar(255),
    [title] nvarchar(255),
    [genre] nvarchar(255),
    [price] decimal(28,10),
    [publish_date] datetime,
    [description] nvarchar(255),
    [ImportDate] datetime DEFAULT (getdate())
)

select * from [xmlBookDataImport]



CREATE TABLE [dbo].[pocTblWebsiteData](
	[WebsiteDataId] [bigint] IDENTITY(1,1) NOT NULL,
	[ListingId] [nvarchar](max) NULL,
	[CreatedDate] [nvarchar](max) NULL,
	[Rating] [nvarchar](max) NULL,
	[Type] [nvarchar](max) NULL,
	[WebsiteUserId] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[ModifiedDate] [datetime]  DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


drop table [pocTblWebsiteData]
select * from [pocTblWebsiteData]

truncate table [pocTblWebsiteData]

sp_help pocTblWebsiteData



CREATE TABLE dbo.emp
(
    ID int IDENTITY(1,1) NOT NULL,
    FirstName varchar(50),
    LastName varchar(50)
)
GO

CREATE CLUSTERED INDEX IX_emp_ID ON dbo.emp (ID);

select * from emp

drop table emp

select * from MarketingCampaignEffectiveness
sp_help MarketingCampaignEffectiveness



CREATE TABLE [dbo].[books](
	[book_id] [int] IDENTITY(1,1) NOT NULL,
	[book_name] [varchar](100) NOT NULL,
	[book_author] [varchar](100) NOT NULL,
	[book_isbn] [varchar](100) NOT NULL,
	[book_publisher] [varchar](100) NOT NULL,
	[book_entry_date] [datetime] DEFAULT (getdate()),
PRIMARY KEY CLUSTERED 
(
	[book_id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]


select * from books

select count(*),book_entry_date from books
group by book_entry_date


-- For Email Results Data
CREATE TABLE [dbo].[tblEmailResults](
	[EmailResultsId] [bigint] IDENTITY(1,1) NOT NULL,
	[MdmContactId] [nvarchar](max) NULL,
	[LastName] [nvarchar](max) NULL,
	[FirstName] [nvarchar](max) NULL,
	[IsActive] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NULL,
	[CampaignName] [nvarchar](max) NULL,
	[Result] [nvarchar](max) NULL,
	[ResultDate] [nvarchar](max) NULL,
	[ModifiedDate] [datetime] NULL DEFAULT (getdate())
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


