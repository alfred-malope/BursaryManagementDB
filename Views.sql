CREATE VIEW [dbo].[vw_UniversityRequests] AS

	SELECT 
        University.[Name] AS University, 
        Provinces.ProvinceName AS Province, 
        UniversityFundRequest.Amount,
        [dbo].[Status].[Type] AS [Status],
        UniversityFundRequest.DateCreated,
        UniversityFundRequest.Comment
    FROM 
        University 
    INNER JOIN 
        UniversityFundRequest ON University.ID = UniversityFundRequest.UniversityID
    INNER JOIN 
        Provinces ON University.ProvinceID = Provinces.ID
    INNER JOIN 
        [dbo].[Status] ON UniversityFundRequest.StatusID = [dbo].[Status].ID

GO


USE [UkukhulaDB]
GO

/****** Object: View [dbo].[vw_UniversityAllocation] Script Date: 2024/02/20 08:33:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_UniversityAllocation] AS
SELECT 
    University.[Name] AS University, 
    Provinces.ProvinceName AS Province, 
    UniversityFundAllocation.Budget,
    UniversityFundAllocation.DateAllocated,
    ISNULL(SUM(StudentFundAllocation.Amount),0) AS TotalAllocated
FROM 
    University 
INNER JOIN 
    UniversityFundAllocation ON University.ID = UniversityFundAllocation.UniversityID
INNER JOIN 
    Provinces ON University.ProvinceID = Provinces.ID
LEFT JOIN 
    StudentFundAllocation ON UniversityFundAllocation.ID = StudentFundAllocation.UniversityFundID
WHERE 
    DATEDIFF(YEAR, UniversityFundAllocation.DateAllocated, GETDATE()) = 0
GROUP BY
    University.[Name], 
    Provinces.ProvinceName, 
    UniversityFundAllocation.Budget,
    UniversityFundAllocation.DateAllocated;

