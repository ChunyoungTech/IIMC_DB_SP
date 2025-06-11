CREATE TABLE [dbo].[kpi_yield] (
    [id]                  INT             IDENTITY (1, 1) NOT NULL,
    [plant]               VARCHAR (50)    NULL,
    [datetime]            DATETIME        NULL,
    [array]               DECIMAL (18, 8) NULL,
    [cf]                  DECIMAL (18, 8) NULL,
    [lcd]                 DECIMAL (18, 8) NULL,
    [array_cf]            DECIMAL (18, 8) NULL,
    [array_cf_moved_pc]   DECIMAL (18, 8) NULL,
    [array_cf_moved_m2]   DECIMAL (18, 8) NULL,
    [array_cf_moved_rate] DECIMAL (18, 8) NULL
);

