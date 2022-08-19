# A. Find the names of aircraft such that all pilots certified to operate them earn more than $80,000.

SELECT aname FROM Aircraft WHERE aid IN
			(SELECT aid FROM certified WHERE eid IN 
            (SELECT eid FROM employees WHERE salary > 80000));

# B. For each pilot who is certified for more than three aircraft, 
#    find the eid and the maximum cruisingrange of the aircraft for which she or he is certified.

SELECT MAX(cruisingrange) AS max_cruiserange, eid
FROM Certified
JOIN Aircraft USING (aid)
GROUP BY eid HAVING COUNT(eid)>3;

# C. Find the names of pilots whose salary is less than the price of the cheapest route from Los Angeles to Honolulu.

  SELECT ename FROM Employees ;
  WHERE salary<(SELECT MIN(price) FROM Flights WHERE from ='Los Angeles' AND to = 'Honolulu');

# D. For all aircraft with cruisingrange over 1000 miles, find the name of the 
#    aircraft and the average salary of all pilots certified for this aircraft.

SELECT aname, AVG(salary) AS Average_salary FROM Certified c
JOIN Aircraft a USING(aid)
JOIN Employees e ON c.eid=e.eid
WHERE cruisinrange > 1000
GROUP BY aname;

# E. Find the names of pilots certified for some Boeing aircraft.

SELECT ename FROM Employees e
JOIN Certified c USING (eid)
JOIN Aircraf a ON a.aid=c.aid
WHERE aname='Boeing';

# F. Find the aids of all aircraft that can be used on routes from Los Angeles to Chicago.

SELECT aid, aname FROM Aircraft 
WHERE cruisingrange >= 
			(SELECT distance FROM Flights WHERE from = 'Los Angeles' AND to = 'Chicago')

# G. Identify the routes that can be piloted by every pilot who makes more than $100,000.

SELECT f.from,f.to
FROM Flights f
WHERE distance <= 
			(SELECT MAX(cruisingrange) FROM Aircrafts
            JOIN Certified c USING (aid)
            JOIN Employees e ON e.eid =c.eid
            WHERE e.salary>100000);
 
# H. Print the enames of pilots who can operate planes with cruisingrange greater
#    than 3000 miles but are not certified on any Boeing aircraft.

SELECT e.ename FROM Employees e
JOIN Certified c USING (eid)
JOIN Aircrafts a ON a.aid = c.aid
WHERE a.cruisingrange>3000 AND a.aname <> Boeing;

# I. A customer wants to travel from Madison to New York with no more than two changes of flight. 
#    List the choice of departure times from Madison if the customer wants to arrive in New York by 6 p.m.

SELECT flno FROM Flights
WHERE from = 'Madison' AND to = 'New York' AND arrives < '18:00:00'

UNION 

SELECT flno FROM Flights f1
JOIN Flights f2 ON f1.departs=f2.arrives
WHERE f1.from='Madison' AND f2.to <> 'New York' AND arrives<'18:00:00'

UNION 

SELECT flno FROM Flights f1
JOIN Flights f2 ON f1.departs=f2.arrives
WHERE f2.from=f1.to 
		AND f2.arrives < f1.departs
        AND f2.to='New York'
        AND f2.from<>'Madison'


# J. Compute the difference between the average salary of a pilot and the average salary of all employees (including pilots).

SELECT AVG(salary) AS avg_pilot_salary, 
		(SELECT AVG(salary) FROM Employees) AS avg_employee_salary,
        ((SELECT AVG(salary) FROM Employees)-AVG(salary)) AS difference
FROM Employees e
JOIN Certified c USING(eid)
WHERE c.eid=e.eid
			

# k. Print the name and salary of every nonpilot whose salary is more than the average salary for pilots.

SELECT ename, salary
FROM Employees
WHERE salary >
		(SELECT AVG(salary) 
        FROM Employees
        WHERE eid IN (SELECT eid FROM Certified));
                            
# L. Print the names of employees who are certified only on aircrafts with cruising range longer than 1000 miles.

SELECT ename FROM Employees
LEFT JOIN Certified c USING (eid)
JOIN Aircrafts a On a.aid = c.aid
WHERE cruisingrange>1000;

# M. Print the names of employees who are certified only on aircrafts with cruising range longer than 1000 miles,
#	 but on at least two such aircrafts.

SELECT ename FROM Employees
LEFT JOIN Certified c USING (eid)
JOIN Aircrafts a On a.aid = c.aid
WHERE cruisingrange>1000
GROUP BY c.eid
HAVING COUNT(eid)>=2;

# N. Print the names of employees who are certified only on aircrafts with cruising 
#	 range longer than 1000 miles and who are certified on some Boeing aircraft.

SELECT ename FROM Employees
LEFT JOIN Certified c USING (eid)
JOIN Aircrafts a On a.aid = c.aid
WHERE cruisingrange>1000 AND aname='Boeing';