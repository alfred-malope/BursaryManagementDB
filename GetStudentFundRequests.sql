CREATE PROCEDURE GetStudentFundRequests
AS
BEGIN
    SELECT
        [StudentFundRequest].[ID],
        [User].[FirstName],
        [User].[LastName],
        [University].[Name] AS UniversityName,
        [Student].[IDNumber],
        [Student].[BirthDate],
        [Student].[Age],
        [Gender].[GenderName],
        [ContactDetails].[Email],
        [ContactDetails].[PhoneNumber],
        [Race].[RaceName],
        [StudentFundRequest].[Grade],
        [StudentFundRequest].[Amount],
        [StudentFundRequest].[CreatedDate] AS RequestCreatedDate,
        [Status].[Type] AS FundRequestStatus,
        [StudentFundRequest].[Comment],
        CASE
            WHEN [Document].[ID] IS NOT NULL THEN 'Received'
            ELSE 'Pending Document'
        END AS DocumentStatus
    FROM
        [dbo].[StudentFundRequest]
    INNER JOIN [dbo].[Student] ON [StudentFundRequest].[StudentID] = [Student].[ID]
    INNER JOIN [dbo].[User] ON [Student].[UserID] = [User].[ID]
    INNER JOIN [dbo].[ContactDetails] ON [User].[ContactID] = [ContactDetails].[ID]
    INNER JOIN [dbo].[Gender] ON [Student].[GenderID] = [Gender].[ID]
    INNER JOIN [dbo].[Race] ON [Student].[RaceID] = [Race].[ID]
    INNER JOIN [dbo].[UniversityStudentInformation] ON [StudentFundRequest].[StudentID] = [UniversityStudentInformation].[StudentID]
    INNER JOIN [dbo].[University] ON [UniversityStudentInformation].[UniversityID] = [University].[ID]
    INNER JOIN [dbo].[Status] ON [StudentFundRequest].[StatusID] = [Status].[ID]
    LEFT JOIN [dbo].[Document] ON [StudentFundRequest].[ID] = [Document].[RequestID];
END;
GO
