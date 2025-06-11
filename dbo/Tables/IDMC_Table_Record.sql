CREATE TABLE [dbo].[IDMC_Table_Record] (
    [IR_SEQ_ID]      INT           IDENTITY (1, 1) NOT NULL,
    [IR_Date]        NVARCHAR (10) NULL,
    [IR_Time]        NVARCHAR (8)  NULL,
    [IR_Tag]         VARCHAR (255) NULL,
    [IR_OValue]      VARCHAR (255) NULL,
    [IR_NValue]      VARCHAR (255) NULL,
    [IR_UPDATE_USER] VARCHAR (50)  NULL,
    [IR_UPDATE_TIME] DATETIME      NULL
);

