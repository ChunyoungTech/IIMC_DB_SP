CREATE VIEW dbo.v_ManualInTemp
AS
SELECT     dbo.Material_Table.M_Date, dbo.Material_Table.M_Seq_ID, dbo.Material_Base_Data.MB_Sysname AS I_Sysname, dbo.Material_Base_Data.MB_Plant AS I_Plant, 
                      dbo.Material_Base_Data.MB_Shop AS I_Shop, dbo.Material_Base_Data.MB_CName AS I_CName, dbo.IDMC_Table_Temp.TM_TAG_NAME, 
                      dbo.IDMC_Table_Temp.TM_TAG_DESC, dbo.IDMC_Table_Temp.TM_TAG_SITE, dbo.IDMC_Table_Temp.TM_TAG1_ID, 
                      dbo.IDMC_Table_Temp.TM_TAG_DEFAULT AS Value, dbo.IDMC_Table_Temp.TM_TYPE_OF, dbo.Material_Base_Data.MB_spName
FROM         dbo.IDMC_Table_Temp INNER JOIN
                      dbo.Material_Table ON dbo.IDMC_Table_Temp.I_DATE = dbo.Material_Table.M_Date AND 
                      dbo.IDMC_Table_Temp.MB_SEQ_ID = dbo.Material_Table.MB_SEQ_ID INNER JOIN
                      dbo.Material_Base_Data ON dbo.Material_Table.MB_SEQ_ID = dbo.Material_Base_Data.MB_Seq_ID
WHERE     (dbo.IDMC_Table_Temp.TM_TYPE_OF = 1) AND (dbo.Material_Base_Data.MB_IsManual = 'Y')

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[37] 4[23] 2[18] 3) )"
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
         Begin Table = "IDMC_Table_Temp"
            Begin Extent = 
               Top = 10
               Left = 33
               Bottom = 296
               Right = 280
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Material_Table"
            Begin Extent = 
               Top = 10
               Left = 355
               Bottom = 183
               Right = 631
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Material_Base_Data"
            Begin Extent = 
               Top = 9
               Left = 740
               Bottom = 182
               Right = 1026
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 14
         Width = 284
         Width = 1830
         Width = 2295
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1890
         Width = 1035
         Width = 1200
         Width = 1200
         Width = 1530
         Width = 2295
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2475
         Alias = 3510
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ManualInTemp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_ManualInTemp';

