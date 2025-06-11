CREATE TABLE [dbo].[IDMC_Table_Temp] (
    [I_DATE]         DATE            NOT NULL,
    [TM_SEQ_ID]      INT             NOT NULL,
    [MB_SEQ_ID]      INT             NOT NULL,
    [TM_TYPE_ID]     INT             NOT NULL,
    [TM_TAG_NAME]    VARCHAR (100)   NOT NULL,
    [TM_TAG_DESC]    VARCHAR (100)   NULL,
    [TM_TAG_SITE]    INT             NULL,
    [TM_TAG1_ID]     VARCHAR (200)   NULL,
    [TM_TAG_DEFAULT] DECIMAL (18, 4) NULL,
    [TM_TYPE_OF]     INT             NULL
);

