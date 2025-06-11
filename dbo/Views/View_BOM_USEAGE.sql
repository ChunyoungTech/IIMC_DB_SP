CREATE VIEW dbo.View_BOM_USEAGE
AS
SELECT     dbo.BOM_USEAGE.BU_SEQ_ID, dbo.BOM_USEAGE.BU_DATE, dbo.Material_Base_Data.MB_Sysname, dbo.Material_Base_Data.MB_Plant, 
                      dbo.Material_Base_Data.MB_Shop, dbo.Material_Base_Data.MB_CName, dbo.BOM_SETTING.BS_TAG, dbo.BOM_SETTING.BS_MASTER_BOM_NO, 
                      dbo.BOM_SETTING.BS_UNIT, dbo.BOM_SETTING.BS_BOM_NO, dbo.BOM_USEAGE.BS_TRANSFER_PARA, dbo.BOM_USEAGE.BS_UNIT_TRANSFER_PARA, 
                      dbo.BOM_USEAGE.BS_LOSS_PARA, dbo.BOM_USEAGE.BS_SURVIVAL_PARA, dbo.BOM_USEAGE.BS_USE_PARA, dbo.BOM_USEAGE.BS_UNIT_PRICE, 
                      dbo.Material_Table.M_Amount, dbo.Material_Table.M_Amount * dbo.BOM_USEAGE.BS_TRANSFER_PARA * dbo.BOM_USEAGE.BS_USE_PARA / 100 AS BU_USEAGE, 
                      dbo.Material_Table.M_Amount * dbo.BOM_USEAGE.BS_TRANSFER_PARA * dbo.BOM_USEAGE.BS_USE_PARA * dbo.BOM_USEAGE.BS_UNIT_PRICE / 100 AS BU_COST,
                       dbo.Material_Base_Data.MB_DECIMAL_BITS
FROM         dbo.BOM_USEAGE INNER JOIN
                      dbo.BOM_SETTING ON dbo.BOM_USEAGE.BS_SEQ_ID = dbo.BOM_SETTING.BS_SEQ_ID INNER JOIN
                      dbo.Material_Table ON dbo.BOM_SETTING.MB_SEQ_ID = dbo.Material_Table.MB_SEQ_ID AND 
                      dbo.BOM_USEAGE.BU_DATE = dbo.Material_Table.M_Date INNER JOIN
                      dbo.Material_Base_Data ON dbo.Material_Table.MB_SEQ_ID = dbo.Material_Base_Data.MB_Seq_ID
WHERE     (dbo.Material_Base_Data.MB_IsVisable = 'Y')

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[48] 4[14] 2[21] 3) )"
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
         Left = -387
      End
      Begin Tables = 
         Begin Table = "BOM_USEAGE"
            Begin Extent = 
               Top = 6
               Left = 44
               Bottom = 198
               Right = 312
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "BOM_SETTING"
            Begin Extent = 
               Top = 140
               Left = 374
               Bottom = 329
               Right = 642
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Material_Table"
            Begin Extent = 
               Top = 36
               Left = 583
               Bottom = 249
               Right = 828
            End
            DisplayFlags = 280
            TopColumn = 8
         End
         Begin Table = "Material_Base_Data"
            Begin Extent = 
               Top = 101
               Left = 890
               Bottom = 323
               Right = 1144
            End
            DisplayFlags = 280
            TopColumn = 16
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
         Width = 1305
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 15870
         Alias = 2115
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_USEAGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'= 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_USEAGE';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_USEAGE';

