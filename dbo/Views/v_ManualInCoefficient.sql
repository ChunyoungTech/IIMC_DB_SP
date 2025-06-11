CREATE VIEW dbo.v_ManualInCoefficient
AS
SELECT     dbo.Material_Table.M_Date, dbo.Material_Table.M_Seq_ID, dbo.Material_Base_Data.MB_Sysname AS I_Sysname, dbo.Material_Base_Data.MB_Plant AS I_Plant, 
                      dbo.Material_Base_Data.MB_Shop AS I_Shop, dbo.Material_Base_Data.MB_CName AS I_CName, dbo.IDMC_Table_Temp.TM_TAG_NAME, 
                      dbo.IDMC_Table_Temp.TM_TAG_DESC, dbo.IDMC_Table_Temp.TM_TAG_SITE, dbo.IDMC_Table_Temp.TM_TAG1_ID, 
                      dbo.IDMC_Table_Temp.TM_TAG_DEFAULT AS Value, dbo.Material_Base_Data.MB_spName
FROM         dbo.IDMC_Table_Temp INNER JOIN
                      dbo.Material_Table ON dbo.IDMC_Table_Temp.I_DATE = dbo.Material_Table.M_Date AND 
                      dbo.IDMC_Table_Temp.MB_SEQ_ID = dbo.Material_Table.MB_SEQ_ID INNER JOIN
                      dbo.Material_Base_Data ON dbo.Material_Table.MB_SEQ_ID = dbo.Material_Base_Data.MB_Seq_ID

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
         Top = -1056
         Left = 0
      End
      Begin Tables = 
         Begin Table = "IDMC_Table_Temp"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 217
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material_Table"
            Begin Extent = 
               Top = 6
               Left = 255
               Bottom = 125
               Right = 455
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material_Base_Data"
            Begin Extent = 
               Top = 6
               Left = 493
               Bottom = 125
               Right = 699
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ManualInCoefficient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ManualInCoefficient';

