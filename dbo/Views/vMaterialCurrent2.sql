﻿/* AND MB.MB_IsUse = 'Y'*/
CREATE VIEW dbo.vMaterialCurrent2
AS
SELECT         M.M_Seq_ID, MB.MB_Seq_ID, MB.MB_Sysname AS Sysname, 
                          MB.MB_Plant AS Plant, MB.MB_Shop AS Shop, MB.MB_DECIMAL_BITS, 
                          MB.MB_CName AS CName, CONVERT(CHAR(10), M.M_Date, 126) AS Today, 
                          M.M_Amount AS Amount, CONVERT(CHAR(10), DATEADD(DD, - 1, M.M_Date), 
                          126) AS Yesterday, ISNULL
                              ((SELECT         M_Amount
                                  FROM             dbo.Material_Table AS C
                                  WHERE         (M_Date = DATEADD(DD, - 1, M.M_Date)) AND 
                                                            (MB_SEQ_ID = MB.MB_Seq_ID)), 0) AS YesterdayAmount, 
                          M2.M_Seq_ID AS YesterdaySeq_ID,
                              (SELECT         AVG(M_Amount) AS Expr1
                                FROM              dbo.Material_Table AS C
                                WHERE          (M_Date BETWEEN DATEADD(DD, - 30, M.M_Date) AND 
                                                           M.M_Date) AND (MB_SEQ_ID = M.MB_SEQ_ID)) 
                          AS MonthAvgAmount, MB.MB_Unit AS Unit, MB.MB_HiLimit, MB.MB_LoLimit, 
                          MB.MB_spName, MB.MB_IsMaster,
                              (SELECT         TOP (1) M_Remark
                                FROM              dbo.Remark_Table AS C
                                WHERE          (M_SEQ_ID = M1.M_Seq_ID)
                                ORDER BY   M_UPDATE_TIME DESC) AS M_Remark,
                              (SELECT         TOP (1) M_Remark
                                FROM              dbo.Remark_Table AS C
                                WHERE          (M_SEQ_ID = M2.M_Seq_ID)
                                ORDER BY   M_UPDATE_TIME DESC) AS Yesterday_M_Remark, 
                          M1.M_Seq_ID AS TodaySeq_ID, MB.MB_IsFilling, 
                          (CASE WHEN MB.MB_Sysname LIKE '%*%' THEN 2 ELSE 1 END) AS SysID, 
                          MB.MB_IsUse
FROM             dbo.Material_Table AS M INNER JOIN
                          dbo.Material_Base_Data AS MB ON 
                          M.MB_SEQ_ID = MB.MB_Seq_ID INNER JOIN
                          dbo.Material_Table AS M1 ON M1.M_Date = M.M_Date AND 
                          MB.MB_Upper = M1.MB_SEQ_ID LEFT OUTER JOIN
                          dbo.Material_Table AS M2 ON M2.M_Date = DATEADD(DD, - 1, M.M_Date) AND 
                          MB.MB_Upper = M2.MB_SEQ_ID
WHERE         (MB.MB_IsVisable = 'Y')

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[43] 4[36] 2[10] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "M"
            Begin Extent = 
               Top = 5
               Left = 278
               Bottom = 281
               Right = 436
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "MB"
            Begin Extent = 
               Top = 4
               Left = 493
               Bottom = 285
               Right = 779
            End
            DisplayFlags = 280
            TopColumn = 24
         End
         Begin Table = "M1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "M2"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1770
         Width = 1200
         Width = 1365
         Width = 1530
         Width = 1590
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 15030
         Alias = 2175
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
   ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vMaterialCurrent2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'      Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vMaterialCurrent2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vMaterialCurrent2';

