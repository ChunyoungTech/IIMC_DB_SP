CREATE VIEW [dbo].[vWeekTotalQty3]
AS
SELECT          M.M_Seq_ID, M.M_Date, MB.MB_Plant, MB.MB_Shop, MB.MB_Sysname, MB.MB_CName, MB.MB_DECIMAL_BITS, 
                            MB.MB_Unit, CONVERT(VARCHAR(10), DATEADD(DD, 0, M.M_Date), 120) AS Today, CONVERT(VARCHAR(10), 
                            DATEADD(DD, - 1, M.M_Date), 120) AS Yesterday, CONVERT(VARCHAR(10), DATEADD(DD, - 2, M.M_Date), 120) 
                            AS beforday1, CONVERT(VARCHAR(10), DATEADD(DD, - 3, M.M_Date), 120) AS beforday2, CONVERT(VARCHAR(10), 
                            DATEADD(DD, - 4, M.M_Date), 120) AS beforday3, CONVERT(VARCHAR(10), DATEADD(DD, - 5, M.M_Date), 120) 
                            AS beforday4, CONVERT(VARCHAR(10), DATEADD(DD, - 6, M.M_Date), 120) AS beforday5, M_Amount, 
                            ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS b
                                    WHERE          (M_Date = DATEADD(DD, - 1, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS YesterdayAmount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS f
                                    WHERE          (M_Date = DATEADD(DD, - 2, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday1Amount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS g
                                    WHERE          (M_Date = DATEADD(DD, - 3, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday2Amount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS b
                                    WHERE          (M_Date = DATEADD(DD, - 4, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday3Amount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS h
                                    WHERE          (M_Date = DATEADD(DD, - 5, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday4Amount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS i
                                    WHERE          (M_Date = DATEADD(DD, - 6, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday5Amount, MB.MB_ShowMAX
FROM              dbo.Material_Table AS M INNER JOIN
                            dbo.Material_Base_Data AS MB ON M.MB_SEQ_ID = MB.MB_Seq_ID AND MB.MB_IsVisable = 'Y' AND MB.MB_IsUse = 'Y'
