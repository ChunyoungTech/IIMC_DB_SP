CREATE TABLE [dbo].[SDP_Exclusion_Date_Log] (
    [SEDL_SEQ_ID] INT           IDENTITY (1, 1) NOT NULL,
    [SED_SEQ_ID]  INT           NULL,
    [SED_PLANT]   VARCHAR (50)  NOT NULL,
    [SED_EDATE_S] DATE          NOT NULL,
    [SED_EDATE_E] DATE          NOT NULL,
    [SED_REMARK]  VARCHAR (100) NULL,
    [SED_TYPE]    VARCHAR (10)  NULL,
    [update_time] DATETIME      NULL,
    [update_user] VARCHAR (50)  NULL,
    CONSTRAINT [PK_SDP_Exclusion_Date_Log] PRIMARY KEY CLUSTERED ([SEDL_SEQ_ID] ASC)
);

