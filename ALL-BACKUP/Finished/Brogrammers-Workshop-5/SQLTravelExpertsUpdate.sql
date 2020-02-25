USE [master]
GO
/****** Object:  Database [TravelExperts]    Script Date: 2/24/2020 2:43:19 PM ******/
CREATE DATABASE [TravelExperts]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TravelExperts', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TravelExperts.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TravelExperts_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\TravelExperts_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [TravelExperts] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TravelExperts].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TravelExperts] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TravelExperts] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TravelExperts] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TravelExperts] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TravelExperts] SET ARITHABORT OFF 
GO
ALTER DATABASE [TravelExperts] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [TravelExperts] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TravelExperts] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TravelExperts] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TravelExperts] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TravelExperts] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TravelExperts] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TravelExperts] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TravelExperts] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TravelExperts] SET  ENABLE_BROKER 
GO
ALTER DATABASE [TravelExperts] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TravelExperts] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TravelExperts] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TravelExperts] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TravelExperts] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TravelExperts] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TravelExperts] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TravelExperts] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TravelExperts] SET  MULTI_USER 
GO
ALTER DATABASE [TravelExperts] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TravelExperts] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TravelExperts] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TravelExperts] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TravelExperts] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [TravelExperts] SET QUERY_STORE = OFF
GO
USE [TravelExperts]
GO
/****** Object:  Table [dbo].[Products_Suppliers]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products_Suppliers](
	[ProductSupplierId] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NULL,
	[SupplierId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Find duplicates for Products_Suppliers]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Find duplicates for Products_Suppliers] () 
RETURNS TABLE 
AS RETURN (SELECT TOP 100 PERCENT Products_Suppliers.ProductId, Products_Suppliers.SupplierId, Products_Suppliers.ProductSupplierId
FROM Products_Suppliers
WHERE (((Products_Suppliers.ProductId) In (SELECT ProductId FROM Products_Suppliers As Tmp GROUP BY ProductId,SupplierId HAVING count(*)>1  And SupplierId = Products_Suppliers.SupplierId)))
ORDER BY Products_Suppliers.ProductId, Products_Suppliers.SupplierId)
GO
/****** Object:  Table [dbo].[Bookings]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bookings](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[BookingDate] [datetime] NULL,
	[BookingNo] [nvarchar](50) NULL,
	[TravelerCount] [float] NULL,
	[CustomerId] [int] NULL,
	[TripTypeId] [nvarchar](1) NULL,
	[PackageId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[Find duplicates for Bookings]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Find duplicates for Bookings] () 
RETURNS TABLE 
AS RETURN (SELECT TOP 100 PERCENT Bookings.BookingNo, Bookings.BookingId, Bookings.BookingDate
FROM Bookings
WHERE (((Bookings.BookingNo) In (SELECT BookingNo FROM Bookings As Tmp GROUP BY BookingNo HAVING count(*)>1 )))
ORDER BY Bookings.BookingNo)
GO
/****** Object:  Table [dbo].[Affiliations]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Affiliations](
	[AffilitationId] [nvarchar](10) NOT NULL,
	[AffName] [nvarchar](50) NULL,
	[AffDesc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Agencies]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agencies](
	[AgencyId] [int] IDENTITY(1,1) NOT NULL,
	[AgncyAddress] [nvarchar](50) NULL,
	[AgncyCity] [nvarchar](50) NULL,
	[AgncyProv] [nvarchar](50) NULL,
	[AgncyPostal] [nvarchar](50) NULL,
	[AgncyCountry] [nvarchar](50) NULL,
	[AgncyPhone] [nvarchar](50) NULL,
	[AgncyFax] [nvarchar](50) NULL,
 CONSTRAINT [PK_Agencies] PRIMARY KEY CLUSTERED 
(
	[AgencyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Agents]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Agents](
	[AgentId] [int] IDENTITY(1,1) NOT NULL,
	[AgtFirstName] [nvarchar](20) NULL,
	[AgtMiddleInitial] [nvarchar](5) NULL,
	[AgtLastName] [nvarchar](20) NULL,
	[AgtBusPhone] [nvarchar](20) NULL,
	[AgtEmail] [nvarchar](50) NULL,
	[AgtPosition] [nvarchar](20) NULL,
	[AgencyId] [int] NULL,
 CONSTRAINT [PK_Agents] PRIMARY KEY CLUSTERED 
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingDetails]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetails](
	[BookingDetailId] [int] IDENTITY(1,1) NOT NULL,
	[ItineraryNo] [float] NULL,
	[TripStart] [datetime] NULL,
	[TripEnd] [datetime] NULL,
	[Description] [nvarchar](255) NULL,
	[Destination] [nvarchar](255) NULL,
	[BasePrice] [money] NULL,
	[AgencyCommission] [money] NULL,
	[BookingId] [int] NULL,
	[RegionId] [nvarchar](5) NULL,
	[ClassId] [nvarchar](5) NULL,
	[FeeId] [nvarchar](10) NULL,
	[ProductSupplierId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Classes]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Classes](
	[ClassId] [nvarchar](5) NOT NULL,
	[ClassName] [nvarchar](20) NOT NULL,
	[ClassDesc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CreditCards]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CreditCards](
	[CreditCardId] [int] IDENTITY(1,1) NOT NULL,
	[CCName] [nvarchar](10) NOT NULL,
	[CCNumber] [nvarchar](50) NOT NULL,
	[CCExpiry] [datetime] NOT NULL,
	[CustomerId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerId] [int] IDENTITY(1,1) NOT NULL,
	[CustFirstName] [nvarchar](25) NOT NULL,
	[CustLastName] [nvarchar](25) NOT NULL,
	[CustAddress] [nvarchar](75) NOT NULL,
	[CustCity] [nvarchar](50) NOT NULL,
	[CustProv] [nvarchar](2) NOT NULL,
	[CustPostal] [nvarchar](7) NOT NULL,
	[CustCountry] [nvarchar](25) NULL,
	[CustHomePhone] [nvarchar](20) NULL,
	[CustBusPhone] [nvarchar](20) NOT NULL,
	[CustEmail] [nvarchar](50) NOT NULL,
	[AgentId] [int] NULL,
	[UserName] [varchar](25) NULL,
	[Password] [varchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customers_Rewards]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers_Rewards](
	[CustomerId] [int] NOT NULL,
	[RewardId] [int] NOT NULL,
	[RwdNumber] [nvarchar](25) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmpFirstName] [nvarchar](20) NOT NULL,
	[EmpMiddleInitial] [nvarchar](5) NULL,
	[EmpLastName] [nvarchar](20) NOT NULL,
	[EmpBusPhone] [nvarchar](20) NOT NULL,
	[EmpEmail] [nvarchar](50) NOT NULL,
	[EmpPosition] [nvarchar](20) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fees]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fees](
	[FeeId] [nvarchar](10) NOT NULL,
	[FeeName] [nvarchar](50) NOT NULL,
	[FeeAmt] [money] NOT NULL,
	[FeeDesc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Packages]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Packages](
	[PackageId] [int] IDENTITY(1,1) NOT NULL,
	[PkgName] [nvarchar](50) NOT NULL,
	[PkgStartDate] [datetime] NULL,
	[PkgEndDate] [datetime] NULL,
	[PkgDesc] [nvarchar](50) NULL,
	[PkgBasePrice] [money] NOT NULL,
	[PkgAgencyCommission] [money] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Packages_Products_Suppliers]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Packages_Products_Suppliers](
	[PackageId] [int] NOT NULL,
	[ProductSupplierId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductId] [int] IDENTITY(1,1) NOT NULL,
	[ProdName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Regions]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Regions](
	[RegionId] [nvarchar](5) NOT NULL,
	[RegionName] [nvarchar](25) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rewards]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rewards](
	[RewardId] [int] NOT NULL,
	[RwdName] [nvarchar](50) NULL,
	[RwdDesc] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SupplierContacts]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SupplierContacts](
	[SupplierContactId] [int] NOT NULL,
	[SupConFirstName] [nvarchar](50) NULL,
	[SupConLastName] [nvarchar](50) NULL,
	[SupConCompany] [nvarchar](255) NULL,
	[SupConAddress] [nvarchar](255) NULL,
	[SupConCity] [nvarchar](255) NULL,
	[SupConProv] [nvarchar](255) NULL,
	[SupConPostal] [nvarchar](255) NULL,
	[SupConCountry] [nvarchar](255) NULL,
	[SupConBusPhone] [nvarchar](50) NULL,
	[SupConFax] [nvarchar](50) NULL,
	[SupConEmail] [nvarchar](255) NULL,
	[SupConURL] [nvarchar](255) NULL,
	[AffiliationId] [nvarchar](10) NULL,
	[SupplierId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Suppliers]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierId] [int] NOT NULL,
	[SupName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TripTypes]    Script Date: 2/24/2020 2:43:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TripTypes](
	[TripTypeId] [nvarchar](1) NOT NULL,
	[TTName] [nvarchar](25) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'ACTA', N'Association of Canadian Travel Agents', NULL)
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'ACTANEW', NULL, NULL)
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'ACTANEWP', NULL, NULL)
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'ACTAPGY', NULL, NULL)
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'NEW', NULL, NULL)
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'NEWPGY', NULL, NULL)
GO
INSERT [dbo].[Affiliations] ([AffilitationId], [AffName], [AffDesc]) VALUES (N'PGY', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Agencies] ON 
GO
INSERT [dbo].[Agencies] ([AgencyId], [AgncyAddress], [AgncyCity], [AgncyProv], [AgncyPostal], [AgncyCountry], [AgncyPhone], [AgncyFax]) VALUES (1, N'1155 8th Ave SW', N'Calagary', N'AB', N'T2P1N3', N'Canada', N'4032719873', N'4032719872')
GO
INSERT [dbo].[Agencies] ([AgencyId], [AgncyAddress], [AgncyCity], [AgncyProv], [AgncyPostal], [AgncyCountry], [AgncyPhone], [AgncyFax]) VALUES (2, N'110 Main Street', N'Okatokes', N'AB', N'T7R3J5', N'Canada', N'4035632381', N'4035632382')
GO
SET IDENTITY_INSERT [dbo].[Agencies] OFF
GO
SET IDENTITY_INSERT [dbo].[Agents] ON 
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (1, N'Janet', NULL, N'Delton', N'(403) 210-7801', N'janet.delton@travelexperts.com', N'Senior Agent', 1)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (2, N'Judy', NULL, N'Lisle', N'(403) 210-7802', N'judy.lisle@travelexperts.com', N'Intermediate Agent', 1)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (3, N'Dennis', N'C.', N'Reynolds', N'(403) 210-7843', N'dennis.reynolds@travelexperts.com', N'Junior Agent', 1)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (4, N'John', NULL, N'Coville', N'(403) 210-7823', N'john.coville@travelexperts.com', N'Intermediate Agent', 1)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (5, N'Janice', N'W.', N'Dahl', N'(403) 210-7865', N'janice.dahl@travelexperts.com', N'Senior Agent', 1)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (6, N'Bruce', N'J.', N'Dixon', N'(403) 210-7867', N'bruce.dixon@travelexperts.com', N'Intermediate Agent', 2)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (7, N'Beverly', N'S.', N'Jones', N'(403) 210-7812', N'beverly.jones@travelexperts.com', N'Intermediate Agent', 2)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (8, N'Jane', NULL, N'Merrill', N'(403) 210-7868', N'jane.merrill@travelexperts.com', N'Senior Agent', 2)
GO
INSERT [dbo].[Agents] ([AgentId], [AgtFirstName], [AgtMiddleInitial], [AgtLastName], [AgtBusPhone], [AgtEmail], [AgtPosition], [AgencyId]) VALUES (9, N'Brian', N'S.', N'Peterson', N'(403) 210-7833', N'brian.peterson@travelexperts.com', N'Junior Agent', 2)
GO
SET IDENTITY_INSERT [dbo].[Agents] OFF
GO
SET IDENTITY_INSERT [dbo].[BookingDetails] ON 
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (11, 168, CAST(N'2001-03-17T00:00:00.000' AS DateTime), CAST(N'2001-03-22T00:00:00.000' AS DateTime), N'Calgary/Vancouver/Calgary', N'Vancouver', 450.0000, 22.5000, 11, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (15, 306, CAST(N'2001-05-09T00:00:00.000' AS DateTime), CAST(N'2001-06-03T00:00:00.000' AS DateTime), N'all-inclusive European tour', N'London, England', 3000.0000, 112.5000, 15, N'EU', N'ECN', N'GR', 14)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (16, 306, CAST(N'2001-05-09T00:00:00.000' AS DateTime), CAST(N'2001-06-03T00:00:00.000' AS DateTime), N'all-inclusive European tour', N'London, England', 3000.0000, 112.5000, 15, N'EU', N'ECN', N'GR', 14)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (17, 178, CAST(N'2001-07-18T00:00:00.000' AS DateTime), CAST(N'2001-08-01T00:00:00.000' AS DateTime), N'Calgary/Calcutta/Calgary', N'Calcutta, India', 799.0000, 39.9500, 17, N'MEAST', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (34, 142, CAST(N'2001-05-08T00:00:00.000' AS DateTime), CAST(N'2001-06-02T00:00:00.000' AS DateTime), N'Calgary/Athens/Calgary', N'Athens, Greece', 1000.0000, 32.5000, 34, N'MED', N'ECN', N'BK', 12)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (46, 141, CAST(N'2001-05-14T00:00:00.000' AS DateTime), CAST(N'2001-06-07T00:00:00.000' AS DateTime), N'midsize car', N'Toronto', 900.0000, 29.2500, 46, N'NA', N'NA', N'NC', 20)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (49, 201, CAST(N'2001-05-12T00:00:00.000' AS DateTime), CAST(N'2001-05-31T00:00:00.000' AS DateTime), N'Calgary/Victoria/Calgary', N'Victoria', 199.0000, 2.2885, 49, N'NA', N'ECN', N'BK', 12)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (52, 225, CAST(N'2001-05-14T00:00:00.000' AS DateTime), CAST(N'2001-06-07T00:00:00.000' AS DateTime), N' ', N'Toronto', 1700.0000, 55.2500, 52, N'NA', N'DLX', N'BK', 12)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (55, 771, CAST(N'2001-05-14T00:00:00.000' AS DateTime), CAST(N'2001-06-07T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 1200.0000, 60.0000, 55, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (57, 893, CAST(N'2001-09-24T00:00:00.000' AS DateTime), CAST(N'2001-10-15T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 750.0000, 75.0000, 57, N'EU', N'ECN', N'BK', 13)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (62, 964, CAST(N'2002-01-09T00:00:00.000' AS DateTime), CAST(N'2002-01-19T00:00:00.000' AS DateTime), N'Calgary/Victoria/Calgary', N'Victoria', 205.0000, 10.2500, 62, N'NA', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (65, 204, CAST(N'2002-01-31T00:00:00.000' AS DateTime), CAST(N'2002-02-13T00:00:00.000' AS DateTime), N'Calgary/Cairo/Calgary', N'Cairo, Egypt', 350.0000, 17.5000, 65, N'MEAST', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (73, 220, CAST(N'2002-03-13T00:00:00.000' AS DateTime), CAST(N'2002-03-18T00:00:00.000' AS DateTime), N'Calgary/Grande Prairie/Calgary', N'Grande Prairie', 150.0000, 7.5000, 73, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (79, 185, CAST(N'2002-03-29T00:00:00.000' AS DateTime), CAST(N'2002-04-28T00:00:00.000' AS DateTime), N'Calgary/Sydney/Calgary', N'Sydney, Australia', 2200.0000, 264.0000, 79, N'ANZ', N'ECN', N'BK', 30)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (80, 256, CAST(N'2002-03-29T00:00:00.000' AS DateTime), CAST(N'2002-04-11T00:00:00.000' AS DateTime), N'Calgary/Victoria/Calgary', N'Victoria', 190.0000, 9.5000, 80, N'NA', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (84, 185, CAST(N'2002-04-01T00:00:00.000' AS DateTime), CAST(N'2002-04-25T00:00:00.000' AS DateTime), N'Australian trek', N' ', 6250.0000, 234.3750, 84, N'ANZ', N'NA', N'BK', 15)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (85, 185, CAST(N'2002-04-01T00:00:00.000' AS DateTime), CAST(N'2002-04-25T00:00:00.000' AS DateTime), N'Australian trek', N' ', 6250.0000, 234.3750, 84, N'ANZ', N'NA', N'BK', 15)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (89, 279, CAST(N'2002-04-17T00:00:00.000' AS DateTime), CAST(N'2002-04-22T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 628.0000, 31.4000, 89, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (98, 230, CAST(N'2002-05-05T00:00:00.000' AS DateTime), CAST(N'2002-05-10T00:00:00.000' AS DateTime), N'Calgary/Vancouver/Calgary', N'Vancouver', 1048.0000, 52.4000, 98, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (108, 193, CAST(N'2002-05-19T00:00:00.000' AS DateTime), CAST(N'2002-06-01T00:00:00.000' AS DateTime), N'Calgary/Athens/Calgary', N'Athens, Greece', 1200.0000, 60.0000, 108, N'MED', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (122, 300, CAST(N'2002-05-23T00:00:00.000' AS DateTime), CAST(N'2002-06-07T00:00:00.000' AS DateTime), N'Calgary/Victoria/Calgary', N'Victoria', 175.0000, 8.7500, 124, N'NA', N'ECN', N'BK', 16)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (138, 397, CAST(N'2002-07-12T00:00:00.000' AS DateTime), CAST(N'2002-07-16T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 645.0000, 32.2500, 138, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (141, 244, CAST(N'2002-07-15T00:00:00.000' AS DateTime), CAST(N'2002-07-19T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 499.0000, 24.9500, 141, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (148, 805, CAST(N'2002-07-25T00:00:00.000' AS DateTime), CAST(N'2002-08-11T00:00:00.000' AS DateTime), N'Calgary/Athens/Calgary', N'Athens, Greece', 2300.0000, 70.0000, 148, N'MED', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (152, 1134, CAST(N'2002-09-29T00:00:00.000' AS DateTime), CAST(N'2002-10-12T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 780.0000, 39.0000, 152, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (156, 139, CAST(N'2002-11-07T00:00:00.000' AS DateTime), CAST(N'2002-11-12T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 620.0000, 31.0000, 156, N'NA', N'BSN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (161, 518, CAST(N'1999-11-07T00:00:00.000' AS DateTime), CAST(N'1999-11-12T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 620.0000, 31.0000, 161, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (162, 218, CAST(N'2002-11-12T00:00:00.000' AS DateTime), CAST(N'2002-11-18T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 620.0000, 31.0000, 162, N'NA', N'BSN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (172, 686, CAST(N'1999-11-07T00:00:00.000' AS DateTime), CAST(N'1999-11-12T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 629.0000, 31.4500, 172, N'EU', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (187, 449, CAST(N'1999-02-15T00:00:00.000' AS DateTime), CAST(N'1999-02-20T00:00:00.000' AS DateTime), N'Calgary/Houston/Calgary', N'Houston', 2875.0000, 60.0000, 187, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (199, 286, CAST(N'1999-03-01T00:00:00.000' AS DateTime), CAST(N'1999-03-16T00:00:00.000' AS DateTime), N'Calgary/Hong Kong/Calgary', N'Hong Kong, China', 3625.0000, 70.0000, 199, N'ASIA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (204, 933, CAST(N'1999-03-04T00:00:00.000' AS DateTime), CAST(N'1999-03-09T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 620.0000, 31.0000, 204, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (220, 932, CAST(N'1999-02-21T00:00:00.000' AS DateTime), CAST(N'1999-02-26T00:00:00.000' AS DateTime), N'Calgary/Houston/Calgary', N'Houston', 620.0000, 31.0000, 220, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (226, 460, CAST(N'1999-10-03T00:00:00.000' AS DateTime), CAST(N'1999-10-08T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 2585.0000, 60.0000, 226, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (228, 573, CAST(N'1999-12-03T00:00:00.000' AS DateTime), CAST(N'1999-12-07T00:00:00.000' AS DateTime), N'Ramada', N'Vancouver', 700.0000, 8.0500, 228, N'NA', N'SNG', N'BK', 35)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (263, 255, CAST(N'1999-05-01T00:00:00.000' AS DateTime), CAST(N'1999-06-01T00:00:00.000' AS DateTime), N'Calgary/Sydney/Calgary', N'Sydney, Australia', 2500.0000, 70.0000, 263, N'ANZ', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (265, 306, CAST(N'1999-05-02T00:00:00.000' AS DateTime), CAST(N'1999-05-31T00:00:00.000' AS DateTime), N'European golf package', N'Paris, France', 3000.0000, 112.5000, 264, N'EU', N'NA', N'GR', 36)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (266, 1076, CAST(N'1999-05-02T00:00:00.000' AS DateTime), CAST(N'1999-05-31T00:00:00.000' AS DateTime), N'Calgary/Paris/Calgary', N'Paris, France', 3000.0000, 70.0000, 266, N'EU', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (270, 331, CAST(N'1999-05-01T00:00:00.000' AS DateTime), CAST(N'1999-05-29T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 800.0000, 40.0000, 273, N'EU', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (273, 776, CAST(N'1999-05-01T00:00:00.000' AS DateTime), CAST(N'1999-05-29T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 800.0000, 40.0000, 273, N'EU', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (275, 255, CAST(N'1999-05-06T00:00:00.000' AS DateTime), CAST(N'1999-05-29T00:00:00.000' AS DateTime), N'Australian trek', N' ', 7900.0000, 296.2500, 263, N'ANZ', N'NA', N'BK', 15)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (276, 1132, CAST(N'1999-05-01T00:00:00.000' AS DateTime), CAST(N'1999-05-29T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 800.0000, 40.0000, 273, N'EU', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (287, 980, CAST(N'1999-05-29T00:00:00.000' AS DateTime), CAST(N'1999-06-03T00:00:00.000' AS DateTime), N'Calgary/Rio de Janeiro/Calgary', N'Rio de Janeiro, Brazil', 3590.0000, 70.0000, 287, N'SA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (305, 979, CAST(N'1999-06-05T00:00:00.000' AS DateTime), CAST(N'1999-06-10T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 2580.0000, 60.0000, 305, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (312, 398, CAST(N'1999-06-12T00:00:00.000' AS DateTime), CAST(N'1999-06-17T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 615.0000, 30.7500, 312, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (313, 775, CAST(N'1999-06-12T00:00:00.000' AS DateTime), CAST(N'1999-06-17T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 2258.0000, 60.0000, 313, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (322, 404, CAST(N'1999-07-11T00:00:00.000' AS DateTime), CAST(N'1999-07-18T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 630.0000, 31.5000, 322, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (325, 874, CAST(N'1999-07-17T00:00:00.000' AS DateTime), CAST(N'1999-08-02T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 630.0000, 31.5000, 325, N'NA', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (327, 228, CAST(N'1999-07-25T00:00:00.000' AS DateTime), CAST(N'1999-08-10T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 900.0000, 45.0000, 98, N'EU', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (369, 481, CAST(N'1999-10-01T00:00:00.000' AS DateTime), CAST(N'1999-10-06T00:00:00.000' AS DateTime), N'intermediate car', N'Paris, France', 500.0000, 15.5000, 369, N'EU', N'NA', N'BK', 32)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (375, 492, CAST(N'1999-10-01T00:00:00.000' AS DateTime), CAST(N'1999-10-06T00:00:00.000' AS DateTime), N'Hilton', N'Paris, France', 650.0000, 7.4750, 375, N'EU', N'DLX', N'BK', 31)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (381, 610, CAST(N'1999-10-01T00:00:00.000' AS DateTime), CAST(N'1999-10-06T00:00:00.000' AS DateTime), N'Calgary/Paris/Calgary', N'Paris, France', 3560.0000, 70.0000, 381, N'EU', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (382, 619, CAST(N'1999-10-07T00:00:00.000' AS DateTime), CAST(N'1999-10-12T00:00:00.000' AS DateTime), N'Hilton', N'London, England', 620.0000, 7.1300, 382, N'EU', N'DLX', N'BK', 31)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (384, 644, CAST(N'1999-10-07T00:00:00.000' AS DateTime), CAST(N'1999-10-12T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 600.0000, 30.0000, 384, N'EU', N'ECN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (409, 492, CAST(N'1999-10-22T00:00:00.000' AS DateTime), CAST(N'1999-11-03T00:00:00.000' AS DateTime), N'Medium size car', N'Greece', 500.0000, 15.5000, 409, N'MED', N'NA', N'NC', 55)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (410, 624, CAST(N'1999-10-21T00:00:00.000' AS DateTime), CAST(N'1999-11-04T00:00:00.000' AS DateTime), N'Calgary-Athens-Calgary', N'Greece', 1300.0000, 65.0000, 410, N'MED', N'ECN', N'BK', 7)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (424, 492, CAST(N'1999-10-27T00:00:00.000' AS DateTime), CAST(N'1999-10-30T00:00:00.000' AS DateTime), N'cruise on the Greek''s islands', N'Greece', 650.0000, 19.5000, 425, N'MED', N'INT', N'NC', 49)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (425, 492, CAST(N'1999-10-27T00:00:00.000' AS DateTime), CAST(N'1999-10-30T00:00:00.000' AS DateTime), N'cruise on the Greek''s islands', N'Greece', 650.0000, 19.5000, 425, N'MED', N'INT', N'NC', 49)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (442, 654, CAST(N'1999-11-04T00:00:00.000' AS DateTime), CAST(N'1999-11-09T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 629.0000, 31.4500, 442, N'EU', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (443, 691, CAST(N'1999-11-05T00:00:00.000' AS DateTime), CAST(N'1999-11-10T00:00:00.000' AS DateTime), N'Calgary/Paris/Calgary', N'Paris, France', 4599.0000, 70.0000, 443, N'EU', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (449, 645, CAST(N'1999-11-06T00:00:00.000' AS DateTime), CAST(N'1999-11-11T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 599.0000, 29.9500, 449, N'NA', N'ECN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (458, 323, CAST(N'1999-12-08T00:00:00.000' AS DateTime), CAST(N'1999-12-12T00:00:00.000' AS DateTime), N'Calgary/Edmonton/Calgary', N'Edmonton', 300.0000, 15.0000, 517, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (482, 740, CAST(N'1999-11-17T00:00:00.000' AS DateTime), CAST(N'1999-11-23T00:00:00.000' AS DateTime), N'Hilton', N'Sydney, Australia', 590.0000, 6.7850, 482, N'ANZ', N'DLX', N'BK', 31)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (484, 549, CAST(N'1999-11-14T00:00:00.000' AS DateTime), CAST(N'1999-11-19T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 600.0000, 30.0000, 484, N'NA', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (488, 601, CAST(N'1999-11-14T00:00:00.000' AS DateTime), CAST(N'1999-11-19T00:00:00.000' AS DateTime), N'Niagara on the Lake', N'Niagara', 675.0000, 7.7625, 488, N'NA', N'DLX', N'BK', 33)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (489, 1040, CAST(N'1999-11-17T00:00:00.000' AS DateTime), CAST(N'1999-11-23T00:00:00.000' AS DateTime), N'Calgary/Sydney/Calgary', N'Sydney, Australia', 625.0000, 31.2500, 489, N'ANZ', N'FST', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (510, 587, CAST(N'1999-12-02T00:00:00.000' AS DateTime), CAST(N'1999-12-06T00:00:00.000' AS DateTime), N'Ramada', N'Toronto', 650.0000, 7.4750, 510, N'NA', N'SNG', N'BK', 35)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (511, 745, CAST(N'1999-11-16T00:00:00.000' AS DateTime), CAST(N'1999-11-22T00:00:00.000' AS DateTime), N'Niagara on the Lake', N'Niagara', 620.0000, 7.1300, 511, N'NA', N'DLX', N'BK', 33)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (512, 903, CAST(N'1999-11-16T00:00:00.000' AS DateTime), CAST(N'1999-11-22T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 499.0000, 24.9500, 512, N'NA', N'ECN', N'BK', 23)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (517, 695, CAST(N'1999-12-02T00:00:00.000' AS DateTime), CAST(N'1999-12-06T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 700.0000, 35.0000, 517, N'NA', N'FST', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (529, 479, CAST(N'1999-12-12T00:00:00.000' AS DateTime), CAST(N'1999-12-19T00:00:00.000' AS DateTime), N'Calgary/Vancouver/Calgary', N'Vancouver', 350.0000, 17.5000, 529, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (546, 482, CAST(N'2000-01-10T00:00:00.000' AS DateTime), CAST(N'2000-01-15T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 800.0000, 40.0000, 546, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (553, 233, CAST(N'2000-01-13T00:00:00.000' AS DateTime), CAST(N'2000-01-18T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 750.0000, 37.5000, 553, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (594, 497, CAST(N'2000-01-20T00:00:00.000' AS DateTime), CAST(N'2000-01-25T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 650.0000, 32.5000, 594, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (596, 343, CAST(N'2000-02-06T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 850.0000, 42.5000, 596, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (598, 401, CAST(N'2000-02-06T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 850.0000, 42.5000, 598, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (600, 642, CAST(N'2000-02-06T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'cancellation/medical policy # 97543', N' ', 200.0000, 4.0000, 600, N'EU', N'NA', N'NC', 39)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (604, 651, CAST(N'2000-02-06T00:00:00.000' AS DateTime), CAST(N'2000-02-11T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 700.0000, 35.0000, 604, N'NA', N'FST', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (605, 780, CAST(N'2000-02-08T00:00:00.000' AS DateTime), CAST(N'2000-02-12T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 700.0000, 35.0000, 605, N'NA', N'FST', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (609, 588, CAST(N'2000-01-30T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N' ', N'Hong Kong, China', 900.0000, 10.3500, 609, N'ASIA', N'DLX', N'BK', 41)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (613, 629, CAST(N'2000-01-30T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'Calgary/Hong Kong/Calgary', N'Hong Kong, China', 5200.0000, 260.0000, 613, N'ASIA', N'FST', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (614, 629, CAST(N'2000-01-30T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'cancellation/medical policy # 98123', N' ', 250.0000, 5.0000, 614, N'ASIA', N'NA', N'NC', 39)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (618, 790, CAST(N'2000-02-06T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 700.0000, 35.0000, 618, N'NA', N'FST', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (622, 863, CAST(N'2000-02-06T00:00:00.000' AS DateTime), CAST(N'2000-02-10T00:00:00.000' AS DateTime), N'Radisson', N'London, England', 990.0000, 11.3850, 622, N'EU', N'DLX', N'BK', 37)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (631, 172, CAST(N'2000-02-05T00:00:00.000' AS DateTime), CAST(N'2000-02-09T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 750.0000, 37.5000, 631, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (665, 502, CAST(N'2000-02-29T00:00:00.000' AS DateTime), CAST(N'2000-03-03T00:00:00.000' AS DateTime), N'Calgary/Rio de Janeiro/Calgary', N'Rio de Janeiro, Brazil', 1130.0000, 56.5000, 665, N'SA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (676, 695, CAST(N'2000-03-03T00:00:00.000' AS DateTime), CAST(N'2000-03-06T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 800.0000, 40.0000, 676, N'NA', N'FST', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (677, 574, CAST(N'2000-02-29T00:00:00.000' AS DateTime), CAST(N'2000-03-03T00:00:00.000' AS DateTime), N'Radisson', N'Rio de Janeiro, Brazil', 1000.0000, 32.5000, 677, N'SA', N'DLX', N'BK', 37)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (682, 686, CAST(N'2000-02-29T00:00:00.000' AS DateTime), CAST(N'2000-03-03T00:00:00.000' AS DateTime), N'cancellation/medical policy # 92165', N' ', 230.0000, 4.6000, 682, N'SA', N'NA', N'NC', 45)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (689, 570, CAST(N'2000-03-14T00:00:00.000' AS DateTime), CAST(N'2000-04-05T00:00:00.000' AS DateTime), N'Calgary, Toronto,Montreal, Ottawa t', N'Canada', 3550.0000, 133.1250, 776, N'NA', N'NA', N'BK', 46)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (709, 471, CAST(N'2000-03-08T00:00:00.000' AS DateTime), CAST(N'2000-03-12T00:00:00.000' AS DateTime), N'Calgary/Houston/Calgary', N'Houston', 720.0000, 36.0000, 709, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (714, 555, CAST(N'2000-03-07T00:00:00.000' AS DateTime), CAST(N'2000-03-11T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 725.0000, 36.2500, 714, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (722, 548, CAST(N'2000-02-25T00:00:00.000' AS DateTime), CAST(N'2000-03-01T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 800.0000, 40.0000, 722, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (739, 1020, CAST(N'2000-03-15T00:00:00.000' AS DateTime), CAST(N'2000-04-05T00:00:00.000' AS DateTime), N'Calgary, Toronto,Montreal, Ottawa t', N'Canada', 3550.0000, 133.1250, 776, N'NA', N'NA', N'BK', 46)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (740, 589, CAST(N'2000-03-13T00:00:00.000' AS DateTime), CAST(N'2000-03-18T00:00:00.000' AS DateTime), N'Calgary/Houston/Calgary', N'Houston', 720.0000, 36.0000, 740, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (777, 672, CAST(N'2000-03-16T00:00:00.000' AS DateTime), CAST(N'2000-04-06T00:00:00.000' AS DateTime), N'cancellation policy # 11191817', N'USA, Mexic', 180.0000, 3.6000, 777, N'NA', N'NA', N'NC', 69)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (805, 833, CAST(N'2000-03-16T00:00:00.000' AS DateTime), CAST(N'2000-04-06T00:00:00.000' AS DateTime), N'CALGARY-LOS ANGELES-MexicoCity-CALG', N'USA, Mexic', 5175.0000, 194.0625, 805, N'NA', N'NA', N'BK', 67)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (826, 675, CAST(N'2000-03-23T00:00:00.000' AS DateTime), CAST(N'2000-04-17T00:00:00.000' AS DateTime), N'Calgary, Toronto,montreal, Ottawa t', N'Canada', 4780.0000, 179.2500, 826, N'NA', N'NA', N'BK', 57)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (827, 716, CAST(N'2000-03-27T00:00:00.000' AS DateTime), CAST(N'2000-03-27T00:00:00.000' AS DateTime), N'Ride Niagara', N'Canada', 150.0000, 0.0000, 827, N'NA', N'NA', N'BK', 58)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (838, 259, CAST(N'2000-04-10T00:00:00.000' AS DateTime), CAST(N'2000-04-15T00:00:00.000' AS DateTime), N'Calgary/Sydney/Calgary', N'Sydney, Australia', 2100.0000, 105.0000, 838, N'ANZ', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (852, 271, CAST(N'2000-04-14T00:00:00.000' AS DateTime), CAST(N'2000-04-19T00:00:00.000' AS DateTime), N'Calgary/Sydney/Calgary', N'Sydney, Australia', 2100.0000, 105.0000, 852, N'ANZ', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (857, 781, CAST(N'2000-04-14T00:00:00.000' AS DateTime), CAST(N'2000-04-19T00:00:00.000' AS DateTime), N'full-size car', N'Sydney, Australia', 800.0000, 24.8000, 857, N'ANZ', N'NA', N'NC', 61)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (866, 851, CAST(N'2000-04-14T00:00:00.000' AS DateTime), CAST(N'2000-04-19T00:00:00.000' AS DateTime), N'World Access', N'Sydney, Australia', 1900.0000, 61.7500, 866, N'ANZ', N'DLX', N'BK', 60)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (876, 1116, CAST(N'2000-04-14T00:00:00.000' AS DateTime), CAST(N'2000-04-19T00:00:00.000' AS DateTime), N'cancellation/medical policy # 95678', N' ', 230.0000, 4.6000, 876, N'ANZ', N'NA', N'NC', 47)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (880, 857, CAST(N'2000-04-10T00:00:00.000' AS DateTime), CAST(N'2000-04-15T00:00:00.000' AS DateTime), N'World Access', N'Sydney, Australia', 1900.0000, 61.7500, 880, N'ANZ', N'DLX', N'BK', 60)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (886, 1117, CAST(N'2000-04-10T00:00:00.000' AS DateTime), CAST(N'2000-04-15T00:00:00.000' AS DateTime), N'midsize car', N'Sydney, Australia', 900.0000, 27.9000, 884, N'ANZ', N'NA', N'NC', 61)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (902, 751, CAST(N'2000-04-25T00:00:00.000' AS DateTime), CAST(N'2000-05-16T00:00:00.000' AS DateTime), N'Calgary-Auckland flight', N'NZ', 3000.0000, 150.0000, 902, N'ANZ', N'BSN', N'BK', 19)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (910, 150, CAST(N'2000-05-16T00:00:00.000' AS DateTime), CAST(N'2000-05-25T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 900.0000, 45.0000, 910, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (940, 1131, CAST(N'2000-05-05T00:00:00.000' AS DateTime), CAST(N'2000-06-02T00:00:00.000' AS DateTime), N'Calgary/Toronto/Montreal tour', N'Canada', 2600.0000, 97.5000, 939, N'NA', N'FST', N'BK', 67)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (943, 821, CAST(N'2000-05-06T00:00:00.000' AS DateTime), CAST(N'2000-06-03T00:00:00.000' AS DateTime), N'Tahiti - South Seas', N' ', 8562.0000, 256.8600, 943, N'SP', N'INT', N'NC', 70)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (955, 141, CAST(N'2000-05-13T00:00:00.000' AS DateTime), CAST(N'2000-05-22T00:00:00.000' AS DateTime), N'Calgary/Paris/Calgary', N'Paris, France', 950.0000, 47.5000, 973, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (960, 186, CAST(N'2000-05-14T00:00:00.000' AS DateTime), CAST(N'2000-05-23T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 650.0000, 32.5000, 960, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (967, 392, CAST(N'2000-05-13T00:00:00.000' AS DateTime), CAST(N'2000-05-22T00:00:00.000' AS DateTime), N'World Access', N'Paris, France', 1200.0000, 39.0000, 973, N'EU', N'DLX', N'BK', 60)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (972, 812, CAST(N'2000-05-13T00:00:00.000' AS DateTime), CAST(N'2000-05-22T00:00:00.000' AS DateTime), N'midsize car', N'Paris, France', 850.0000, 26.3500, 973, N'EU', N'NA', N'NC', 61)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (973, 812, CAST(N'2000-05-13T00:00:00.000' AS DateTime), CAST(N'2000-05-22T00:00:00.000' AS DateTime), N'cancellation policy # 4987140', N' ', 300.0000, 6.0000, 973, N'EU', N'NA', N'NC', 47)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (988, 301, CAST(N'2000-05-19T00:00:00.000' AS DateTime), CAST(N'2000-06-19T00:00:00.000' AS DateTime), N'cancellation/medical policy #923665', N'Peru, argentina, Bollivi', 345.0000, 6.9000, 988, N'SA', N'NA', N'NC', 50)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (990, 757, CAST(N'2000-05-19T00:00:00.000' AS DateTime), CAST(N'2000-06-19T00:00:00.000' AS DateTime), N'Peru, Argentina, Bolivia tour', N' ', 3980.0000, 149.2500, 989, N'SA', N'NA', N'BK', 28)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1002, 846, CAST(N'2000-05-22T00:00:00.000' AS DateTime), CAST(N'2000-05-29T00:00:00.000' AS DateTime), N'Alaska', N' ', 2531.0000, 75.9300, 1001, N'NA', N'INT', N'NC', 68)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1024, 346, CAST(N'2000-06-01T00:00:00.000' AS DateTime), CAST(N'2000-06-16T00:00:00.000' AS DateTime), N'Asia-Africa-Mediteranean', N' ', 12630.0000, 378.9000, 1075, N'MED', N'ECN', N'NC', 70)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1034, 716, CAST(N'2000-06-03T00:00:00.000' AS DateTime), CAST(N'2000-06-28T00:00:00.000' AS DateTime), N'Calgary-Vancouver flight', N'canada', 139.0000, 6.9500, 1034, N'NA', N'FST', N'BK', 19)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1067, 720, CAST(N'2000-06-06T00:00:00.000' AS DateTime), CAST(N'2000-07-01T00:00:00.000' AS DateTime), N'Calgary-toronto-montreal flight', N'Canada', 1000.0000, 50.0000, 1067, N'NA', N'FST', N'BK', 64)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1073, 761, CAST(N'2000-06-06T00:00:00.000' AS DateTime), CAST(N'2000-07-01T00:00:00.000' AS DateTime), N'Toronto-Montreal-ottawa tour', N'Canada', 3080.0000, 115.5000, 1073, N'NA', N'NA', N'BK', 48)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1089, 827, CAST(N'2000-05-30T00:00:00.000' AS DateTime), CAST(N'2000-06-07T00:00:00.000' AS DateTime), N'Alaska plus air', N' ', 3652.0000, 109.5600, 1089, N'NA', N'INT', N'NC', 75)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1105, 831, CAST(N'2000-05-30T00:00:00.000' AS DateTime), CAST(N'2000-06-14T00:00:00.000' AS DateTime), N'Ryndam - Time Travel', N' ', 5506.0000, 165.1800, 1105, N'SA', N'OCNV', N'NC', 70)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1141, 816, CAST(N'2000-05-20T00:00:00.000' AS DateTime), CAST(N'2000-05-20T00:00:00.000' AS DateTime), N'Royal Ontario Museum', N'Canada', 25.0000, 0.0000, 1141, N'NA', N'NA', N'NC', 79)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1165, 355, CAST(N'2000-07-08T00:00:00.000' AS DateTime), CAST(N'2000-07-16T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 850.0000, 42.5000, 1165, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1178, 846, CAST(N'2000-07-08T00:00:00.000' AS DateTime), CAST(N'2000-07-13T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 850.0000, 42.5000, 1178, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1188, 631, CAST(N'2000-07-29T00:00:00.000' AS DateTime), CAST(N'2000-08-16T00:00:00.000' AS DateTime), N'Explorer cruise plus air', N' ', 7593.0000, 227.7900, 1187, N'SA', N'OCNV', N'NC', 75)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1192, 250, CAST(N'2000-08-12T00:00:00.000' AS DateTime), CAST(N'2000-08-16T00:00:00.000' AS DateTime), N'Calgary/Cape Town/Calgary', N'Cape Town, South Africa', 2500.0000, 125.0000, 1192, N'AFR', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1194, 375, CAST(N'2000-08-12T00:00:00.000' AS DateTime), CAST(N'2000-08-15T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 870.0000, 43.5000, 1194, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1202, 154, CAST(N'2000-08-27T00:00:00.000' AS DateTime), CAST(N'2000-09-01T00:00:00.000' AS DateTime), N'Calgary/Hong Kong/Calgary', N'Hong Kong, China', 1700.0000, 85.0000, 1202, N'ASIA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1206, 605, CAST(N'2000-08-25T00:00:00.000' AS DateTime), CAST(N'2000-08-30T00:00:00.000' AS DateTime), N'Calgary/Toronto/Calgary', N'Toronto', 750.0000, 37.5000, 1206, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1207, 188, CAST(N'2000-08-27T00:00:00.000' AS DateTime), CAST(N'2000-09-01T00:00:00.000' AS DateTime), N' ', N'Hong Kong, China', 2000.0000, 65.0000, 1207, N'ASIA', N'BSN', N'NC', 41)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1228, 527, CAST(N'2000-08-24T00:00:00.000' AS DateTime), CAST(N'2000-08-29T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 900.0000, 45.0000, 1228, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1230, 864, CAST(N'2000-08-24T00:00:00.000' AS DateTime), CAST(N'2000-08-29T00:00:00.000' AS DateTime), N'Calgary/Athens/Calgary', N'Athens, Greece', 1100.0000, 55.0000, 1230, N'MED', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1240, 435, CAST(N'2000-09-26T00:00:00.000' AS DateTime), CAST(N'2000-10-01T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 950.0000, 47.5000, 1240, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1248, 421, CAST(N'2000-09-25T00:00:00.000' AS DateTime), CAST(N'2000-09-30T00:00:00.000' AS DateTime), N'Calgary/Montreal/Calgary', N'Montreal', 950.0000, 47.5000, 1248, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1251, 177, CAST(N'2000-09-23T00:00:00.000' AS DateTime), CAST(N'2000-09-28T00:00:00.000' AS DateTime), N'Calgary/London/Calgary', N'London, England', 900.0000, 45.0000, 1251, N'EU', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1254, 420, CAST(N'2000-09-23T00:00:00.000' AS DateTime), CAST(N'2000-09-28T00:00:00.000' AS DateTime), N' ', N'London, England', 1500.0000, 48.7500, 1254, N'EU', N'DLX', N'BK', 82)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1270, 239, CAST(N'2000-12-01T00:00:00.000' AS DateTime), CAST(N'2000-12-10T00:00:00.000' AS DateTime), N'Calgary/Cape Town/Calgary', N'Cape Town, South Africa', 2700.0000, 135.0000, 1270, N'AFR', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1293, 596, CAST(N'2000-12-01T00:00:00.000' AS DateTime), CAST(N'2000-12-10T00:00:00.000' AS DateTime), N' ', N'Cape Town, South Africa', 2500.0000, 81.2500, 1293, N'AFR', N'DLX', N'BK', 42)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1301, 534, CAST(N'2001-01-05T00:00:00.000' AS DateTime), CAST(N'2001-01-09T00:00:00.000' AS DateTime), N'Calgary/Cape Town/Calgary', N'Cape Town, South Africa', 2700.0000, 135.0000, 1301, N'AFR', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1302, 535, CAST(N'2001-01-05T00:00:00.000' AS DateTime), CAST(N'2001-01-09T00:00:00.000' AS DateTime), N'Calgary/Winnipeg/Calgary', N'Winnipeg', 450.0000, 22.5000, 1302, N'NA', N'BSN', N'BK', 44)
GO
INSERT [dbo].[BookingDetails] ([BookingDetailId], [ItineraryNo], [TripStart], [TripEnd], [Description], [Destination], [BasePrice], [AgencyCommission], [BookingId], [RegionId], [ClassId], [FeeId], [ProductSupplierId]) VALUES (1303, 902, CAST(N'2001-01-05T00:00:00.000' AS DateTime), CAST(N'2001-01-09T00:00:00.000' AS DateTime), N' ', N'Cape Town, South Africa', 2500.0000, 81.2500, 1303, N'AFR', N'DLX', N'BK', 42)
GO
SET IDENTITY_INSERT [dbo].[BookingDetails] OFF
GO
SET IDENTITY_INSERT [dbo].[Bookings] ON 
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (11, CAST(N'2001-01-31T00:00:00.000' AS DateTime), N'DFS3', 1, 143, N'B', 1)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (15, CAST(N'2001-03-05T00:00:00.000' AS DateTime), N'WDR898', 1, 135, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (17, CAST(N'2001-03-06T00:00:00.000' AS DateTime), N'FES3', 1, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (34, CAST(N'2001-03-24T00:00:00.000' AS DateTime), N'S935', 2, 138, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (46, CAST(N'2001-03-30T00:00:00.000' AS DateTime), N'SKJ329', 2, 133, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (49, CAST(N'2001-03-31T00:00:00.000' AS DateTime), N'S943', 2, 114, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (52, CAST(N'2001-04-01T00:00:00.000' AS DateTime), N'S934', 2, 133, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (55, CAST(N'2001-04-03T00:00:00.000' AS DateTime), N'SDFJ3982', 2, 133, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (57, CAST(N'2001-08-08T00:00:00.000' AS DateTime), N'FJKD344', 2, 130, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (62, CAST(N'2001-11-25T00:00:00.000' AS DateTime), N'SCR39', 2, 130, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (65, CAST(N'2001-12-17T00:00:00.000' AS DateTime), N'HK777', 1, 143, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (73, CAST(N'2002-01-27T00:00:00.000' AS DateTime), N'SW34', 1, 143, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (79, CAST(N'2002-02-12T00:00:00.000' AS DateTime), N'MKI333', 2, 120, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (80, CAST(N'2002-02-13T00:00:00.000' AS DateTime), N'MKI334', 2, 122, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (84, CAST(N'2002-02-15T00:00:00.000' AS DateTime), N'KK890', 2, 120, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (89, CAST(N'2002-03-03T00:00:00.000' AS DateTime), N'DF344', 1, 109, N'L', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (98, CAST(N'2002-03-22T00:00:00.000' AS DateTime), N'JI8787', 1, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (108, CAST(N'2002-04-04T00:00:00.000' AS DateTime), N'MKI338', 2, 138, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (124, CAST(N'2002-04-29T00:00:00.000' AS DateTime), N'SJKDK89', 2, 114, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (138, CAST(N'2002-05-28T00:00:00.000' AS DateTime), N'HJK78', 1, 109, N'L', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (141, CAST(N'2002-06-01T00:00:00.000' AS DateTime), N'KL888', 1, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (148, CAST(N'2002-06-28T00:00:00.000' AS DateTime), N'LJ888', 2, 133, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (152, CAST(N'2002-08-15T00:00:00.000' AS DateTime), N'WS343', 2, 130, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (156, CAST(N'2002-09-23T00:00:00.000' AS DateTime), N'JKKO9', 1, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (161, CAST(N'2002-09-27T00:00:00.000' AS DateTime), N'SG4SD', 1, 105, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (162, CAST(N'2002-09-28T00:00:00.000' AS DateTime), N'GFRER4', 1, 109, N'B', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (172, CAST(N'2002-10-03T00:00:00.000' AS DateTime), N'FGFD64', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (187, CAST(N'1999-01-01T00:00:00.000' AS DateTime), N'ZAQ344', 1, 109, N'B', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (199, CAST(N'1999-01-15T00:00:00.000' AS DateTime), N'JSD39', 1, 143, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (204, CAST(N'1999-01-18T00:00:00.000' AS DateTime), N'XVV67', 1, 141, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (220, CAST(N'1999-01-29T00:00:00.000' AS DateTime), N'BCV5', 1, 127, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (226, CAST(N'1999-02-19T00:00:00.000' AS DateTime), N'DS3DF', 1, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (228, CAST(N'1999-02-20T00:00:00.000' AS DateTime), N'KF83', 1, 119, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (263, CAST(N'1999-03-17T00:00:00.000' AS DateTime), N'CBB34', 2, 120, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (264, CAST(N'1999-03-18T00:00:00.000' AS DateTime), N'SDF890', 1, 135, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (266, CAST(N'1999-03-18T00:00:00.000' AS DateTime), N'AZX24', 2, 135, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (273, CAST(N'1999-03-21T00:00:00.000' AS DateTime), N'DGG33', 2, 122, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (287, CAST(N'1999-04-15T00:00:00.000' AS DateTime), N'7898797', 1, 141, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (305, CAST(N'1999-04-21T00:00:00.000' AS DateTime), N'XC2', 1, 127, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (312, CAST(N'1999-04-28T00:00:00.000' AS DateTime), N'SDSD33', 1, 130, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (313, CAST(N'1999-04-29T00:00:00.000' AS DateTime), N'SD46', 1, 120, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (322, CAST(N'1999-05-27T00:00:00.000' AS DateTime), N'FJSDKL833', 1, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (325, CAST(N'1999-06-02T00:00:00.000' AS DateTime), N'HJJK77', 1, 121, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (369, CAST(N'1999-08-18T00:00:00.000' AS DateTime), N'KJ392', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (375, CAST(N'1999-08-21T00:00:00.000' AS DateTime), N'SDJF382', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (381, CAST(N'1999-08-23T00:00:00.000' AS DateTime), N'JDKJF8343', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (382, CAST(N'1999-08-23T00:00:00.000' AS DateTime), N'FDJ93', 1, 119, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (384, CAST(N'1999-08-24T00:00:00.000' AS DateTime), N'JHJH7', 1, 119, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (409, CAST(N'1999-09-07T00:00:00.000' AS DateTime), N'FD53767', 2, 139, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (410, CAST(N'1999-09-07T00:00:00.000' AS DateTime), N'JHK7', 2, 140, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (425, CAST(N'1999-09-12T00:00:00.000' AS DateTime), N'FG879', 4, 140, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (442, CAST(N'1999-09-21T00:00:00.000' AS DateTime), N'S53423', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (443, CAST(N'1999-09-21T00:00:00.000' AS DateTime), N'T345', 1, 119, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (449, CAST(N'1999-09-23T00:00:00.000' AS DateTime), N'RD4EW5', 1, 140, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (482, CAST(N'1999-10-03T00:00:00.000' AS DateTime), N'SKFJ32', 1, 127, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (484, CAST(N'1999-10-04T00:00:00.000' AS DateTime), N'GDEWR3', 1, 106, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (488, CAST(N'1999-10-05T00:00:00.000' AS DateTime), N'JDFS39', 1, 106, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (489, CAST(N'1999-10-05T00:00:00.000' AS DateTime), N'SDR54', 1, 127, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (510, CAST(N'1999-10-19T00:00:00.000' AS DateTime), N'HKK7', 1, 140, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (511, CAST(N'1999-10-20T00:00:00.000' AS DateTime), N'FJK3892', 1, 141, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (512, CAST(N'1999-10-20T00:00:00.000' AS DateTime), N'SG444', 1, 141, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (517, CAST(N'1999-10-21T00:00:00.000' AS DateTime), N'FSDW2', 1, 140, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (529, CAST(N'1999-10-28T00:00:00.000' AS DateTime), N'FKJD32', 1, 119, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (546, CAST(N'1999-11-27T00:00:00.000' AS DateTime), N'NKU7', 1, 140, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (553, CAST(N'1999-11-29T00:00:00.000' AS DateTime), N'KKU7', 1, 109, N'B', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (594, CAST(N'1999-12-06T00:00:00.000' AS DateTime), N'HNN77', 1, 119, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (596, CAST(N'1999-12-12T00:00:00.000' AS DateTime), N'FDKJ898', 1, 106, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (598, CAST(N'1999-12-13T00:00:00.000' AS DateTime), N'FDSK3', 1, 121, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (600, CAST(N'1999-12-14T00:00:00.000' AS DateTime), N'ILJ878', 2, 106, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (604, CAST(N'1999-12-15T00:00:00.000' AS DateTime), N'KFKESJK5', 1, 104, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (605, CAST(N'1999-12-15T00:00:00.000' AS DateTime), N'SDJ89342', 1, 140, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (609, CAST(N'1999-12-16T00:00:00.000' AS DateTime), N'KJLK89', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (613, CAST(N'1999-12-17T00:00:00.000' AS DateTime), N'FD2323', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (614, CAST(N'1999-12-17T00:00:00.000' AS DateTime), N'FGG66', 2, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (618, CAST(N'1999-12-18T00:00:00.000' AS DateTime), N'CMFJ39', 1, 119, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (622, CAST(N'1999-12-19T00:00:00.000' AS DateTime), N'JJJ77', 1, 106, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (631, CAST(N'1999-12-22T00:00:00.000' AS DateTime), N'MM78I879', 1, 130, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (665, CAST(N'2000-01-16T00:00:00.000' AS DateTime), N'FDSK83', 1, 140, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (676, CAST(N'2000-01-18T00:00:00.000' AS DateTime), N'SJK5', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (677, CAST(N'2000-01-18T00:00:00.000' AS DateTime), N'KJKJ88', 1, 140, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (682, CAST(N'2000-01-19T00:00:00.000' AS DateTime), N'GF887', 3, 140, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (709, CAST(N'2000-01-25T00:00:00.000' AS DateTime), N'MNHY15', 1, 104, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (714, CAST(N'2000-01-26T00:00:00.000' AS DateTime), N'KKJ91', 1, 140, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (722, CAST(N'2000-01-27T00:00:00.000' AS DateTime), N'FDJS32', 1, 119, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (740, CAST(N'2000-01-29T00:00:00.000' AS DateTime), N'MNHY19', 1, 119, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (776, CAST(N'2000-02-02T00:00:00.000' AS DateTime), N'345435F', 2, 109, N'L', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (777, CAST(N'2000-02-02T00:00:00.000' AS DateTime), N'AS54676', 2, 143, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (798, CAST(N'2000-02-04T00:00:00.000' AS DateTime), N'A7667900', 1, 143, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (805, CAST(N'2000-02-05T00:00:00.000' AS DateTime), N'456546DFD', 1, 143, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (826, CAST(N'2000-02-20T00:00:00.000' AS DateTime), N'62323', 4, 128, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (827, CAST(N'2000-02-20T00:00:00.000' AS DateTime), N'D869990', 2, 128, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (838, CAST(N'2000-02-25T00:00:00.000' AS DateTime), N'GFF84', 1, 141, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (852, CAST(N'2000-02-29T00:00:00.000' AS DateTime), N'GFF79', 1, 127, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (857, CAST(N'2000-03-01T00:00:00.000' AS DateTime), N'SFDFSD54', 2, 127, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (866, CAST(N'2000-03-02T00:00:00.000' AS DateTime), N'SFDFSD53', 1, 127, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (876, CAST(N'2000-03-03T00:00:00.000' AS DateTime), N'SFDFSD55', 1, 127, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (880, CAST(N'2000-03-04T00:00:00.000' AS DateTime), N'GFF85', 1, 141, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (884, CAST(N'2000-03-05T00:00:00.000' AS DateTime), N'GFF86', 2, 141, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (899, CAST(N'2000-03-15T00:00:00.000' AS DateTime), N'QERQ1322', 2, 121, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (902, CAST(N'2000-03-17T00:00:00.000' AS DateTime), N'D569767', 2, 121, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (910, CAST(N'2000-03-19T00:00:00.000' AS DateTime), N'GFF102', 1, 114, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (939, CAST(N'2000-03-25T00:00:00.000' AS DateTime), N'86431RT', 2, 120, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (943, CAST(N'2000-03-26T00:00:00.000' AS DateTime), N'34265Q67L', 2, 140, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (960, CAST(N'2000-03-30T00:00:00.000' AS DateTime), N'GFF105', 1, 122, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (973, CAST(N'2000-04-01T00:00:00.000' AS DateTime), N'GFF104', 2, 133, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (988, CAST(N'2000-04-04T00:00:00.000' AS DateTime), N'76584847', 1, 139, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (989, CAST(N'2000-04-04T00:00:00.000' AS DateTime), N'4656757Q', 1, 139, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1001, CAST(N'2000-04-07T00:00:00.000' AS DateTime), N'53165616', 2, 133, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1034, CAST(N'2000-04-19T00:00:00.000' AS DateTime), N'F789900', 2, 105, N'G', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1047, CAST(N'2000-04-20T00:00:00.000' AS DateTime), N'234244S', 2, 105, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1067, CAST(N'2000-04-22T00:00:00.000' AS DateTime), N'4325434RE', 2, 117, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1073, CAST(N'2000-04-23T00:00:00.000' AS DateTime), N'68798890', 2, 117, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1075, CAST(N'2000-04-23T00:00:00.000' AS DateTime), N'78755U', 2, 123, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1089, CAST(N'2000-04-24T00:00:00.000' AS DateTime), N'T6657D', 2, 142, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1105, CAST(N'2000-04-26T00:00:00.000' AS DateTime), N'53165765R', 1, 119, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1141, CAST(N'2000-05-04T00:00:00.000' AS DateTime), N'35653B', 1, 120, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1165, CAST(N'2000-05-25T00:00:00.000' AS DateTime), N'LJJ113', 1, 127, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1178, CAST(N'2000-05-30T00:00:00.000' AS DateTime), N'LJJ108', 1, 118, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1187, CAST(N'2000-06-14T00:00:00.000' AS DateTime), N'R4777FG', 1, 143, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1192, CAST(N'2000-06-28T00:00:00.000' AS DateTime), N'LJJ115', 1, 109, N'B', 2)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1194, CAST(N'2000-06-29T00:00:00.000' AS DateTime), N'LJJ114', 1, 141, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1202, CAST(N'2000-07-14T00:00:00.000' AS DateTime), N'LJJ126', 1, 135, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1206, CAST(N'2000-07-15T00:00:00.000' AS DateTime), N'LJJ131', 1, 121, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1207, CAST(N'2000-07-15T00:00:00.000' AS DateTime), N'FJS3492', 2, 135, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1228, CAST(N'2000-08-01T00:00:00.000' AS DateTime), N'LJJ120', 1, 106, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1230, CAST(N'2000-08-03T00:00:00.000' AS DateTime), N'LJJ121', 1, 107, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1240, CAST(N'2000-08-14T00:00:00.000' AS DateTime), N'FSDFJ357', 1, 127, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1248, CAST(N'2000-08-17T00:00:00.000' AS DateTime), N'FSDFJ358', 1, 141, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1251, CAST(N'2000-09-09T00:00:00.000' AS DateTime), N'FSDFJ349', 1, 130, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1254, CAST(N'2000-09-12T00:00:00.000' AS DateTime), N'KJFKD89', 1, 130, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1270, CAST(N'2000-10-17T00:00:00.000' AS DateTime), N'FSD82937', 1, 130, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1293, CAST(N'2000-10-22T00:00:00.000' AS DateTime), N'KJLK89234', 1, 130, N'L', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1301, CAST(N'2000-11-21T00:00:00.000' AS DateTime), N'FSD82940', 1, 127, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1302, CAST(N'2000-11-22T00:00:00.000' AS DateTime), N'FSD82941', 1, 141, N'B', NULL)
GO
INSERT [dbo].[Bookings] ([BookingId], [BookingDate], [BookingNo], [TravelerCount], [CustomerId], [TripTypeId], [PackageId]) VALUES (1303, CAST(N'2000-11-23T00:00:00.000' AS DateTime), N'KJk934', 1, 127, N'B', NULL)
GO
SET IDENTITY_INSERT [dbo].[Bookings] OFF
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'BSN', N'Business Class', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'DBL', N'Double', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'DLX', N'Delux', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'ECN', N'Economy', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'FST', N'First Class', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'INT', N'Interior', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'NA', N'Not Applicable', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'OCNV', N'Ocean View', NULL)
GO
INSERT [dbo].[Classes] ([ClassId], [ClassName], [ClassDesc]) VALUES (N'SNG', N'Single', NULL)
GO
SET IDENTITY_INSERT [dbo].[CreditCards] ON 
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (2, N'AMEX', N'12342324248393', CAST(N'2003-04-03T00:00:00.000' AS DateTime), 123)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (26, N'AMEX', N'33454212345651', CAST(N'2003-09-29T00:00:00.000' AS DateTime), 127)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (28, N'AMEX', N'3422343212433430', CAST(N'2003-07-19T00:00:00.000' AS DateTime), 107)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (30, N'AMEX', N'34458998784345', CAST(N'2002-08-22T00:00:00.000' AS DateTime), 140)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (31, N'AMEX', N'345433789979389', CAST(N'1999-11-05T00:00:00.000' AS DateTime), 130)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (41, N'AMEX', N'3522354387984530', CAST(N'2002-06-09T00:00:00.000' AS DateTime), 106)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (63, N'AMEX', N'632456487984533', CAST(N'2003-01-02T00:00:00.000' AS DateTime), 142)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (69, N'AMEX', N'78789007977999', CAST(N'2002-08-22T00:00:00.000' AS DateTime), 104)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (91, N'AMEX', N'904883289756439', CAST(N'2002-01-19T00:00:00.000' AS DateTime), 133)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (99, N'Diners', N'12093458976902', CAST(N'2002-11-02T00:00:00.000' AS DateTime), 143)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (123, N'Diners', N'24348343482482', CAST(N'2003-11-25T00:00:00.000' AS DateTime), 109)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (141, N'Diners', N'3749234924723790', CAST(N'2003-05-01T00:00:00.000' AS DateTime), 128)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (163, N'Diners', N'6788922940392940', CAST(N'2002-10-12T00:00:00.000' AS DateTime), 139)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (167, N'Diners', N'699834387984533', CAST(N'2003-01-04T00:00:00.000' AS DateTime), 118)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (169, N'Diners', N'7482794729742320', CAST(N'2002-04-12T00:00:00.000' AS DateTime), 117)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (185, N'Diners', N'8901128935238970', CAST(N'1999-10-20T00:00:00.000' AS DateTime), 141)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (201, N'MC', N'3424345432894320', CAST(N'2002-01-22T00:00:00.000' AS DateTime), 120)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (230, N'VISA', N'12122387984533', CAST(N'2003-12-13T00:00:00.000' AS DateTime), 121)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (239, N'VISA', N'2311240543980120', CAST(N'2002-11-03T00:00:00.000' AS DateTime), 114)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (243, N'VISA', N'23958389028923', CAST(N'2002-08-22T00:00:00.000' AS DateTime), 119)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (252, N'VISA', N'3456683343353430', CAST(N'2002-10-29T00:00:00.000' AS DateTime), 135)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (272, N'VISA', N'6543254233444530', CAST(N'2002-01-22T00:00:00.000' AS DateTime), 122)
GO
INSERT [dbo].[CreditCards] ([CreditCardId], [CCName], [CCNumber], [CCExpiry], [CustomerId]) VALUES (279, N'VISA', N'78789007977999', CAST(N'2002-08-22T00:00:00.000' AS DateTime), 105)
GO
SET IDENTITY_INSERT [dbo].[CreditCards] OFF
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (104, N'Laetia', N'Enison', N'144-61 87th Ave, NE', N'Calgary', N'AB', N'T2J 6B6', N'Canada', N'4032791223', N'4032557865', N'                                                  ', 4, N'Laetia', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (105, N'Angel', N'Moskowitz', N'320 John St., NE', N'Calgary', N'AB', N'T2J 7E3', N'Canada', N'4032794228', N'4036409874', N'amoskowitz@home.com                               ', 3, N'Angel', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (106, N'Judith', N'Olvsade', N'29 Elmwood Ave.,', N'Calgary', N'AB', N'T2Z 3M9', N'Canada', N'4032795652', N'4036861598', N'jolvsade@aol.com                                  ', 1, N'Judith', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (107, N'Catherine', N'Mierzwa', N'22-70 41st St.,NW', N'Calgary', N'AB', N'T2Z 2Z9', N'Canada', N'4032796878', N'4036404563', N'cmierzwa@msn.com                                  ', 5, N'Catherine', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (108, N'Judy', N'Sethi', N'63 Stratton Hall, SW', N'Calgary', N'AB', N'T1Y 6N4', N'Canada', N'4032795111', N'4036204789', N'judysehti@home.com                                ', 7, N'Judy', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (109, N'Larry', N'Walter', N'38 Bay 26th ST. #2A, NE', N'Calgary', N'AB', N'T2J 6B6', N'Canada', N'4032793254', N'4032845588', N'lwalter@aol.com                                   ', 4, N'Larry', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (114, N'Winsome', N'Laporte', N'268 E.3rd St, SW', N'Calgary', N'AB', N'T1Y 6N4', N'Canada', N'4032691125', N'4032844565', N'                                                  ', 8, N'Winsome', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (117, N'Nancy', N'Kuehn', N'44-255 9th St., SW', N'Calgary', N'AB', N'T1Y 6N5', N'Canada', N'4032693965', N'4032843211', N'                                                  ', 6, N'Nancy', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (118, N'Hiedi', N'Lopez', N'168 Rowayton Ave, NW', N'Calgary', N'AB', N'T3A 4ZG', N'Canada', N'4032699856', N'4035901587', N'hlopez@aol.com                                    ', 5, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (119, N'Mardig', N'Abdou', N'160-04 32nd Ave., SW', N'Calgary', N'AB', N'T2P 2G7', N'Canada', N'4032691429', N'4032251952', N'                                                  ', 9, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (120, N'Ralph', N'Alexander', N'2054 73rd St, SW', N'Calgary', N'AB', N'T2P 2G7', N'Canada', N'4032691634', N'4032256547', N'                                                  ', 1, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (121, N'Sean', N'Pineda', N'3 Salem Rd., NW', N'Calgary', N'AB', N'T2K 3E3', N'Canada', N'4032691954', N'4036864444', N'spineda@hotmail.com                               ', 3, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (122, N'Julita', N'Lippen', N'51-76 VanKleeck St., NW', N'Calgary', N'AB', N'T2K 6C5', N'Canada', N'4032551956', N'4035901478', N'jlippen@cadvision.co                              ', 4, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (123, N'Pierre', N'Radicola', N'322 Atkins Ave., SE', N'Calgary', N'AB', N'T3G 2C6', N'Canada', N'4032551677', N'4036867536', N'pradicola@home.com                                ', 8, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (127, N'Gary', N'Aung', N'135-32 Louis Blvd, NE', N'Calgary', N'AB', N'T2V 2K5', N'Canada', N'4032807858', N'4037501587', N'                                                  ', 9, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (128, N'Jeff', N'Runyan', N'109-15 Queens Blvd., NE', N'Calgary', N'AB', N'T2V 2K6', N'Canada', N'4032809635', N'4036201122', N'jrunyan@aol.com                                   ', 5, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (130, N'Lula', N'Oates', N'11A Emory St., NE', N'Calgary', N'AB', N'T3E 3Z4', N'Canada', N'4032439653', N'4036861587', N'loates@aol.com                                    ', 9, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (133, N'James', N'Reed', N'109-621 96th St, NE', N'Calgary', N'AB', N'T3E 4A1', N'Canada', N'4032432358', N'4037201155', N'jreed@aol.com                                     ', 2, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (135, N'Michelle', N'Masser', N'379 Ovington Ave, NE', N'Calgary', N'AB', N'T2J 2S9', N'Canada', N'4032441586', N'4035908522', N'mmasser@aol.com                                   ', 6, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (138, N'John', N'Smith', N'45 Plaza St. West #2D, NE', N'Calgary', N'AB', N'T3E 5C7', N'Canada', N'4032449653', N'4032837896', N'johnSmith@hotmail.co                              ', 7, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (139, N'Angelo', N'Garshman', N'82 Western Ave., NE', N'Calgary', N'AB', N'T3E 5C8', N'Canada', N'4032259966', N'4032696541', N'                                                  ', 3, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (140, N'Derrick', N'Baltazar', N'9111 Church Ave. #3N, NE', N'Calgary', N'AB', N'T3E 5C9', N'Canada', N'4032255231', N'4037502547', N'                                                  ', 6, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (141, N'Robert', N'Boyd', N'96-04 57th Ave #12A, NE', N'Calgary', N'AB', N'T3E 5C5', N'Canada', N'4032255647', N'4037509512', N'                                                  ', 3, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (142, N'Monica', N'Waldman', N'257 Depot Rd., NE', N'Calgary', N'AB', N'T2J 6P3', N'Canada', N'4032255629', N'4032844566', N'mwaldman@aol.com                                  ', 2, NULL, NULL)
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (143, N'Gerardzs', N'Biers', N'205 19th St., NE', N'Calgary', N'AB', N'T2J 6B6', N'Canada', N'4032251952', N'4037506578', N'                                                  ', 8, N'Person', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (144, N'Client', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'AB', N'T2E0Z5', N'Canada', N'4036906443', N'', N'', NULL, N'Pup', N'4tj2WiIp19LQNT5f1vjpvEG8la2dKoeP5Cc6XQeVqQA=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (145, N'Client', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'ON', N'T2E0Z5', N'CAN', N'4036906443', N'4036906443', N'Client@service.com', NULL, N'bob', N'pooi')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (146, N'John', N'Johnson', N'Johnson st', N'Johnsonville', N'AB', N'T2Z 9T5', N'Canada', N'4036906443', N'4037506578', N'Client@service.com', NULL, N'Yoshi', N'Sama')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (147, N'Hamish', N'Nakamura', N'514', N'Lava', N'QB', N'T2E0Z3', N'Canada land', N'4234123123', N'1235211123', N'ham@hammyham.com', NULL, N'Tail', N'cRQsg/EUGP7AWNQwWNRA7tf6+SRyck5ON66QG0Msgg4=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (153, N'TestPerson', N'Exams', N'555', N'Calgary', N'AB', N'T2M1J5', N'Canada', N'4036777865', N'4236665432', N'Email@email.com', NULL, N'TestPerson', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (154, N'Gerard', N'beer', N'205 19th St., NE', N'Calgary', N'AB', N'T2J 6B6', N'Canada', N'4037506578', N'4037506578', N'', NULL, N'asdasd', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (155, N'Client', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'ON', N'T2E0Z5', N'Canada', N'4036906443', N'', N'Client@service.com', NULL, N'Shiba', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (156, N'Client', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'ON', N'T2E0Z5', N'Canada', N'4036906443', N'', N'', NULL, N'Fred', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (148, N'Bill', N'Brasky', N'666 Ave NW', N'Satanville', N'AB', N'T2E0Z5', N'Canada', N'4036666666', N'', N'', NULL, N'Satan', N'vraeJ3foyu5A4skk1ZhWKjDCQdk/e0zhKmBp/iVNMqg=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (149, N'Client', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'ON', N'T2E0Z5', N'CAN', N'4036906443', N'', N'Client@service.com', NULL, N'Pupper', N'4tj2WiIp19LQNT5f1vjpvEG8la2dKoeP5Cc6XQeVqQA=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (150, N'asdsdf', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'ON', N'T2E0Z5', N'Canada', N'4036906443', N'4036906443', N'Client@service.com', NULL, N'asdasd@hotmail.com', N'588+9PF8OZmpTyxvYS6KiI5bECaHjk4ZOYsjvTjsIho=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (151, N'Client', N'Bigmoney', N'555 555 5th street SW', N'Clouds', N'ON', N'T2E0Z5', N'Pakistan', N'4036906443', N'', N'', NULL, N'Pup1', N'RlTXk5csO2odSPsKtY2csN5Gw9M9YF+SIsKD36oS1CA=')
GO
INSERT [dbo].[Customers] ([CustomerId], [CustFirstName], [CustLastName], [CustAddress], [CustCity], [CustProv], [CustPostal], [CustCountry], [CustHomePhone], [CustBusPhone], [CustEmail], [AgentId], [UserName], [Password]) VALUES (152, N'Zoha', N'Ahmed', N'605 ', N'Calgary', N'AB', N'T3G 3S2', N'Canada', N'4036906443', N'', N'', NULL, N'zoha1', N'A6xnQhbz4Vx2HuGl4lXwZ5U2I8iziLRFnhP5eNfIRvQ=')
GO
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (104, 1, N'123456 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (104, 2, N'5435 678 CF')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (105, 2, N'1435 678 CA')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (106, 1, N'123456 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (106, 4, N'4643 23 5435')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (107, 2, N'5735 638 CF')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (107, 5, N'2354 4583 63A')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (108, 1, N'129456 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (109, 4, N'4343 23 5435')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (109, 5, N'2784 4553 63F')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (114, 2, N'5875 678 CG')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (117, 1, N'123456 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (118, 3, N'FG2343 785')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (123, 2, N'5435 678 CF')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (127, 1, N'113526 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (138, 1, N'124256 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (140, 4, N'4343 23 5435')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (142, 1, N'123456 4322')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (142, 3, N'FG2343 785')
GO
INSERT [dbo].[Customers_Rewards] ([CustomerId], [RewardId], [RwdNumber]) VALUES (142, 5, N'2254 4553 63Z')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Janet', NULL, N'Delton', N'(403) 210-7801', N'janet.delton@travelexperts.com', N'Senior Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Judy', NULL, N'Lisle', N'(403) 210-7802', N'judy.lisle@travelexperts.com', N'Intermediate Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Dennis', N'C.', N'Reynolds', N'(403) 210-7843', N'dennis.reynolds@travelexperts.com', N'Junior Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'John', NULL, N'Coville', N'(403) 210-7823', N'john.coville@travelexperts.com', N'Intermediate Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Janice', N'W.', N'Dahl', N'(403) 210-7865', N'janice.dahl@travelexperts.com', N'Manager')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Bruce', N'J.', N'Dixon', N'(403) 210-7867', N'bruce.dixon@travelexperts.com', N'Intermediate Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Beverly', N'S.', N'Jones', N'(403) 210-7812', N'beverly.jones@travelexperts.com', N'Intermediate Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Jane', NULL, N'Merrill', N'(403) 210-7868', N'jane.merrill@travelexperts.com', N'Senior Agent')
GO
INSERT [dbo].[Employees] ([EmpFirstName], [EmpMiddleInitial], [EmpLastName], [EmpBusPhone], [EmpEmail], [EmpPosition]) VALUES (N'Brian', N'S.', N'Peterson', N'(403) 210-7833', N'brian.peterson@travelexperts.com', N'Junior Agent')
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'BK', N'Booking Charge', 25.0000, NULL)
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'CH', N'Change', 15.0000, NULL)
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'GR', N'Group Booking', 100.0000, NULL)
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'NC', N'No Charge', 0.0000, NULL)
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'NSF', N'Insufficient Funds', 25.0000, NULL)
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'RF', N'Refund', 25.0000, NULL)
GO
INSERT [dbo].[Fees] ([FeeId], [FeeName], [FeeAmt], [FeeDesc]) VALUES (N'RS', N'Research', 50.0000, NULL)
GO
SET IDENTITY_INSERT [dbo].[Packages] ON 
GO
INSERT [dbo].[Packages] ([PackageId], [PkgName], [PkgStartDate], [PkgEndDate], [PkgDesc], [PkgBasePrice], [PkgAgencyCommission]) VALUES (1, N'Caribbean New Years', CAST(N'2005-12-25T00:00:00.000' AS DateTime), CAST(N'2008-01-04T00:00:00.000' AS DateTime), N'Cruise the Caribbean & Celebrate the New Year.', 500.0000, 90.0000)
GO
INSERT [dbo].[Packages] ([PackageId], [PkgName], [PkgStartDate], [PkgEndDate], [PkgDesc], [PkgBasePrice], [PkgAgencyCommission]) VALUES (2, N'cad', CAST(N'2005-12-12T00:00:00.000' AS DateTime), CAST(N'2005-12-20T00:00:00.000' AS DateTime), N'8 Day All Inclusive Hawaiian Vacation', 3050.0000, 250.0000)
GO
INSERT [dbo].[Packages] ([PackageId], [PkgName], [PkgStartDate], [PkgEndDate], [PkgDesc], [PkgBasePrice], [PkgAgencyCommission]) VALUES (4, N'European Vacations', CAST(N'2005-11-01T00:00:00.000' AS DateTime), CAST(N'2005-11-14T00:00:00.000' AS DateTime), N'Euro Tour with Rail Pass and Travel Insurance', 3000.0000, 280.0000)
GO
INSERT [dbo].[Packages] ([PackageId], [PkgName], [PkgStartDate], [PkgEndDate], [PkgDesc], [PkgBasePrice], [PkgAgencyCommission]) VALUES (5, N'Egyptian Nile Float', CAST(N'2020-05-05T00:00:00.000' AS DateTime), CAST(N'2020-06-06T00:00:00.000' AS DateTime), N'Go to Egypt and float down nile', 500.0000, 5.0000)
GO
SET IDENTITY_INSERT [dbo].[Packages] OFF
GO
INSERT [dbo].[Packages_Products_Suppliers] ([PackageId], [ProductSupplierId]) VALUES (4, 9)
GO
INSERT [dbo].[Packages_Products_Suppliers] ([PackageId], [ProductSupplierId]) VALUES (4, 65)
GO
INSERT [dbo].[Packages_Products_Suppliers] ([PackageId], [ProductSupplierId]) VALUES (4, 84)
GO
INSERT [dbo].[Packages_Products_Suppliers] ([PackageId], [ProductSupplierId]) VALUES (5, 4)
GO
SET IDENTITY_INSERT [dbo].[Products] ON 
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (1, N'Arik')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (2, N'Attractions')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (3, N'Car rental')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (4, N'Cruise')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (5, N'Hotel')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (6, N'Motor Coach')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (7, N'Railroad')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (8, N'Tourss')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (9, N'Travel Insurance')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (10, N'Yacht/Boat Char')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (11, N'Skiing')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (12, N'Swimming')
GO
INSERT [dbo].[Products] ([ProductId], [ProdName]) VALUES (13, N'Tea')
GO
SET IDENTITY_INSERT [dbo].[Products] OFF
GO
SET IDENTITY_INSERT [dbo].[Products_Suppliers] ON 
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (99, 3, 1406)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (3, 8, 796)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (4, 1, 4196)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (6, 8, 1040)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (7, 1, 3576)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (8, 3, 845)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (9, 7, 828)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (10, 8, 5777)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (11, 8, 5827)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (12, 5, 3273)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (13, 1, 80)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (14, 8, 9396)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (15, 8, 3589)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (16, 1, 69)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (19, 1, 3376)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (20, 3, 323)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (23, 1, 3549)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (24, 5, 1918)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (25, 3, 11156)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (26, 8, 8837)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (28, 8, 8089)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (29, 1, 1028)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (30, 1, 2466)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (31, 5, 1406)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (32, 3, 1416)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (33, 5, 13596)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (34, 1, 9323)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (35, 5, 11237)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (36, 8, 9785)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (37, 5, 11163)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (39, 9, 11172)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (40, 8, 9285)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (41, 5, 3622)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (42, 5, 9323)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (43, 1, 1766)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (44, 1, 3212)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (45, 9, 11174)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (46, 8, 3600)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (47, 9, 11160)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (48, 8, 11549)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (49, 4, 2827)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (50, 9, 12657)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (51, 8, 7377)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (52, 5, 6550)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (53, 4, 1634)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (54, 8, 2140)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (55, 3, 317)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (56, 1, 1205)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (57, 8, 3633)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (58, 2, 6873)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (59, 1, 7377)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (60, 5, 7244)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (61, 3, 2938)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (63, 2, 5081)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (64, 1, 3119)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (65, 9, 2998)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (66, 8, 3576)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (67, 8, 2592)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (68, 4, 100)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (69, 9, 2987)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (70, 4, 1005)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (71, 4, 908)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (72, 1, 5796)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (73, 10, 2386)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (74, 1, 3650)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (75, 4, 1425)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (76, 8, 6346)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (78, 1, 1685)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (79, 2, 2588)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (80, 6, 1620)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (81, 4, 1542)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (82, 5, 9766)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (83, 5, 5228)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (84, 6, 9396)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (87, 1, 1859)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (90, 1, 1713)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (93, 4, 3650)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (94, 10, 1425)
GO
INSERT [dbo].[Products_Suppliers] ([ProductSupplierId], [ProductId], [SupplierId]) VALUES (95, 10, 12657)
GO
SET IDENTITY_INSERT [dbo].[Products_Suppliers] OFF
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'AFR', N'Africa                   ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'ANZ', N'Australia & New Zealand  ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'ASIA', N'Asia                     ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'EU', N'Europe & United Kingdom  ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'MEAST', N'Middle East              ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'MED', N'Mediterranean            ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'NA', N'North America            ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'OTHR', N'Other                    ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'SA', N'South America            ')
GO
INSERT [dbo].[Regions] ([RegionId], [RegionName]) VALUES (N'SP', N'South Pacific            ')
GO
INSERT [dbo].[Rewards] ([RewardId], [RwdName], [RwdDesc]) VALUES (1, N'Air Miles', NULL)
GO
INSERT [dbo].[Rewards] ([RewardId], [RwdName], [RwdDesc]) VALUES (2, N'AeroPlan', NULL)
GO
INSERT [dbo].[Rewards] ([RewardId], [RwdName], [RwdDesc]) VALUES (3, N'AeroPlan Gold', NULL)
GO
INSERT [dbo].[Rewards] ([RewardId], [RwdName], [RwdDesc]) VALUES (4, N'Coast Rewards', NULL)
GO
INSERT [dbo].[Rewards] ([RewardId], [RwdName], [RwdDesc]) VALUES (5, N'Mariott Rewards', NULL)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (16, NULL, NULL, N'PACIFIC WINGS: Oahu-Molokai-Maui-Hawaii', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.newconcepts.ca', NULL, 69)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (17, NULL, NULL, N'WINAIR / WINDWARD ISLANDS AIRWAYS INTERNATIONAL', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.newconcepts.ca', NULL, 69)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (18, N'A.', N'Haziza', N'NEW CONCEPTS - CANADA', N'1595 Calverton Court', N'Mississauga', N'ON', N'L5G 2W4', N' ', N'9052748508', N'9052714603', N'alhaziza@newconcepts.ca', N'http://www.newconcepts.ca', N'ACTAPGY', 69)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (19, N'A.', N'Haziza', N'DIVI RESORTS', N'1595 Calverton Court', N'Mississauga', N'ON', N'L5G 2W4', N' ', N'9052748508', N'9052714603', N'alhaziza@newconcepts.ca', N'http://www.newconcepts.ca', NULL, 69)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (20, N'A.', N'Haziza', N'TIMBERWOODS VACATION VILLAS', N'7964 Timberwood Circle', N'Sarasota', N'FL', N'34238', N'USA', N'9419234966', N'9419243109', N'reserve@timberwoods.com', N'www.timberwoods.com', NULL, 69)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (26, N'Nick', N'Kissanis', N'AMALIA HOTELS (GREECE)', N'214 Bedford Rd', N'Toronto', N'ON', N'M5R 2K9', N' ', N'4169674333', N'4169676147', N' ', N' ', N'ACTAPGY', 80)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (27, N'Nick', N'Kissanis', N'CHAT/TRAVELINE', N'214 Bedford Rd', N'Toronto', N'ON', N'M5R 2K9', N' ', N'4169674333', N'4169676147', N' ', N' ', N'ACTAPGY', 80)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (28, N'Nick', N'Kissanis', N'CHAT TOURS', N'214 Bedford Rd', N'Toronto', N'ON', N'M5R 2K9', N' ', N'4169674333', N'4169676147', N' ', N' ', N'ACTAPGY', 80)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (47, N'Dr. Carlos', N'Pechtel de A', N'GLOBAL QUEST', N'10316-124 St', N'Edmonton', N'AB', N'T5N 1R2', N' ', N'7804823427', N'7804826900', N'sales@avilatours.ca', N' ', NULL, 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (48, N'Dr. Carlos', N'Pechtel de A', N'MARINE EXPEDITIONS', N'10316-124 St', N'Edmonton', N'AB', N'T5N 1R2', N' ', N'7804823427', N'7804826900', N'sales@avilatours.ca', N' ', NULL, 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (49, N'Dr. Carlos', N'Pechtel de A', N'AMAZON RIVER CRUISES', N'10316-124 St', N'Edmonton', N'AB', N'T5N 1R2', N' ', N'7804823427', N'7804826900', N'sales@avilatours.ca', N' ', NULL, 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (51, NULL, NULL, N'EUROPE RIVER CRUISES/CROISI EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (52, NULL, NULL, N'QUARK EXPEDITIONS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (53, N'Dr. Carlos', N'Pechtel de A', N'AVILA TOURS INC.', N'10316-124 St', N'Edmonton', N'AB', N'T5N 1R2', N' ', N'7804823427', N'7804826900', N'sales@avilatours.ca', N' ', N'ACTAPGY', 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (56, NULL, NULL, N'TUMBACO GALAPAGOS YACHT CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 100)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (65, NULL, NULL, N'CUBA CRUISE CORPORATION', N'13 Hazelton Ave', N'Toronto', N'ON', N'M5R 2E1', N' ', N'4169642569', N'4169645644', N'cuba@blythtravel.com', N'http://www.cubacruising.com', N'PGY', 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (66, N'Sam', N'Blyth', N'BLYTH & COMPANY TRAVEL LTD.', N'13 Hazelton Ave', N'Toronto', N'ON', N'M5R 2E1', N' ', N'4169642569', N'4169643416', N'blythco@blythtravel.com', N'http://www.blythtravel.com', N'PGY', 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (67, NULL, NULL, N'THE ROYAL SCOTSMAN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (68, NULL, NULL, N'THE EASTERN & ORIENTAL EXPRESS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (70, NULL, NULL, N'THE BRITISH PULLMAN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (71, NULL, NULL, N'THE VENICE SIMPLON ORIENT EXPRESS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (73, NULL, NULL, N'MOUNTAIN TRAVEL *SOBEK', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (74, NULL, NULL, N'BACKROADS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (75, NULL, NULL, N'EXOTIC SUN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.blythtravel.com', NULL, 317)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (113, N'M.', N'Pangallo', N'COMPAGNIA ITALIANA TURISMO INC', N'666 Sherbrooke W', N'Montreal', N'PQ', N'H3A 1E7', N' ', N'5148454310', N'5148459137', N'citmontreal@cittours.com', N' ', N'ACTAPGY', 323)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (114, NULL, NULL, N'ITALY/EURAILPASS/EUROPASS/GERMAN PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 323)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (121, N'Mary', N'Papamichael', N'CYPRUS AIRWAYS LTD', N'34-09 Broadway', N'Astoria', N'NY', N'11106', N'USA', N'7182676882', N'7182676885', N'kinisisusa@aol.com', N' ', NULL, 796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (123, N'Mary', N'Papamichael', N'KINISIS TRAVEL & TOURS', N'34-09 Broadway', N'Astoria', N'NY', N'11106', N'USA', N'7182676880', N'7182676885', N'kinisisusa@aol.com', N' ', NULL, 796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (127, NULL, NULL, N'BRITISH HERITAGE PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (128, N'Charlotte', N' Mikolaiczyk', N'DER TRAVEL SERVICE LTD', N'904 The East Mall', N'Toronto (Etobicoke)', N'ON', N'M9B 6K2', N' ', N'4166951209', N'4166951210', N'der@dercanada.com', N'http://www.dercanada.com', N'ACTAPGY', 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (129, NULL, NULL, N'EUROLINE BUS PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (131, N'Charlotte', N' Mikolaiczyk', N'DERRAIL - EUROPEAN RAIL SERVICES', N'904 The East Mall', N'Toronto (Etobicoke)', N'ON', N'M9B 6K2', N' ', N'4166951209', N'4166951210', N'der@dercanada.com', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (132, NULL, NULL, N'BENELUX PASS (BELGIUM LUXEMBOURG THE NETHERLANDS)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (133, NULL, NULL, N'BRITRAIL PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (134, NULL, NULL, N'GREEK RAIL PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (135, NULL, NULL, N'EURAIL/EURO PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (136, NULL, NULL, N'BALKAN RAIL PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (137, NULL, NULL, N'GERMAN RAIL', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (138, NULL, NULL, N'EUROPEAN EAST PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (139, NULL, NULL, N'SCANRAIL NORWAY SWEDEN RAILPASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (140, NULL, NULL, N'PARIS METRO PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (141, NULL, NULL, N'IBERIC FLEXIPASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (142, NULL, NULL, N'SPAIN RAIL PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (143, NULL, NULL, N'HOLLAND RAIL PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (144, NULL, NULL, N'ITALIAN RAIL PASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (145, NULL, NULL, N'AUSTRIAN RAILPASS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (146, NULL, NULL, N'LONDON VISITOR CARD', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (147, NULL, NULL, N'EUROSTAR SERVICES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.dercanada.com', NULL, 828)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (150, N'Joanne', N'Lundy', N'DISCOVER THE WORLD MARKETING', N'1599 Hurontario St', N'Mississauga', N'ON', N'L5G 4S1', N' ', N'9058910093', N'9058918026', N'toronto@discovertheworld.ca', N' ', N'PGY', 845)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (151, NULL, NULL, N'BRITISH MIDLAND', N'1599 Hurontario St', N'Mississauga', N'ON', N'L5G 4S1', N' ', N'9058910093', N'9058918026', N'toronto@discovertheworld.ca', N' ', N'PGY', 845)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (152, N'Joanne', N'Lundy', N'AEROMEXICO', N'1599 Hurontario St', N'Mississauga', N'ON', N'L5G 4S1', N' ', N'9058910093', N'9058918026', N'toronto@discovertheworld.ca', N' ', N'PGY', 845)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (153, N'Joanne', N'Lundy', N'AOM FRENCH AIRLINES', N'1599 Hurontario St', N'Mississauga', N'ON', N'L5G 4S1', N' ', N'9058910093', N'9058918026', N'toronto@discovertheworld.ca', N' ', N'PGY', 845)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (154, NULL, NULL, N'AMERICA WEST AIRLINES', N'4000 E Sky Harbor Blvd', N'Phoenix', N'AZ', N'85034', N' ', N'8002929378', NULL, N'toronto@discovertheworld.ca', N'http://www.americawest.com', NULL, 845)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (156, N'Joanne', N'Lundy', N'HYATT NORTH AMERICA/CARIBBEAN', N'1599 Hurontario St', N'Mississauga', N'ON', N'L5G 4S1', N' ', N'9052331234', N'9058918026', N'toronto@discovertheworld.ca', N'www.hyatt.com', N'PGY', 845)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (161, N'Angie', N'Lo', N'ELITE ORIENT TOURS INC.', N'170 University Ave', N'Toronto', N'ON', N'M5H 3B3', N' ', N'4169773026', N'4169773104', N' ', N' ', N'ACTAPGY', 908)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (165, N'Angie', N'Lo', N'JAPAN RAIL PASS', N'170 University Ave', N'Toronto', N'ON', N'M5H 3B3', N' ', N'4169773026', N'4169773104', N' ', N' ', NULL, 908)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (167, N'Aideen', N'Hennessy', N'ENCORE CRUISES', N'160 Bloor St E', N'Toronto', N'ON', N'M4W 1B9', N' ', N'4169602516', N'4169670303', N' ', N' ', N'ACTAPGY', 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (168, NULL, NULL, N'CUNARD LINE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (169, NULL, NULL, N'WINDSTAR CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (170, NULL, NULL, N'CELEBRITY CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (171, NULL, NULL, N'SEABOURN CRUISE LINE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (172, NULL, NULL, N'ORIENT LINES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (173, NULL, NULL, N'SILVERSEA CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (174, NULL, NULL, N'STAR CLIPPERS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (175, NULL, NULL, N'ROYAL CARIBBEAN INTERNATIONAL', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (176, NULL, NULL, N'ROYAL OLYMPIC CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (177, NULL, NULL, N'HOLLAND AMERICA LINE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (178, NULL, NULL, N'RADISSON SEVEN SEAS CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1005)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (181, N'Maria', N'Conte', N'EUROCRUISES INC.', N'33 Little W 12th St', N'New York', N'NY', N'10014', N'USA', N'2126912099', N'2123664747', N'info@eurocruises.com', N'http://www.eurocruises.com', N'PGY', 1406)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (182, NULL, NULL, N'DELPHIN CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.eurocruises.com', NULL, 1406)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (184, NULL, NULL, N'KRISTINA CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.eurocruises.com', NULL, 1406)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (185, NULL, NULL, N'FRED. OLSEN CRUISE LINES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.eurocruises.com', NULL, 1406)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (186, N'Marcel', N'Paoli', N'EUROP-AUTO-VACANCES/HOLIDAYS', N'5174 Cote des Neiges', N'Montreal', N'PQ', N'H3T 1X8', N' ', N'5147353083', N'5143428802', N'europauto@netrover.com', N'http://www.europauto.qc.ca', N'ACTANEWP', 1028)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (187, NULL, NULL, N'EUROPCAR', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.europauto.qc.ca', NULL, 1028)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (188, N'M.', N'Schon', N'EXECUTIVE SUITES', N'Emerald Business Centre', N'Mississauga', N'ON', N'L5R 3K6', N' ', N'9055029550', N'9055020355', N'execsuit@idirect.com', N'http://www.execsuit.com', N'PGY', 1040)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (189, NULL, NULL, N'PARK SUITES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1040)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (210, N'Rochelle', N'Goldman', N'GOLDMAN MARKETING STRATEGY INC', N'80 St Clair Ave E', N'Toronto', N'ON', N'M4T 1N6', N' ', N'4169235705', N'4169235628', N'gms@on.aibn.com', N' ', N'PGY', 1205)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (211, N'Rochelle', N'Goldman', N'HEBRIDEAN ISLAND CRUISES: THE HEBRIDEAN PRINCESS', N'80 St Clair Ave E', N'Toronto', N'ON', N'M4T 1N6', N' ', N'4169235705', N'4169235628', N'gms@on.aibn.com', N' ', N'PGY', 1205)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (214, N'Bruce', N'Hodge', N'GOWAY TRAVEL LTD.', N'3284 Yonge St', N'Toronto', N'ON', N'M4N 3M7', N' ', N'4163221034', N'4163221109', N'res@goway.com', N'http://www.goway.com', N'ACTAPGY', 1685)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (215, NULL, NULL, N'GREAT BARRIER REEF CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.goway.com', NULL, 1685)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (216, NULL, NULL, N'FIJI (BLUE LAGOON) CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.goway.com', NULL, 1685)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (217, NULL, NULL, N'YANTZE RIVER CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.goway.com', NULL, 1685)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (219, N'Bruce', N'Hodge', N'AUSTRALIAN RAIL', N'3284 Yonge St', N'Toronto', N'ON', N'M4N 3M7', N' ', N'4163221034', N'4163221109', N'res@goway.com', N'http://www.goway.com', NULL, 1685)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (221, NULL, NULL, N'AAT KINGS AUSTRALIAN TOURS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.goway.com', NULL, 1685)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (245, N'Marc', N'Vezina', N'TOURS MAISON - THE HOLIDAY NETWORK', N'2155 Guy St', N'Montreal', N'PQ', N'H3H 2R9', N' ', N'5149357103', N'5149854492', N' ', N'http://www.holidaynetwork.ca', N'ACTAPGY', 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (249, NULL, NULL, N'WOODS CAR RENTAL - BRITAIN', N' ', N' ', N' ', N' ', N' ', N'8002688354', N'4163671749', N' ', N'http://www.holidaynetwork.ca', N'PGY', 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (250, NULL, NULL, N'ALAMO RENT A CAR', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (251, NULL, NULL, N'DOLLAR HAWAII', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (252, NULL, NULL, N'AVIS RENT A CAR', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (257, NULL, NULL, N'KD RIVER CRUISES OF EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (258, NULL, NULL, N'DISNEY CRUISE LINE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (259, NULL, NULL, N'CRYSTAL CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (260, NULL, NULL, N'PRINCESS CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (261, NULL, NULL, N'SILVERSEA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (262, NULL, NULL, N'NORWEGIAN CRUISE LINES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (263, NULL, NULL, N'COSTA CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (264, NULL, NULL, N'SUN CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.holidaynetwork.ca', NULL, 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (266, N'Astrinos', N' Kozoronis', N'CARRIERS TRAVEL INTERNATIONAL INC. - THE HOLIDAY NETWORK', N'75 The Donway W', N'Toronto', N'ON', N'M3C 2E9', N' ', N'4164299000', N'4164297159', N' ', N'http://www.holidaynetwork.ca', N'PGY', 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (267, N'Leanda', N'Townsend', N'HOLIDAY HOUSE', N'26 Wellington St E 5th Fl', N'Toronto', N'ON', N'M5E 1S2', N' ', N'4163645100', N'4163671836', N' ', N'http://www.holidaynetwork.ca', N'PGY', 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (268, N'Leanda', N'Townsend', N'SIVER FERN - THE HOLIDAY NETWORK', N'26 Wellington St E 5th Fl', N'Toronto', N'ON', N'M5E 1S2', N' ', N'4163645100', N'4163671836', N' ', N'http://www.holidaynetwork.ca', N'PGY', 1416)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (272, N'Erik', N'Elvejord', N'HOLLAND AMERICA LINE WESTOURS INC', N'300 Elliott Ave W', N'Seattle', N'WA', N'98119', N'USA', N'8004260327', N'2062863229', N' ', N' ', N'ACTAPGY', 1425)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (274, NULL, NULL, N'WESTOURS INC.', N'300 Elliott Ave W', N'Seattle', N'WA', N'98119', N'USA', N'8004260327', N'2064260329', N' ', N' ', N'ACTAPGY', 1425)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (282, NULL, NULL, N'EVAN EVANS TOURS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1542)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (283, N'Helen', N'Panagides', N'INSIGHT VACATIONS CANADA LTD.', N'2300 Yonge St', N'Toronto', N'ON', N'M4P 1E4', N' ', N'4164822116', N'4164824307', N' ', N' ', N'ACTAPGY', 1542)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (288, N'Jacques', N'Darcy', N'INTAIR TRANSIT', N'1221 rue St-Hubert', N'Montreal', N'PQ', N'H2L 3Y8', N' ', N'5142869747', N'5148437678', N' ', N' ', N'ACTANEWP', 1620)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (289, N'Jacques', N'Darcy', N'INTAIR VACATIONS', N'1221 rue St-Hubert', N'Montreal', N'PQ', N'H2L 3Y8', N' ', N'5142862800', N'5142861655', N' ', N' ', NULL, 1620)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (290, N'Jacques', N'Darcy', N'BOOMERANG TOURS', N'1221 rue St-Hubert', N'Montreal', N'PQ', N'H2L 3Y8', N' ', N'5142866035', N'5142861655', N' ', N' ', NULL, 1620)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (291, N'Jacques', N'Darcy', N'INTAIR VACATIONS / INTAIR USA / INTAIR CRUISES', N'1221 rue St-Hubert', N'Montreal', N'PQ', N'H2L 3Y8', N' ', N'5142862800', N'5142861655', N' ', N' ', NULL, 1620)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (294, NULL, NULL, N'TALL SHIP CRUISES (MAINE THE CARIBBEAN SOUTH PACIFIC)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (295, NULL, NULL, N'IVARAN CRUISE LINE (FREIGHTER CRUISES)-SOUTH AMERICA/CARIBBEAN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (296, NULL, NULL, N'ZEUS TALL SHIP CRUISES-GREECE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (297, NULL, NULL, N'TEMPTRESS CRUISES-COSTA RICA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (298, NULL, NULL, N'ARANUI CRUISES (FREIGHTER CRUISES) - TAHITI', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (299, NULL, NULL, N'CROWN BLUE LINE/FRANCE CANAL & RIVER POWER BOATS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (300, NULL, NULL, N'AMAZING GRACE (FREIGHTER CRUISES)-CARIBBEAN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (301, N'Michael', N'Tomlinson', N'WINDJAMMER BAREFOOT CRUISES', N'200 10441-124th St', N'Edmonton', N'AB', N'T5N 1R7', N' ', N'7804825022', N'7804825328', N'islands@cruising.nu', N'http://www.cruising.nu', N'ACTAPGY', 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (302, N'Michael', N'Tomlinson', N'ISLANDS IN THE SUN CRUISES', N'200 10441-124th St', N'Edmonton', N'AB', N'T5N 1R7', N' ', N'7804825022', N'7804825328', N'islands@cruising.nu', N'http://www.cruising.nu', N'ACTAPGY', 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (303, NULL, NULL, N'NEILSON CYCLING HOLIDAYS-GREECE/TURKEY', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (304, NULL, NULL, N'ISLANDS IN THE SUN CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (305, NULL, NULL, N'SUNSAIL SAIL & STAY', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (306, NULL, NULL, N'MOORINGS THE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (307, NULL, NULL, N'VIRGIN ISLANDS CHARTER YACHT LEAGUE CREWED YACHT HOLIDAYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (308, NULL, NULL, N'CLUB MARINER SAIL & STAY HOLIDAYS-ST. LUCIA/GRENADA/BVI', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (309, NULL, NULL, N'NEILSON FLOTILLA SAILING-GREECE/TURKEY', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (310, NULL, NULL, N'TRAWLERS IN PARADISE - CARIBBEAN USVI''S', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (311, NULL, NULL, N'VIKING TOURS AND TALL SHIP CRUISES OF GREECE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (312, NULL, NULL, N'WINDJAMMER BAREFOOT CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (313, NULL, NULL, N'DIVE BELIZE-AGGRESSOR DIVE FLEET', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (314, NULL, NULL, N'SUNSAIL YACHT CHARTERS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (315, NULL, NULL, N'SOUTH FLORIDA SAILING SCHOOL & YACHT CHARTERS - FLORIDA KEYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (316, NULL, NULL, N'BAREBOAT YACHT CHARTERS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (317, NULL, NULL, N'NEILSON CYCLING HOLIDAYS-DOMINICAN REPUBLIC/GRENADA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (318, NULL, NULL, N'SUNSAIL CLUB ANTIGUA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (319, NULL, NULL, N'HORIZON POWER/SAIL BVI''S', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (320, NULL, NULL, N'AGGRESSOR DIVE HOLIDAYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (321, NULL, NULL, N'HOSEASONS - UK CANALBOATS (U-DRIVE) FRANCE/EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (322, NULL, NULL, N'QUEENSLAND YACHT CHARTERS - AUSTRALIAN BARRIER REEF', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (323, NULL, NULL, N'COPPER SKY-NW PACIFIC', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.cruising.nu', NULL, 1634)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (330, N'Kenny', N'Lee', N'JETPACIFIC HOLIDAYS INC.', N'120-8877 Odlin Cres', N'Richmond', N'BC', N'V6X 3Z7', N' ', N'6042148932', N'6042148933', N'jetpac@infoserve.net', N' ', N'ACTAPGY', 1713)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (331, NULL, NULL, N'BANGKOK AIRWAYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1713)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (333, NULL, NULL, N'BALI HAI CRUISES - BALI', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1713)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (334, NULL, NULL, N'STAR CRUISES - SINGAPORE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1713)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (342, N'Chris', N'Rivers', N'KLM ROYAL DUTCH AIRLINES', N'777 Bay St', N'Toronto', N'ON', N'M5G 2C8', N' ', N'4162045151', N'4162049708', N' ', N' ', N'ACTAPGY', 1766)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (343, NULL, NULL, N'NORTHWEST AIRLINES & KLM ROYAL DUTCH AIRLINES (NW/KL)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1766)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (357, N'Emile', N'Habib', N'LOTUS HOLIDAYS', N'792 Kennedy Rd', N'Toronto (Scarborough)', N'ON', N'M1K 2C8', N' ', N'4167517025', N'4167510608', N' ', N' ', N'PGY', 1859)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (359, NULL, NULL, N'NILE CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 1859)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (369, N'Corinne', N'Martin', N'MARKET SQUARE TOURS', N'273 Donald St', N'Winnipeg', N'MB', N'R3C 1M9', N' ', N'2049564279', N'2049490188', N'sales@gctc-mst.com', N'http://www.greatcanadiantravel.com', N'ACTAPGY', 1918)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (370, N'Corinne', N'Martin', N'THE GREAT CANADIAN TRAVEL COMPANY LTD', N'273 Donald St', N'Winnipeg', N'MB', N'R3C 1M9', N' ', N'2049490199', N'2049490188', N'sales@gctc-mst.com', N'http://www.greatcanadiantravel.com', NULL, 1918)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (371, N'Antonio', N'Alonso', N'MARKETING AHEAD', N'433 Fifth Ave.', N'New York', N'NY', N'10016', N'USA', N'2126869213', N'2126860271', N' ', N' ', N'PGY', 3273)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (372, NULL, NULL, N'PARADORES OF SPAIN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 3273)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (373, NULL, NULL, N'POUSADAS OF PORTUGAL', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 3273)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (375, N'S.R.', N'Vale', N'MARTINAIR SERVICES', N'111 Richmond St W', N'Toronto', N'ON', N'M5H 2G4', N' ', N'4163643672', N'4163643886', N' ', N' ', N'ACTAPGY', 3376)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (376, N'S.R.', N'Vale', N'MARTINAIR HOLLAND', N'111 Richmond St W', N'Toronto', N'ON', N'M5H 2G4', N' ', N'4163643672', N'4163643886', N' ', N' ', N'PGY', 3376)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (396, N'Pat', N'Nagel', N'NAGEL TOURS LTD', N'Edmonton Inn', N'Edmonton', N'AB', N'T5G 0X5', N' ', N'7804527345', N'7804786666', N' ', N'http://www.nageltours.com', N'PGY', 2140)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (397, N'Pat', N'Nagel', N'OKANAGAN VALLEY WINE TRAIN', N'Edmonton Inn', N'Edmonton', N'AB', N'T5G 0X5', N' ', N'7804888725', N'7804827666', N' ', N'http://www.okanaganwinetrain.com', N'PGY', 2140)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (419, NULL, NULL, N'HOTEL NARROW BOATS/UK', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (420, NULL, NULL, N'CROWN BLUE LINE FRANCE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (421, NULL, NULL, N'LOCABOAT - SELF-SKIPPERED PENICHETTES - EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (422, NULL, NULL, N'EUROPE RIVER CRUISES/CROISI EUROPE (ALSACE CROISIERES)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (423, NULL, NULL, N'CONTINENTAL WATERWAYS - HOTEL-BARGE CRUISES FRANCE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (424, NULL, NULL, N'BARGE CRUISES EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (425, NULL, NULL, N'CANAL & RIVER CRUISES EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (426, N'Janet', N'Pavlik', N'PAVLIK TRAVEL GROUP', N'2221 Panorama Dr', N'N Vancouver', N'BC', N'V7G 1V4', N' ', N'6049297911', N'6049240634', N'pavlik@infomatch.com', N'http://www.infomatch.com/~pavlik', N'PGY', 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (428, NULL, NULL, N'ANGLO WELSH SELF SKIPPERED BOATS(BRITAIN)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (429, NULL, NULL, N'IRELAND - SELF SKIPPERED CANAL BOATS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (430, NULL, NULL, N'HOLLAND - CANAL BOATING', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (431, NULL, NULL, N'CROWN BLUE LINE (FRANCE)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.infomatch.com/~pavlik', NULL, 2386)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (434, N'Patricia', N'Fargeon', N'PLANET FRANCE INC.', N'7351 Victoria Park Ave', N'Markham', N'ON', N'L3R 3A5', N' ', N'9054796121', N'9054795411', N'planet.pat@sympatico.ca', N' ', N'PGY', 2466)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (435, N'Patricia', N'Fargeon', N'PLANET EUROPE GROUP', N'7351 Victoria Park Ave', N'Markham', N'ON', N'L3R 3A5', N' ', N'9054797069', N'9054795411', N'planet.pat@sympatico.ca', N' ', N'PGY', 2466)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (466, N'Gary C.', N'Sadler', N'UNIQUE VACATIONS (CANADA) INC.', N'4211 Yonge St', N'Toronto (North York)', N'ON', N'M2P 2A9', N' ', N'4162230028', N'4162233306', N' ', N' ', N'ACTA', 2588)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (467, NULL, NULL, N'SANDALS AND BEACHES RESORTS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', N'ACTA', 2588)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (476, N'Ash', N'Mukherjee', N'ESPRIT/SERVICENTRE HOLIDAYS', N'5945 Airport Rd', N'Mississauga', N'ON', N'L4V 1R9', N' ', N'9056733333', N'9056733327', N'tscash@aol.com', N'http://www.espritvacations.com', N'PGY', 2592)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (477, NULL, NULL, N'CLUBAVANTAGE GROUP TRAVE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.espritvacations.com', NULL, 2592)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (496, N'Julio', N'Erhart', N'HOTEL NETS', N'1235 Bay St', N'Toronto', N'ON', N'M5R 3K4', N' ', N'4169214012', N'4169698916', N'southwin@ican.net', N' ', NULL, 2827)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (497, N'Julio', N'Erhart', N'SOUTH WIND TOURS LTD.', N'1235 Bay St', N'Toronto', N'ON', N'M5R 3K4', N' ', N'4169214012', N'4169698916', N'southwin@ican.net', N' ', NULL, 2827)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (500, N'Mela', N'Pascoe', N'SUN & LEISURE TRAVEL CORP', N'401 The West Mall', N'Toronto (Etobicoke)', N'ON', N'M9C 5J5', N' ', N'4166265199', N'4166200009', N' ', N' ', N'PGY', 2938)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (501, NULL, NULL, N'CANADIAN TOURS INTERNATIONAL', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 2938)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (517, NULL, NULL, N'YANGTZE RIVER CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (518, NULL, NULL, N'EASTERN & ORIENTAL EXPRESS/ROAD TO MANDALAY CRUISE BURMA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (519, NULL, NULL, N'STAR CRUISE LINES-SINGAPORE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (520, NULL, NULL, N'STAR CLIPPER-ASIA-CARIBBEAN-MEDITERRANEAN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (521, N'Miki', N'Friendly', N'TOURCAN VACATIONS INC', N'255 Duncan Mill Rd', N'Toronto', N'ON', N'M3B 3H9', N' ', N'4163910334', N'4163910986', N'tourcanvacations@tourcanvacations.com', N'http://www.tourcanvacations.com', N'ACTAPGY', 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (522, N'Miki', N'Friendly', N'ROVOS RAIL - SOUTH AFRICA', N'255 Duncan Mill Rd', N'Toronto', N'ON', N'M3B 3H9', N' ', N'4163910334', N'4163910986', N'tourcanvacations@tourcanvacations.com', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (523, NULL, NULL, N'ROYAL SCOTSMAN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (524, NULL, NULL, N'VENICE SIMPLON - ORIENT - EXPRESS - LONDON/VENICE OR V.V. EASTERN & ORI', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (525, N'Miki', N'Friendly', N'VENICE SIMPLON -- ORIENT EXPRESS - EUROPE EASTERN & ORIENTAL ORIENT EXP', N'255 Duncan Mill Rd', N'Toronto', N'ON', N'M3B 3H9', N' ', N'4163910334', N'4163910986', N'tourcanvac', N' ', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (526, N'Miki', N'Friendly', N'PALACE ON WHEELS - INDIA', N'255 Duncan Mill Rd', N'Toronto', N'ON', N'M3B 3H9', N' ', N'4163910334', N'4163910986', N'tourcanvacations@tourcanvacations.com', N'http://www.tourcanvacations.com', NULL, 2987)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (532, N'Elisabeth', N'Dupuis', N'ALIOTOURS', N'1410 Stanley St', N'Montreal', N'PQ', N'H3A 1P8', N' ', N'5142871066', N'5148435680', N' ', N' ', N'ACTA', 2998)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (533, N'Elisabeth', N'Dupuis', N'ALIO TOURS DIV. TOURS NEW YORK', N'1410 Stanley St', N'Montreal', N'PQ', N'H3A 1P8', N' ', N'5142871066', N'5148435680', N' ', N' ', N'ACTA', 2998)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (538, N'Joaquin', N'Murillo', N'TRANS WORLD AIRLINES INC. (TWA)', N'1751 Richardson St', N'Montreal', N'PQ', N'H3K 1G6', N' ', N'5148448242', N'5148440921', N'aviaction@median-aviation.com', N'http://www.median-aviation.com', N'PGY', 3119)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (540, N'Joaquin', N'Murillo', N'AVIACTION', N'Airway Centre 1 5955 Airport', N'Mississauga', N'ON', N'L4V 1R9', N' ', N'9056778242', N'9056779394', N'aviaction@median-aviation.com', N'http://www.median-aviation.com', N'PGY', 3119)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (550, N'Terri', N'Ronneseth', N'TREK AIR', N'8412 - 109 St', N'Edmonton', N'AB', N'T6G 1E2', N' ', N'7804399118', N'7804335494', N'airfares@trekholidays.com', N'http://www.trekholidays.com', N'ACTAPGY', 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (551, N'Terri', N'Ronneseth', N'TREK HOLIDAYS', N'8412 - 109 St', N'Edmonton', N'AB', N'T6G 1E2', N' ', N'7804399118', N'7804335494', N'adventures@trekholidays.com', N'http://www.trekholidays.com', N'ACTAPGY', 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (552, NULL, NULL, N'KARIBU SAFARIS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (553, NULL, NULL, N'PEREGRINE ADVENTURES/GECKO ADVENTURES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (554, NULL, NULL, N'EXPLORE WORLDWIDE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (555, NULL, NULL, N'DRAGOMAN HOLIDAYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (556, NULL, NULL, N'KIRRA TOURS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (557, NULL, NULL, N'IMAGINATIVE TRAVELLER', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (558, NULL, NULL, N'ENCOUNTER OVERLAND', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.trekholidays.com', NULL, 3212)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (568, N'Vicky', N'Alberto', N'VIP INTERNATIONAL', N'727-7th Ave SW', N'Calgary', N'AB', N'T2P 0Z5', N' ', N'4032693566', N'4032612046', N'info@vipintcorp.com', N' ', N'PGY', 3633)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (569, N'Kelly', N'Blake', N'ALL SUITES INTERNATIONAL', N'727-7th Ave SW', N'Calgary', N'AB', N'T2P 0Z5', N' ', N'4032664776', N'4032665228', N'info@vipintcorp.com', N' ', N'PGY', 3633)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (586, N'Jeronimo', N'Rius', N'BONANZA HOLIDAYS', N'1224 Stanley St', N'Montreal', N'PQ', N'H3B 2S7', N' ', N'5143939501', N'5143939504', N'bonanza@globalserve.net', N' ', N'ACTAPGY', 3549)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (598, NULL, NULL, N'AUSTRIA HOTELS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (599, NULL, NULL, N'CEDOK CZECH TOURIST/TRAVEL AGENCY', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (600, NULL, NULL, N'VIENNA INTERNATIONAL HOTELS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (601, NULL, NULL, N'DANUBIUS SPA HOTELS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (602, NULL, NULL, N'HUNGARIAN HOTELS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (604, NULL, NULL, N'GRAYLINE FRANCE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (605, NULL, NULL, N'GRAYLINE AUSTRIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (606, NULL, NULL, N'GRAYLINE ITALY', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (607, NULL, NULL, N'GRAYLINE SPAIN', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (609, N'Madeline', N'Ferenzy', N'BLUE DANUBE HOLIDAYS', N'80 Richmond St W', N'Toronto', N'ON', N'M5H 2A4', N' ', N'4163625000', N'4163628024', N'bluedanube@bluedanubeholidays.com', N'http://www.bluedanubeholidays.com', N'PGY', 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (610, NULL, NULL, N'MAHART-HYDROFOIL', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.bluedanubeholidays.com', NULL, 3576)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (620, N'Susan', N'Savoie', N'GOLDEN ESCAPES', N'75 The Donway W', N'Toronto', N'ON', N'M3C 2E9', N' ', N'4164477683', N'4164474824', N'admin@goldenescapes.com', N'http://www.goldenescapes.com', N'PGY', 3600)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (621, NULL, NULL, N'BACK ROADS TOURING COMPANY of Great Britain', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.goldenescapes.com', NULL, 3600)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (622, N'Sandra', N'Mirkovic', N'G.A.P ADVENTURES INC', N'The Great Adventure People', N'Toronto', N'ON', N'M5H 3H1', N' ', N'4162600999', N'4162601888', N'adventure@gap.ca', N'http://www.gap.ca', N'ACTAPGY', 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (623, NULL, NULL, N'TREK AMERICA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.gap.ca', NULL, 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (624, NULL, NULL, N'EXODUS WORLDWIDE ADVENTURE HOLIDAYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.gap.ca', NULL, 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (625, NULL, NULL, N'TREK AUSTRALIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.gap.ca', NULL, 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (626, NULL, NULL, N'INTREPID SOUTH EAST ASIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.gap.ca', NULL, 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (627, NULL, NULL, N'GUERBA EXPEDITIONS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.gap.ca', NULL, 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (628, NULL, NULL, N'AMADABLAM ADVENTURES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.gap.ca', NULL, 3589)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (639, N'Paul', N'Chu', N'CHINA TRAVEL SERVICE (CANADA) INC', N'556 W Broadway', N'Vancouver', N'BC', N'V5Z 1E9', N' ', N'6048728787', N'6048732823', N' ', N' ', N'ACTAPGY', 3622)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (641, N'Paul', N'Chu', N'CHINA TRAVEL AIR SERVICE HONG KONG LTD.', N'556 W Broadway', N'Vancouver', N'BC', N'V5Z 1E9', N' ', N'6048728787', N'6048732823', N' ', N' ', NULL, 3622)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (642, N'Paul', N'Chu', N'SHENZHEN AIRLINE CHINA', N'556 W Broadway', N'Vancouver', N'BC', N'V5Z 1E9', N' ', N'6048728787', N'6048732823', N' ', N' ', NULL, 3622)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (644, N'Paul', N'Chu', N'YANGTZE RIVER SPLENDID CHINA CRUISE LTD.', N'556 W Broadway', N'Vancouver', N'BC', N'V5Z 1E9', N' ', N'6048728787', N'6048732823', N' ', N' ', NULL, 3622)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (646, N'Paul', N'Chu', N'CHINA TRAVEL HOTEL MANAGEMENT SERVICES HONG KONG LTD.', N'556 W Broadway', N'Vancouver', N'BC', N'V5Z 1E9', N' ', N'6048728787', N'6048732823', N' ', N' ', NULL, 3622)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (648, N'Paul', N'Chu', N'CHINA NATIONAL RAILWAY', N'556 W Broadway', N'Vancouver', N'BC', N'V5Z 1E9', N' ', N'6048728787', N'6048732823', N' ', N' ', NULL, 3622)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (662, NULL, NULL, N'CUNARD LINES', N'6100 Blue Lagoon Drive', N'Miami', N'FL', N'33126', N' ', N'8007286273', NULL, N' ', N'http://www.cunard.com', N'ACTAPGY', 3650)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (681, N'Nigel', N'Wood', N'TRAVEL STUDIO', N'Suite 890', N'Vancouver', N'BC', N'V6C 1N5', N' ', N'8005656670', N'8006652998', N'tsyvr@baxter.net', N'http://www.travelstudio.com', NULL, 4196)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (683, NULL, NULL, N'ROVOS RAIL - SOUTH AFRICA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.travelstudio.com', NULL, 4196)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (684, NULL, NULL, N'BLUE TRAIN - SOUTH AFRICA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.travelstudio.com', NULL, 4196)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (706, N'Randy', N'Anger', N'ANHEUSER-BUSCH ADVENTURE PARKS', N'358 Broadway Ave', N'Toronto', N'ON', N'M4P 1X2', N' ', N'4164839410', N'4164835982', N' ', N' ', N'PGY', 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (707, NULL, NULL, N'BUSCH GARDENS TAMPA BAY, FLORIDA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (708, NULL, NULL, N'ADVENTURE ISLAND TAMPA BAY, FLORIDA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (709, NULL, NULL, N'SESAME PLACE, LANGHORNE PENNSYLVANIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (710, NULL, NULL, N'SEAWORLD ADVENTURE PARK, ORLANDO FLORIDA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (711, NULL, NULL, N'SEAWORLD ADVENTURE PARK, CLEVELAND OHIO', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (712, NULL, NULL, N'SEAWORLD ADVENTURE PARK, SAN DIEGO CALIFORNIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (713, NULL, NULL, N'BUSCH GARDENS, WILLIAMSBURG VIRGINIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (714, NULL, NULL, N'WATER COUNTRY USA, WILLIAMSBURG VIRGINIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (715, NULL, NULL, N'SEAWORLD ADVENTURE PARK, SAN ANTONIO TEXAS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (716, NULL, NULL, N'DISCOVERY COVE, ORLANDO FLORIDA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5081)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (726, N'Maybelle', N'Ravin', N'THE RMR GROUP INC', N'Taurus House', N'Toronto', N'ON', N'M4R 2E3', N' ', N'4164858724', N'4164858256', N'assoc@thermrgroup.ca', N'http://www.thermrgroup.ca', N'PGY', 5228)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (727, N'Maybelle', N'Ravin', N'KLM uk/buzz', N'Taurus House', N'Toronto', N'ON', N'M4R 2E3', N' ', N'4164858724', N'4164858256', N'assoc@thermrgroup.ca', N'http://www.thermrgroup.ca', N'PGY', 5228)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (728, N'Jackie', N'Lutz', N'THE RMR GROUP INC', N'Taurus House', N'Toronto', N'ON', N'M4R 2E3', N' ', N'4164844864', N'4164858256', N'assoc@thermrgroup.ca', N'http://www.thermrgroup.ca', N'PGY', 5228)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (733, N'Lourdes', N'Freire', N'SKYWAYS INTERNATIONAL', N'486 College St', N'Toronto', N'ON', N'M6G 1A4', N' ', N'4169238949', N'4169601339', N'skyways@netcom.ca', N'http://www.addictravel.com', N'PGY', 5492)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (734, N'Lourdes', N'Freire', N'AEROCONTINENTE (CODE N6) PERUVIAN AIRLINES', N'486 College St', N'Toronto', N'ON', N'M6G 1A4', N' ', N'4169238949', N'4169601339', N'skyways@netcom.ca', N'http://www.addictravel.com', N'PGY', 5492)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (739, N'Hope', N'Burridge', N'TRAVEL BY RAIL', N'34 Flintridge Rd', N'Toronto (Scarborough)', N'ON', N'M1P 1G3', N' ', N'4167010756', N'4167010751', N'travelbyrail@hotmail.com', N'http://www.travelbyrail.com', N'PGY', 5777)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (740, NULL, NULL, N'BAUDHHA PARIKRAMA EXPRESS - INDIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.travelbyrail.com', NULL, 5777)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (741, NULL, NULL, N'PALACE ON WHEELS - INDIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.travelbyrail.com', NULL, 5777)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (742, NULL, NULL, N'ROYAL ORIENT - INDIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.travelbyrail.com', NULL, 5777)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (743, NULL, NULL, N'RAZDAN HOLIDAYS (INDIA)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.travelbyrail.com', NULL, 5777)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (744, N'Paulo', N'Karbach', N'REPWORLD INC', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', N'ACTAPGY', 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (745, N'Paulo', N'Karbach', N'LTU INTERNATIONAL AIRWAYS', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (746, N'Paulo', N'Karbach', N'LLOYD AEREO BOLIVIANO', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (747, N'Paulo', N'Karbach', N'ACES (Aerolineas Centrales De Colombia S.A.)', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (748, N'Paulo', N'Karbach', N'HARBOUR AIR SEAPLANES', N'4760 Inglis Dr', N'Richmond', N'BC', N'V7B 1W4', N' ', N'6042783478', N'6042789897', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (749, N'Paulo', N'Karbach', N'HELIUSA', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (750, N'Paulo', N'Karbach', N'ECUATORIANA', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (751, N'Paulo', N'Karbach', N'SRI LANKAN AIRLINES', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (752, N'Paulo', N'Karbach', N'AERO CALIFORNIA', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (753, N'Paulo', N'Karbach', N'LAUDA AIR', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (754, N'Paulo', N'Karbach', N'SURINAM AIRWAYS', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (755, N'Paulo', N'Karbach', N'ETHIOPIAN AIRLINES', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (756, N'Paulo', N'Karbach', N'ICELANDAIR', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (757, N'Paulo', N'Karbach', N'MERIDIANA', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (758, N'Paulo', N'Karbach', N'ASIANA AIRLINES', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (759, N'Paulo', N'Karbach', N'TURKISH AIRLINES', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (760, N'Paulo', N'Karbach', N'TAM BRAZILIAN AIRLINES', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (761, N'Paulo', N'Karbach', N'GHANA AIRWAYS', N'409-1200 W Pender St', N'Vancouver', N'BC', N'V6E 2S9', N' ', N'6046837824', N'6046837819', N' ', N' ', NULL, 5796)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (764, N'Tina', N'Myers', N'RESORT MARKETING INC', N'19495 Biscayne Blvd', N'Aventura', N'FL', N'33180-2', N'USA', N'8004320221', N'3059320023', N'radcblebch@aol.com', N'http://www.radisson.com/nassaubs', N'ACTAPGY', 5827)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (765, N'Tina', N'Myers', N'RESORT MARKETING', N'19495 Biscayne Blvd', N'Aventura', N'FL', N'33180-2', N'USA', N'8004320221', N'3059320023', N'radcblebch@aol.com', N'http://www.radisson.com/nassaubs', N'ACTAPGY', 5827)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (766, NULL, NULL, N'RADISSON CABLE BEACH RESORT', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 5827)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (767, N'Catherine', N'Evans', N'TOURS OF EXPLORATION', N'PO Box 48225', N'Vancouver', N'BC', N'V7X 1N8', N' ', N'6048867300', N'6048867304', N'info@toursexplore.com', N'http://www.toursexplore.com', N'PGY', 5857)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (768, NULL, NULL, N'DIRECTIONS IN TRVL SPECIALTY TRS INC', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.toursexplore.com', NULL, 5857)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (769, N'Gary', N'Murtagh', N'PASSAGES EXPEDITIONS', N'597 Markham St', N'Toronto', N'ON', N'M6G 2L7', N' ', N'4165885000', N'4165889839', N'eldertreks@eldertreks.com', N'http://www.eldertreks.com', N'PGY', 6346)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (770, N'Gary', N'Murtagh', N'ELDERTREKS', N'597 Markham St', N'Toronto', N'ON', N'M6G 2L7', N' ', N'4165885000', N'4165889839', N'eldertreks@eldertreks.com', N'http://www.eldertreks.com', N'PGY', 6346)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (776, N'Nilufer', N'Mama', N'GULF AIR', N'77 Bloor St W', N'Toronto', N'ON', N'M5S 1M2', N' ', N'4169664853', N'4169668924', N'info@twai-canada.com', N'http://www.twai-canada.com', NULL, 6505)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (777, N'Nilufer', N'Mama', N'AEROMAR', N'77 Bloor St W', N'Toronto', N'ON', N'M5S 1M2', N' ', N'4169664853', N'4169668924', N'info@twai-canada.com', N'http://www.twai-canada.com', NULL, 6505)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (778, N'Nilufer', N'Mama', N'AERO ASIA', N'77 Bloor St W', N'Toronto', N'ON', N'M5S 1M2', N' ', N'4169664853', N'4169668924', N'info@twai-canada.com', N'http://www.twai-canada.com', NULL, 6505)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (779, N'Nilufer', N'Mama', N'JET AIRWAYS', N'77 Bloor St W', N'Toronto', N'ON', N'M5S 1M2', N' ', N'4169664853', N'4169668924', N'info@twai-canada.com', N'http://www.twai-canada.com', NULL, 6505)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (780, N'Nilufer', N'Mama', N'TRADE WINDS ASSOCIATES CANADA INC', N'77 Bloor St W', N'Toronto', N'ON', N'M5S 1M2', N' ', N'4169664853', N'4169668924', N'info@twai-canada.com', N'http://www.twai-canada.com', N'ACTAPGY', 6505)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (781, N'D.', N'Soota', N'LTI TOURS', N'719 Yonge St', N'Toronto', N'ON', N'M4Y 2B5', N' ', N'4169629661', N'4169625910', N'info@ltitours.com', N'http://www.ltitours.com', N'PGY', 6550)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (783, NULL, NULL, N'EASTERN & ORIENTAL EXPRESS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.ltitours.com', NULL, 6550)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (784, NULL, NULL, N'PALACE ON WHEELS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.ltitours.com', NULL, 6550)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (786, N'Ashraf', N'Khan', N'BIMAN BANGLADESH AIRLINES', N'206 Bloor St W', N'Toronto', N'ON', N'M5S IT8', N' ', N'4169200110', N'4169209598', N' ', N' ', N'PGY', 6873)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (788, N'Ashraf', N'Khan', N'AIR EXPRESS TRAVEL INC', N'206 Bloor St W', N'Toronto', N'ON', N'M5S IT8', N' ', N'4169200110', N'4169209598', N' ', N' ', N'PGY', 6873)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (822, N'Rosie', N'Melkonian', N'WORLD ACCESS MARKETING', N'33 Blue Ridge Rd', N'Toronto (North York)', N'ON', N'M2K 1R8', N' ', N'4162235506', N'4162220319', N'reservations@outrigger.com', N' ', N'PGY', 7244)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (823, N'Rosie', N'Melkonian', N'OUTRIGGER HOTELS & RESORTS', N'33 Blue Ridge Rd', N'Toronto (North York)', N'ON', N'M2K 1R8', N' ', N'4162235506', N'4162220319', N'reservations@outrigger.com', N' ', N'PGY', 7244)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (825, NULL, NULL, N'BALKAN AIRLINES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 7377)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (826, N'Subash', N'Chauhan', N'MAJESTIC TOURS', N'545 N Rivermede Rd', N'Concord', N'ON', N'L4K 4H1', N' ', N'9056604704', N'9056603055', N' ', N' ', N'PGY', 7377)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (834, N'Robert', N'Townshend', N'MUSTIQUE AIRWAYS', N'2011 Lawrence Ave W', N'Toronto', N'ON', N'M9N 3V3', N' ', N'4162407700', N'4162407701', N'travel@totaladvantage.com', N' ', N'PGY', 11160)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (835, N'Robert', N'Townshend', N'TOTAL ADVANTAGE TRAVEL & TOURS INC', N'2011 Lawrence Ave W', N'Toronto', N'ON', N'M9N 3V3', N' ', N'4162407700', N'4162407701', N'travel@totaladvantage.com', N' ', N'PGY', 11160)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (839, N'Mary', N'Warner', N'EXCLUSIVE TOURS', N'145 King St W', N'Toronto', N'ON', N'M5H 1J8', N' ', N'4163688558', N'4169559869', N'et@merit.ca', N' ', N'PGY', 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (840, NULL, NULL, N'DANUBE CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (841, NULL, NULL, N'CONTINENTAL WATERWAYS - HOTEL BARGE CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (842, NULL, NULL, N'VIKING RIVER CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (843, NULL, NULL, N'BARGE CANAL & RIVER CRUISES EUROPE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (845, NULL, NULL, N'EUROPEAN WATERWAYS/LUXURY EUROPEAN BARGE CRUISES', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (846, NULL, NULL, N'PETER DEILMANN EUROPAMERICA CRUISES:', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (849, NULL, NULL, N'UNIWORLD EUROPE RIVER CRUISES & WATERWAYS OF RUSSIA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 8089)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (862, N'Ross', N'de Gregorio', N'MANDITOURS - ITALY', N'9625 Yonge St', N'Richmond Hill', N'ON', N'L4C 5T2', N' ', N'9055088190', N'9057372978', N'mandi@italia-magica.com', N' ', N'PGY', 9785)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (867, N'Stephen', N'Yo', N'KINTETSU INTERNATIONAL EXPRESS', N'1550 Enterprises Rd', N'Mississauga', N'ON', N'L4W 4P4', N' ', N'9056708710', N'9056702238', N'outbound@kiecan.com', N'http://www.kiecan.com/outbound', N'PGY', 9766)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (868, N'Stephen', N'Yo', N'JAPAN RAIL PASS', N'1550 Enterprises Rd', N'Mississauga', N'ON', N'L4W 4P4', N' ', N'9056708710', N'9056702238', N'outbound@kiecan.com', N'http://www.kiecan.com/outbound', N'PGY', 9766)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (872, N'Timo', N'Jokinen', N'SCANDITOURS', N'191 Eglinton Ave E', N'Toronto', N'ON', N'M4P 1K1', N' ', N'4164823006', N'4164829447', N'toronto@scanditours.com', N'http://www.scanditours.com', N'PGY', 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (873, NULL, NULL, N'STENA LINE (GSA CANADA)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.scanditours.com', NULL, 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (874, NULL, NULL, N'GOTA CANAL (GSA CANADA)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.scanditours.com', NULL, 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (875, NULL, NULL, N'DFDS SEAWAYS', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.scanditours.com', NULL, 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (876, NULL, NULL, N'VIKING LINE (GSA CANADA)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.scanditours.com', NULL, 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (877, NULL, NULL, N'ESTLINE', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.scanditours.com', NULL, 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (878, NULL, NULL, N'FRED OLSEN LINE (GSA CANADA)', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N'http://www.scanditours.com', NULL, 8837)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (886, N'Vonna', N'McDonald', N'BONAVENTURE TOURS', N'205-221 W Esplanade', N'N Vancouver', N'BC', N'V7M 3J3', N' ', N'6049907390', N'6049907394', N'info@bonaventuretours.com', N'http://www.bonaventuretours.com', N'PGY', 9323)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (887, N'Vonna', N'McDonald', N'BONAVENTURE TOURS - UK & IRELAND - CANAL BOAT CHARTERS', N'205-221 W Esplanade', N'N Vancouver', N'BC', N'V7M 3J3', N' ', N'6049907390', N'6049907394', N'info@bonaventuretours.com', N'http://www.bonaventuretours.com', N'PGY', 9323)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (888, N'Jim', N'Cohen', N'HOTELINK', N'1027 Yonge St', N'Toronto', N'ON', N'M4W 2K9', N' ', N'4169232003', N'4169442245', N'info@skylinkholidays.com', N' ', N'PGY', 9396)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (895, N'Mari', N'Abe', N'JTB INTERNATIONAL (CANADA) LTD', N'77 King St W', N'Toronto', N'ON', N'M5K 1E7', N' ', N'4163675824', N'4163674859', N'sales@jtbcnd.com', N' ', N'PGY', 9285)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (897, N'Mari', N'Abe', N'JAPAN RAIL PASS', N'77 King St W', N'Toronto', N'ON', N'M5K 1E7', N' ', N'4163675824', N'4163674859', N'sales@jtbcnd.com', N' ', N'PGY', 9285)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (899, N'Mari', N'Abe', N'SUNRISE TOURS', N'77 King St W', N'Toronto', N'ON', N'M5K 1E7', N' ', N'4163675824', N'4163674859', N'sales@jtbcnd.com', N' ', N'PGY', 9285)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (908, N'Eric', N'Douay', N'D-TOUR MARKETING', N'625 W Rene Levesque Blvd', N'Montreal', N'PQ', N'H3B 1R2', N' ', N'5143939585', N'5143939029', N'dtour.marketing@planetepc.qc.ca', N'http://www.dtourmarketing.com', N'PGY', 11163)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (909, N'Eric', N'Douay', N'RIVAGES CROISIERES THE CARIBBEAN INTIMATE YACHT CRUISES', N'625 W Rene Levesque Blvd', N'Montreal', N'PQ', N'H3B 1R2', N' ', N'5143939585', N'5143939029', N'dtour.marketing@planetepc.qc.ca', N'http://www.dtourmarketin', NULL, 11163)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (910, N'Eric', N'Douay', N'CONCORDE HOTELS (WORLDWIDE)', N'625 W Rene Levesque Blvd', N'Montreal', N'PQ', N'H3B 1R2', N' ', N'5143939585', N'5143939029', N'dtour.marketing@planetepc.qc.ca', N'http://www.dtourmarketing.com', N'PGY', 11163)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (911, N'Eric', N'Douay', N'PRIMEREVE ''ALL-SUITE'' HOTEL (Martinique)', N'625 W Rene Levesque Blvd', N'Montreal', N'PQ', N'H3B 1R2', N' ', N'5143939585', N'5143939029', N'dtour.marketing@planetepc.qc.ca', N'http://www.dtourmarketing.com', N'PGY', 11163)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (912, N'Eric', N'Douay', N'CHATEAUX & HOTELS DE FRANCE', N'625 W Rene Levesque Blvd', N'Montreal', N'PQ', N'H3B 1R2', N' ', N'5143939585', N'5143939029', N'dtour.marketing@planetepc.qc.ca', N'http://www.dtourmarketing.com', N'PGY', 11163)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (913, N'Michael', N'Merrithew', N'MERIT TRAVEL GROUP INC', N'145 King St W', N'Toronto', N'ON', N'M5H 1J8', N' ', N'4163688558', N'4169559869', N'golf@merit.ca', N' ', N'PGY', 11172)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (914, N'Michael', N'Merrithew', N'GOLF HOLIDAYS', N'145 King St W', N'Toronto', N'ON', N'M5H 1J8', N' ', N'4163688558', N'4169559869', N'golf@merit.ca', N' ', N'PGY', 11172)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (938, N'Hugo', N'Maggi', N'GRUPO TACA', N'1235 Bay St', N'Toronto', N'ON', N'M5R 3K4', N' ', N'4169682222', N'4169680363', N' ', N'http://www.grupotaca.com', N'PGY', 11174)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (939, NULL, NULL, N'LACSA AIRLINES OF COSTA RICA', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 11174)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (942, N'Loreen', N'Walter', N'DKM COACH LINES LTD', N'1908 Spruce Hill Rd', N'Pickering', N'ON', N'L1V 1S7', N' ', N'4164104680', N'4168313384', N'dkmcl@home.com', N'http://www.dkmtravel.com', N'PGY', 11237)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (943, NULL, NULL, N'CASINO DIRECT', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 11237)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (957, NULL, NULL, N'ALITOURS CAR RENTAL BY HERTZ', N' ', N' ', N' ', N' ', N' ', NULL, NULL, N' ', N' ', NULL, 11156)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (958, N'Tony', N'Veca', N'ALITOURS INTERNATIONAL INC.', N'792 St. Clair Ave W', N'Toronto', N'ON', N'M6C 1B6', N' ', N'4166537751', N'4166539010', N'alitours@baxter.net', N'http://www.alitours.com', N'PGY', 11156)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1113, N'Cindy', N' Harris', N'TRANS SIBERIAN RAILWAY', N'1847 W 4th Ave', N'Vancouver', N'BC', N'V6J 1M4', N' ', N'6046061830', N'6047378854', N'adventure@freshtracks.com', N'http://www.goactivevacations.com', N'PGY', 11549)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1114, N'Cindy', N' Harris', N'GO ACTIVE VACATIONS', N'1847 W 4th Ave', N'Vancouver', N'BC', N'V6J 1M4', N' ', N'6046061830', N'6047378854', N'team@goactivevacations.com', N'http://www.goactivevacations.com', N'PGY', 11549)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1115, N'Cindy', N' Harris', N'FRESH TRACKS CANADA', N'1847 W 4th Ave', N'Vancouver', N'BC', N'V6J 1M4', N' ', N'6047378743', N'6047185110', N'adventure@freshtracks.com', N'http://www.goactivevacations.com', N'PGY', 11549)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1126, N'Bashiruddin', N'Ahmed', N'SAAAI TRAVEL INC.', N'1410 Guy St', N'Montreal', N'PQ', N'H3H 2L7', N' ', N'5149311100', N'5149311200', N'saaaitravel@sympatico.ca', N' ', N'PGY', 12657)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1127, N'Bashiruddin', N'Ahmed', N'BIMAN BANGLADESH AIRLINES', N'1410 Guy St', N'Montreal', N'PQ', N'H3H 2L7', N' ', N'5149311100', N'5149311200', N'saaaitravel@sympatico.ca', N' ', N'PGY', 12657)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1128, N'Bashiruddin', N'Ahmed', N'SAAAI TRAVEL', N'1410 Guy St', N'Montreal', N'PQ', N'H3H 2L7', N' ', N'5149314070', N'5149339992', N'saaaitravel@sympatico.ca', N' ', N'PGY', 12657)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1129, N'Bashiruddin', N'Ahmed', N'S.I. TRAVELS', N'1410 Guy St', N'Montreal', N'PQ', N'H3H 2L7', N' ', N'5149314070', N'5149339992', N'saaaitravel@sympatico.ca', N' ', N'PGY', 12657)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1158, N'Kristin', N'Karbach', N'A & TIC SUPPORT INC.', N'80 John Stiver Cres', N'Markham', N'ON', N'L3R 9B3', N' ', N'9059439763', N'9059439764', N'elcotour-na@netcom.ca', N' ', N'PGY', 13596)
GO
INSERT [dbo].[SupplierContacts] ([SupplierContactId], [SupConFirstName], [SupConLastName], [SupConCompany], [SupConAddress], [SupConCity], [SupConProv], [SupConPostal], [SupConCountry], [SupConBusPhone], [SupConFax], [SupConEmail], [SupConURL], [AffiliationId], [SupplierId]) VALUES (1159, N'Kristin', N'Karbach', N'ELCOTOUR - BRAZIL TOUR SPECIALISTS', N'80 John Stiver Cres', N'Markham', N'ON', N'L3R 9B3', N' ', N'9059439763', N'9059439764', N'elcotour-na@netcom.ca', N' ', N'PGY', 13596)
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (69, N'NEW CONCEPTS - CANADA')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (80, N'CHAT / TRAVELINE')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (100, N'AVILA TOURS INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (317, N'BLYTH & COMPANY TRAVEL')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (323, N'COMPAGNIA ITALIANA TURISM')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (796, N'CYPRUS AIRWAYS LTD')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (828, N'DER TRAVEL SERVICE LTD')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (845, N'DISCOVER THE WORLD MARKET')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (908, N'ELITE ORIENT TOURS INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1005, N'ENCORE CRUISES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1028, N'EUROP-AUTO-VACANCES/HOLIDAYS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1040, N'EXECUTIVE SUITES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1205, N'GOLDMAN MARKETING')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1406, N'EUROCRUISES INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1416, N'THE HOLIDAY NETWORK')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1425, N'HOLLAND AMERICA LINE WEST')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1542, N'INSIGHT VACATIONS CANADA')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1620, N'INTAIR VACATIONS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1634, N'ISLANDS IN THE SUN CRUISE')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1685, N'GOWAY TRAVEL LTD.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1713, N'JETPACIFIC HOLIDAYS INC')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1766, N'KLM ROYAL DUTCH AIRLINES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1859, N'LOTUS HOLIDAYS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (1918, N'MARKET SQUARE TOURS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2140, N'NAGEL TOURS LTD')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2386, N'PAVLIK TRAVEL GROUP')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2466, N'PLANET FRANCE/PLANET EURO')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2588, N'UNIQUE VACATIONS (CANADA)')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2592, N'ESPRIT/SERVICENTRE HOLIDAYS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2827, N'SOUTH WIND TOURS LTD.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2938, N'SUN & LEISURE TRAVEL CORP.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2987, N'TOURCAN VACATIONS INC')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (2998, N'ALIOTOURS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3119, N'MEDIAN AVIATION RESOURCES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3212, N'TREK HOLIDAYS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3273, N'MARKETING AHEAD')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3376, N'MARTINAIR SERVICES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3549, N'BONANZA HOLIDAYS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3576, N'BLUE DANUBE HOLIDAYS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3589, N'G.A.P ADVENTURES INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3600, N'GOLDEN ESCAPES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3622, N'CHINA TRAVEL SERVICE (CAN)')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3633, N'VIP INTERNATIONAL')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (3650, N'CUNARD LINES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (4196, N'TRAVEL STUDIO')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5081, N'ANHEUSER-BUSCH ADVENTURE')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5228, N'THE RMR GROUP INC')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5492, N'Skyways Freightline')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5777, N'TRAVEL BY RAIL')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5796, N'REPWORLD INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5827, N'RESORT MARKETING INC')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (5857, N'TOURS OF EXPLORATION')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (6346, N'PASSAGES EXPEDITIONS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (6505, N'TRADE WINDS ASSOCIATES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (6550, N'LTI TOURS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (6873, N'BIMAN BANGLADESH AIRLINES')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (7244, N'WORLD ACCESS MARKETING')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (7377, N'MAJESTIC TOURS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (8089, N'EXCLUSIVE TOURS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (8837, N'SCANDITOURS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (9285, N'JTB INTERNATIONAL (CANADA)')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (9323, N'BONAVE')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (9396, N'SKYLINK TICKET CENTRE')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (9766, N'KINTETSU INTERNATIONAL')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (9785, N'MANDITOURS INTL INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11156, N'ALITOURS INTERNATIONAL INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11160, N'TOTAL ADVANTAGE TRAVEL')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11163, N'D-TOUR MARKETING')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11172, N'MERIT TRAVEL GROUP INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11174, N'GRUPO TACA')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11237, N'DKM COACH LINES LTD')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (11549, N'GO ACTIVE VACATIONS')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (12657, N'SAAAI TRAVEL INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (13596, N'A & TIC SUPPORT INC.')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (13597, N'Franks Red Hot Sauce')
GO
INSERT [dbo].[Suppliers] ([SupplierId], [SupName]) VALUES (13598, N'Starbucks')
GO
INSERT [dbo].[TripTypes] ([TripTypeId], [TTName]) VALUES (N'B', N'Business                 ')
GO
INSERT [dbo].[TripTypes] ([TripTypeId], [TTName]) VALUES (N'G', N'Group                    ')
GO
INSERT [dbo].[TripTypes] ([TripTypeId], [TTName]) VALUES (N'L', N'Leisure                  ')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aaaaaAffiliations_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Affiliations] ADD  CONSTRAINT [aaaaaAffiliations_PK] PRIMARY KEY NONCLUSTERED 
(
	[AffilitationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaBookingDetails_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[BookingDetails] ADD  CONSTRAINT [aaaaaBookingDetails_PK] PRIMARY KEY NONCLUSTERED 
(
	[BookingDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Agency Fee Code]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [Agency Fee Code] ON [dbo].[BookingDetails]
(
	[FeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [BookingId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [BookingId] ON [dbo].[BookingDetails]
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [BookingsBookingDetails]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [BookingsBookingDetails] ON [dbo].[BookingDetails]
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [ClassesBookingDetails]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ClassesBookingDetails] ON [dbo].[BookingDetails]
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Dest ID]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [Dest ID] ON [dbo].[BookingDetails]
(
	[RegionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [DestinationsBookingDetails]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [DestinationsBookingDetails] ON [dbo].[BookingDetails]
(
	[RegionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [FeesBookingDetails]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [FeesBookingDetails] ON [dbo].[BookingDetails]
(
	[FeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Products_SuppliersBookingDetails]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [Products_SuppliersBookingDetails] ON [dbo].[BookingDetails]
(
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductSupplierId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ProductSupplierId] ON [dbo].[BookingDetails]
(
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaBookings_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Bookings] ADD  CONSTRAINT [aaaaaBookings_PK] PRIMARY KEY NONCLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [BookingsCustomerId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [BookingsCustomerId] ON [dbo].[Bookings]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CustomersBookings]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [CustomersBookings] ON [dbo].[Bookings]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PackageId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [PackageId] ON [dbo].[Bookings]
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PackagesBookings]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [PackagesBookings] ON [dbo].[Bookings]
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [TripTypesBookings]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [TripTypesBookings] ON [dbo].[Bookings]
(
	[TripTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aaaaaClasses_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Classes] ADD  CONSTRAINT [aaaaaClasses_PK] PRIMARY KEY NONCLUSTERED 
(
	[ClassId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaCreditCards_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[CreditCards] ADD  CONSTRAINT [aaaaaCreditCards_PK] PRIMARY KEY NONCLUSTERED 
(
	[CreditCardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CustomersCreditCards]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [CustomersCreditCards] ON [dbo].[CreditCards]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaCustomers_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [aaaaaCustomers_PK] PRIMARY KEY NONCLUSTERED 
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [EmployeesCustomers]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [EmployeesCustomers] ON [dbo].[Customers]
(
	[AgentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaCustomers_Rewards_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Customers_Rewards] ADD  CONSTRAINT [aaaaaCustomers_Rewards_PK] PRIMARY KEY NONCLUSTERED 
(
	[CustomerId] ASC,
	[RewardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [CustomersCustomers_Rewards]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [CustomersCustomers_Rewards] ON [dbo].[Customers_Rewards]
(
	[CustomerId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [RewardsCustomers_Rewards]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [RewardsCustomers_Rewards] ON [dbo].[Customers_Rewards]
(
	[RewardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aaaaaFees_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Fees] ADD  CONSTRAINT [aaaaaFees_PK] PRIMARY KEY NONCLUSTERED 
(
	[FeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaPackages_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Packages] ADD  CONSTRAINT [aaaaaPackages_PK] PRIMARY KEY NONCLUSTERED 
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaPackages_Products_Suppliers_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Packages_Products_Suppliers] ADD  CONSTRAINT [aaaaaPackages_Products_Suppliers_PK] PRIMARY KEY NONCLUSTERED 
(
	[PackageId] ASC,
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [PackagesPackages_Products_Suppliers]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [PackagesPackages_Products_Suppliers] ON [dbo].[Packages_Products_Suppliers]
(
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Products_SuppliersPackages_Products_Suppliers]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [Products_SuppliersPackages_Products_Suppliers] ON [dbo].[Packages_Products_Suppliers]
(
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductSupplierId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ProductSupplierId] ON [dbo].[Packages_Products_Suppliers]
(
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaProducts_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [aaaaaProducts_PK] PRIMARY KEY NONCLUSTERED 
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ProductId] ON [dbo].[Products]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaProducts_Suppliers_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Products_Suppliers] ADD  CONSTRAINT [aaaaaProducts_Suppliers_PK] PRIMARY KEY NONCLUSTERED 
(
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [Product Supplier ID]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [Product Supplier ID] ON [dbo].[Products_Suppliers]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ProductId] ON [dbo].[Products_Suppliers]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductsProducts_Suppliers1]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ProductsProducts_Suppliers1] ON [dbo].[Products_Suppliers]
(
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [ProductSupplierId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [ProductSupplierId] ON [dbo].[Products_Suppliers]
(
	[ProductSupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SuppliersProducts_Suppliers1]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [SuppliersProducts_Suppliers1] ON [dbo].[Products_Suppliers]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aaaaaRegions_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Regions] ADD  CONSTRAINT [aaaaaRegions_PK] PRIMARY KEY NONCLUSTERED 
(
	[RegionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaRewards_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Rewards] ADD  CONSTRAINT [aaaaaRewards_PK] PRIMARY KEY NONCLUSTERED 
(
	[RewardId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaSupplierContacts_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[SupplierContacts] ADD  CONSTRAINT [aaaaaSupplierContacts_PK] PRIMARY KEY NONCLUSTERED 
(
	[SupplierContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AffiliationsSupCon]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [AffiliationsSupCon] ON [dbo].[SupplierContacts]
(
	[AffiliationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SuppliersSupCon]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [SuppliersSupCon] ON [dbo].[SupplierContacts]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [aaaaaSuppliers_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [aaaaaSuppliers_PK] PRIMARY KEY NONCLUSTERED 
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [SupplierId]    Script Date: 2/24/2020 2:43:20 PM ******/
CREATE NONCLUSTERED INDEX [SupplierId] ON [dbo].[Suppliers]
(
	[SupplierId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [aaaaaTripTypes_PK]    Script Date: 2/24/2020 2:43:20 PM ******/
ALTER TABLE [dbo].[TripTypes] ADD  CONSTRAINT [aaaaaTripTypes_PK] PRIMARY KEY NONCLUSTERED 
(
	[TripTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BookingDetails] ADD  CONSTRAINT [DF__BookingDe__Booki__7C8480AE]  DEFAULT ((0)) FOR [BookingId]
GO
ALTER TABLE [dbo].[BookingDetails] ADD  CONSTRAINT [DF__BookingDe__Produ__7D78A4E7]  DEFAULT ((0)) FOR [ProductSupplierId]
GO
ALTER TABLE [dbo].[Bookings] ADD  CONSTRAINT [DF__Bookings__Packag__023D5A04]  DEFAULT ((0)) FOR [PackageId]
GO
ALTER TABLE [dbo].[Customers_Rewards] ADD  CONSTRAINT [DF__Customers__Rewar__1273C1CD]  DEFAULT ((0)) FOR [RewardId]
GO
ALTER TABLE [dbo].[Fees] ADD  CONSTRAINT [DF__Fees__FeeAmt__1B0907CE]  DEFAULT ((0)) FOR [FeeAmt]
GO
ALTER TABLE [dbo].[Packages] ADD  CONSTRAINT [DF__Packages__PkgBas__76CBA758]  DEFAULT ((0)) FOR [PkgBasePrice]
GO
ALTER TABLE [dbo].[Packages] ADD  CONSTRAINT [DF__Packages__PkgAge__77BFCB91]  DEFAULT ((0)) FOR [PkgAgencyCommission]
GO
ALTER TABLE [dbo].[Packages_Products_Suppliers] ADD  CONSTRAINT [DF__Packages___Packa__239E4DCF]  DEFAULT ((0)) FOR [PackageId]
GO
ALTER TABLE [dbo].[Packages_Products_Suppliers] ADD  CONSTRAINT [DF__Packages___Produ__24927208]  DEFAULT ((0)) FOR [ProductSupplierId]
GO
ALTER TABLE [dbo].[Products_Suppliers] ADD  CONSTRAINT [DF__Products___Produ__2D27B809]  DEFAULT ((0)) FOR [ProductId]
GO
ALTER TABLE [dbo].[Rewards] ADD  CONSTRAINT [DF__Rewards__RewardI__35BCFE0A]  DEFAULT ((0)) FOR [RewardId]
GO
ALTER TABLE [dbo].[SupplierContacts] ADD  CONSTRAINT [DF__SupplierC__Suppl__3A81B327]  DEFAULT ((0)) FOR [SupplierId]
GO
ALTER TABLE [dbo].[Suppliers] ADD  CONSTRAINT [DF__Suppliers__Suppl__3F466844]  DEFAULT ((0)) FOR [SupplierId]
GO
ALTER TABLE [dbo].[Agents]  WITH CHECK ADD  CONSTRAINT [FK_Agents_Agencies] FOREIGN KEY([AgencyId])
REFERENCES [dbo].[Agencies] ([AgencyId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Agents] CHECK CONSTRAINT [FK_Agents_Agencies]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetails_Bookings] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Bookings] ([BookingId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK_BookingDetails_Bookings]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetails_Classes] FOREIGN KEY([ClassId])
REFERENCES [dbo].[Classes] ([ClassId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK_BookingDetails_Classes]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetails_Fees] FOREIGN KEY([FeeId])
REFERENCES [dbo].[Fees] ([FeeId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK_BookingDetails_Fees]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetails_Products_Suppliers] FOREIGN KEY([ProductSupplierId])
REFERENCES [dbo].[Products_Suppliers] ([ProductSupplierId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK_BookingDetails_Products_Suppliers]
GO
ALTER TABLE [dbo].[BookingDetails]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetails_Regions] FOREIGN KEY([RegionId])
REFERENCES [dbo].[Regions] ([RegionId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[BookingDetails] CHECK CONSTRAINT [FK_BookingDetails_Regions]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [Bookings_FK00] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [Bookings_FK00]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [Bookings_FK01] FOREIGN KEY([PackageId])
REFERENCES [dbo].[Packages] ([PackageId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [Bookings_FK01]
GO
ALTER TABLE [dbo].[Bookings]  WITH CHECK ADD  CONSTRAINT [Bookings_FK02] FOREIGN KEY([TripTypeId])
REFERENCES [dbo].[TripTypes] ([TripTypeId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Bookings] CHECK CONSTRAINT [Bookings_FK02]
GO
ALTER TABLE [dbo].[CreditCards]  WITH CHECK ADD  CONSTRAINT [CreditCards_FK00] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[CreditCards] CHECK CONSTRAINT [CreditCards_FK00]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_Agents] FOREIGN KEY([AgentId])
REFERENCES [dbo].[Agents] ([AgentId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_Agents]
GO
ALTER TABLE [dbo].[Customers_Rewards]  WITH CHECK ADD  CONSTRAINT [Customers_Rewards_FK00] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([CustomerId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers_Rewards] CHECK CONSTRAINT [Customers_Rewards_FK00]
GO
ALTER TABLE [dbo].[Customers_Rewards]  WITH CHECK ADD  CONSTRAINT [Customers_Rewards_FK01] FOREIGN KEY([RewardId])
REFERENCES [dbo].[Rewards] ([RewardId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers_Rewards] CHECK CONSTRAINT [Customers_Rewards_FK01]
GO
ALTER TABLE [dbo].[Packages_Products_Suppliers]  WITH CHECK ADD  CONSTRAINT [Packages_Products_Supplie_FK00] FOREIGN KEY([PackageId])
REFERENCES [dbo].[Packages] ([PackageId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Packages_Products_Suppliers] CHECK CONSTRAINT [Packages_Products_Supplie_FK00]
GO
ALTER TABLE [dbo].[Packages_Products_Suppliers]  WITH CHECK ADD  CONSTRAINT [Packages_Products_Supplie_FK01] FOREIGN KEY([ProductSupplierId])
REFERENCES [dbo].[Products_Suppliers] ([ProductSupplierId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Packages_Products_Suppliers] CHECK CONSTRAINT [Packages_Products_Supplie_FK01]
GO
ALTER TABLE [dbo].[Products_Suppliers]  WITH CHECK ADD  CONSTRAINT [Products_Suppliers_FK00] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Products] ([ProductId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Products_Suppliers] CHECK CONSTRAINT [Products_Suppliers_FK00]
GO
ALTER TABLE [dbo].[Products_Suppliers]  WITH CHECK ADD  CONSTRAINT [Products_Suppliers_FK01] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([SupplierId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Products_Suppliers] CHECK CONSTRAINT [Products_Suppliers_FK01]
GO
ALTER TABLE [dbo].[SupplierContacts]  WITH CHECK ADD  CONSTRAINT [SupplierContacts_FK00] FOREIGN KEY([AffiliationId])
REFERENCES [dbo].[Affiliations] ([AffilitationId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SupplierContacts] CHECK CONSTRAINT [SupplierContacts_FK00]
GO
ALTER TABLE [dbo].[SupplierContacts]  WITH CHECK ADD  CONSTRAINT [SupplierContacts_FK01] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Suppliers] ([SupplierId])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[SupplierContacts] CHECK CONSTRAINT [SupplierContacts_FK01]
GO
USE [master]
GO
ALTER DATABASE [TravelExperts] SET  READ_WRITE 
GO
