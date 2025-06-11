CREATE TABLE [dbo].[Inventory_DailyData] (
    [IDD_SEQ_ID]               BIGINT          IDENTITY (1, 1) NOT NULL,
    [IBD_SEQ_ID]               BIGINT          NOT NULL,
    [IDD_DailyDate]            DATE            NOT NULL,
    [IDD_ONLINE_INVENTORY_AMT] DECIMAL (18, 2) NULL,
    [IDD_INVENTORY_AMT]        DECIMAL (18, 2) CONSTRAINT [DF_Inventory_DailyData_IDD_INVENTORY_AMT] DEFAULT ((0)) NULL,
    [IDD_PUT_IN_AMT]           INT             NULL,
    [IDD_CHANGE_AMT]           INT             NULL,
    [IDD_CLAC_AVG]             DECIMAL (18, 2) NULL,
    [IDD_ReplacementCycle]     DECIMAL (18, 2) CONSTRAINT [DF__Inventory__IDD_R__1A74D648] DEFAULT ('0') NULL,
    [IDD_AvailableDays]        DECIMAL (18, 2) CONSTRAINT [DF__Inventory__IDD_A__1B68FA81] DEFAULT ('0') NULL,
    [UPD_DATETIME]             DATETIME        NULL,
    [UPD_USER]                 VARCHAR (50)    NULL,
    CONSTRAINT [PK_Inventory_DailyData] PRIMARY KEY CLUSTERED ([IDD_SEQ_ID] ASC)
);

