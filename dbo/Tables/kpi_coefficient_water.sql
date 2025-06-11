CREATE TABLE [dbo].[kpi_coefficient_water] (
    [name]       VARCHAR (50)    NULL,
    [MB_CName]   NVARCHAR (50)   NOT NULL,
    [MB_Sysname] VARCHAR (15)    NOT NULL,
    [base_value] DECIMAL (18, 8) NULL,
    [exponent]   DECIMAL (18, 8) NULL,
    [r_value]    DECIMAL (18, 8) NULL,
    [correction] DECIMAL (18, 8) NULL,
    [adjusted]   DECIMAL (18, 8) NULL,
    [plant]      VARCHAR (50)    NULL,
    [datetime]   DATETIME        NULL
);

