

CREATE VIEW [dbo].[v_Coefficient]
AS

SELECT DISTINCT  CB.*,TM.TM_TAG_DESC,TM.TM_TAG_DEFAULT,TM.TM_TAG_SITE,MB.MB_spName FROM(
SELECT I_Plant
,I_Date
,I_CName
,I_Tag1 AS TM_TAG_NAME
,I_Value1 AS [Value]
FROM IDMC_TABLE WHERE I_Tag1<>''AND I_Tag1 IS NOT NULL
UNION
SELECT I_Plant
,I_Date
,I_CName
,I_Tag2 AS TM_TAG_NAME
,I_Value2 AS [Value]
FROM IDMC_TABLE WHERE I_Tag2<>''AND I_Tag2 IS NOT NULL
UNION
SELECT I_Plant
,I_Date
,I_CName
,I_Tag3 AS TM_TAG_NAME
,I_Value3 AS [Value]
FROM IDMC_TABLE WHERE I_Tag3<>''AND I_Tag3 IS NOT NULL
UNION
SELECT I_Plant
,I_Date
,I_CName
,I_Tag4 AS TM_TAG_NAME
,I_Value4 AS [Value]
FROM IDMC_TABLE WHERE I_Tag4<>''AND I_Tag4 IS NOT NULL
UNION
SELECT I_Plant
,I_Date
,I_CName
,I_Tag5 AS TM_TAG_NAME
,I_Value5 AS [Value]
FROM IDMC_TABLE WHERE I_Tag5<>''AND I_Tag5 IS NOT NULL) CB INNER JOIN TAG_MAPPING TM
ON TM.TM_TYPE_OF =2 AND CB.TM_TAG_NAME=TM.TM_TAG_NAME LEFT JOIN Material_Base_Data MB
ON CB.I_CName=MB.MB_CName AND CB.I_Plant=MB.MB_Plant 


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[42] 2[9] 3) )"
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
         Left = -768
      End
      Begin Tables = 
         Begin Table = "T"
            Begin Extent = 
               Top = 147
               Left = 18
               Bottom = 429
               Right = 292
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "MB"
            Begin Extent = 
               Top = 4
               Left = 281
               Bottom = 123
               Right = 490
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "I"
            Begin Extent = 
               Top = 0
               Left = 965
               Bottom = 119
               Right = 1134
            End
            DisplayFlags = 280
            TopColumn = 20
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
      Begin ColumnWidths = 11
         Column = 8490
         Alias = 1665
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
  ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Coefficient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'       Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Coefficient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_Coefficient';

