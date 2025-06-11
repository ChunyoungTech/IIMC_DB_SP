CREATE TABLE [dbo].[Remark_Table] (
    [M_SEQ_ID]      INT           NOT NULL,
    [M_Remark]      VARCHAR (255) NULL,
    [M_UPDATE_USER] VARCHAR (50)  NULL,
    [M_UPDATE_TIME] DATETIME      NULL,
    [SEQ_ID]        BIGINT        IDENTITY (1, 1) NOT NULL,
    [REMARK_TYPE]   NVARCHAR (10) NULL,
    CONSTRAINT [PK_Remark_Table] PRIMARY KEY CLUSTERED ([SEQ_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Remark_Table]
    ON [dbo].[Remark_Table]([M_SEQ_ID] ASC);

