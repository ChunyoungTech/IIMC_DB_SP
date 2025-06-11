CREATE TABLE [dbo].[Use_Budget] (
    [B_Plant]                  VARCHAR (50)    NULL,
    [B_Sysname]                NVARCHAR (50)   NULL,
    [B_Shop]                   NVARCHAR (15)   NULL,
    [B_Material]               NVARCHAR (100)  NULL,
    [B_Year]                   INT             NULL,
    [B_Month]                  INT             NULL,
    [B_Budget]                 NUMERIC (9, 2)  NULL,
    [B_Date]                   INT             NULL,
    [IDD_ONLINE_INVENTORY_AMT] NUMERIC (18, 2) NULL,
    [IBD_BOOKING_LIMIT]        NUMERIC (18, 2) NULL,
    [IDD_INVENTORY_AMT]        NUMERIC (18, 2) NULL,
    [IBD_FEED_AMT]             NUMERIC (18, 2) NULL,
    [IDD_CLAC_AVG]             NUMERIC (18, 2) NULL,
    [Budget_Car]               INT             NULL,
    [cal_days]                 INT             NULL,
    [Mb_Seq_ID]                INT             NULL,
    [B_Price]                  NUMERIC (9, 3)  NULL
);

