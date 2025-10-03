Build started...
Build succeeded.
CREATE TABLE IF NOT EXISTS "__EFMigrationsHistory" (
    "MigrationId" TEXT NOT NULL CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY,
    "ProductVersion" TEXT NOT NULL
);

BEGIN TRANSACTION;
CREATE TABLE "Courses" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Courses" PRIMARY KEY AUTOINCREMENT,
    "Title" TEXT NOT NULL,
    "Credits" INTEGER NOT NULL
);

CREATE TABLE "Enrollments" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Enrollments" PRIMARY KEY AUTOINCREMENT,
    "StudentId" INTEGER NOT NULL,
    "CourseId" INTEGER NOT NULL,
    "Grade" INTEGER NOT NULL
);

CREATE TABLE "Students" (
    "Id" INTEGER NOT NULL CONSTRAINT "PK_Students" PRIMARY KEY AUTOINCREMENT,
    "FirstName" TEXT NOT NULL,
    "LastName" TEXT NOT NULL,
    "Email" TEXT NOT NULL,
    "EnrollmentDate" TEXT NOT NULL
);

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20251002182140_InitialSchema', '9.0.9');

ALTER TABLE "Students" ADD "MiddleName" TEXT NULL;

INSERT INTO "__EFMigrationsHistory" ("MigrationId", "ProductVersion")
VALUES ('20251003133510_AddMiddleNameToStudent', '9.0.9');

COMMIT;


