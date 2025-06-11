CREATE TABLE [dbo].[Inventory_BOM] (
    [IB_SEQ_ID]  INT           IDENTITY (1, 1) NOT NULL,
    [PLANT]      NVARCHAR (10) NOT NULL,
    [MTRL_NAME]  NVARCHAR (50) NOT NULL,
    [MTRL_NO]    NVARCHAR (20) NOT NULL,
    [IS_DISABLE] NCHAR (1)     CONSTRAINT [DF_Inventory_BOM_IS_DISABLE] DEFAULT (N'N') NOT NULL,
    [REMARK]     NVARCHAR (50) NULL,
    [UPD_DATE]   DATETIME      NULL,
    [UPD_USER]   NVARCHAR (10) NULL,
    CONSTRAINT [PK_Inventory_BOM] PRIMARY KEY CLUSTERED ([PLANT] ASC, [MTRL_NO] ASC, [MTRL_NAME] ASC)
);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<新增bom時，自動新增至2廠barcode資料庫>
-- =============================================
CREATE TRIGGER [dbo].[INSERT_BOM]
   ON  [dbo].[Inventory_BOM]
   AFTER INSERT
AS 
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @Plant varchar(50) ='';
	DECLARE @MTRL_NAME varchar(50) ='';
	DECLARE @MTRL_NO varchar(50) ='';
	
	SELECT  @Plant=B.SBO_PLANT,@MTRL_NAME=A.MTRL_NAME,@MTRL_NO=A.MTRL_NO FROM inserted A INNER JOIN SDP_Base_Org B ON A.PLANT =B.SBO_PLANT2
	
	--檢查資料庫內是否已有資料，沒有財新增
	IF NOT EXISTS (SELECT * FROM [C2C03600\SQLEXPRESS].[FAC2DB].[dbo].[Material_INFO] WHERE PLANT=@Plant AND MTRL_NAME=@MTRL_NAME AND MTRL_NO=@MTRL_NO)
	BEGIN
		INSERT INTO [C2C03600\SQLEXPRESS].[FAC2DB].[dbo].[Material_INFO]
				   ([PLANT],[MTRL_NAME],[MTRL_NO],[USER_ID],[USER])
			 VALUES  (@Plant,@MTRL_NAME,@MTRL_NO,NULL,NULL)
	END
END

GO
DISABLE TRIGGER [dbo].[INSERT_BOM]
    ON [dbo].[Inventory_BOM];

