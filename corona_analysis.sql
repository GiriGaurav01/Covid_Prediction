-- 1. Find the number of corona patients who faced shortness of breath.

select * from corona_tested.corona_tested_cleaned;

SELECT COUNT(*) 
FROM corona_tested.corona_tested_cleaned
WHERE Corona = 'positive' AND Shortness_of_breath = 'True';

-- 2. Find the number of negative corona patients who have fever and sore_throat. 

select count(*) 
from corona_tested.corona_tested_cleaned 
where corona = 'negative' and fever = 'True' and sore_throat = 'True';

-- 3. Group the data by month and rank the number of positive cases.
SELECT DATE_FORMAT(Test_date, '%m') AS Month, 
COUNT(*) AS Positive_Cases_Rank 
FROM corona_tested.corona_tested_cleaned 
WHERE Corona = 'positive'
GROUP BY Month 
ORDER BY Positive_Cases_Rank DESC;


-- 4. Find the female negative corona patients who faced cough and headache.

SELECT count(*) FROM corona_tested.corona_tested_cleaned
WHERE Corona = 'negative' AND Cough_symptoms = 'True' AND Headache = 'True' AND Sex = 'Female';


-- 5. How many elderly corona patients have faced breathing problems?

SELECT COUNT(*) FROM corona_tested.corona_tested_cleaned 
WHERE Age_60_above = True AND Corona = 'positive' AND Shortness_of_breath = True;

-- 6. Which three symptoms were more common among COVID positive patients?

SELECT 
    symptom, 
    COUNT(*) AS count
FROM 
    (
    SELECT 
        CASE 
            WHEN Fever = 'True' THEN 'Fever'
            WHEN Cough_symptoms = 'True' THEN 'Cough'
            WHEN Sore_throat = 'True'THEN 'Sore throat'
            WHEN Shortness_of_breath = 'True' THEN 'Shortness of breath'
            WHEN Headache = 'True' THEN 'Headache'
            ELSE NULL
        END AS symptom,
        Corona
    FROM 
        corona_tested.corona_tested_cleaned
    WHERE 
        Corona = 'positive'
    ) AS covid_symptoms
WHERE 
    symptom IS NOT NULL
GROUP BY 
    symptom
ORDER BY 
    count DESC
LIMIT 3;


-- 7. Which symptom was less common among COVID negative people?

SELECT 
    symptom, 
    COUNT(*) AS count
FROM 
    (
    SELECT 
        CASE 
            WHEN Fever = 'True' THEN 'Fever'
            WHEN Cough_symptoms = 'True' THEN 'Cough'
            WHEN Sore_throat = 'True' THEN 'Sore throat'
            WHEN Shortness_of_breath = 'True' THEN 'Shortness of breath'
            WHEN Headache = 'True' THEN 'Headache'
            ELSE NULL
        END AS symptom,
        Corona
    FROM 
        corona_tested.corona_tested_cleaned
    WHERE 
        Corona = 'negative'
    ) AS non_covid_symptoms
WHERE 
    symptom IS NOT NULL
GROUP BY 
    symptom
ORDER BY 
    count ASC
LIMIT 1;


-- 8. What are the most common symptoms among COVID positive males whose known contact was abroad? 

SELECT 
    symptom, 
    COUNT(*) AS count
FROM 
    (
    SELECT 
        CASE 
            WHEN Fever = 'True' THEN 'Fever'
            WHEN Cough_symptoms = 'True' THEN 'Cough'
            WHEN Sore_throat = 'True' THEN 'Sore throat'
            WHEN Shortness_of_breath = 'True' THEN 'Shortness of breath'
            WHEN Headache = 'True' THEN 'Headache'
            ELSE NULL
        END AS symptom,
        Corona,
        Sex,
        Known_contact
    FROM 
        corona_tested.corona_tested_cleaned
    WHERE 
        Corona = 'positive'
        AND Sex = 'male'
        AND Known_contact = 'Abroad'
    ) AS covid_symptoms
WHERE 
    symptom IS NOT NULL
GROUP BY 
    symptom
ORDER BY 
    count DESC
LIMIT 3;





















