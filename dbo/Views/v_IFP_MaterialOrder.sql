CREATE VIEW [dbo].[v_IFP_MaterialOrder]
AS
SELECT          A.SEQ_ID AS Code, 1 AS IsEnabled, 
                            (CASE WHEN B.IBD_MATERIAL2 = 'TMAH25%-ARRAY' THEN 99 WHEN B.IBD_MATERIAL2 = 'TMAH25%-CF' THEN 89 END) AS MaterialID, C.CALLED_NO, C.CREATE_DATE AS OrderDate, 
                            C.VENDOR_ARRIVAL_DATE AS EstimateDate, A.SOM_STATUS, C.STATUS, 999 AS OrderUser
FROM              INX_GCIC.dbo.SDP_Order_Master AS A LEFT OUTER JOIN
                            INX_GCIC.dbo.SDP_VW_SRM_CALLED_ORDERS_GCIC AS C ON 
                            A.SOM_SDP_NO = C.CALLED_NO INNER JOIN
                            INX_GCIC.dbo.Inventory_BaseData AS B ON A.IBD_SEQ_ID = B.IBD_SEQ_ID
WHERE          (A.SOM_PLANT ='TT06') AND (A.SOM_STATUS IN ('SENT', 'Cancel')) AND 
                            (A.SOM_DELIVERY_DATE >= CONVERT(VARCHAR(10), GETDATE(), 111))


