create database employee; 
# q.1

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT AS DEPARTMENT
FROM emp_record_table;

# q.2

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT AS DEPARTMENT, EMP_RATING
FROM emp_record_table
WHERE EMP_RATING < 2 OR EMP_RATING > 4 OR (EMP_RATING >= 2 AND EMP_RATING <= 4);

SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT AS DEPARTMENT, EMP_RATING,
case
when EMP_RATING < 2 then "Poor" 
when EMP_RATING between 2 AND 4 then "Average"
when EMP_RATING > 4 then "Good" 
else "NA"
end as Performance
FROM emp_record_table;
 


# q.3

SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME
FROM emp_record_table
WHERE DEPT = 'Finance';

# q.4

SELECT E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.DEPT AS DEPARTMENT, COUNT(E2.EMP_ID) AS REPORTERS
FROM emp_record_table E1
LEFT JOIN emp_record_table E2 ON E1.EMP_ID = E2.MANAGER_ID
GROUP BY E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.DEPT
HAVING COUNT(E2.EMP_ID) > 0;

# q.5

SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT AS DEPARTMENT
FROM emp_record_table
WHERE DEPT = 'Healthcare'
UNION
SELECT EMP_ID, FIRST_NAME, LAST_NAME, DEPT AS DEPARTMENT
FROM emp_record_table
WHERE DEPT = 'Finance';

# q.6

SELECT E1.DEPT AS DEPARTMENT, E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.ROLE, MAX(E2.EMP_RATING) AS MAX_EMP_RATING
FROM emp_record_table E1
LEFT JOIN emp_record_table E2 ON E1.DEPT = E2.DEPT
GROUP BY E1.DEPT, E1.EMP_ID, E1.FIRST_NAME, E1.LAST_NAME, E1.ROLE;

# q.7

SELECT ROLE, MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM emp_record_table
GROUP BY ROLE;

# q.8

Select FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP,
dense_rank() over (order by EXP desc) as “Ranking”
from emp_record_table;


Select FIRST_NAME, LAST_NAME, ROLE, DEPT, EXP
from emp_record_table;

# q.9
CREATE OR REPLACE VIEW EmployeeSal AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, country, salary
FROM emp_record_table
WHERE salary> 6000;
SELECT * from EmployeeSal;


# q.12

CREATE OR REPLACE VIEW EmployeeRanks AS
SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP,
    CASE
        WHEN EXP <= 2 THEN 'JUNIOR DATA SCIENTIST'
        WHEN EXP <= 5 THEN 'ASSOCIATE DATA SCIENTIST'
        WHEN EXP <= 10 THEN 'SENIOR DATA SCIENTIST'
        WHEN EXP <= 12 THEN 'LEAD DATA SCIENTIST'
        WHEN EXP <= 16 THEN 'MANAGER'
    END AS RANKs
FROM emp_record_table;

# q.13

CREATE INDEX idx_firstname ON emp_record_table (FIRST_NAME);

# q.14

SELECT EMP_ID, FIRST_NAME, LAST_NAME, (0.05 * SALARY * EMP_RATING) AS BONUS
FROM emp_record_table;

# q.15

SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;

# q.16

SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
FROM emp_record_table
WHERE EXP > 10;

# q.17

DELIMITER //
CREATE PROCEDURE GetEmployeesWithExperience()
BEGIN
    SELECT EMP_ID, FIRST_NAME, LAST_NAME, EXP
    FROM emp_record_table
    WHERE EXP > 3;
END//
DELIMITER ;

# q.18

DELIMITER //
CREATE FUNCTION CheckJobProfile(EXP INT) RETURNS VARCHAR(50)
BEGIN
    DECLARE JOB_PROFILE VARCHAR(50);
    
    IF EXP <= 2 THEN
        SET JOB_PROFILE = 'JUNIOR DATA SCIENTIST';
    ELSEIF EXP <= 5 THEN
        SET JOB_PROFILE = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF EXP <= 10 THEN
        SET JOB_PROFILE = 'SENIOR DATA SCIENTIST';
    ELSEIF EXP <= 12 THEN
        SET JOB_PROFILE = 'LEAD DATA SCIENTIST';
    ELSE
        SET JOB_PROFILE = 'MANAGER';
    END IF;
    
    RETURN JOB_PROFILE;
END//
DELIMITER ;

-- Example of using the function
SELECT EMP_ID, FIRST_NAME, LAST_NAME, CheckJobProfile(EXP) AS JOB_PROFILE
FROM data_science_team; 

CREATE INDEX idx_firstname ON emp_record_table (FIRST_NAME(50));

SELECT * FROM emp_record_table WHERE first_name = 'Eric';

SELECT * from idx_firstname where FIRST_NAME = 'Eric';


SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVERAGE_SALARY
FROM emp_record_table
GROUP BY CONTINENT, COUNTRY;

SELECT EMP_ID, FIRST_NAME, LAST_NAME, (0.05 * SALARY * EMP_RATING) AS BONUS
FROM emp_record_table;