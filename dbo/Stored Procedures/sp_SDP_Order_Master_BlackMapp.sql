




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<當點選鋼瓶黑名單作業中的同步時，呼叫此預存程序，對所有GCIC群組發送MAPP通知>
-- =============================================
 CREATE PROCEDURE [dbo].[sp_SDP_Order_Master_BlackMapp]
	@plant nvarchar(10)
AS
BEGIN


	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC01',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')

	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC02',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC03',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC04',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC05',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC06',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC07',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC08',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FAC08B',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FACL6',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	
	INSERT INTO [FAC_MAPP_DB].[dbo].[MApp_Table] ([MApp_No],[MApp_Plant],[MApp_Date],[MApp_Time],[MApp_Value1],[MApp_Value2],[MApp_Value3],[MApp_Sec],[MApp_Type],[MApp_Ack_Flag],[MApp_Provider])
	VALUES ('33333','FACL ',convert(varchar(10),GETDATE(),111),convert(varchar(8),GETDATE(),114),'','請更新條碼機資料庫',@plant+'有新增鋼瓶黑名單','0','GCI','N','GCIC叫料系統')
	

END
