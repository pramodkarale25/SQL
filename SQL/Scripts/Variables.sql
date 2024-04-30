--Variable
Declare @Var1 int;

--Table Variable are for storing small data - lets say less than 100 rows
--Table Variable
Declare @Employee Table
(
	Empid int primary key identity,--you can only create clustred index on table variable
	EmpName varchar(100) not null,
	PAN varchar(100) unique
);

--You can not alter structure of Table Variable
--alter table @Employee add salary int 
--You can not drop Table Variable
--drop table @Employee

--Temp tables are for storing huge data - lets say more than 100 rows
--Local Temp Table
create table #LocalTemp
(
	Empid int primary key identity,
	EmpName varchar(100) not null,
	PAN varchar(100) unique
	--DepartmentId int foreign key references Department(id) - not allowed
)

alter table #localtemp add salary int 
drop table #localtemp
--Global Temp Table
create table #GlobalTemp
(
	Empid int primary key identity,
	EmpName varchar(100) not null,
	PAN varchar(100) unique
	--DepartmentId int foreign key references Department(id)-- not allowed
)

alter table #GlobalTemp add salary int
drop table #GlobalTemp