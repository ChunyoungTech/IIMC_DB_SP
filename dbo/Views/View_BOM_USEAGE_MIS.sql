CREATE VIEW dbo.View_BOM_USEAGE_MIS
AS
SELECT     BU.BU_DATE AS M_date, 
                      (CASE MB_Plant WHEN 'FAB1' THEN 'FAC1' WHEN 'FAB2' THEN 'FAC2' WHEN 'FAB3' THEN 'FAC3' WHEN 'FAB4' THEN 'FAC4' WHEN 'FAB5' THEN 'FAC5' WHEN 'FAB6'
                       THEN 'FAC6' WHEN 'FAB7' THEN 'FAC7' WHEN 'FAB8' THEN 'FAC8' WHEN 'FAB8B' THEN 'FAC8B' WHEN 'FABT6' THEN 'FACT6' WHEN 'FABC' THEN 'FACL' END) 
                      AS M_fac, MB.MB_Plant AS M_fab, MB.MB_Shop AS M_mfab, BS.BS_TAG AS M_tagname, BS.BS_MASTER_BOM_NO AS M_material_no, 
                      MB.MB_CName AS M_material_name, M.M_Amount * BU.BS_TRANSFER_PARA * BU.BS_USE_PARA / 100 AS M_usage, BS.BS_UNIT AS M_unit, 'B' AS M_type
FROM         dbo.BOM_USEAGE AS BU INNER JOIN
                      dbo.BOM_SETTING AS BS ON BU.BS_SEQ_ID = BS.BS_SEQ_ID INNER JOIN
                      dbo.Material_Table AS M ON BS.MB_SEQ_ID = M.MB_SEQ_ID AND BU.BU_DATE = M.M_Date INNER JOIN
                      dbo.Material_Base_Data AS MB ON M.MB_SEQ_ID = MB.MB_Seq_ID
WHERE     (MB.MB_IsVisable = 'Y')
UNION
SELECT     M.M_Date AS M_date, 
                      (CASE MB_Plant WHEN 'FAB1' THEN 'FAC1' WHEN 'FAB2' THEN 'FAC2' WHEN 'FAB3' THEN 'FAC3' WHEN 'FAB4' THEN 'FAC4' WHEN 'FAB5' THEN 'FAC5' WHEN 'FAB6'
                       THEN 'FAC6' WHEN 'FAB7' THEN 'FAC7' WHEN 'FAB8' THEN 'FAC8' WHEN 'FAB8B' THEN 'FAC8B' WHEN 'FABT6' THEN 'FACT6' WHEN 'FABC' THEN 'FACL' END) 
                      AS M_fac, MB2.MB_Plant AS M_fab, MB2.MB_Shop AS M_mfab, MB2.MB_tagname AS M_tagname, MB2.MB_material_no AS M_material_no, 
                      MB2.MB_CName AS M_material_name, M.M_Amount AS M_usage, MB2.MB_Unit AS M_unit, 'M' AS M_type
FROM         dbo.Material_Base_Data AS MB2 INNER JOIN
                      dbo.Material_Table AS M ON MB2.MB_Seq_ID = M.MB_SEQ_ID
WHERE     (MB2.MB_IsVisable = 'Y')

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[27] 4[17] 2[43] 3) )"
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
         Begin Table = "BU"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 260
            End
            DisplayFlags = 280
            TopColumn = 7
         End
         Begin Table = "BS"
            Begin Extent = 
               Top = 6
               Left = 298
               Bottom = 125
               Right = 520
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "M"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MB"
            Begin Extent = 
               Top = 126
               Left = 276
               Bottom = 245
               Right = 482
            End
            DisplayFlags = 280
            TopColumn = 9
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
         Width = 1500
         Width = 1500
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
         Column = 5250
         Alias = 1590
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
      ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_USEAGE_MIS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'   Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_USEAGE_MIS';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'View_BOM_USEAGE_MIS';

