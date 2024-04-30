--Scalar Valued Functions
create function ScalarFun
(
@var1 int,
@var2 int
)
returns int
as
BEGIN

return @var1*@var2

END

--Table valued functions

create function TableFun
(
@var1 int,
@var2 int
)
returns table
as
--BEGIN - not allowed
	return (select * from Customers)
--END- not allowed


--NOTALLOWED Functions
create function NOTALLOWED
(
@var1 int,
@var2 int
)
returns int
as
BEGIN
--CREATE TABLE #LocalTempTable -- NOT ALLOWED
--INSERT/UPDATE/DELETE from Customers - NOT ALLOWED
--BEGIN TRY - NOT ALLOWED

--END TRY - NOT ALLOWED

--BEGIN TRANSACTION --NOT ALLOWED

--END TRANSACTION -- NOT ALLOWED

return (@var1*@var2)
END
