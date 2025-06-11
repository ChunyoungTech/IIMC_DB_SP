CREATE TABLE [dbo].[Users] (
    [U_SEQ_ID]      INT           IDENTITY (23, 1) NOT NULL,
    [U_USER_ID]     VARCHAR (50)  NOT NULL,
    [U_PWD]         VARCHAR (50)  NULL,
    [U_USER_NAME]   VARCHAR (50)  NULL,
    [U_TEL]         VARCHAR (50)  NULL,
    [U_EMAIL]       VARCHAR (50)  NULL,
    [U_PLANT]       VARCHAR (255) NULL,
    [U_Permission]  VARCHAR (2)   NULL,
    [U_START_DATE]  DATE          NULL,
    [U_STOP_DATE]   DATE          NULL,
    [U_UPDATE_USER] VARCHAR (50)  NULL,
    [U_UPDATE_TIME] DATETIME      NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([U_USER_ID] ASC)
);

