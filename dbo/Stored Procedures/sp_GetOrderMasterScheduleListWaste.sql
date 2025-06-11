



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- ex. exec dbo.sp_GetOrderMasterScheduleList 'FAB2','2','','2019/06/09','0'
-- =============================================

CREATE PROCEDURE [dbo].[sp_GetOrderMasterScheduleListWaste]
	@strDate as varchar(10),		/*計算日期*/
	@intWeek as int,				/*計算週別*/
	@intBOM as varchar(10)					/*計算週別*/
AS
BEGIN
	--declare @strDate as varchar(10)='2020-01-13'
	--declare @intWeek as int=0
	declare @strError nvarchar(max)='';

	declare @intDayWeek int;			/*傳回日期的星期幾*/
	declare @strCalDate smalldatetime;	/*排程計算日期*/
	declare @strDateS smalldatetime;	/*計算起始日期*/
	declare @strWeekDate smalldatetime;

	declare @intRow int=0;				/*計算筆數*/
	declare @intDay int=27				/*排程天數*/
	declare	@strRowDate as varchar(10)  /*迴圈計算日期*/
	declare @strWeekNote char(1)='N';

	declare @tabDate table
	(
		CalRow int,
		CalDate varchar(10),
		CalDayWeek int,
		WeekNote char(1),	/*本週註記 Y:是;N:否*/

		IsolationStatus char(1)	/*隔離狀態 Y:是;N:否*/

	)

	declare @tabDateSchedule table
	(
		CalRow int,
		CalDate varchar(10),
		CalDayWeek int,
		WeekNote char(1),	/*本週註記 Y:是;N:否*/
		IsolationStatus char(1),	/*隔離狀態 Y:是;N:否*/
		
		Kind int,

		SEQ_ID bigint,
		PLANT varchar(10),
		SOM_TYPE varchar(50),
		SOM_STATUS varchar(50),
		SOL_TYPE varchar(50),

		BOM_NO varchar(50),
		MATERIALName nvarchar(100),
		SYSTEMNO nvarchar(50),
		VENDORNAME varchar(240),
		SDD DATETIME,
		VAD DATETIME,
		SOQ int,
		SQ int
	)

	BEGIN TRY

		select @strCalDate=DATEADD(day,@intWeek*7,@strDate);
		SELECT @intDayWeek=DATEPART(WEEKDAY, @strCalDate);
		--select @intDayWeek;

		if @intDayWeek<>1
			begin
				set @intDayWeek=@intDayWeek-2;
			end
		else
			begin
				set @intDayWeek=@intDayWeek+7-2;
			end

		SELECT @strDateS=DATEADD(day,-7-@intDayWeek, @strCalDate); 

		SELECT @intDayWeek=DATEPART(WEEKDAY, getdate());

		if @intDayWeek<>1
			begin
				set @intDayWeek=@intDayWeek-2;
			end
		else
			begin
				set @intDayWeek=@intDayWeek+7-2;
			end

		SELECT @strWeekDate=DATEADD(day,0-@intDayWeek, getdate()); 

		/*0 先塞入整個行事曆 */
		BEGIN TRY
			while (@intRow<=@intDay)
				begin
					set @strRowDate=convert(varchar(10),DATEADD(day,@intRow,@strDateS),112)

					if (DATEADD(day,@intRow,@strDateS)>=dateadd(day,-1,@strWeekDate) and DATEADD(day,@intRow,@strDateS)<=dateadd(day,6,@strWeekDate))
						begin
							set @strWeekNote='Y';
						end
					else 
						begin
							set @strWeekNote='N'
						end

					--select @intRow,@strRowDate;
					insert into @tabDate
						(CalRow,CalDate
						,CalDayWeek,WeekNote
						,IsolationStatus
						)
					select '1' + convert(varchar(10),@intRow+1),@strRowDate
						,DATEPART(WEEKDAY, @strRowDate),@strWeekNote
						,'N'
					set @intRow=@intRow+1
				end

		END TRY
		BEGIN CATCH
			set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
				+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
					+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
					+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
					+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
					+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(max))

			Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_GetOrderMasterScheduleList','1 SDP_Order_Master_Waste欄位SOM_TYPE=A或M，SOM_STATUS=temp',@strError
					,getdate())

		END CATCH 


		/*1 SDP_Order_Master_Waste欄位SOM_TYPE=A或M，SOM_STATUS=temp (未送出,黑字無底色)*/
		BEGIN TRY

			insert into @tabDateSchedule
				(CalRow
				,CalDate
				,CalDayWeek
				,WeekNote
				,IsolationStatus
				,Kind
				,SEQ_ID
				,PLANT
				,SOM_TYPE
				,SOM_STATUS
				,SOL_TYPE
				,BOM_NO
				,MATERIALName
				,SYSTEMNO
				,VENDORNAME
				,SDD
				,VAD
				,SOQ
				,SQ
				)
			select case --CalRow
				when D.SOM_STATUS ='Wait_Confirm' then '1' + convert(varchar(20),CalRow)--等待確認
				when D.SOM_STATUS ='Shipped' then '2' + convert(varchar(20),CalRow)--等待出貨
				when D.SOM_STATUS ='Wait_Cancel' then '3' + convert(varchar(20),CalRow)--等待作廢
				when D.SOM_STATUS ='Cancel' then '4' + convert(varchar(20),CalRow)--已作廢
				when D.SOM_STATUS ='Closed' then '9' + convert(varchar(20),CalRow)--已結案

				end
				,CalDate --CalDate
				,CalDayWeek --CalDayWeek
				,WeekNote--WeekNote
				,IsolationStatus--IsolationStatus
				,case
				when D.SOM_STATUS ='Wait_Confirm' then 1
				when D.SOM_STATUS ='Shipped' then 2
				when D.SOM_STATUS ='Wait_Cancel' then 3
				when D.SOM_STATUS ='Cancel' then 4
				when D.SOM_STATUS ='Closed' then 9


				end
				,isnull(SEQ_ID,0)--SEQ_ID
				,isnull(PLANT,'')--PLANT
				,isnull(SOM_TYPE,'')--SOM_TYPE
				,isnull(SOM_STATUS,'')--SOM_STATUS
				,isnull(SOL_TYPE,'')--SOL_TYPE
				,isnull(BOM_NO,'')--BOM_NO
				,isnull(MATERIALName,'')--MATERIALName
				,isnull(SYSTEMNO,'')--SYSTEMNO
				,isnull(VendorName,'')--VENDORNAME
				,convert(varchar ,SDD,120)
				,convert(varchar ,VAD,120)
				,SOQ
				,SQ
				from @tabDate as M
				left join (
					select (case
						when ((O.VENDOR_ARRIVAL_DATE ='' or O.VENDOR_ARRIVAL_DATE is null)and (m.SOM_DELIVERY_DATE!=O.ARRIVAL_DATE))then convert(varchar(10),O.ARRIVAL_DATE,112) 
						when (O.VENDOR_ARRIVAL_DATE ='' or O.VENDOR_ARRIVAL_DATE is null)then convert(varchar(10),M.SOM_DELIVERY_DATE,112)
						else convert(varchar(10),O.VENDOR_ARRIVAL_DATE,112)
						end)as ArrivalDate
						,M.SEQ_ID
						,M.SOM_PLANT as PLANT
						,M.SOM_TYPE
						,(CASE 
						WHEN M.SOM_STATUS='SENT' AND O.STATUS='Wait_Confirm' THEN 'Wait_Confirm'
						WHEN M.SOM_STATUS='SENT' AND O.STATUS='Shipped' THEN 'Shipped'
						WHEN M.SOM_STATUS='Wait_Cancel' THEN 'Wait_Cancel'
						WHEN M.SOM_STATUS='Cancel' THEN 'Cancel'
						WHEN M.SOM_STATUS='Closed' THEN 'Closed'
						END
						)AS SOM_STATUS
						,L.SOL_TYPE
						,M.SOM_BOM as BOM_NO
						,IBD.IBD_MATERIAL as MATERIALName
						,IBD.IBD_SYSTEM as SYSTEMNO
						,SOM_PLANT as VendorName
						,SOM_DELIVERY_DATE AS SDD
						,VENDOR_ARRIVAL_DATE AS VAD
						,m.SOM_ORDER_QTY as SOQ
						,o.SHIP_QTY as SQ
						
						from SDP_Order_Master_Waste as M
						left join (select * from SDP_VW_SRM_CALLED_ORDERS_GCIC union select * from SDP_VW_SRM_CALLED_ORDERS_GCIC_Waste) as O on O.CALLED_NO=M.SOM_SDP_NO
						left join V_Plant as P on P.Plant_T=M.SOM_PLANT
						left join V_Inventory_BaseData as IBD on IBD_BOM_NO=M.SOM_BOM and IBD.IBD_PLANT=M.SOM_PLANT
						left join SDP_ORDER_Log as L on L.SOM_ID=M.SEQ_ID
						WHERE (M.SOM_BOM like (CASE 
							WHEN @intBOM='ALL' THEN '%W10%'
							END) or M.SOM_BOM like (CASE 
							WHEN @intBOM='ALL' THEN '%W11%'
							END)) and
							M.SOM_STATUS IN ('SENT','Closed','Wait_Cancel','Cancel')
				) as D on M.CalDate=D.ArrivalDate

		END TRY
		BEGIN CATCH
			set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
				+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
					+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
					+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
					+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
					+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(max))

			Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_GetOrderMasterScheduleListWaste','1 SDP_Order_Master_Waste欄位SOM_TYPE=A或M，SOM_STATUS=temp',@strError
					,getdate())

		END CATCH 

		select distinct * from @tabDateSchedule
			order by CalDate,CalRow;


	END TRY

	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(100))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_GetOrderMasterScheduleListWaste','_GetOrderMasterScheduleListWaste',@strError
				,getdate())

	END CATCH 

END

