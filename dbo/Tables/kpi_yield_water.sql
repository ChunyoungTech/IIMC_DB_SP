CREATE TABLE [dbo].[kpi_yield_water] (
    [id]              INT             IDENTITY (1, 1) NOT NULL,
    [plant]           VARCHAR (50)    NULL,
    [datetime]        DATETIME        NULL,
    [fab2_sum_volume] DECIMAL (18, 8) NULL,
    [fab2_moved_m3]   DECIMAL (18, 8) NULL,
    [fbc_in_volume]   DECIMAL (18, 8) NULL,
    [fbc_moved_m3]    DECIMAL (18, 8) NULL,
    [aer_in_volume]   DECIMAL (18, 8) NULL,
    [aer_moved_m3]    DECIMAL (18, 8) NULL,
    [ana_in_volume]   DECIMAL (18, 8) NULL,
    [ana_moved_m3]    DECIMAL (18, 8) NULL
);

