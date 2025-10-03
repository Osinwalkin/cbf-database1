CREATE TABLE Students (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    MiddleName TEXT NULL,
    LastName TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    EnrollmentDate TEXT NOT NULL,
    DateOfBirth TEXT NOT NULL
);

CREATE TABLE Instructors (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    Email TEXT NOT NULL UNIQUE,
    HireDate TEXT NOT NULL
);

CREATE TABLE Departments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    Budget REAL NOT NULL,
    StartDate TEXT NOT NULL,
    InstructorId INTEGER,
    FOREIGN KEY (InstructorId) REFERENCES Instructors(Id)
);

CREATE TABLE Courses (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    Title TEXT NOT NULL,
    Credits INTEGER NOT NULL,
    InstructorId INTEGER,
    FOREIGN KEY (InstructorId) REFERENCES Instructors(Id)
);

CREATE TABLE Enrollments (
    Id INTEGER PRIMARY KEY AUTOINCREMENT,
    StudentId INTEGER NOT NULL,
    CourseId INTEGER NOT NULL,
    FinalGrade INTEGER,
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (CourseId) REFERENCES Courses(Id)
);
