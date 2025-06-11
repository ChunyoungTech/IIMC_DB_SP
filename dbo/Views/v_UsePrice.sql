




CREATE VIEW [dbo].[v_UsePrice]
AS
SELECT  TOP (100) PERCENT MB_Seq_ID, MB_Plant, MB_Shop, MB_Sysname, MB_CName, M_YEAR, M_MONTH, AVG(M_Price) AS M_Price, SUM(M_Amount) 
                   AS M_Amount, SUM(M_AP) AS M_AP
FROM      (SELECT  MB.MB_Seq_ID, MB.MB_Plant, MB.MB_Shop, MB.MB_Sysname, MB.MB_CName, YEAR(M.M_Date) AS M_YEAR, 
                                      MONTH(M.M_Date) AS M_MONTH, M.M_Amount, M.M_Price, M.M_Amount * M.M_Price AS M_AP
                   FROM       dbo.Material_Base_Data AS MB INNER JOIN
                                      dbo.Material_Table AS M ON MB.MB_Seq_ID = M.MB_SEQ_ID AND MB.MB_IsUse = 'Y') AS SS
GROUP BY MB_Seq_ID, MB_Plant, MB_Shop, MB_Sysname, MB_CName, M_YEAR, M_MONTH
