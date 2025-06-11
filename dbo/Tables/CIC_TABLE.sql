CREATE TABLE [dbo].[CIC_TABLE] (
    [UPDATETIME] DATETIME      NOT NULL,
    [I_Date]     DATE          NOT NULL,
    [I_Time]     TIME (0)      NOT NULL,
    [I_Plant]    VARCHAR (10)  NOT NULL,
    [I_Tag]      VARCHAR (255) NOT NULL,
    [I_Value]    VARCHAR (255) NULL,
    [SEQ_ID]     INT           IDENTITY (1, 1) NOT NULL
);

