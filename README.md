# Database Schema Migrations Assignment

Dette er et repository til Database Schema Migrations afleveringen (Obligatorisk).

Jeg har brugt SQLite og DB Browser for SQLite fordi jeg er på linux.

Den demonstrerer to forskellige tilgange til at udvikle et databaseskema for et "Student Management System".
Der er den ændringsbaserede tilgang (Change-based) som bruger Entity Framework Core, og en tilstandsbaseret tilgang (State-based) som gør det ved burg af manuelt håndterede SQL-scripts.

---

## Koncepter og tilgange

Projektet implementerer syv skemaændringer ved hjælp af to metoder. Historikken og arbejdet lavet for hver tilgang er i hver deres egen branch:

*   **`change-based-ef`**: Indeholder historik for change-based
*   **`state-based-manual`**: Indeholder historik for state-based

### 1. Change-Based tilgang (Entity Framework Core)

**Artifacts:** Ligger i Student-Management folderen

Denne tilgang fokuserer på at skabe en række små, trinvise og versionerede migrationsscripts. hvert script repræsenterer en enkelt ændring af databaseskemaet. Til sidst kan vi se at jeg har en komplet historik.


**Workflow:**
1.  oprettede en ny feature branch fra `change-based-ef`.
2.  redigeret c#-modelklasserne i `.NET` projektet.
3.  kørte `dotnet ef migrations add <MigrationName>` for at generere nyt migrationsscript.
4.  kørte `dotnet ef migrations script > <VersionedName.sql>` for at lave det endelige SQL artifact.
5.  comittede ændringerne og mergede featurebranchen tilbage til changed-based-ef branchen

### 2. State-Based tilgang (Manuel SQL)

**Artifacts:** Ligger i projektfolderen

Denne tilgang fokuserer på at vedligeholde et enkelt master SQL-script som altid vil repræsenterer den endelige tilstand af hele databaseskemaet. I stedet for at man sporer ændringerne har vi versioneringer af masterplanen. Det tager meget længere tid ved at bruge denne tilgang, når man vil lave små incrementelle ændringer...

**Workflow:**
1.  oprettede en ny featurebranch fra `state-based-manual`.
2.  kopierede den forrige versions master-script til en ny versioneret fil (e.g., `V2_...`).
3.  redigerede CREATE TABLE definitionerne direkte i den nye fil for at give den ønskede tilstand.
4.  verificerede at scriptet kunne bygge databasen fra bunden ved brug af DB Browser for SQLite
5.  Committede det nye script og mergede branchen.

---

## Destruktive vs. Ikke-Destruktive Ændringer

For en produktionsdatabase er det næsten altid det korrekte valg at bruge en ikke-destruktiv tilgang for at sikre dataintegritet og forhindre tab af data.

### Omdøb `Grade` til `FinalGrade`

*   **Tilgang:** Ikke-Destruktiv.
*   **Begrundelse:** At omdøbe en kolonne skal helst ikke medføre, at data i den går tabt.
    *   I den (EF) tilgangen er Entity Framework intelligent nok til at generere en ikke-destruktiv `ALTER TABLE ... RENAME COLUMN`-command, som bevarer alle eksisterende data.
    *   I den state-based tilgang, ved at definere den endelige tilstand med det nye kolonnenavn indikerer vi en ikke-destruktiv ændring. Et avanceret udrulningsværktøj ville sammenligne tilstanden med den live database og generere et sikkert rename-script.

### Rediger Credits fra Heltal (Integer) til Decimal/Real

*   **Tilgang:** Ikke-Destruktiv.
*   **Begrundelse:** At ændre en kolonnes datatype skal gøres forsigtigt for at undgå datatab.
    *   I dette tilfælde er ændringen fra en `INTEGER` til en `REAL` (decimal) en "widening conversion" (en sikker konvertering). Det er en sikker, ikke-destruktiv operation, fordi enhver heltalsværdi kan konverteres perfekt som et decimaltal (f.eks. bliver `5` til `5.0`). Ingen data burde gå tabt.
    *   Både EF-tilgangen (som genererer en `ALTER COLUMN`-kommando) og den state-based tilgang (som definerer den endelige type) håndterer dette som en sikker ikke-destruktiv ændring.
