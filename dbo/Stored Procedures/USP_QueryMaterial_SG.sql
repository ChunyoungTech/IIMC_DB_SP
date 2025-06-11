CREATE PROCEDURE [dbo].[USP_QueryMaterial_SG] 
	@strQPlant varchar(20),	/*廠區代號*/
	@strYear varchar(4),		/*年度*/
	@strMonth varchar(2)		/*月份*/
AS
BEGIN TRY
	--SET NOCOUNT ON;
	DECLARE @strError nvarchar(max)='';
	declare @intSerialNo bigint
	declare @FS_CalculationMonth_S int;
	declare @FS_CalculationDay_S varchar(20);
	declare @FS_CalculationMonth_E int;
	declare @FS_CalculationDay_E varchar(20);
	declare @strPlant varchar(20)='';
	if SUBSTRING(@strQPlant,1,4)='FAB8'
		begin
			set @strPlant='FAB8'
		end

	--declare @tmpTable Table
	--(
	--	Plant varchar(20), /**/
	--	Calculation_YYYY varchar(4),
	--	Calculation_MM varchar(2),
	--	CalculationDate varchar(8),
	--	SEQ_ID int,
	--	Material_CName nvarchar(50),
	--	Material_Unit varchar(50),
	--	MB_DosageQty decimal(20,5)
	--)

	declare @tmpSumTable Table
	(
		Plant varchar(20), /**/
		Calculation_YYYY varchar(4),
		Calculation_MM varchar(2),
		SEQ_ID int,
		Material_CName nvarchar(50),
		MB_DosageQty decimal(20,5)
	)

	select @FS_CalculationMonth_S=FS_CalculationMonth_S,@FS_CalculationDay_S=FS_CalculationDay_S
		,@FS_CalculationMonth_E=FS_CalculationMonth_E,@FS_CalculationDay_E=FS_CalculationDay_E
		from FactorySetting
		where FS_Plant=@strPlant and @strYear between FS_SettingYYYY_S and FS_SettingYYYY_E

	--定義迴圈參數
	DECLARE  
	@TotalNum INT, --執行次數
	@Num INT       --目前次數

	DECLARE @Data_S smalldatetime,
	@Data_E smalldatetime

	--設定迴圈參數
	--SET @TotalNum = 12 --執行次數
	--SET @Num =1        --目前次數 
	declare @day int
	set @Num=convert(int,@strMonth)
	declare @U_Table TABLE (C1 bigint);

	INSERT INTO ReportData_Head (RDH_Plant,RDH_DataYYYY,RDH_DataMM)
	OUTPUT INSERTED.RDH_SerialNo INTO @U_Table
	VALUES (@strQPlant,@strYear,'');

	select @intSerialNo=C1 from @U_Table

	BEGIN

		set @Data_S=DATEADD(MONTH,@FS_CalculationMonth_S,(@strYear + '/' + right(('0' + @Num),2) + '/' + @FS_CalculationDay_S))
		set @day=day(DATEADD(Day,-1,(DATEADD(MONTH,1,(@strYear + '/' + right(('0' + @Num),2) + '/' + '01')))))
		set @Data_E=DATEADD(MONTH,@FS_CalculationMonth_E,(@strYear + '/' + right(('0' + @Num),2) + '/' + (case when @FS_CalculationDay_E<>'31' then @FS_CalculationDay_E else CONVERT(varchar(2),day(DATEADD(Day,-1,(DATEADD(MONTH,1,(@strYear + '/' + right(('0' + @Num),2) + '/' + '01')))))) end)))
		
		--select concat('@Num:',right(concat('00',@Num),2),';@Data_S:',@Data_S,';@Data_E:',@Data_E)

		insert into ReportData_Body (RDB_HNo,RDB_Plant
			,RDB_Calculation_YYYY,RDB_Calculation_MM
			,RDB_CalculationDate,RDB_SEQ_ID
			,RDB_Material_CName,RDB_Material_Unit
			,RDB_MB_DosageQty)
		select @intSerialNo,MB_Plant
			,@strYear as Calculation_YYYY,right(('00'+CAST(@Num AS NVARCHAR)),2) as Calculation_MM
			--,@strYear as Calculation_YYYY,right(concat('00',@Num),2) as Calculation_MM
			,convert(varchar(8),M_Date,112) as CalculationDate,M.MB_SEQ_ID
			,MB_CName,MB_Unit
			,M_Amount as MB_DosageQty
			from Material_Table as D
			inner join Material_Base_Data as M on M.MB_Seq_ID=D.MB_SEQ_ID
			where MB_Plant in ('FAB8','FAB8B','FABT6') 
				and convert(varchar(10),M_Date,111) between convert(varchar(10),@Data_S,111) and convert(varchar(10),@Data_E,111)
	END

	BEGIN TRY
		insert into @tmpSumTable
			(Plant,Calculation_YYYY
			,Calculation_MM,SEQ_ID
			,Material_CName,MB_DosageQty)

		select [RDB_Plant],[RDB_Calculation_YYYY]
			,[RDB_Calculation_MM],[RDB_SEQ_ID]
			,[RDB_Material_CName],isnull(sum(RDB_MB_DosageQty),0) as MB_DosageQty
			
			from ReportData_Body 

			where [RDB_HNo]=@intSerialNo
			group by [RDB_Plant],[RDB_Calculation_YYYY]
			,[RDB_Calculation_MM],[RDB_SEQ_ID]
			,[RDB_Material_CName]
	END TRY
	BEGIN CATCH
		set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
			+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
				+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
				+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
				+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(max))

		Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('USP_SaveMaterial_SG_FAB8','@tmpSumTable',@strError
				,getdate())

	END CATCH 

	
	select (A.Plant+'_'+B.MB_Shop+'_'+Material_CName) AS Plant,Calculation_YYYY,Calculation_MM,SEQ_ID,Material_CName,MB_DosageQty 
	from @tmpSumTable A INNER JOIN Material_Base_Data B ON A.SEQ_ID=B.MB_Seq_ID
	ORDER BY SEQ_ID
 
END TRY

BEGIN CATCH
	set @strError = 'ERROR_NUMBER：'+cast(isnull(ERROR_NUMBER(),'') AS varchar(100))
		+'，ERROR_SEVERITY：'+cast(isnull(ERROR_SEVERITY(),'') AS varchar(100))
			+'，ERROR_STATE：'+cast(isnull(ERROR_STATE(),'') AS VARCHAR(100))
			+'，ERROR_PROCEDURE：'+cast(isnull(ERROR_PROCEDURE(),'') AS VARCHAR(100))
			+'，ERROR_LINE：'+cast(isnull(ERROR_LINE(),'') AS VARCHAR(100))
			+'，ERROR_LINE：'+cast(isnull(ERROR_MESSAGE(),'') AS  VARCHAR(max))

	Insert into DBO.Err_Message_Txt(Err_Object,Err_Flag,Err_Txt,Err_CRDate) VALUES('USP_SaveMaterial_SG_FAB8','SaveMaterial',@strError
			,getdate())

END CATCH 
