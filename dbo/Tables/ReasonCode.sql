CREATE TABLE [dbo].[ReasonCode] (
    [RC_SeqID]      BIGINT        IDENTITY (1, 1) NOT NULL,
    [RC_ReasonType] CHAR (2)      NOT NULL,
    [RC_ReasonName] NVARCHAR (50) NOT NULL,
    [RC_CreateTime] DATETIME      NULL,
    [RC_CreateUser] VARCHAR (50)  NULL,
    [RC_UpdateTime] DATETIME      NULL,
    [RC_UpdateUser] VARCHAR (50)  NULL,
    CONSTRAINT [PK_ReasonCode] PRIMARY KEY CLUSTERED ([RC_ReasonType] ASC, [RC_ReasonName] ASC)
);

