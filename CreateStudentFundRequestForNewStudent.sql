CREATE PROCEDURE CreateStudentFundRequestForNewStudent
(
    @IDNumber CHAR(13),
    @FirstName VARCHAR(120),
    @LastName VARCHAR(120),
    @Email VARCHAR(255),
    @PhoneNumber VARCHAR(13),
    @GenderName VARCHAR(8),
    @RaceName VARCHAR(8),
    @UniversityID INT,
    @BirthDate DATE,
    @Grade TINYINT,
    @Amount MONEY
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        DECLARE @StudentID INT;
        DECLARE @UserID INT;
        DECLARE @StatusID INT;
        DECLARE @GenderID INT;
        DECLARE @RaceID INT;

        INSERT INTO dbo.ContactDetails (Email, PhoneNumber)
        VALUES (@Email, @PhoneNumber);
        SET @UserID = SCOPE_IDENTITY();

        INSERT INTO dbo.[User] (FirstName, LastName, ContactID)
        VALUES (@FirstName, @LastName, @UserID);
        SET @StudentID = SCOPE_IDENTITY();

        SELECT @GenderID = ID FROM dbo.Gender WHERE GenderName = @GenderName;

        SELECT @RaceID = ID FROM dbo.Race WHERE RaceName = @RaceName;

        INSERT INTO dbo.Student (IDNumber, GenderID, UserID, RaceID, BirthDate)
        VALUES (@IDNumber, @GenderID, @StudentID, @RaceID, @BirthDate);

        INSERT INTO dbo.UniversityStudentInformation (UniversityID, StudentID)
        VALUES (@UniversityID, @StudentID);

        INSERT INTO dbo.StudentFundRequest (Grade, Amount, StatusID, Comment, StudentID)
        VALUES (@Grade, @Amount, 3, '', @StudentID);

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
    END CATCH;
END


EXEC [dbo].[CreateStudentFundRequestForNewStudent] @IDNumber,@FirstName,@LastName,@Email,@PhoneNumber,@GenderName,@RaceName,@UniversityID,@BirthDate,@Grade,@Amount