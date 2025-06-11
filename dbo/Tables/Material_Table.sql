CREATE TABLE [dbo].[Material_Table] (
    [M_Seq_ID]             INT             IDENTITY (74259, 1) NOT NULL,
    [M_Date]               DATE            NOT NULL,
    [MB_SEQ_ID]            INT             NOT NULL,
    [M_Amount]             DECIMAL (18, 5) CONSTRAINT [DF_Material_Table_M_Amount] DEFAULT ((0)) NOT NULL,
    [M_CalcFlag]           CHAR (1)        NULL,
    [M_UploadFlag]         CHAR (1)        NULL,
    [M_HiLimit]            VARCHAR (50)    NULL,
    [M_LoLimit]            VARCHAR (50)    NULL,
    [M_MenuFlag]           CHAR (1)        NULL,
    [M_MenuRemark]         NVARCHAR (500)  CONSTRAINT [DF_Material_Table_M_MenuRemark] DEFAULT ('') NULL,
    [M_UPDATE_USER]        VARCHAR (50)    NULL,
    [M_UPDATE_TIME]        DATETIME        NULL,
    [M_FillingQty]         INT             CONSTRAINT [DF_Material_Table_M_FillingQty] DEFAULT ((0)) NULL,
    [M_TotalTransferPara]  DECIMAL (9, 4)  NULL,
    [M_WeightTransferPara] DECIMAL (9, 4)  NULL,
    [M_UnitTransferPara]   DECIMAL (9, 4)  NULL,
    [M_RegenerationQty]    INT             NULL,
    [M_TotalQty]           DECIMAL (18, 2) NULL,
    [M_TotalPara]          DECIMAL (9, 2)  NULL,
    [M_Price]              DECIMAL (9, 3)  CONSTRAINT [DF_Material_Table_M_Pricr] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_Material_Table] PRIMARY KEY CLUSTERED ([M_Date] ASC, [MB_SEQ_ID] ASC)
);

