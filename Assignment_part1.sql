use assignment;
/*Create a table called authors with the following columns
authorid , name
- choose appropriate datatypes for the columns
	a) Insert the following data into the table*/
    
creaTE table authors(
authorID int,
name varchar(30));
insert into authors ( authorID, Name) values
        (1, 'J K Rowling'), 
        (2, 'Thomas Hardy'),
		(3, 'Oscar Wilde'),
		(4, 'Sidney Sheldon'),
		(5, 'Alistair Maclean'),
		(6, 'Jane Autsen');
        
/*b) Add a couple of authors of your choice*/
 insert into authors ( authorID, Name) values
 (7, 'Tagore'),
 (8,'Kuvempu'),
 (9,'Allan Poe');
 
/*c) Change 'Alistair Maclean' to 'Alastair McNeal'*/
update authors set name='Alastair McNeal' where authorID=5;
 select * from authors;
 
 
 /*Create a table called Books with the following  columns
bookid, title, authorid
- choose appropriate datatypes for the columns*/

Create table book(
bookid int, title varchar(50), authorid int); 

 /*a) Insert the following records*/
 
 insert into book(bookid, title, authorid) values
 (1,'Harry Potter and the Philosophers Stone',1),
		(2,'Harry Potter and the Chamber of Secrets',1),
		(3,'Harry Potter and the Half-Blood Prince',1),
		(4,'Harry Potter and the Goblet of Fire',1),
		(5,'Night Without End',5),
		(6,'Fear is the Key',5),
		(7,'Where Eagles Dare',5),
		(8,'Sense and Sensibility',6),
		(9,'Pride and Prejudice',6),
		(10,'Emma',6),
		(11,'Random Book',22);
 select * from book;
 
  /*b) Delete 'Random Book' from the table.*/
  delete from book where title= 'random book';
  
  
 /*5. Rename the table Books to Favbooks and Authors to Favauthors.*/
 ALTER TABLE book RENAME TO Favbooks;
 ALTER TABLE authors RENAME TO Favauthors; 
  
/*Create the following tables*/

   create table Suppliers(
		supplier_id int,
		supplier_name varchar(50),
		location varchar(50),
        primary key (supplier_id));
        ALTER TABLE suppliers AUTO_INCREMENT=100;
  
  create table products(
		product_id int,
		product_name varchar(50) Not null unique,
		description varchar(50),
		supplier_id int,
        primary key(product_id),
        foreign key (supplier_id) references suppliers (supplier_id));
        ALTER TABLE products AUTO_INCREMENT=100;
        
  create table Stock(
		id int,
		product_id int,
		balance_stock int,
        foreign key (product_id) references products(product_ID));
        ALTER TABLE Stock
        ADD PRIMARY KEY (id);
        ALTER TABLE stock AUTO_INCREMENT=100;
        
     /*7. Enter some records into the three tables.*/   
        
    insert into suppliers(supplier_id, supplier_name, location) values( 100,'varun', 'mumbai');
     insert into suppliers(supplier_id, supplier_name, location) values(101,'arjun', 'Andhra');    
     insert into suppliers(supplier_id, supplier_name, location) values(103,'sanjay', 'Tamilnadu');
     
     insert into products(product_id, product_name, description ,supplier_id) values(
     001,'falula','chatfood',100),(002,'Fish','Seafood',101),(003,'friedchicken','homeFood',103);
        
      insert into stock(id,product_id,balance_stock) values(
      501,001,1001),(502,002,23000),(503,003,59000);
      
      
      /*8. Modify the supplier table to make supplier name unique and not null.*/
      ALTER TABLE suppliers MODIFY supplier_name varchar(50) NOT NULL;
      alter table suppliers add unique(supplier_name);
      
      /*9. Modify the emp table as follows
  	a. Add a column called deptno*/
    
    ALTER TABLE emp ADD deptno int;
      
    /*  b. Set the value of deptno in the following order
  	       deptno = 20 where emp_id is divisible by 2
  	       deptno = 30 where emp_id is divisible by 3
  	       deptno = 40 where emp_id is divisible by 4
  	       deptno = 50 where emp_id is divisible by 5
  	       deptno = 10 for the remaining records.*/
           
		update emp set deptno=10 where deptno = null;
        update emp set deptno= 20 where emp_no%2=0;
        update emp set deptno= 30 where emp_no%3=0;       
        update emp set deptno= 40 where emp_no%4=0;
        update emp set deptno= 50 where emp_no%5=0;
      
        
        /*10. Create a unique, hash index on the emp_id column. */
        
        CREATE  UNIQUE INDEX newautid ON newauthor(aut_id);