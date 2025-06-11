CREATE TABLE [dbo].[Fill_Mapping] (
    [FM_SEQ_ID]  INT           IDENTITY (1, 1) NOT NULL,
    [MB_SEQ_ID]  INT           NULL,
    [IBD_SEQ_ID] INT           NULL,
    [MATNO]      NVARCHAR (50) NULL,
    [MATNONAME]  NVARCHAR (50) NULL,
    [INXUNIT]    NVARCHAR (50) NULL,
    [PLANT]      NVARCHAR (50) NULL
);

