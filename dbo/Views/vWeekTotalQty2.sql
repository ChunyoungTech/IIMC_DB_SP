





CREATE VIEW [dbo].[vWeekTotalQty2]
AS
SELECT          M.M_Seq_ID, M.M_Date, MB.MB_Plant, MB.MB_Shop, MB.MB_Sysname, MB.MB_CName, MB.MB_DECIMAL_BITS, 
                            MB.MB_Unit, CONVERT(VARCHAR(10), DATEADD(DD, 0, M.M_Date), 120) AS Today, CONVERT(VARCHAR(10), 
                            DATEADD(DD, - 1, M.M_Date), 120) AS Yesterday, CONVERT(VARCHAR(10), DATEADD(DD, - 2, M.M_Date), 120) 
                            AS beforday1, CONVERT(VARCHAR(10), DATEADD(DD, - 3, M.M_Date), 120) AS beforday2, CONVERT(VARCHAR(10), 
                            DATEADD(DD, - 4, M.M_Date), 120) AS beforday3, CONVERT(VARCHAR(10), DATEADD(DD, - 5, M.M_Date), 120) 
                            AS beforday4, CONVERT(VARCHAR(10), DATEADD(DD, - 6, M.M_Date), 120) AS beforday5, M_TotalQty M_Amount, 
                            ISNULL
                                ((SELECT         M_TotalQty M_Amount
                                    FROM              dbo.Material_Table AS b
                                    WHERE          (M_Date = DATEADD(DD, - 1, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS YesterdayAmount, ISNULL
                                ((SELECT         M_TotalQty M_Amount
                                    FROM              dbo.Material_Table AS f
                                    WHERE          (M_Date = DATEADD(DD, - 2, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday1Amount, ISNULL
                                ((SELECT         M_TotalQty M_Amount
                                    FROM              dbo.Material_Table AS g
                                    WHERE          (M_Date = DATEADD(DD, - 3, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday2Amount, ISNULL
                                ((SELECT         M_TotalQty M_Amount
                                    FROM              dbo.Material_Table AS b
                                    WHERE          (M_Date = DATEADD(DD, - 4, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday3Amount, ISNULL
                                ((SELECT         M_TotalQty M_Amount
                                    FROM              dbo.Material_Table AS h
                                    WHERE          (M_Date = DATEADD(DD, - 5, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday4Amount, ISNULL
                                ((SELECT         M_TotalQty M_Amount
                                    FROM              dbo.Material_Table AS i
                                    WHERE          (M_Date = DATEADD(DD, - 6, M.M_Date)) AND (MB_SEQ_ID = M.MB_SEQ_ID)), 0) 
                            AS beforday5Amount, MB.MB_ShowMAX
FROM              dbo.Material_Table AS M INNER JOIN
                            dbo.Material_Base_Data AS MB ON M.MB_SEQ_ID = MB.MB_Seq_ID AND MB.MB_IsVisable = 'Y' AND MB.MB_IsMaster = 'Y'

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[40] 2[18] 3) )"
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
               Top = 6
               Left = 38
               Bottom = 136
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MB"
            Begin Extent = 
               Top = 6
               Left = 293
               Bottom = 136
               Right = 522
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
      Begin ColumnWidths = 21
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1524
         Width = 1704
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 16380
         Alias = 6144
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1350
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vWeekTotalQty2';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vWeekTotalQty2';

