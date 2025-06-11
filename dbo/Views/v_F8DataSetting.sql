CREATE VIEW dbo.v_F8DataSetting
AS
SELECT     B.MB_CName, B.MB_Plant, B.MB_Shop, B.MB_Sysname, M.M_Seq_ID, M.MB_SEQ_ID, CONVERT(CHAR(10), M.M_Date, 120) AS M_Date, 
                      CASE WHEN T1.TM_TAG_SITE = 0 THEN '' ELSE I.I_Value1 END AS I_Value1, CASE WHEN T2.TM_TAG_SITE = 0 THEN '' ELSE I.I_Value2 END AS I_Value2, 
                      CASE WHEN T3.TM_TAG_SITE = 0 THEN '' ELSE I.I_Value3 END AS I_Value3, CASE WHEN T4.TM_TAG_SITE = 0 THEN '' ELSE I.I_Value4 END AS I_Value4, 
                      CASE WHEN T3.TM_TAG_SITE = 0 THEN '' ELSE I.I_Value5 END AS I_Value5, CASE WHEN T1.TM_TAG_SITE = 0 THEN '' ELSE I.I_Tag1 END AS I_Tag1, 
                      CASE WHEN T2.TM_TAG_SITE = 0 THEN '' ELSE I.I_Tag2 END AS I_Tag2, CASE WHEN T3.TM_TAG_SITE = 0 THEN '' ELSE I.I_Tag3 END AS I_Tag3, 
                      CASE WHEN T4.TM_TAG_SITE = 0 THEN '' ELSE I.I_Tag4 END AS I_Tag4, CASE WHEN T5.TM_TAG_SITE = 0 THEN '' ELSE I.I_Tag5 END AS I_Tag5, 
                      CASE WHEN T1.TM_TAG_SITE = 0 THEN '' ELSE ISNULL(T1.TM_TAG_DESC, '') END AS TAGDESC1, 
                      CASE WHEN T2.TM_TAG_SITE = 0 THEN '' ELSE ISNULL(T2.TM_TAG_DESC, '') END AS TAGDESC2, 
                      CASE WHEN T3.TM_TAG_SITE = 0 THEN '' ELSE ISNULL(T3.TM_TAG_DESC, '') END AS TAGDESC3, 
                      CASE WHEN T4.TM_TAG_SITE = 0 THEN '' ELSE ISNULL(T4.TM_TAG_DESC, '') END AS TAGDESC4, 
                      CASE WHEN T5.TM_TAG_SITE = 0 THEN '' ELSE ISNULL(T5.TM_TAG_DESC, '') END AS TAGDESC5, B.MB_spName
FROM         dbo.Material_Table AS M INNER JOIN
                      dbo.Material_Base_Data AS B ON M.MB_SEQ_ID = B.MB_Seq_ID AND B.MB_IsMaster = 'Y' INNER JOIN
                      dbo.IDMC_Table AS I ON I.I_Plant = B.MB_Plant AND I.I_Shop = B.MB_Shop AND I.I_CName = B.MB_CName AND M.M_Date = I.I_Date AND 
                      I.I_Time < '07:00:00' LEFT OUTER JOIN
                      dbo.TAG_MAPPING AS T1 ON I.I_Tag1 = T1.TM_TAG_NAME AND T1.MB_SEQ_ID = M.MB_SEQ_ID LEFT OUTER JOIN
                      dbo.TAG_MAPPING AS T2 ON I.I_Tag2 = T2.TM_TAG_NAME AND T2.MB_SEQ_ID = M.MB_SEQ_ID LEFT OUTER JOIN
                      dbo.TAG_MAPPING AS T3 ON I.I_Tag3 = T3.TM_TAG_NAME AND T3.MB_SEQ_ID = M.MB_SEQ_ID LEFT OUTER JOIN
                      dbo.TAG_MAPPING AS T4 ON I.I_Tag4 = T4.TM_TAG_NAME AND T4.MB_SEQ_ID = M.MB_SEQ_ID LEFT OUTER JOIN
                      dbo.TAG_MAPPING AS T5 ON I.I_Tag5 = T5.TM_TAG_NAME AND T5.MB_SEQ_ID = M.MB_SEQ_ID
WHERE     (T1.TM_TAG_SITE <> 0) OR
                      (T2.TM_TAG_SITE <> 0) OR
                      (T3.TM_TAG_SITE <> 0) OR
                      (T4.TM_TAG_SITE <> 0) OR
                      (T5.TM_TAG_SITE <> 0)

GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[36] 4[28] 2[21] 3) )"
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
               Bottom = 125
               Right = 238
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 247
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "I"
            Begin Extent = 
               Top = 6
               Left = 276
               Bottom = 125
               Right = 445
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T1"
            Begin Extent = 
               Top = 126
               Left = 285
               Bottom = 245
               Right = 448
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "T2"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 365
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T3"
            Begin Extent = 
               Top = 246
               Left = 239
               Bottom = 365
               Right = 402
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "T4"
            Begin Extent = 
               Top = 366
               Left = 38
               Bottom = 485
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         En', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_F8DataSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'd
         Begin Table = "T5"
            Begin Extent = 
               Top = 366
               Left = 239
               Bottom = 485
               Right = 402
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
      Begin ColumnWidths = 25
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
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 13
         Column = 6195
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
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_F8DataSetting';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_F8DataSetting';

