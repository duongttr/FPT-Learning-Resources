-- EXERCISE 2
-- a
INSERT INTO EMPLOYEE VALUES('Robert', 'F', 'Scott', '943775543', '1972-06-21', '2365
Newcastle Rd, Bellaire, TX', 'M', 58000, '888665555', 1)

-- b
INSERT INTO PROJECT VALUES('ProductA', 4, 'Bellaire', 2)

-- c
INSERT INTO DEPARTMENT VALUES('Production', 4, '943775543', '2007-10-01')

-- d
INSERT INTO WORKS_ON VALUES ('677678989', NULL, 40.0)

-- e
INSERT INTO DEPENDENT VALUES ('453453453', 'John', 'M', '1990-12-12', 'spouse')

-- f
DELETE FROM WORKS_ON WHERE essn = '333445555'

-- g
DELETE FROM EMPLOYEE WHERE ssn = '987654321'

-- h
DELETE FROM PROJECT WHERE pname = 'ProductX'

-- i
UPDATE DEPARTMENT
SET mgrssn = '123456789', mgrstartdate = '2007-10-01'
WHERE  dnumber = 5

-- j
UPDATE EMPLOYEE
SET superssn = '943775543'
WHERE ssn = '999887777'

-- k
UPDATE WORKS_ON
SET hours = 5.0
WHERE essn = '999887777' AND pno = 10