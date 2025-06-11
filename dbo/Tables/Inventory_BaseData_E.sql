CREATE TABLE [dbo].[Inventory_BaseData_E] (
    [IBD_SEQ_ID]            INT            NOT NULL,
    [IBDE_CalcGroup]        NVARCHAR (10)  NULL,
    [IBDE_TagNO1]           NVARCHAR (50)  NULL,
    [IBDE_TAG_SITE]         INT            NULL,
    [IBDE_MaxValue]         NUMERIC (9, 2) NULL,
    [IBDE_MinValue]         NUMERIC (9, 2) NULL,
    [IBDE_SplitProprtion]   NUMERIC (9, 2) NULL,
    [IBDE_CylinderQuantity] INT            NULL
);

