CREATE TABLE [dbo].[Material_Receipt] (
    [PLANT]        VARCHAR (MAX)  NULL,
    [USER]         NVARCHAR (MAX) NULL,
    [USER_ID]      VARCHAR (MAX)  NULL,
    [MTRL_GRP]     NVARCHAR (MAX) NULL,
    [MTRL_NAME]    NVARCHAR (MAX) NULL,
    [WORK_TYPE]    NVARCHAR (MAX) NULL,
    [OPE_DATE]     DATETIME       NULL,
    [ASN_NO]       VARCHAR (MAX)  NULL,
    [MTRL_NO]      VARCHAR (MAX)  NULL,
    [LOT_NO]       VARCHAR (MAX)  NULL,
    [LORRY_NO]     VARCHAR (MAX)  NULL,
    [LORRY_VOL]    VARCHAR (MAX)  NULL,
    [CCB]          NVARCHAR (MAX) NULL,
    [CYL_NO]       VARCHAR (MAX)  NULL,
    [STORAGE_AREA] NVARCHAR (MAX) NULL,
    [UNIT_NO]      NVARCHAR (MAX) NULL,
    [UP_DATE]      DATETIME       NULL,
    [USE_DATE]     DATETIME       NULL,
    [NET_WEIGHT]   INT            NULL
);

