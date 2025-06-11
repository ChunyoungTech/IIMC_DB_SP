CREATE TABLE [dbo].[Inventory_BookingLog] (
    [IBL_SEQ_ID]         BIGINT       IDENTITY (1, 1) NOT NULL,
    [IBL_IDD_SEQ_ID]     BIGINT       NOT NULL,
    [IBL_IBD_SEQ_ID]     BIGINT       NOT NULL,
    [IBL_IDD_DailyDate]  DATE         NOT NULL,
    [IBL_IDD_IS_BOOKING] CHAR (1)     NOT NULL,
    [IBL_UPD_DATETIME]   DATETIME     NULL,
    [IBL_UPD_USER]       VARCHAR (50) NULL,
    CONSTRAINT [PK_Inventory_BookingLog] PRIMARY KEY CLUSTERED ([IBL_SEQ_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_Inventory_BookingLog]
    ON [dbo].[Inventory_BookingLog]([IBL_IDD_SEQ_ID] ASC);

