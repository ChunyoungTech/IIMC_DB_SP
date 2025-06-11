CREATE TABLE [dbo].[Material_Base_Data] (
    [MB_Seq_ID]             INT             IDENTITY (1, 1) NOT NULL,
    [MB_Plant]              VARCHAR (10)    NOT NULL,
    [MB_Shop]               VARCHAR (15)    NOT NULL,
    [MB_Sysname]            VARCHAR (15)    NOT NULL,
    [MB_CName]              NVARCHAR (50)   NOT NULL,
    [MB_spName]             NVARCHAR (50)   NULL,
    [MB_Unit]               VARCHAR (50)    NULL,
    [MB_HiLimit]            VARCHAR (50)    NULL,
    [MB_LoLimit]            VARCHAR (50)    NULL,
    [MB_LinkHtml]           VARCHAR (50)    NULL,
    [MB_DESC]               NVARCHAR (500)  NULL,
    [MB_UnitTransferPara]   DECIMAL (9, 4)  CONSTRAINT [DF_Material_Base_Data_MB_UnitTransferPara] DEFAULT ((1)) NULL,
    [MB_UnitTransferDesc]   NVARCHAR (500)  CONSTRAINT [DF_Material_Base_Data_MB_UnitTransferDesc] DEFAULT ('') NULL,
    [MB_IsVisable]          CHAR (1)        CONSTRAINT [DF_Material_Base_Data_MB_IsVisable] DEFAULT ('Y') NULL,
    [MB_TotalTransferPara]  DECIMAL (9, 4)  NULL,
    [MB_TotalTransferDesc]  NVARCHAR (500)  NULL,
    [MB_WeightTransferPara] DECIMAL (9, 4)  NULL,
    [MB_IsMaster]           CHAR (1)        CONSTRAINT [DF_Material_Base_Data_MB_IsMaster] DEFAULT ('N') NULL,
    [MB_Upper]              INT             NULL,
    [MB_Cost]               INT             NULL,
    [MB_Plant_T]            NVARCHAR (100)  NULL,
    [PLANT]                 NCHAR (4)       NULL,
    [MB_UPDATE_USER]        VARCHAR (50)    NULL,
    [MB_UPDATE_TIME]        DATETIME        NULL,
    [MB_DECIMAL_BITS]       INT             CONSTRAINT [DF_Material_Base_Data_MB_DECIMAL_BITS] DEFAULT ((0)) NOT NULL,
    [MB_IsManual]           CHAR (1)        CONSTRAINT [DF_Material_Base_Data_MB_IsManual] DEFAULT ('Y') NULL,
    [MB_IsFilling]          CHAR (1)        NOT NULL,
    [MB_tagname]            VARCHAR (50)    NULL,
    [MB_material_no]        VARCHAR (50)    NULL,
    [MATNO]                 VARCHAR (20)    NULL,
    [MB_ShowMAX]            CHAR (1)        CONSTRAINT [DF_Material_Base_Data_MB_ShowMAX] DEFAULT ('N') NOT NULL,
    [MB_LimitType]          CHAR (1)        CONSTRAINT [DF_Material_Base_Data_MB_LimitType] DEFAULT ('P') NULL,
    [MB_HiLimitValue]       DECIMAL (18, 3) CONSTRAINT [DF_Material_Base_Data_MB_HiLimitValue] DEFAULT ((0)) NULL,
    [MB_LoLimitValue]       DECIMAL (18, 3) CONSTRAINT [DF_Material_Base_Data_MB_LoLimitValue] DEFAULT ((0)) NULL,
    [MB_Price]              DECIMAL (9, 3)  CONSTRAINT [DF_Material_Base_Data_MB_Price] DEFAULT ((0)) NOT NULL,
    [MB_IsUse]              CHAR (1)        NOT NULL,
    CONSTRAINT [PK_Material_Table_Base] PRIMARY KEY CLUSTERED ([MB_Plant] ASC, [MB_Shop] ASC, [MB_Sysname] ASC, [MB_CName] ASC, [MB_IsUse] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'警示色類別，Avg是指與前三十日平均比對，Limit是上下限值比對', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Material_Base_Data', @level2type = N'COLUMN', @level2name = N'MB_LimitType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Limit警示上限值', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Material_Base_Data', @level2type = N'COLUMN', @level2name = N'MB_HiLimitValue';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Limit警示下限值', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Material_Base_Data', @level2type = N'COLUMN', @level2name = N'MB_LoLimitValue';

