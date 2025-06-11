CREATE TABLE [dbo].[Inventory_ReceiptMapping] (
    [IRM_SEQ_ID]    BIGINT        IDENTITY (1, 1) NOT NULL,
    [IBD_SEQ_ID]    BIGINT        NOT NULL,
    [IRM_TYPE]      INT           CONSTRAINT [DF_Inventory_ReceiptMapping_IRM_TYPE] DEFAULT ((1)) NULL,
    [IRM_TAGNAME]   VARCHAR (100) NULL,
    [IRM_MTRL_NO]   VARCHAR (50)  NULL,
    [IRM_STOP_TIME] DATETIME      NULL,
    [UPDATE_TIME]   DATETIME      NULL,
    [UPDATE_USER]   VARCHAR (50)  NULL,
    CONSTRAINT [PK_Inventory_Receipt_] PRIMARY KEY CLUSTERED ([IRM_SEQ_ID] ASC)
);

