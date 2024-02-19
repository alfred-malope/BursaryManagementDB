
CREATE PROCEDURE [dbo].[usp_NewUniversityFundRequest] 
    @UniversityID INT, 
    @Amount DECIMAL(18,2),
    @Comment NVARCHAR(1000)
AS
BEGIN
    SET NOCOUNT ON;

    -- Insert the new request into the UniversityFundRequest table
    INSERT INTO UniversityFundRequest (UniversityID, Amount, DateCreated, Comment, StatusID)
    VALUES (@UniversityID, @Amount, GETDATE(), @Comment, 3);

    -- Return the inserted data
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
    WHERE 
        University.ID = @UniversityID;
END;

GO


CREATE PROCEDURE [dbo].[usp_UpdateUniversityFundRequest] 
	@RequestID INT,  
	@StatusID INT
    AS
    BEGIN
    SET NOCOUNT ON;

		UPDATE UniversityFundRequest
		SET StatusID = @StatusID
		WHERE ID = @RequestID;

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
		WHERE 
			UniversityFundRequest.ID = @RequestID;
	END;
