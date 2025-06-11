CREATE TABLE [dbo].[ItemNumberCorresponding] (
    [INC_SerialNo]   BIGINT       IDENTITY (118, 1) NOT NULL,
    [INC_SeqID]      INT          NOT NULL,
    [INC_MATNO]      VARCHAR (50) NOT NULL,
    [INC_ActiveFlag] CHAR (1)     NOT NULL,
    [INC_CreatUser]  VARCHAR (50) NULL,
    [INC_CreatTime]  DATETIME     NULL,
    [INC_UpdateUser] VARCHAR (50) NULL,
    [INC_UpdateTime] DATETIME     NULL
);

