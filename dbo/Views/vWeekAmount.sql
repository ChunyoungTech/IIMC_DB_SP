﻿

CREATE VIEW [dbo].[vWeekAmount]
AS
SELECT          A.M_Seq_ID, A.M_Date, d.MB_Plant, d.MB_Shop, d.MB_Sysname, d.MB_CName, CONVERT(VARCHAR(10), 
                            DATEADD(DD, 0, A.M_Date), 120) AS Today, CONVERT(VARCHAR(10), DATEADD(DD, - 1, A.M_Date), 120) 
                            AS Yesterday, CONVERT(VARCHAR(10), DATEADD(DD, - 2, A.M_Date), 120) AS beforday1, CONVERT(VARCHAR(10), 
                            DATEADD(DD, - 3, A.M_Date), 120) AS beforday2, CONVERT(VARCHAR(10), DATEADD(DD, - 4, A.M_Date), 120) 
                            AS beforday3, CONVERT(VARCHAR(10), DATEADD(DD, - 5, A.M_Date), 120) AS beforday4, CONVERT(VARCHAR(10), 
                            DATEADD(DD, - 6, A.M_Date), 120) AS beforday5, A.M_Amount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS b
                                    WHERE          (M_Date = DATEADD(DD, - 1, A.M_Date)) AND (A.MB_SEQ_ID = MB_SEQ_ID)), 0) 
                            AS YesterdayAmount, ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS f
                                    WHERE          (M_Date = DATEADD(DD, - 2, A.M_Date)) AND (A.MB_SEQ_ID = MB_SEQ_ID)), 0) AS beforday1Amount,
                             ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS g
                                    WHERE          (M_Date = DATEADD(DD, - 3, A.M_Date)) AND (A.MB_SEQ_ID = MB_SEQ_ID)), 0) AS beforday2Amount,
                             ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS b
                                    WHERE          (M_Date = DATEADD(DD, - 4, A.M_Date)) AND (A.MB_SEQ_ID = MB_SEQ_ID)), 0) AS beforday3Amount,
                             ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS h
                                    WHERE          (M_Date = DATEADD(DD, - 5, A.M_Date)) AND (A.MB_SEQ_ID = MB_SEQ_ID)), 0) AS beforday4Amount,
                             ISNULL
                                ((SELECT          M_Amount
                                    FROM              dbo.Material_Table AS i
                                    WHERE          (M_Date = DATEADD(DD, - 6, A.M_Date)) AND (A.MB_SEQ_ID = MB_SEQ_ID)), 0) 
                            AS beforday5Amount
FROM              dbo.Material_Table AS A INNER JOIN
                            dbo.Material_Base_Data AS d ON A.MB_SEQ_ID = d.MB_Seq_ID AND d.MB_IsVisable = 'Y'



GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
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
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 255
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "d"
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vWeekAmount';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vWeekAmount';

