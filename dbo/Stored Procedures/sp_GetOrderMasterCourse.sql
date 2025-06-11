
CREATE PROCEDURE [dbo].[sp_GetOrderMasterCourse]
	@strSeqID as int		/*SDP_Order_Master流水號*/
AS
BEGIN
	declare @strError nvarchar(max)='';
	--declare @strSeqID as int=513

	BEGIN TRY

		select distinct 
			--廠務叫料資訊--
			 H.SEQ_ID
			,P.Plant_F as SOM_PLANT --廠別
			,IBD.IBD_SYSTEM as SysName	  --系統名
			,IBD.IBD_MATERIAL as MATERIALName	  --品名
			,M.SOM_BOM							  --料號
			,isnull(convert(varchar(30),D.CREATE_DATE,120),'') as CallingOrderTime	--叫貨單生成時間
			,isnull(M.SOM_SDP_NO,'') as CALLED_NO --叫貨單號
			,convert(varchar,SOM_DELIVERY_DATE,120) as DELIVERY_DATE --預計到貨時間(廠務)
			,SOM_ORDER_QTY/IBD_TRANSFER_PARA as SOM_ORDER_QTY --叫貨數量(廠務)
			,IBD.IBD_UNIT as SOM_ORDER_UNIT --單位(廠務)
			,SOM_ORDER_QTY as Material_QTY	--叫貨數量(物管)
			,SOM_ORDER_UNIT as Material_UNIT--單位(物管)
			,isnull(U.U_USER_NAME,'') as U_USER_NAME --開單人員
			,isnull(D.REMARKS,'') as REMARKS_Factory			--備註說明(廠務人員)
			,(case --目前狀態
				when M.SOM_STATUS='TEMP' then '未開單'
				when M.SOM_STATUS='FAIL' then '開單失敗'
				when M.SOM_STATUS='Urgent' then '緊急叫料'
				when M.SOM_STATUS='SENT' AND D.STATUS='Wait_Confirm' then '待供應商確認' 
				when M.SOM_STATUS='SENT' AND D.STATUS='Wait_Shipping' then '待供應商出貨' 
				when M.SOM_STATUS='SENT' AND D.STATUS='Shipped' then '供應商已出貨' 
				when M.SOM_STATUS='SENT' AND D.STATUS='Closed' then '物管結案' 
				when M.SOM_STATUS='Wait_Cancel' then '等待作廢:'+ISNULL(M.SOM_CANCEL_REMARK,'')
				when M.SOM_STATUS='Cancel' then '廠務作廢:'+ISNULL(M.SOM_CANCEL_REMARK,'')
				when M.SOM_STATUS='Closed' then '廠務結案:'+ISNULL(M.SOM_CLOSE_REMARK,'')
				else '' end) as CurrentState 
			--供應商回應資訊--
			,isnull(convert(varchar(30),H.UPDATE_DATE,120),'') as HistoryTime --供應商更新時間
			,isnull(convert(varchar(30),H.VENDOR_ARRIVAL_DATE,120),'') as ShippingTime	--到貨日期時間(供應商回覆)
			,(CASE WHEN H.STATUS='Closed' THEN isnull(H.CLOSE_ASN_QTY,'') ELSE  isnull(H.SHIP_QTY,'') END) as SHIP_QTY					--供應商確認可出貨數量
			,(case --物管叫貨單歷史狀態(歷史歷程用)
				when H.STATUS='Wait_Confirm' then '待供應商確認' 
				when H.STATUS='Wait_Shipping' then '待供應商出貨'
				when H.STATUS='Shipped' then '供應商已出貨'
				when H.STATUS='CANCEL' then '已作廢'
				when H.STATUS='Closed' then '物管結案'
				else '' end) as HistroryState
			,isnull(H.ASN,'') as ASN_NO --ASN單號
			,isnull(L.SOL_ErrMsg,'') as SOL_ErrMsg --錯誤訊息
			,H.PO_NO+'-'+H.PO_LINE+''+isnull(H.VENDOR_REMARK,'') as REMARKS_Supplier		--備註說明(供應商回覆)
			--其他資訊--
			,SOM_STATUS --目前狀態(網頁上判斷狀態用)
			,D.STATUS as NowSTATUS --供應商目前狀態(網頁上判斷狀態用)
			--資料表來源--
			from SDP_Order_Master as M --廠務叫料單主檔
			inner join V_Inventory_BaseData as IBD on IBD.IBD_SEQ_ID=M.IBD_SEQ_ID --庫存基本檔
			inner join V_Plant as P on P.Plant_T=SOM_PLANT --廠別代號對照
			left join (SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC UNION SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_ALLOCATE)  as D on D.CALLED_NO=M.SOM_SDP_NO --物管叫料單主檔
			left join Users as U on U.U_USER_ID=D.CREATE_BY --使用者
			left join (SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS UNION SELECT * FROM SDP_VW_SRM_CALLED_ORDERS_GCIC_HIS_ALLOCATE) as H on H.CALLED_NO=M.SOM_SDP_NO  --物管叫料單歷史
			left join SDP_ORDER_Log as L on L.SOM_ID = m.SEQ_ID  --叫料單錯誤訊息
			where M.SEQ_ID=@strSeqID
			order by HistoryTime desc
		 

	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(max))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('sp_GetOrderMasterCourse','',@strError
				,getdate())

	END CATCH 
end
