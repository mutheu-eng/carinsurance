SELECT *
FROM carinsurance;

ALTER TABLE carinsurance
DROP COLUMN birth_year; 

ALTER TABLE carinsurance ADD COLUMN birth_year YEAR;

UPDATE carinsurance
SET 
birth_year = YEAR(STR_TO_DATE(birthdate, '%m/%d/%Y'));

ALTER TABLE carinsurance ADD COLUMN age INT;

UPDATE carinsurance
SET
age = 2023 - birth_year;

ALTER TABLE carinsurance
DROP COLUMN birthdate;

SELECT *
FROM carinsurance;

-- How many unique customers does the insurance company have?
SELECT DISTINCT COUNT(ID) AS unique_customers
FROM carinsurance;

-- Age distribution of the customers: we can use a few parameters to measure this
-- mean= 47, mode = 44, range = 53

SELECT ROUND(AVG(age),0) AS average_age
FROM carinsurance;

SELECT age, COUNT(*) AS count_of_age
FROM carinsurance
GROUP BY age
ORDER BY COUNT(*) DESC;

SELECT MAX(age) - MIN(age) as age_range
FROM carinsurance;

-- Customers distribution based on their marital status ,gender and education level
SELECT marital_status,COUNT(ID) AS count
FROM carinsurance
GROUP BY marital_status;

SELECT gender,COUNT(ID) AS count
FROM carinsurance
GROUP BY gender;

SELECT education,COUNT(ID) AS count
FROM carinsurance
GROUP BY education
ORDER BY COUNT(ID) DESC;

-- Common car manufacturers ,models and color
SELECT car_model, COUNT(ID) AS count
FROM carinsurance
GROUP BY car_model
ORDER BY COUNT(ID) DESC
LIMIT 10;

SELECT car_make, COUNT(ID) AS count
FROM carinsurance
GROUP BY car_make
ORDER BY COUNT(ID) DESC
LIMIT 10;

SELECT car_color, COUNT(ID) AS count
FROM carinsurance
GROUP BY car_color
ORDER BY COUNT(ID) DESC
LIMIT 10;

 -- car usage analysis ; private and commercial
SELECT car_use, COUNT(ID) AS count
FROM carinsurance
GROUP BY car_use
ORDER BY COUNT(ID) DESC
LIMIT 10;

 -- Any differences between the claim amount and claim frequency in the car use
 SELECT car_use,
        ROUND(AVG(claim_freq),2) AS avg_claim_freq,
        ROUND(AVG(claim_amt),2) AS avg_claim_amt
FROM carinsurance
GROUP BY car_use;

-- Does car use affect the income household
SELECT car_use,
       ROUND(AVG(household_income),2) AS avg_household_income
FROM carinsurance 
GROUP BY car_use
ORDER BY ROUND(AVG(household_income),2) DESC;

-- HOW DOES COVERAGE ZONE INSURANCE CLAIM ANALYSIS
SELECT coverage_zone,
       COUNT(*) AS count_claimfreq
FROM carinsurance   
GROUP BY coverage_zone
ORDER BY COUNT(*) DESC;

SELECT coverage_zone,
       COUNT(ID) AS count_claimfreq
FROM carinsurance   
GROUP BY coverage_zone
ORDER BY COUNT(ID) DESC;

-- Car characteristics and insurance claims
SELECT  car_make,SUM(claim_freq) AS sum_claim_freq
FROM carinsurance
GROUP BY car_make
ORDER BY SUM(claim_freq) DESC;
   
SELECT  car_make,ROUND(SUM(claim_amt),2) AS sum_claim_amt
FROM carinsurance
GROUP BY car_make
ORDER BY ROUND(SUM(claim_amt),2) DESC;

-- CUSTOMER SEGMENTATION: Ford, Chevrolet, Toyota
SELECT car_make, COUNT(gender) AS count_gender
FROM carinsurance
GROUP BY car_make
ORDER BY COUNT(gender) DESC
LIMIT 5;

SELECT car_model, COUNT(gender) AS count_gender
FROM carinsurance
GROUP BY car_model
ORDER BY COUNT(gender) DESC
LIMIT 5;

-- CAR YEAR AVERAGELY : 2000
SELECT AVG(car_year) AS avg_car_year
FROM carinsurance;

SELECT car_year,COUNT(*) AS num_years
FROM carinsurance
GROUP BY car_year
ORDER BY COUNT(*) DESC;

SELECT car_make,car_year
FROM carinsurance
WHERE car_year > 2006
LIMIT 5;

SELECT car_model,car_year
FROM carinsurance
WHERE car_year > 2006
LIMIT 5;

SELECT car_model, age
FROM carinsurance
WHERE age > 44 
LIMIT 5;

SELECT car_model, age
FROM carinsurance
WHERE age < 44 
LIMIT 5;

SELECT car_use, COUNT(parent) AS num_parents
FROM carinsurance
GROUP BY car_use;