CREATE TABLE [dbo].[Budget_Table] (
    [B_Plant]  NVARCHAR (10)  NOT NULL,
    [B_Year]   INT            NOT NULL,
    [B_Month]  INT            NOT NULL,
    [B_Budget] NUMERIC (9, 2) CONSTRAINT [DF_Budget_Table_B_Budget] DEFAULT ((0)) NOT NULL
);

