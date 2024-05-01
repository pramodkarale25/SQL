--SIMPLE DYNAMIC SQL QUERY
Declare @sqlQry varchar(4000)
SET @sqlQry='Select empid,empname,age,salary,dob from tblEmployee'
EXEC(@sqlQry)

--Dynamic SQL Using Table Name as Dynamic
Declare @sqlQry varchar(4000)
Declare @tblName varchar(20)='tblEmployee'
SET @sqlQry='Select empid,empname,age,salary,dob from '+ @tblName
EXEC(@sqlQry)

--Dynamic SQL Using Column Name as Dynamic
Declare @sqlQry varchar(4000)
Declare @tblcol varchar(50)='empid,empname,age,salary,dob'
SET @sqlQry='Select '+ @tblcol +' from tblEmployee '
EXEC(@sqlQry)

--Dynamic SQL Using Table Using Filters
Declare @sqlQry varchar(4000)
Declare @age int=0  Declare @Salary decimal=0.0
Declare @designation varchar(50)=null
BEGIN
	SET @sqlQry='Select empid,empname,age,salary,dob,designation from tblEmployee where 1=1'
	IF @designation is not null
	BEGIN
		SET @sqlQry=@sqlQry+' AND designation ='''+@designation+''''
	END
	IF @age <> 0
	BEGIN
		SET @sqlQry=@sqlQry+' AND age ='+Convert(Varchar(2),@age)
	END
	IF @Salary <> 0.0
	BEGIN
		SET @sqlQry=@sqlQry+' AND Salary ='+Convert(Varchar(6),@Salary)
	END
END
EXEC(@sqlQry)

--EXEC vs sp_Executesql
DECLARE @SQL NVARCHAR(MAX)
DECLARE @ParameterDef NVARCHAR(500)

SET @ParameterDef ='@ProductID NVARCHAR(50),
					@Name NVARCHAR(100),
					@ProductNumber NVARCHAR(100),
					@Color NVARCHAR(100)'


EXEC sp_Executesql @SQL, @ParameterDef, @ProductID=@ProductID,@Name=@Name,@ProductNumber=@ProductNumber,@Color=@Color