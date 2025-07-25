﻿CREATE TABLE [dbo].[SDP_VW_ASN_DATA_GCIC] (
    [CALLED_NO]       VARCHAR (30)  NOT NULL,
    [ASN_NO]          VARCHAR (32)  NOT NULL,
    [CAR_NO]          VARCHAR (200) NULL,
    [IMPORT_NO]       VARCHAR (32)  NULL,
    [INVOICE_DATE]    VARCHAR (16)  NULL,
    [MATERIAL_NO]     VARCHAR (18)  NULL,
    [PLANT]           VARCHAR (10)  NULL,
    [SHIP_QTY]        FLOAT (53)    NULL,
    [TOT_BOXES]       FLOAT (53)    NULL,
    [TOT_PLATE]       FLOAT (53)    NULL,
    [TRANS_TYPES]     VARCHAR (30)  NULL,
    [UPL_LOT]         VARCHAR (50)  NULL,
    [UPL_PALLET]      VARCHAR (50)  NULL,
    [UPL_PO_LINE]     VARCHAR (5)   NULL,
    [UPL_PO_NO]       VARCHAR (20)  NULL,
    [VDR_SHIPPING_NO] VARCHAR (32)  NULL,
    [VENDOR_CODE]     VARCHAR (30)  NULL,
    [VENDOR_NAME]     VARCHAR (240) NULL,
    CONSTRAINT [PK_SDP_VW_ASN_DATA_GCIC] PRIMARY KEY CLUSTERED ([CALLED_NO] ASC, [ASN_NO] ASC)
);

