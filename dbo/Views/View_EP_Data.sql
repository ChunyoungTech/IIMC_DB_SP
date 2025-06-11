CREATE VIEW [dbo].[View_EP_Data]
AS
SELECT E.EP_NO, E.EP_Pant, E.EP_CNAME, E.EP_UNIT, M.MMA_YM, SUM(M.MMA_AMOUNT * E.EP_UnitTransferPara) 
                  AS Amount
FROM     dbo.EP_Data AS E INNER JOIN
                  dbo.vMeterial_Month_Amount AS M ON E.MB_SEQ_ID = M.MB_SEQ_ID
GROUP BY E.EP_NO, E.EP_CNAME, E.EP_UNIT, M.MMA_YM, E.EP_Pant

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[37] 2[23] 3) )"
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
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 44
               Bottom = 156
               Right = 241
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "M"
            Begin Extent = 
               Top = 6
               Left = 310
               Bottom = 110
               Right = 487
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1309
         Width = 1309
         Width = 1309
         Width = 1309
         Width = 1309
         Width = 1309
         Width = 1309
         Width = 1309
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 12
         Column = 4778
         Alias = 1964
         Table = 1165
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1348
         SortOrder = 1414
         GroupBy = 1350
         Filter = 1348
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_EP_Data';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_EP_Data';

