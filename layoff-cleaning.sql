/*
============================================================
Script Name  : layoffs-cleaning.sql
Purpose      : This script creates a clean version of the 'layoffs' table for analysis
Actions Performed:
    1. Remove duplicates
    2. Standardize the data
    3. Handling blank and null values
    4. Remove unwanted columns
============================================================
*/

-- Creating a copy of the original table to preserve raw data

CREATE TABLE layoffs_staging
LIKE layoffs
;

INSERT INTO layoffs_staging
SELECT *
FROM layoffs
;
------------------------------------------------------------
-- Identifying Duplicate Rows

WITH duplicate_rows AS (
SELECT *,
ROW_NUMBER()
OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_rows
WHERE row_num > 1
;
------------------------------------------------------------
-- Creating a copy of 'layoffs_staging' table for deleting duplicates

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
;

TRUNCATE TABLE layoffs_staging2
;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER()
OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
;

DELETE
FROM layoffs_staging2
WHERE row_num > 1
;
------------------------------------------------------------
-- Standardizing 'company' column by removing unwanted spaces

SELECT company, TRIM(company)
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET company = TRIM(company)
;
------------------------------------------------------------
-- Standardizing 'industry' column by maintaning a consistent naming

SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1
;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;
------------------------------------------------------------
-- -- Standardizing 'country' column by maintaning a consistent naming

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1
;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%'
;
------------------------------------------------------------
-- Converting the 'date' column from TEXT to DATE format

SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2
;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
;

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE
;
------------------------------------------------------------
-- Replacing NULL values

SELECT industry
FROM layoffs_staging2
WHERE industry = ''
;

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = ''
;

SELECT t1.industry, t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL
;

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL
;
------------------------------------------------------------
-- Removing rows containing unwanted NULL values

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;
------------------------------------------------------------
-- Dropping unwanted 'row_num' column

ALTER TABLE layoffs_staging2
DROP COLUMN row_num
;
------------------------------------------------------------
-- Final Table

SELECT *
FROM layoffs_staging2
;