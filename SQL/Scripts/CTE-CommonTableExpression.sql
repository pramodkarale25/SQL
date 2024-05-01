with CTEEmployee(EmpId, EmpName, DeptId, ManagerId)
as
(
	select * from Employee
)

select * 
from CTEEmployee emp
inner join 