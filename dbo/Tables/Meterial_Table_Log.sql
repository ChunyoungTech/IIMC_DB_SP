CREATE TABLE [dbo].[Meterial_Table_Log] (
    [ML_SEQ_ID]      INT             IDENTITY (1, 1) NOT NULL,
    [M_SEQ_ID]       INT             NOT NULL,
    [ML_Amount]      DECIMAL (18, 5) NULL,
    [ML_MenuRemark]  NVARCHAR (500)  NULL,
    [ML_UPDATE_USER] INT             NULL,
    [ML_UPDATE_TIME] DATETIME        NULL,
    CONSTRAINT [PK_Meterial_Table_Log] PRIMARY KEY CLUSTERED ([ML_SEQ_ID] ASC)
);

