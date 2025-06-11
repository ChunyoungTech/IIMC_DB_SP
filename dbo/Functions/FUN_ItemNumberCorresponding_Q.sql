
CREATE Function [dbo].[FUN_ItemNumberCorresponding_Q]
(
     @strSeqID varchar(30),				/*編碼*/
	 @strPlant nvarchar(10)			/*姓名*/
)
RETURNS TABLE 
AS
RETURN 
(
	select INC_SerialNo,MB_Plant,INC_SeqID,MBD.MB_CName as MB_CName,INC_MATNO
		,(case INC_ActiveFlag when 'Y' then '使用中' when 'N' then '停用' else '' end) as ActiveFlag
		,INC_ActiveFlag
		from ItemNumberCorresponding as INC
		inner join Material_Base_Data as MBD on MB_Seq_ID=INC_SeqID
		where MB_Plant=@strPlant and INC_SeqID=(case when @strSeqID<>'' then @strSeqID else INC_SeqID end)
			and INC_ActiveFlag='Y'
)
