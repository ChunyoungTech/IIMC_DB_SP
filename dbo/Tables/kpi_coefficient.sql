CREATE TABLE [dbo].[kpi_coefficient] (
    [material_base_data_id] INT             NULL,
    [datetime]              DATETIME        NULL,
    [name]                  VARCHAR (50)    NULL,
    [base_value]            DECIMAL (18, 8) NULL,
    [exponent]              DECIMAL (18, 8) NULL,
    [r_value]               DECIMAL (18, 8) NULL,
    [correction]            DECIMAL (18, 8) NULL,
    [adjusted]              DECIMAL (18, 8) NULL,
    [water_volume]          DECIMAL (18, 8) NULL,
    [converted_area]        DECIMAL (18, 8) NULL
);

