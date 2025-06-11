CREATE TABLE [dbo].[MappMessage] (
    [MM_SEQ_ID]         INT             IDENTITY (1, 1) NOT NULL,
    [MS_SYS_NAME]       VARCHAR (50)    NOT NULL,
    [MM_CONTENT_TYPE]   INT             NOT NULL,
    [MM_TEXT_CONTENT]   NVARCHAR (4000) NULL,
    [MM_MEDIA_CONTENT]  VARBINARY (MAX) NULL,
    [MM_FILE_SHOW_NAME] VARCHAR (50)    NULL,
    [MM_SENDED_FLAG]    CHAR (1)        NULL,
    [UPDATE_USER]       INT             NULL,
    [UPDATE_TIME]       DATETIME        NULL,
    [MM_TYPE]           CHAR (1)        NULL,
    [MM_SendToOA]       CHAR (1)        NULL,
    [MM_SyncFromOA]     CHAR (1)        NULL,
    [MM_subject]        NVARCHAR (50)   NULL,
    [MM_ExtFileName]    VARCHAR (10)    NULL,
    [MM_TRANS_NAME]     NVARCHAR (50)   NULL,
    [MM_FLAG]           CHAR (1)        CONSTRAINT [DF_MappMessage_MM_FLAG] DEFAULT ('N') NULL
);

