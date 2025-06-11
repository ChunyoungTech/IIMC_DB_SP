
CREATE function [dbo].[FUN_StringSplit](
	@String nvarchar(Max), /*來源字串*/
	@SplitStr varchar(20) /*分割字元*/
)
Returns @TmpTab Table
(
	[No] int identity(1,1),
	[Result] Nvarchar(max) /*分割後字串*/
)	
as
begin
	declare @ChartindexNum int = 1 /*字串搜尋起始位置*/
	declare @SplitStrNum int = 0 /*分割字元位置*/
	declare @StringStar varchar(max) ='' /*分割取得的字串*/

	/*若字串內含有分割字元*/
	if (CHARINDEX(@SplitStr,@String)>0)
		begin
			/*為取得最後一個字串,若結束字元不為分割符號則補上*/
			if right(@String,LEN(@SplitStr)) <> @SplitStr
				begin
					set @String=@String+@SplitStr
				end
			while(CHARINDEX(@SplitStr,@String,@chartindexNum)>0)
			begin

				/*分割字元位置*/
				set @SplitStrNum = CHARINDEX(@SplitStr,@String,@chartindexNum)
				
				/*取得分割字串*/
				set @StringStar = substring(@String,@chartindexNum,@SplitStrNum-@chartindexNum)

				--select concat('@chartindexNum:' , @chartindexNum,'@SplitStrNum:',@SplitStrNum,'@StringStar:',@StringStar)
				insert into @TmpTab values (@StringStar)

				/*下次搜尋起始位置*/
				set @chartindexNum= @SplitStrNum+LEN(@SplitStr)
			end
		end
	else
		begin
			insert into @TmpTab values(@String)
		end
	
	return
end	
