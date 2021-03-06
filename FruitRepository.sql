USE [master]
GO

CREATE DATABASE [FruitRepository] ON  PRIMARY 
( NAME = N'FruitMaster_Final', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\FruitMaster_Final.mdf' , SIZE = 2048KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FruitMaster_Final_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10.SQLEXPRESS\MSSQL\DATA\FruitMaster_Final_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [FruitRepository] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FruitRepository].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FruitRepository] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [FruitRepository] SET ANSI_NULLS OFF
GO
ALTER DATABASE [FruitRepository] SET ANSI_PADDING OFF
GO
ALTER DATABASE [FruitRepository] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [FruitRepository] SET ARITHABORT OFF
GO
ALTER DATABASE [FruitRepository] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [FruitRepository] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [FruitRepository] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [FruitRepository] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [FruitRepository] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [FruitRepository] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [FruitRepository] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [FruitRepository] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [FruitRepository] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [FruitRepository] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [FruitRepository] SET  DISABLE_BROKER
GO
ALTER DATABASE [FruitRepository] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [FruitRepository] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [FruitRepository] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [FruitRepository] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [FruitRepository] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [FruitRepository] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [FruitRepository] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [FruitRepository] SET  READ_WRITE
GO
ALTER DATABASE [FruitRepository] SET RECOVERY SIMPLE
GO
ALTER DATABASE [FruitRepository] SET  MULTI_USER
GO
ALTER DATABASE [FruitRepository] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [FruitRepository] SET DB_CHAINING OFF
GO
USE [FruitRepository]
GO
/****** Object:  Table [dbo].[Fruit]    Script Date: 02/25/2017 17:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Fruit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](500) NULL,
 CONSTRAINT [PrimayKey_FruitId] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FruitStock]    Script Date: 02/25/2017 17:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FruitStock](
	[FruitId] [int] NULL,
	[Quantity] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FruitPalletMap]    Script Date: 02/25/2017 17:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FruitPalletMap](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FruitId] [int] NULL,
	[PalletPrice] [decimal](18, 2) NULL,
	[NoOfCases] [int] NULL,
 CONSTRAINT [PrimayKey_FruitPalletMap_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FruitPalletCaseMap]    Script Date: 02/25/2017 17:29:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FruitPalletCaseMap](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PalletId] [int] NULL,
	[NoOfUnit] [int] NULL,
 CONSTRAINT [PrimayKey_FruitPalletCaseMap_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [FruitPalletCaseMap_Index] ON [dbo].[FruitPalletCaseMap] 
(
	[Id] ASC,
	[PalletId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[GetPriceOfFruit]    Script Date: 02/25/2017 17:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetPriceOfFruit]	
AS
BEGIN
			
	SELECT Name, 
	  CAST( FPM.PalletPrice AS FLOAT)/ (CAST(FPM.NoOfCases AS FLOAT) * CAST(FPCM.NoOfUnit AS FLOAT)) AS 'Price'
			FROM Fruit F 
			INNER JOIN FruitPalletMap FPM ON FPM.FruitId = F.Id
			INNER JOIN FruitPalletCaseMap FPCM ON FPCM.PalletId = FPM.Id
END
GO
/****** Object:  StoredProcedure [dbo].[GetCurrentStock]    Script Date: 02/25/2017 17:29:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCurrentStock]	
AS
BEGIN

SELECT Name, 
	   Quantity AS 'Current Stock',
	   CAST(Quantity AS FLOAT)/ (CAST(FPM.NoOfCases AS FLOAT)* CAST(FPCM.NoOfUnit AS FLOAT))  AS 'Current Stock in Pallets',
	   CAST( Quantity AS FLOAT) / CAST( FPCM.NoOfUnit   AS FLOAT) AS 'Current Stock In Cases'
			FROM Fruit F 
			INNER JOIN FruitStock FS ON F.Id = FS.FruitId
			INNER JOIN FruitPalletMap FPM ON FPM.FruitId = FS.FruitId
			INNER JOIN FruitPalletCaseMap FPCM ON FPCM.PalletId = FPM.Id
END
GO
/****** Object:  ForeignKey [ForeignKey_FruitStock_FruitId]    Script Date: 02/25/2017 17:29:44 ******/
ALTER TABLE [dbo].[FruitStock]  WITH CHECK ADD  CONSTRAINT [ForeignKey_FruitStock_FruitId] FOREIGN KEY([FruitId])
REFERENCES [dbo].[Fruit] ([Id])
GO
ALTER TABLE [dbo].[FruitStock] CHECK CONSTRAINT [ForeignKey_FruitStock_FruitId]
GO
/****** Object:  ForeignKey [ForeignKey_FruitPalletMap_FruitId]    Script Date: 02/25/2017 17:29:44 ******/
ALTER TABLE [dbo].[FruitPalletMap]  WITH CHECK ADD  CONSTRAINT [ForeignKey_FruitPalletMap_FruitId] FOREIGN KEY([FruitId])
REFERENCES [dbo].[Fruit] ([Id])
GO
ALTER TABLE [dbo].[FruitPalletMap] CHECK CONSTRAINT [ForeignKey_FruitPalletMap_FruitId]
GO
/****** Object:  ForeignKey [ForeignKey_FruitPalletCaseMap_FruitId]    Script Date: 02/25/2017 17:29:44 ******/
ALTER TABLE [dbo].[FruitPalletCaseMap]  WITH CHECK ADD  CONSTRAINT [ForeignKey_FruitPalletCaseMap_FruitId] FOREIGN KEY([PalletId])
REFERENCES [dbo].[FruitPalletMap] ([Id])
GO
ALTER TABLE [dbo].[FruitPalletCaseMap] CHECK CONSTRAINT [ForeignKey_FruitPalletCaseMap_FruitId]
GO
