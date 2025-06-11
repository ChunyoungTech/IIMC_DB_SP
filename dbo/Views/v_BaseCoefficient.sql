

CREATE VIEW [dbo].[v_BaseCoefficient]
AS
/*
SELECT     dbo.Material_Base_Data.MB_Sysname,
			dbo.Material_Base_Data.MB_Plant,
			dbo.Material_Base_Data.MB_Shop,
			dbo.Material_Base_Data.MB_CName, 
            dbo.TAG_MAPPING.TM_TAG_NAME, 
			dbo.TAG_MAPPING.TM_TAG_DESC, 
			dbo.TAG_MAPPING.TM_TAG_DEFAULT
FROM        dbo.TAG_MAPPING INNER JOIN dbo.Material_Base_Data ON dbo.TAG_MAPPING.MB_SEQ_ID = dbo.Material_Base_Data.MB_Seq_ID
WHERE     (dbo.TAG_MAPPING.TM_TYPE_OF = 2) AND (dbo.Material_Base_Data.MB_IsManual = 'Y')
*/
SELECT DISTINCT  CB.*,TM.TM_TAG_DESC,TM.TM_TAG_DEFAULT FROM(
SELECT I_Plant AS MB_Plant
--,I_Shop AS MB_Shop
--,I_Sysname AS MB_Sysname
,I_CName AS MB_CName
,I_Tag1 AS TM_TAG_NAME
FROM CIC_BASE_TABLE WHERE I_Tag1<>''AND I_Tag1 IS NOT NULL
UNION
SELECT I_Plant AS MB_Plant
--,I_Shop AS MB_Shop
--,I_Sysname AS MB_Sysname
,I_CName AS MB_CName
,I_Tag2 AS TM_TAG_NAME
FROM CIC_BASE_TABLE WHERE I_Tag2<>''AND I_Tag2 IS NOT NULL
UNION
SELECT I_Plant AS MB_Plant
--,I_Shop AS MB_Shop
--,I_Sysname AS MB_Sysname
,I_CName AS MB_CName
,I_Tag3 AS TM_TAG_NAME
FROM CIC_BASE_TABLE WHERE I_Tag3<>''AND I_Tag3 IS NOT NULL
UNION
SELECT I_Plant AS MB_Plant
--,I_Shop AS MB_Shop
--,I_Sysname AS MB_Sysname
,I_CName AS MB_CName
,I_Tag4 AS TM_TAG_NAME
FROM CIC_BASE_TABLE WHERE I_Tag4<>''AND I_Tag4 IS NOT NULL
UNION
SELECT I_Plant AS MB_Plant
--,I_Shop AS MB_Shop
--,I_Sysname AS MB_Sysname
,I_CName AS MB_CName
,I_Tag5 AS TM_TAG_NAME
FROM CIC_BASE_TABLE WHERE I_Tag5<>''AND I_Tag5 IS NOT NULL) CB INNER JOIN TAG_MAPPING TM
ON TM.TM_TYPE_OF IN(2) AND CB.TM_TAG_NAME=TM.TM_TAG_NAME





GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[31] 2[22] 3) )"
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
         Begin Table = "TAG_MAPPING"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 285
               Right = 305
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Material_Base_Data"
            Begin Extent = 
               Top = 10
               Left = 372
               Bottom = 291
               Right = 738
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
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
         Column = 1920
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_BaseCoefficient';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v_BaseCoefficient';

