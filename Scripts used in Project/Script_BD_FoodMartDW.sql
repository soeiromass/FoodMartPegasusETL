CREATE DATABASE [FoodMartDW]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FoodMartDW', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\FoodMartDW.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'FoodMartDW_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\FoodMartDW_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE [FoodMartDW]
GO
/****** Object:  Table [dbo].[D_Customers]    Script Date: 20-04-2014 23:51:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_Customer](
	[CustomerKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [nchar](5) NOT NULL,
	[CompanyName] [nvarchar](40) NOT NULL,
	[ContactName] [nvarchar](30) NULL,
	[ContactTitle] [nvarchar](30) NULL,
	[City] [nvarchar](15) NULL,
	[Region] [nvarchar](15) NULL,
	[PostalCode] [nvarchar](10) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL
 CONSTRAINT [PK_D_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[D_Product]    Script Date: 20-04-2014 23:51:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_Product](
	[ProductKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[ProductName] [nvarchar](40) NOT NULL,
	[CategoryID] [int] NULL,
	[CategoryName] [nvarchar](15) NOT NULL,
	[UnitCostPrice] [money] NULL,
	[UnitPrice] [money] NULL,
	[ActiveFlag] [bit] NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ExpiredDate] [datetime] NULL,
 CONSTRAINT [PK_D_Products] PRIMARY KEY CLUSTERED 
(
	[ProductKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[F_Sales_Month]    Script Date: 20-04-2014 23:51:02 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[F_Sales_Month](
	[MonthKey] [int] NOT NULL,
	[CustomerKey] [int] NOT NULL,
	[ProductKey] [int] NOT NULL,
	[SalesQty] [smallint] NULL,
	[SalesAmount] [money] NULL,
	[NetSalesAmount] [money] NULL
) ON [PRIMARY]

GO
