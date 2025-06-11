-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- 每日庫存計量
-- =============================================
CREATE PROCEDURE [dbo].[sp_DailyInventory]
	@strPlant as varchar(10),	/*廠區 TT01~T006*/
	@strDate as varchar(8),		/*計算日期 20190101 */
	@strUser as varchar(50)		/*使用者 system*/
AS
BEGIN
	--declare @strPlant as varchar(10)=''
	--declare @strDate as varchar(8)='20240325'
	--declare @strUser as varchar(50)='system'

	declare @strError nvarchar(max)='';
	declare @strSettlementDate varchar(8)=convert(varchar(8),DateAdd(day,-1,convert(date,@strDate)),112);
	declare @intSettingDays int=6;
	declare @intDefaultDays int=0;
	declare @strDateS varchar(10)=convert(varchar(10),DateAdd(day,@intDefaultDays-@intSettingDays,convert(date,@strSettlementDate)),111)
	declare @strDateE varchar(10)=convert(varchar(10),DateAdd(day,@intDefaultDays,convert(date,@strSettlementDate)),111)


	--SELECT @strDate,@strSettlementDate,@strDateS,@strDateE


	/* 新增庫存主檔 */
	BEGIN TRY

		DELETE IDD FROM  Inventory_DailyData IDD INNER JOIN Inventory_BaseData IBD ON IDD.IBD_SEQ_ID=IBD.IBD_SEQ_ID AND IDD_DailyDate=@strDate AND IBD_PLANT=CASE WHEN @strPlant<>'' THEN @strPlant ELSE  IBD_PLANT END
		
		INSERT INTO Inventory_DailyData (IBD_SEQ_ID
			,IDD_DailyDate --庫存日期
			,IDD_ONLINE_INVENTORY_AMT	--線上庫存量
			,IDD_INVENTORY_AMT	--庫存量
			,IDD_PUT_IN_AMT		--昨日入料量
			,IDD_CHANGE_AMT		--昨入更換量
			,IDD_CLAC_AVG		--平均用量
			,UPD_DATETIME		--更新日期
			,UPD_USER)			--更新者
		SELECT IBD_SEQ_ID
				,convert(varchar(10),@strDate,120)
				,0
				,0
				,0
				,0
				,0
				,getdate()
				,@strUser
		FROM Inventory_BaseData WHERE IBD_PLANT=CASE WHEN @strPlant<>'' THEN @strPlant ELSE  IBD_PLANT END
		
	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))
		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_DailyInventory','新增庫存主檔',@strError,getdate())
	END CATCH 


	/* 計算桶槽線上庫存 */		
	BEGIN TRY

		--CDSS
		UPDATE IDD SET IDD_ONLINE_INVENTORY_AMT=Q.INVENTORY_AMT
		FROM Inventory_DailyData IDD 
		INNER JOIN Inventory_BaseData IBD ON IDD.IBD_SEQ_ID=IBD.IBD_SEQ_ID
		INNER JOIN (--桶槽7點液位
			select I_Plant,IBD_SEQ_ID as IBD_SeqId,round(SUM(CAST(IT.I_Value1 as decimal(18,2))),0) as INVENTORY_AMT --取7:00:00庫存
				from (
						select distinct I_Plant,I_Tag1,(CASE WHEN COALESCE(TRY_CAST(I_Value1 AS NUMERIC),0)=0 THEN 0 ELSE COALESCE(TRY_CAST(I_Value1 AS decimal(9,2)),0)*COALESCE(TRY_CAST(I_Value5 AS decimal(9,2)),1) END) as I_Value1
						from IDMC_Table as IT
						where convert(varchar(10),IT.I_Date,112)=@strDate and I_Type ='S'
				) as IT 	inner join Inventory_ReceiptMapping as IRM on IRM.IRM_MTRL_NO=IT.I_Tag1
				group by I_Plant,IBD_SEQ_ID
		) as Q on Q.IBD_SeqId=IBD.IBD_SEQ_ID
		WHERE IBD.IBD_TYPE in ('桶槽') AND IDD.IDD_DailyDate=@strDate AND IBD_PLANT=CASE WHEN @strPlant<>'' THEN @strPlant ELSE  IBD_PLANT END
	
	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))
		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_DailyInventory','計算桶槽庫存',@strError,getdate())
	END CATCH 


	/* 計算桶槽 平均用量 */
	BEGIN TRY
		UPDATE IDD SET IDD_CLAC_AVG=case when I_COEF=0 then V2.I_Value/ROUND(1*TransferPara,2) else V2.I_Value/ROUND(I_COEF*TransferPara,2) end,--平均用量
					   IDD_INVENTORY_AMT= case when I_COEF=0 then ROUND(1*TransferPara,2) else ROUND(I_COEF*TransferPara,2) end  --,桶槽面積
		--UPDATE IDD SET IDD_CLAC_AVG=V2.I_Value/ROUND(I_COEF*TransferPara,2),IDD_INVENTORY_AMT=ROUND(I_COEF*TransferPara,2) --平均用量,桶槽面積
		--SELECT IBD.IBD_PLANT,IBD.IBD_SYSTEM,IBD.IBD_MATERIAL,V2.I_Value, ROUND(I_COEF*TransferPara,2)I_COEF
		FROM Inventory_DailyData AS IDD 
			INNER JOIN Inventory_BaseData as IBD on IBD.IBD_SEQ_ID=IDD.IBD_SEQ_ID
			INNER JOIN (--桶槽面積
				SELECT DISTINCT IRM.IBD_SEQ_ID, IT.I_Date, IT.I_Tag1,ROUND((COALESCE(TRY_CAST(IT.I_Value2 AS NUMERIC),0)/2)*(COALESCE(TRY_CAST(IT.I_Value2 AS NUMERIC),0)/2)*3.1415/1000,2) I_COEF 
				FROM IDMC_Table IT INNER JOIN Inventory_ReceiptMapping IRM
				ON IT.I_Tag1=IRM.IRM_MTRL_NO
				WHERE IT.I_Date = @strDate
			)V1 ON IDD.IBD_SEQ_ID=V1.IBD_SEQ_ID AND IDD.IDD_DailyDate=V1.I_DATE
			INNER JOIN (--七日平均用量,比重係數
				SELECT PLANT,MB_Shop,MB_Sysname,MB_CName,AVG(M_Amount) I_Value,MAX(M_WeightTransferPara) TransferPara
				FROM Material_Base_Data MB INNER JOIN Material_Table MT ON MB.MB_Seq_ID=MT.MB_SEQ_ID
				WHERE MB_IsFilling='Y'
				AND M_Date BETWEEN @strDateS AND @strDateE
				GROUP BY PLANT,MB_Shop,MB_Sysname,MB_CName
			--)V2 ON IBD.IBD_PLANT=V2.PLANT AND IBD.IBD_SYSTEM=V2.MB_Sysname AND IBD.IBD_MATERIAL=V2.MB_CName
			)V2 ON IBD.IBD_PLANT=V2.PLANT AND REPLACE(IBD.IBD_SYSTEM,'~','')=REPLACE(V2.MB_Sysname,'~','') AND IBD.IBD_MATERIAL=V2.MB_CName
		WHERE  IDD.IDD_DailyDate= @strDate  AND IBD.IBD_PLANT=CASE WHEN @strPlant<>'' THEN @strPlant ELSE  IBD.IBD_PLANT END

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))
		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_DailyInventory','計算桶槽 平均用量',@strError,getdate())
	END CATCH 

END
