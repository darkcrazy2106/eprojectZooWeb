create database dbpretest4
on primary(name='dbpretest4',filename='E:\data\dbpretest4.mdf', size=8, maxsize= unlimited ,filegrowth=20)
log on (name='dbpretest4_log',filename='E:\data\dbpretest4.ldf', size=8, maxsize= 50 ,filegrowth=10%)
go

use dbpretest4
go

create table tbStudents 
(
	stID varchar(5) Primary Key nonclustered,
	stName varchar(50) Not null,
	stAge tinyint check( stage >=14 and stage<=70),
	stGender bit Default 1
)
go

create table tbProjects
(
	pID Varchar(5) Primary Key nonclustered,
	pName Varchar(50) Not null unique,
	pType Varchar(5) check(pType in('EDU','DEP', 'GOV')),
	pStartDate Date Not null Default getdate()
)
go

create table tbStudentProject
(
	studentID Varchar(5) Not null foreign key references tbstudents,
	projectID Varchar(5) Not null foreign key references tbprojects,
	joinedDate date Not null Default getdate(),
	rate tinyint check( rate>=1 and rate<=5)
)
go

insert tbStudents values
('S01', 'Tom Hanks' ,18, 1),
('S02', 'Phil Collins', 18, 1),
('S03', 'Jennifer Aniston', 19, 0),
('S04', 'Jane Fonda', 20, 0),
('S05' ,'Cristiano Ronaldo', 24, 1)
go

set dateformat dmy
go

insert tbProjects values
('P20' ,'Social Network', 'GOV' ,'12/01/2020'),
('P21', 'React Navtive + NodeJS', 'EDU', '22/08/2019'),
('P22', 'Google Map API', 'DEP', '15/10/2019'),
('P23', 'nCovid Vaccine', 'GOV', '16/05/2020')
go

insert tbStudentProject values
('S01', 'P20', '12/02/2020', 4),
('S01', 'P21', '12/03/2020', 5),
('S02', 'P20', '16/02/2020',3),
('S02', 'P22', '01/09/2020', 5),
('S04','P21' ,'12/04/2020', 4),
('S04', 'P22', '01/10/2020', 3),
('S04', 'P20', '16/10/2020', 3),
('S03', 'P23', '04/07/2020', 5)
go

Create clustered index IX_stnames on tbstudents(stname)
go

Create index IX_pID on tbstudentproject(projectID)
go 

create view vwStudentProject with encryption 
as
select stID,stName,stAge,pName,pStartDate,joinedDate,rate from tbstudents a join tbStudentProject b on a.stID = b.studentID join tbProjects c on b.projectID=c.pID
	where pStartDate <'2020-06-01'
	with check option
go

select * from vwStudentProject
go

create proc upRating 
@name varchar(50) = null, @avgRate float output
as
begin 
	if @name is null 
	begin
		select stID,stName,stAge,pName,pStartDate,joinedDate,rate from tbstudents a join tbStudentProject b on a.stID = b.studentID join tbProjects c on b.projectID=c.pID
		select @avgRate=avg(rate) from tbStudentProject
	end
	else
	begin
	select stID,stName,stAge,pName,pStartDate,joinedDate,rate from tbstudents a join tbStudentProject b on a.stID = b.studentID join tbProjects c on b.projectID=c.pID
	where stName like'%'+@name+'%'
	select @avgRate=avg(rate) from tbStudentProject a join tbStudents b on a.studentID=b.stID
	where b.stName like '%'+@name+'%'
	end
	
end
go


--test case 1
declare @dtb float
exec upRating default, @dtb output
select @dtb 'avg rating'
go

--test case 2
declare @dtb float
exec upRating 'jane', @dtb output
select @dtb 'avg rating'
go

create trigger tgDeletestudent on tbstudents
instead of delete as
delete from tbStudentProject where studentID in(select stID from deleted)
delete from tbStudents where stID in (select stID from deleted)
go

-- test case
select * from tbStudents
go

delete from tbStudents where stName like'tom%'
go

select * from tbStudentProject
go
