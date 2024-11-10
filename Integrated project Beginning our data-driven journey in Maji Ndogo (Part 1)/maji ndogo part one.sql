SET 
	SQL_SAFE_UPDATES = 0
;

-- getting to know the data

-- Part 1
-- Fetch first 5 records from the location table
SELECT
	* 
FROM 
	md_water_services.location 
LIMIT
	5
 ;

-- Fetch first 5 records from the visits table
SELECT
	* 
FROM 
	md_water_services.visits 
LIMIT 
	5
;

-- Fetch first 5 records from the water_source table
SELECT 
	* 
FROM 
	md_water_services.water_source 
LIMIT 
	5
;



-- Part 2
-- Dive into the water sources

-- Retrieve unique types of water sources
SELECT DISTINCT
	type_of_water_source
FROM
	md_water_services.water_source
;


-- Part 3
-- Unpack the visits to water sources

-- Retrieve visits where time in queue is greater than 500
SELECT
	*
FROM
	md_water_services.visits
WHERE
	time_in_queue > 500
LIMIT
	5
;

-- type of water sources taking longer
SELECT 
	*
FROM
	md_water_services.water_source
WHERE
	source_id = 'AkKi00881224'
    OR source_id = 'AkLu01628224'
    OR source_id = 'AkRu05234224'
    OR source_id = 'HaRu19601224'
    OR source_id = 'HaZa21742224'
    OR source_id = 'SoRu36096224'
    OR source_id = 'SoRu37635224'
    OR source_id = 'SoRu38776224'
;


-- Part 4
-- Assess the quality of water sources

-- Look through the table record to find the table
SELECT 
	* 
FROM 
	md_water_services.water_quality
LIMIT
	5
;
/* find records where the subject_quality_score is 10 -- only looking for home taps -- and where the source
was visited a second time */
SELECT 
	* 
FROM 
	md_water_services.water_quality
WHERE
	subjective_quality_score=10
AND 
	visit_count=2
;


-- part 5
-- Investigate pollution issues

-- Finding the right table and printing the first few rows
SELECT 
	* 
FROM 
	md_water_services.well_pollution
LIMIT
	5
;

-- checking if results is Clean but the biological column is > 0.01.
SELECT 
	* 
FROM 
	md_water_services.well_pollution
WHERE
	results = 'clean'
AND
	 biological > 0.01
;
-- finding inconsistencies
SELECT 
	*
FROM 
	md_water_services.well_pollution
WHERE
	description LIKE 'clean_%'
;

/* Case 1a: Update descriptions that mistakenly mention
`Clean Bacteria: E. coli` to `Bacteria: E. coli` */
UPDATE
	md_water_services.well_pollution
SET
	description = 'Bacteria: E. coli'
WHERE
	description = 'Clean Bacteria: E. coli'
;

/* Case 1b: Update the descriptions that mistakenly mention
`Clean Bacteria: Giardia Lamblia` to `Bacteria: Giardia Lamblia */
UPDATE
	md_water_services.well_pollution
SET
	description = 'Bacteria: Giardia Lamblia'
WHERE
	description = 'Clean Bacteria: Giardia Lamblia'
;

/* Case 2: Update the `result` to `Contaminated: Biological` where
`biological` is greater than 0.01 plus current results is `Clean` */
UPDATE
	md_water_services.well_pollution
SET
	results = 'Contaminated: Biological'
WHERE
	 biological > 0.01 
AND 
	results = 'Clean'
;