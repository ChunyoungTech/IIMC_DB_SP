CREATE VIEW dbo.v_IdmcTable
AS
SELECT         TOP (100) PERCENT B.MB_CName, B.MB_Plant, B.MB_Shop, M.M_Amount, 
                          M.M_MenuRemark, B.MB_DESC, CONVERT(CHAR(10), M.M_Date, 120) 
                          AS M_Date, CONVERT(CHAR(10), I.I_Date, 120) AS I_Date, CONVERT(CHAR(8), 
                          I.I_Time, 120) AS I_Time, I.I_Value1, I.I_Value2, I.I_Value3, I.I_Value4, 
                          I.I_Value5, M.M_Seq_ID, I.I_row_index, 
                          M.M_UnitTransferPara AS MB_UnitTransferPara, B.MB_UnitTransferDesc, 
                          I.I_Tag1, I.I_Tag2, I.I_Tag3, I.I_Tag4, I.I_Tag5, 
                          M.M_TotalTransferPara AS MB_TotalTransferPara, 
                          M.M_WeightTransferPara AS MB_WeightTransferPara, B.MB_IsVisable, 
                          M.MB_SEQ_ID, M.M_FillingQty, M.M_RegenerationQty,
                              (SELECT         M_Seq_ID
                                FROM              dbo.Material_Table AS E
                                WHERE          (MB_SEQ_ID = B.MB_Upper) AND (M_Date = M.M_Date)) 
                          AS UPPER_SEQ_ID, ISNULL(T1.TM_TAG_DESC, '') AS TAGDESC1, 
                          ISNULL(T2.TM_TAG_DESC, '') AS TAGDESC2, ISNULL(T3.TM_TAG_DESC, '') 
                          AS TAGDESC3, ISNULL(T4.TM_TAG_DESC, '') AS TAGDESC4, 
                          ISNULL(T5.TM_TAG_DESC, '') AS TAGDESC5, B.MB_spName, 
                          B.MB_TotalTransferDesc, I.I_ROWID, T1.TM_Sort, B.MB_Sysname
FROM             dbo.Material_Table AS M LEFT OUTER JOIN
                          dbo.Material_Base_Data AS B ON M.MB_SEQ_ID = B.MB_Seq_ID INNER JOIN
                          dbo.IDMC_Table AS I ON M.M_Seq_ID = I.M_SEQ_ID LEFT OUTER JOIN
                          dbo.TAG_MAPPING AS T1 ON I.I_Tag1 = T1.TM_TAG_NAME LEFT OUTER JOIN
                          dbo.TAG_MAPPING AS T2 ON I.I_Tag2 = T2.TM_TAG_NAME LEFT OUTER JOIN
                          dbo.TAG_MAPPING AS T3 ON I.I_Tag3 = T3.TM_TAG_NAME LEFT OUTER JOIN
                          dbo.TAG_MAPPING AS T4 ON I.I_Tag4 = T4.TM_TAG_NAME LEFT OUTER JOIN
                          dbo.TAG_MAPPING AS T5 ON I.I_Tag5 = T5.TM_TAG_NAME

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[47] 4[21] 2[14] 3) )"
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
               Left = 305
               Bottom = 174
               Right = 494
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 19
               Left = 28
               Bottom = 149
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "I"
            Begin Extent = 
               Top = 5
               Left = 536
               Bottom = 340
               Right = 713
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "T1"
            Begin Extent = 
               Top = 150
               Left = 38
               Bottom = 269
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "T2"
            Begin Extent = 
               Top = 174
               Left = 266
               Bottom = 293
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T3"
            Begin Extent = 
               Top = 270
               Left = 38
               Bottom = 389
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T4"
            Begin Extent = 
               Top = 294
               Left = 266
               Bottom = 413
               Right = 456
            End
            DisplayFlags = 280
            TopColumn = 0
         ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_IdmcTable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'End
         Begin Table = "T5"
            Begin Extent = 
               Top = 390
               Left = 38
               Bottom = 509
               Right = 228
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
      Begin ColumnWidths = 16
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
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 2850
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 2910
         Alias = 4125
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_IdmcTable';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_IdmcTable';

