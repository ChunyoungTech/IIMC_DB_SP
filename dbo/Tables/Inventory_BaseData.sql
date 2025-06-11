CREATE TABLE [dbo].[Inventory_BaseData] (
    [IBD_SEQ_ID]             BIGINT          IDENTITY (1, 1) NOT NULL,
    [IBD_PLANT]              NVARCHAR (15)   NOT NULL,
    [IBD_SHOP]               NVARCHAR (15)   NULL,
    [IBD_SYSTEM]             NVARCHAR (50)   NOT NULL,
    [IBD_MATERIAL]           NVARCHAR (100)  NOT NULL,
    [IBD_MATERIAL2]          NVARCHAR (100)  NULL,
    [IBD_BOM_NO]             VARCHAR (50)    NULL,
    [IBD_TYPE]               NVARCHAR (50)   NOT NULL,
    [IBD_CLAC_TYPE]          CHAR (1)        CONSTRAINT [DF_Inventory_BaseData_IBD_CLAC_TYPE] DEFAULT ('A') NOT NULL,
    [IBD_UNIT]               NVARCHAR (50)   NOT NULL,
    [IBD_TANK_CAPACITY]      INT             NULL,
    [IBD_TANK_AMT]           INT             CONSTRAINT [DF_Inventory_BaseData_IBD_TANK_AMT] DEFAULT ((0)) NULL,
    [IBD_FEED_AMT]           INT             CONSTRAINT [DF_Inventory_BaseData_IBD_FEED_AMT] DEFAULT ((0)) NULL,
    [IBD_MAX_LIMIT]          DECIMAL (18, 2) CONSTRAINT [DF_Inventory_BaseData_IBD_MAX_LIMIT] DEFAULT ((0)) NULL,
    [IBD_BOOKING_LIMIT]      DECIMAL (18, 2) CONSTRAINT [DF_Inventory_BaseData_IBD_BOOKING_LIMIT] DEFAULT ((0)) NOT NULL,
    [IBD_TRANSFER_PARA]      DECIMAL (18, 2) NULL,
    [IBD_NUIT_TRANSFER_PARA] DECIMAL (18, 4) CONSTRAINT [DF_Inventory_BaseData_IBD_NUIT_TRANSFER_PARA] DEFAULT ((1)) NOT NULL,
    [IBD_InitialStock]       DECIMAL (18, 2) CONSTRAINT [DF__Inventory__IBD_I__43ABF605] DEFAULT ((0)) NULL,
    [IBD_MEMO]               NVARCHAR (MAX)  CONSTRAINT [DF__Inventory__IBD_M__7DD8979A] DEFAULT ('') NULL,
    [IBD_WATER_VOL]          DECIMAL (18, 2) CONSTRAINT [DF_Inventory_BaseData_IBD_WATER_VOL] DEFAULT ((1)) NULL,
    [IBD_FAB_UNIT]           NVARCHAR (50)   NULL,
    [IBD_PackingUnit]        NVARCHAR (50)   CONSTRAINT [DF__Inventory__IBD_P__7BF04F28] DEFAULT ('') NULL,
    [IBD_AUTO_ORDER]         CHAR (1)        CONSTRAINT [DF_Inventory_BaseData_IBD_AUTO_ORDER] DEFAULT ('Y') NULL,
    [IBD_ONLINE]             CHAR (1)        CONSTRAINT [DF_Inventory_BaseData_IBD_ONLINE] DEFAULT ('N') NOT NULL,
    [IBD_TAG_SITE]           INT             NULL,
    [IBD_CylinderQuantity]   INT             NULL,
    [IBD_MaxValue]           DECIMAL (18, 2) NULL,
    [IBD_MinValue]           DECIMAL (18, 2) NULL,
    [IBD_DelayDay]           INT             CONSTRAINT [DF_Inventory_BaseData_IBD_DelayDay] DEFAULT ((0)) NULL,
    [UPD_DATETIME]           DATETIME        NULL,
    [UPD_USER]               VARCHAR (50)    NULL,
    CONSTRAINT [PK_Inventory_BaseData] PRIMARY KEY CLUSTERED ([IBD_SEQ_ID] ASC)
);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[Inventory_BaseData_TRIGGER] ON  dbo.Inventory_BaseData AFTER UPDATE
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

INSERT INTO [Inventory_BaseDataLog]
           ([IBDL_IBD_SEQ_ID]
           ,[IBDL_PLANT]
           ,[IBDL_SYSTEM]
           ,[IBDL_MATERIAL]
           ,[IBDL_BOM_NO]
           ,[IBDL_TYPE]
           ,[IBDL_CLAC_TYPE]
           ,[IBDL_UNIT]
           ,[IBDL_TANK_CAPACITY]
           ,[IBDL_TANK_AMT]
           ,[IBDL_FEED_AMT]
           ,[IBDL_MAX_LIMIT]
           ,[IBDL_BOOKING_LIMIT]
           ,[IBDL_TRANSFER_PARA]
           ,[IBDL_NUIT_TRANSFER_PARA]
           ,[IBDL_InitialStock]
           ,[IBDL_MEMO]
           ,[IBDL_WATER_VOL]
           ,[IBDL_FAB_UNIT]
           ,[IBDL_PackingUnit]
           ,[IBDL_AUTO_ORDER]
           ,[IBDL_ONLINE]
           ,[IBDL_TAG_SITE]
           ,[IBDL_CylinderQuantity]
           ,[IBDL_MaxValue]
           ,[IBDL_MinValue]
           ,[IBDL_DelayDay]
           ,[IBDL_UPD_DATETIME]
           ,[IBDL_UPD_USER])
SELECT [IBD_SEQ_ID]
      ,[IBD_PLANT]
      ,[IBD_SYSTEM]
      ,[IBD_MATERIAL]
      ,[IBD_BOM_NO]
      ,[IBD_TYPE]
      ,[IBD_CLAC_TYPE]
      ,[IBD_UNIT]
      ,[IBD_TANK_CAPACITY]
      ,[IBD_TANK_AMT]
      ,[IBD_FEED_AMT]
      ,[IBD_MAX_LIMIT]
      ,[IBD_BOOKING_LIMIT]
      ,[IBD_TRANSFER_PARA]
      ,[IBD_NUIT_TRANSFER_PARA]
      ,[IBD_InitialStock]
      ,[IBD_MEMO]
      ,[IBD_WATER_VOL]
      ,[IBD_FAB_UNIT]
      ,[IBD_PackingUnit]
      ,[IBD_AUTO_ORDER]
      ,[IBD_ONLINE]
      ,[IBD_TAG_SITE]
      ,[IBD_CylinderQuantity]
      ,[IBD_MaxValue]
      ,[IBD_MinValue]
      ,[IBD_DelayDay]
      ,[UPD_DATETIME]
      ,[UPD_USER]
  FROM [Inventory_BaseData]
  where [IBD_SEQ_ID]= (SELECT [IBD_SEQ_ID] FROM inserted)


END
