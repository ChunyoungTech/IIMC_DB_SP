CREATE TABLE [dbo].[SDP_Order_Master] (
    [IBD_SEQ_ID]        BIGINT         NULL,
    [SEQ_ID]            INT            IDENTITY (1, 1) NOT NULL,
    [SOM_PLANT]         VARCHAR (10)   NOT NULL,
    [SOM_BOM]           VARCHAR (50)   NOT NULL,
    [SOM_ORDER_QTY]     INT            NOT NULL,
    [SOM_ORDER_UNIT]    VARCHAR (50)   NOT NULL,
    [SOM_DELIVERY_DATE] DATETIME       NOT NULL,
    [SOM_STATUS]        VARCHAR (50)   NOT NULL,
    [SOM_SDP_NO]        VARCHAR (50)   NULL,
    [SOM_REMARK]        NVARCHAR (100) NULL,
    [SOM_USER]          NVARCHAR (50)  NOT NULL,
    [SOM_TYPE]          VARCHAR (50)   NOT NULL,
    [SOM_CANCEL_ID]     INT            NULL,
    [SOM_CANCEL_REMARK] VARCHAR (100)  NULL,
    [SOM_CLOSE_ID]      INT            NULL,
    [SOM_CLOSE_REMARK]  VARCHAR (100)  NULL,
    [update_user]       NVARCHAR (50)  NULL,
    [update_time]       DATETIME       NULL,
    CONSTRAINT [PK_SDP_Order_Master] PRIMARY KEY CLUSTERED ([SEQ_ID] ASC)
);

