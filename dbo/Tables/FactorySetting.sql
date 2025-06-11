CREATE TABLE [dbo].[FactorySetting] (
    [FS_SerialNo]           BIGINT       IDENTITY (1, 1) NOT NULL,
    [FS_Plant]              VARCHAR (10) NOT NULL,
    [FS_SettingYYYY_S]      VARCHAR (4)  NOT NULL,
    [FS_SettingYYYY_E]      VARCHAR (4)  NOT NULL,
    [FS_CalculationMonth_S] INT          NOT NULL,
    [FS_CalculationDay_S]   VARCHAR (2)  NOT NULL,
    [FS_CalculationMonth_E] INT          NOT NULL,
    [FS_CalculationDay_E]   VARCHAR (2)  NOT NULL,
    CONSTRAINT [PK_FactorySetting] PRIMARY KEY CLUSTERED ([FS_Plant] ASC, [FS_SettingYYYY_S] ASC)
);

