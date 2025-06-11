




CREATE VIEW [dbo].[vMaterialCurrentTotal]
AS
SELECT          M.M_Seq_ID, MB.MB_Seq_ID, MB.MB_Sysname AS Sysname, MB.MB_Plant AS Plant, MB.MB_Shop AS Shop, 
                            MB.MB_DECIMAL_BITS, MB.MB_CName AS CName, CONVERT(CHAR(10), M.M_Date, 126) AS Today, 
                            M.M_Amount AS Amount, CONVERT(CHAR(10), DATEADD(DD, - 1, M.M_Date), 126) AS Yesterday, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS C
                                    WHERE          (M_Date = DATEADD(DD, - 1, M.M_Date)) AND (MB_SEQ_ID = MB.MB_Seq_ID)), 0) 
                            AS YesterdayAmount, M2.M_Seq_ID AS YesterdaySeq_ID,
                                (SELECT          AVG(M_TotalQty) AS Expr1
                                  FROM               dbo.Material_Table AS C
                                  WHERE           (M_Date BETWEEN DATEADD(DD, - 30, M.M_Date) AND M.M_Date) AND 
                                                              (MB_SEQ_ID = M.MB_SEQ_ID)) AS MonthAvgAmount, MB.MB_Unit AS Unit, MB.MB_HiLimit, 
                            MB.MB_LoLimit,MB_LimitType, MB.MB_spName, MB.MB_IsMaster,MB_HiLimitValue,MB_LoLimitValue,
                                (SELECT          TOP (1) M_Remark
                                  FROM               dbo.Remark_Table AS C
                                  WHERE           (M_SEQ_ID = M1.M_Seq_ID)
                                  ORDER BY    M_UPDATE_TIME DESC) AS M_Remark,
                                (SELECT          TOP (1) M_Remark
                                  FROM               dbo.Remark_Table AS C
                                  WHERE           (M_SEQ_ID = M2.M_Seq_ID)
                                  ORDER BY    M_UPDATE_TIME DESC) AS Yesterday_M_Remark, M1.M_Seq_ID AS TodaySeq_ID, 
                            MB.MB_ShowMAX
FROM              dbo.Material_Table AS M INNER JOIN
                            dbo.Material_Base_Data AS MB ON M.MB_SEQ_ID = MB.MB_Seq_ID INNER JOIN
                            dbo.Material_Table AS M1 ON M1.M_Date = M.M_Date AND MB.MB_Upper = M1.MB_SEQ_ID LEFT OUTER JOIN
                            dbo.Material_Table AS M2 ON M2.M_Date = DATEADD(DD, - 1, M.M_Date) AND 
                            MB.MB_Upper = M2.MB_SEQ_ID
WHERE          (MB.MB_IsVisable = 'Y') AND MB.MB_IsUse='Y' --and MB.MB_IsMaster='Y'
