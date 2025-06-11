CREATE TABLE [dbo].[Inventory_DailyDataLog] (
    [IDDL_SEQ_ID]              INT             IDENTITY (1, 1) NOT NULL,
    [IDD_SEQ_ID]               INT             NULL,
    [IDD_ONLINE_INVENTORY_OLD] DECIMAL (18, 2) NULL,
    [IDD_INVENTORY_OLD]        DECIMAL (18, 2) NULL,
    [IDD_ONLINE_INVENTORY_NEW] DECIMAL (18, 2) NULL,
    [IDD_INVENTORY_NEW]        DECIMAL (18, 2) NULL,
    [IDDL_REMARK]              NVARCHAR (50)   NULL,
    [UPD_DATETIME]             DATETIME        NULL,
    [UPD_USER]                 NVARCHAR (50)   NULL
);

