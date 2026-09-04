IF DB_ID('RaceDayDB') IS NULL
BEGIN
    CREATE DATABASE RaceDayDB;
END
GO
 
USE RaceDayDB;
GO

IF OBJECT_ID('dbo.Results', 'U') IS NOT NULL
    DROP TABLE dbo.Results;

IF OBJECT_ID('dbo.Enrolments', 'U') IS NOT NULL
    DROP TABLE dbo.Enrolments;

IF OBJECT_ID('dbo.Routes', 'U') IS NOT NULL
    DROP TABLE dbo.Routes;

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL
    DROP TABLE dbo.Categories;

IF OBJECT_ID('dbo.Events', 'U') IS NOT NULL
    DROP TABLE dbo.Events;

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE dbo.Users;
GO

CREATE TABLE dbo.Users
(
    UserID INT IDENTITY(1,1) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    Phone VARCHAR(20) NULL,

    CONSTRAINT PK_Users PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Email UNIQUE (Email),
    CONSTRAINT CK_Users_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);
GO

CREATE TABLE dbo.Events
(
    EventID INT IDENTITY(1,1) NOT NULL,
    OrganiserID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    EventType VARCHAR(20) NOT NULL,

    CONSTRAINT PK_Events PRIMARY KEY (EventID),
    CONSTRAINT FK_Events_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES dbo.Users(UserID),
    CONSTRAINT CK_Events_Distance
        CHECK (Distance > 0),
    CONSTRAINT CK_Events_EventType
        CHECK (EventType IN ('Run', 'Walk', 'Cycle'))
);
GO

CREATE TABLE dbo.Categories
(
    CategoryID INT IDENTITY(1,1) NOT NULL,
    EventID INT NOT NULL,
    CategoryName VARCHAR(100) NOT NULL,
    AgeMinimum INT NULL,
    AgeMaximum INT NULL,
    Distance DECIMAL(6,2) NULL,

    CONSTRAINT PK_Categories PRIMARY KEY (CategoryID),
    CONSTRAINT FK_Categories_Event
        FOREIGN KEY (EventID)
        REFERENCES dbo.Events(EventID),
    CONSTRAINT UQ_Categories_Event_Name
        UNIQUE (EventID, CategoryName),
    CONSTRAINT CK_Categories_AgeMinimum
        CHECK (AgeMinimum IS NULL OR AgeMinimum >= 0),
    CONSTRAINT CK_Categories_AgeMaximum
        CHECK (AgeMaximum IS NULL OR AgeMaximum >= 0),
    CONSTRAINT CK_Categories_AgeRange
        CHECK (
            AgeMinimum IS NULL
            OR AgeMaximum IS NULL
            OR AgeMaximum >= AgeMinimum
        ),
    CONSTRAINT CK_Categories_Distance
        CHECK (Distance IS NULL OR Distance > 0)
);
GO

CREATE TABLE dbo.Routes
(
    RouteID INT IDENTITY(1,1) NOT NULL,
    EventID INT NOT NULL,
    RouteName VARCHAR(100) NOT NULL,
    StartLocation VARCHAR(150) NOT NULL,
    FinishLocation VARCHAR(150) NOT NULL,
    Distance DECIMAL(6,2) NOT NULL,
    RouteDescription VARCHAR(500) NULL,

    CONSTRAINT PK_Routes PRIMARY KEY (RouteID),
    CONSTRAINT FK_Routes_Event
        FOREIGN KEY (EventID)
        REFERENCES dbo.Events(EventID),
    CONSTRAINT UQ_Routes_Event
        UNIQUE (EventID),
    CONSTRAINT CK_Routes_Distance
        CHECK (Distance > 0)
);
GO

CREATE TABLE dbo.Enrolments
(
    EnrolmentID INT IDENTITY(1,1) NOT NULL,
    ParticipantID INT NOT NULL,
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,
    EnrolmentDate DATE NOT NULL
        CONSTRAINT DF_Enrolments_EnrolmentDate
        DEFAULT CAST(GETDATE() AS DATE),

    CONSTRAINT PK_Enrolments PRIMARY KEY (EnrolmentID),
    CONSTRAINT FK_Enrolments_Participant
        FOREIGN KEY (ParticipantID)
        REFERENCES dbo.Users(UserID),
    CONSTRAINT FK_Enrolments_Event
        FOREIGN KEY (EventID)
        REFERENCES dbo.Events(EventID),
    CONSTRAINT FK_Enrolments_Category
        FOREIGN KEY (CategoryID)
        REFERENCES dbo.Categories(CategoryID),
    CONSTRAINT UQ_Enrolments_Participant_Event
        UNIQUE (ParticipantID, EventID)
);
GO

CREATE TABLE dbo.Results
(
    ResultID INT IDENTITY(1,1) NOT NULL,
    EnrolmentID INT NOT NULL,
    FinishTime TIME NOT NULL,
    FinishPosition INT NOT NULL,

    CONSTRAINT PK_Results PRIMARY KEY (ResultID),
    CONSTRAINT FK_Results_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES dbo.Enrolments(EnrolmentID),
    CONSTRAINT UQ_Results_Enrolment
        UNIQUE (EnrolmentID),
    CONSTRAINT CK_Results_FinishPosition
        CHECK (FinishPosition > 0)
);
GO

INSERT INTO dbo.Users
(
    FirstName,
    LastName,
    Email,
    PasswordHash,
    Role,
    Phone
)
VALUES
(
    'Thabo',
    'Mokoena',
    'thabo.mokoena@raceday.co.za',
    'HASHED_PASSWORD_001',
    'Organiser',
    '0712345678'
),
(
    'Lerato',
    'Molefe',
    'lerato.molefe@raceday.co.za',
    'HASHED_PASSWORD_002',
    'Organiser',
    '0723456789'
),
(
    'Karabo',
    'Nkosi',
    'karabo.nkosi@example.com',
    'HASHED_PASSWORD_003',
    'Participant',
    '0734567890'
),
(
    'Palesa',
    'Mabena',
    'palesa.mabena@example.com',
    'HASHED_PASSWORD_004',
    'Participant',
    '0745678901'
);
GO

INSERT INTO dbo.Events
(
    OrganiserID,
    Name,
    Description,
    EventDate,
    Location,
    Distance,
    EventType
)
VALUES
(
    1,
    'Polokwane City Run',
    'Annual road running event through Polokwane.',
    '2026-10-10',
    'Polokwane',
    10.00,
    'Run'
),
(
    1,
    'Limpopo Family Walk',
    'Family-friendly walking event for all ages.',
    '2026-10-24',
    'Polokwane',
    5.00,
    'Walk'
),
(
    2,
    'Limpopo Cycle Challenge',
    'Road cycling challenge for beginner and experienced cyclists.',
    '2026-11-07',
    'Polokwane',
    21.00,
    'Cycle'
);
GO

INSERT INTO dbo.Categories
(
    EventID,
    CategoryName,
    AgeMinimum,
    AgeMaximum,
    Distance
)
VALUES
(1, 'Under 20', 0, 19, 5.00),
(1, 'Senior', 20, 39, 10.00),
(1, 'Veteran', 40, 99, 10.00),
(2, 'Junior', 0, 17, 5.00),
(2, 'Adult', 18, 59, 5.00),
(2, 'Senior', 60, 99, 5.00),
(3, 'Junior Cyclist', 14, 17, 21.00),
(3, 'Senior Cyclist', 18, 39, 21.00),
(3, 'Veteran Cyclist', 40, 99, 21.00);
GO

INSERT INTO dbo.Routes
(
    EventID,
    RouteName,
    StartLocation,
    FinishLocation,
    Distance,
    RouteDescription
)
VALUES
(
    1,
    'Polokwane City 10K',
    'Polokwane Civic Centre',
    'Peter Mokaba Stadium',
    10.00,
    'Road route through central Polokwane and surrounding suburbs.'
),
(
    2,
    'Family Walk Route',
    'Polokwane Park',
    'Polokwane Park',
    5.00,
    'Accessible 5 km community walking route.'
),
(
    3,
    'Limpopo Cycle 21K',
    'Polokwane Sports Grounds',
    'Polokwane Sports Grounds',
    21.00,
    'Road cycling loop around Polokwane.'
);
GO

INSERT INTO dbo.Enrolments
(
    ParticipantID,
    EventID,
    CategoryID,
    EnrolmentDate
) 
VALUES
(3, 1, 2, '2026-08-20'),
(4, 1, 2, '2026-08-21'),
(3, 2, 5, '2026-08-21'),
(4, 2, 5, '2026-08-22'),
(3, 3, 8, '2026-08-22'),
(4, 3, 8, '2026-08-23');
GO

INSERT INTO dbo.Results
(
    EnrolmentID,
    FinishTime,
    FinishPosition
)
VALUES
(1, '01:02:35', 8),
(2, '01:08:12', 14);
GO

SELECT * FROM dbo.Users;
SELECT * FROM dbo.Events;
SELECT * FROM dbo.Categories;
SELECT * FROM dbo.Routes;
SELECT * FROM dbo.Enrolments;
SELECT * FROM dbo.Results;
GO
