show columns
from records;

-- RENAMING COLUMN NAMES:

alter table records
rename column
`Event.Id` to Event_Id;
alter table records
rename column `Investigation.Type` to Investigation_type,
rename column `Accident.Number` to Accident_Number,
rename column `Event.Date` to Event_Date,
rename column `Airport.Code` to Airport_code,
rename column `Airport.Name` to Airport_Name,
rename column `Injury.Severity` to Injury_Severity,
rename column `Aircraft.damage` to Aircraft_damage,
rename column `Aircraft.Category` to Aircraft_Category,
rename column `Registration.Number` to Registration_Number,
rename column `Amateur.Built` to Amateur_Built,
rename column `Number.of.Engines` to Number_of_Engines,
rename column `Engine.Type` to Engine_Type,
rename column `FAR.Description` to FAR_Description,
rename column `Purpose.of.flight` to Purpose_of_flight,
rename column `Air.carrier` to Air_carrier,
rename column `Total.Fatal.Injuries` to Total_Fatal_Injuries,
rename column `Total.Serious.Injuries` to Total_Serious_Injuries,
rename column `Total.Minor.Injuries` to Total_Minor_Injuries,
rename column `Total.Uninjured` to Total_Uninjured,
rename column `Weather.Condition` to Weather_Condition,
rename column `Broad.phase.of.flight` to Phase_of_flight,
rename column `Report.Status` to Report_Status,
rename column `Publication.Date` to Publication_Date;

show columns
from records;

select *
from records;

-- CHANGING BLANKS TO NULL:

update records
set latitude = nullif(trim(latitude), '');
update records
set event_id = nullif(trim(event_id), ''),
investigation_type = nullif(trim(investigation_type), ''),
accident_number = nullif(trim(accident_number), ''),
event_date = nullif(trim(event_date), ''),
location = nullif(trim(location), ''),
country = nullif(trim(country), ''),
longitude = nullif(trim(longitude), ''),
airport_code = nullif(trim(airport_code), ''),
airport_name = nullif(trim(airport_name), ''),
Injury_severity = nullif(trim(Injury_severity), ''),
aircraft_damage = nullif(trim(aircraft_damage), ''),
aircraft_category = nullif(trim(aircraft_category), ''),
Registration_Number = nullif(trim(Registration_Number), ''),
Make = nullif(trim(Make), ''),
Model = nullif(trim(Model), ''),
Amateur_Built = nullif(trim(Amateur_Built), ''),
Number_of_Engines = nullif(trim(Number_of_Engines), ''),
Engine_Type = nullif(trim(Engine_Type), ''),
FAR_Description = nullif(trim(FAR_Description), ''),
`Schedule` = nullif(trim(`Schedule`), ''),
Purpose_of_flight = nullif(trim(Purpose_of_flight), ''),
Air_carrier = nullif(trim(Air_carrier), ''),
Total_fatal_injuries = nullif(trim(Total_fatal_injuries), ''),
Total_serious_injuries = nullif(trim(Total_serious_injuries), ''),
Total_minor_injuries = nullif(trim(Total_minor_injuries), ''),
Total_Uninjured = nullif(trim(Total_Uninjured), ''),
Weather_Condition = nullif(trim(Weather_Condition), ''),
Phase_of_flight = nullif(trim(Phase_of_flight), ''),
Report_Status = nullif(trim(Report_Status), ''),
Publication_Date = nullif(trim(Publication_Date), '');

select *
from records;

-- MAKING FIGURES UNIFORM:

update records
set Number_of_Engines = null
where Number_of_Engines = 0;
update records
set total_fatal_injuries = null
where total_fatal_injuries = 0;
update records
set total_serious_injuries = null
where total_serious_injuries = 0;
update records
set total_minor_injuries = null
where total_minor_injuries = 0;
update records
set total_uninjured = null
where total_uninjured = 0;

select *
from records;

-- FORMATTING DATE COLUMNS; first setting dates to a common format, then converting it to a date data type
update records
set event_date = replace(event_date, '/', '-');
update records
set event_date = str_to_date(event_date, '%m-%d-%Y');
alter table records
modify event_date DATE;

update records
set publication_date = replace(publication_date, '/', '-');
update records
set publication_date = str_to_date(publication_date, '%d-%m-%Y');
alter table records
modify Publication_Date DATE;

-- SETTING THE APPROPRIATE DATA TYPE FOR CERTAIN COLUMNS

alter table records
modify Number_of_Engines INT;
alter table records
modify Total_Fatal_Injuries INT,
modify Total_Serious_Injuries INT,
modify Total_Minor_Injuries INT,
modify Total_Uninjured INT;

show columns
from records;

select *
from records;

-- USING SUBSTRING TO  CUT OUT THE LOCATION IN THE UNITED KINGDOM:

select substring_index(location, ',', 1)
from records;
update records
set location = upper(substring_index(location, ',', 1));

-- CHECKING FOR DUPLICATES WITH ROW_NUMBER() AND A CTE:

with duplicates as (
select *, 
		row_number() over(partition by Event_id, Accident_Number order by event_date) as row_num
from records)
select *
from duplicates
where row_num > 1;

select *
from records;

-- CREATING A VIEW FROM OUR TABLE OF DATA:

create view crash_records as
select Investigation_type, Accident_Number, event_date, location, Airport_Name, Aircraft_damage, Aircraft_Category, Make, Model, Number_of_Engines,
		Engine_type, total_fatal_injuries, total_serious_injuries, total_minor_injuries, total_uninjured, publication_date
from records;

select *
from crash_records;