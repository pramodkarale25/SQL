SELECT * FROM
(	
SELECT [EmpID],[FirstName],[LastName]
		FROM [EmployeeDetails]
) 
AS [Derived Employee Details]
WHERE [Sales] > 500