use assignment_part2_dml;

/*1. select all employees in department 10 whose salary is greater than 3000. [table: employee]*/

select * from employee where salary>3000;

/*2. The grading of students based on the marks they have obtained is done as follows

	40 to 50 -> Second Class
	50 to 60 -> First Class
	60 to 80 -> First Class
	80 to 100 -> Distinctions
    
    a. How many students  have graduated with first class?
    b. How many students  have obtained distinction?  [table: students]*/
    
    select * from students where marks between 50 and 80;
    select * from students where marks between 80 and 100;
     select count(*) from students where marks between 50 and 60;
    select count(*) from students where marks between 80 and 100;
/*
3. Get a list of city names from station with even ID numbers only. Exclude duplicates from your answer.[table: station]*/

SELECT distinct city FROM station WHERE mod(id,2) = 0;

/*4. Find the difference between the total number of city entries in the table and the number of distinct city entries in the table.
 In other words, if N is the number of city entries in station, and N1 is the number of distinct city names in station, 
 write a query to find the value of N-N1 from station.[table: station]
*/
select(select count(city) from station)-(  SELECT count(distinct city) FROM station) as Difference;

/*5. a. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION.
 Your result cannot contain duplicates. [Hint: Use RIGHT() / LEFT() methods ]*/

select distinct city from station 
where
left(city,1) in ('a', 'e', 'i', 'o','u');

/*b. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters.
 Your result cannot contain duplicates. */
 select distinct city from station 
where
right(city,1) in ('a', 'e', 'i', 'o','u') and left(city,1) in ('a', 'e', 'i', 'o','u');
 
   /*c. Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.*/
   select distinct city from station 
where
left(city,1) not in ('a', 'e', 'i', 'o','u');
   
 /*  d. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
 Your result cannot contain duplicates. [table: station]*/

select distinct city from station 
where
right(city,1) not in ('a', 'e', 'i', 'o','u') and left(city,1) not in ('a', 'e', 'i', 'o','u');



/*7. Write a query that prints a list of employee names having a salary greater than $2000 per month 
who have been employed for less than 10 months. Sort your result by ascending emp_id. [table: emp]*/

select * from emp where salary >2000  order by emp_no;


/*8. 12. How much money does the company spend every month on salaries for each department? [table: emp]

Expected Result:

+-------------+--------+
| sum(salary) | deptno |
+-------------+--------+
|    30700.00 |     10 |
|    13600.00 |     20 |
|     2600.00 |     30 |
+-------------+--------+

******(NOTE:-  Here emp table does not have deptno so i am usind employee table)*******/

select sum(salary), deptno from employee group by deptno;


/*
9. How many cities in the CITY table have a Population larger than 100000. [table: city]*/

select * from city where population > 100000;
select count(*) from city where population > 100000;


/*10. What is the total population of California? [table: city]*/

select sum(population) from city where district= 'California';

/*11. What is the average population of the districts in each country? [table: city]

Expected Result:

+-------------+-----------------+
| countrycode | avg(population) |
+-------------+-----------------+
| JPN         |     175839.2000 |
| NLD         |     593321.0000 |
| USA         |     120225.8750 |
+-------------+-----------------+*/

select avg(population), countrycode from city group by countrycode order by countrycode;










/*1. Write a stored procedure that accepts the month and year as inputs and prints the ordernumber, orderdate and status of the orders placed in 
that month. The month should be abbreviated to three characters.
Example: 
   Input: month -> 'Feb'
          year -> 2003
          
   Output:
+------------+---------+
| orderdate  | status  |
+------------+---------+
| 2003-02-11 | Shipped |
| 2003-02-17 | Shipped |
| 2003-02-24 | Shipped |
+------------+---------+*/


Delimiter //
 create procedure order_detail (in month varchar(15),
							    in year int)
 
 begin
 Select ordernumber, orderdate, status from orders where year(orderdate)=year and left(monthname(orderdate),3)=month;
 
 end//
  
 call order_detail('feb',2003);
 
 /*Write a stored procedure to insert a record into the cancellations table for all cancelled orders. 
STEPS: a. Create a table called cancellations with the following fields
id (primary key),  custumernumber (foreign key), ordernumber (foreign key), comments
All values except id should be taken from the order table.*/

create table cancellations(
 id int primary key auto_increment,
 orderNumber int,
 comments text,
 customerNumber int,
 foreign key (ordernumber) references orders(orderNumber),
 foreign key (customernumber) references orders(customerNumber));
 
 /*b. Read through the orders table . If an order is cancelled, then put an entry in the cancellations table.*/
 
 Delimiter //
 CREATE PROCEDURE shipment_cancelled ()
BEGIN
    INSERT INTO cancellations(orderNumber, comments, customerNumber) 
        SELECT orderNumber, comments, customerNumber FROM orders
        WHERE status = 'cancelled';
        END//

        call shipment_cancelled
        
        
     /*3. a. Write function that takes the customernumber as input and returns the purchase_status based on the following criteria . [table:Payments]

if the total purchase amount for the customer is < 25000 status = Silver, amount between 25000 and 50000, status = Gold
if amount > 50000 Platinum   */

DELIMITER $$

CREATE FUNCTION purchase_status(purchase int) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE purchase_status VARCHAR(20);

    IF purchase > 50000 THEN
		SET purchase_status = 'PLATINUM';
    ELSEIF (purchase >= 50000 AND 
			purchase <= 25000) THEN
        SET purchase_status = 'GOLD';
    ELSEIF purchase < 25000 THEN
        SET purchase_status = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (purchase_status);
END$$
DELIMITER $$

SELECT customerNumber, purchase_status(amount) FROM payments;



DELIMITER $$

CREATE PROCEDURE Getpurchase(IN  customerNo INT, OUT purchase_status VARCHAR(20)
)
BEGIN

	DECLARE purchase int DEFAULT 0;
    
    SELECT purchase_status INTO purchase FROM payments WHERE customerNumber = customerNo;
    SET purchase_status = purchase_status(purchase);
END$$
DELIMITER ;

CALL Getpurchase(-131,@purchase_status);
SELECT @purchase_status;

/*4. Write a stored procedure that checks the creditlimit and the purchase status of the customers. 
  If a platinum customer has crediltlimit less than 100,000 raise an exception. In the exception handler update the crediltlimit to 100000.
  If a silver customer has creditlimit greater than 60,000 raise an exception. In the exception handler update the crediltlimit to 60000.*/


delimiter // 
create procedure credit(in credit_limit int)

begin 
 declare creditamout int;
 declare status nvarchar(50);
  if credit_limit<100000 
  then BEGIN
        SET Credit_Limit = 100000;
    END;
    IF Credit_Limit > 60000
   then BEGIN
    	SET Credit_Limit = 60000;
    END;


/*
5. Replicate the functionality of 'on delete cascade' and 'on update cascade' using triggers on movies and rentals tables. 
Note: Both tables - movies and rentals - don't have primary or foreign keys. Use only triggers to implement the above.*/

  DELIMITER //
CREATE TRIGGER categories_update AFTER UPDATE ON movies FOR EACH ROW
BEGIN
    UPDATE rentals  SET rentals.memid=new.id WHERE rentals.memid=old.id;
END //
DELIMITER ;

DELIMITER //
CREATE TRIGGER categories_delete AFTER DELETE ON movies
    FOR EACH ROW 
    BEGIN
        DELETE FROM rentals WHERE rentals.memid = movies.id;
    END//


