-- open db db2010_DM
use db2010_DM
go

select * from tbModule
go

-- tao bang khoa hoc
create table tbCourse
(
	course_id int identity primary key,
	course_name varchar(50) not null,
	course_year smallint
)
go

-- them rang buoc kiem tra (check constraint) cho cot course_year: course_year<=nam hien tai va >=1990

alter table tbCourse
	add constraint ckYear 
	    check (course_year between 1990 and year(getdate()))
go
select * from tbCourse

 
-- tao bang sinh vien
create table tbStudent
(
	st_id varchar(5) primary key,
	st_name varchar(30) not null,
	gender bit not null default 1,
	phone int
)
go

-- tao bang lop hoc
create table tbBatch
(
	batch_no varchar(10),
	startdate date,
	course_id int foreign key references tbCourse(course_id)
)
go
alter table tbBatch
	alter column batch_no varchar(10) not null
go
alter table tbBatch
	add constraint PKBatch primary key(batch_no) 
go



/* sua lai cau truc bang lop hoc :
	them thuoc tinh not null va lap gia tri default cho cot startdate
*/
alter table tbBatch
	alter column startdate date not null

alter table tbBatch
	add constraint dfDate default getdate() for startdate
go


-- nhap du lieu cho bang khoa hoc
insert tbCourse(course_name, course_year) values ('ACCP 11', 2011);
select * from tbCourse
go

insert tbCourse values 
('ACCP 17',2017), ('6715', 2019), ('6800', 2021)
select * from tbCourse
go

-- linh nay se bao loi vi nam > 2021
insert tbCourse(course_name, course_year) values ('8700', 2022);
select * from tbCourse
go

-- tao bang lien he
create table tbContact (
	id uniqueidentifier not null default newid(),
	contact varchar(40) not null,
	st_id varchar(5) not null foreign key references tbStudent(st_id)
)
go


select * from tbCourse
go

select * from tbBatch
go

-- lenh set lai cach nhap so lieu kieu date (ngay-thang-nam)
set dateformat dmy
insert tbBatch values
('2010-E0', '09-10-2020',3 ),
('2008-A0', '15-08-2020',3),
('2001-E0', '24-02-2020',2),
('2012-M0', '17-01-2021',3)
go
select * from tbBatch
go


select * from tbStudent
go

-- bo cot phone trong bang sinh vien
alter table tbStudent
	drop column phone
go
select * from tbStudent
go



-- them cac cot ngay sinh, dia chi, lop hoc cho bang sinh vien
alter table tbStudent
	add dob date check (datediff(yy, dob, getdate()) between 12 and 80)

alter table tbStudent
	add [address] varchar(30)

alter table tbStudent
	add [batch] varchar(10) foreign key references tbBatch
go	 


select * from tbBatch
select * from tbStudent
go

-- nhap du lieu cho bang sinh vien
set dateformat dmy
insert tbStudent values
('S01','Nguyen Anh Duc', 1,'Hai Phong', '2010-E0', '19-01-2000')
go

insert tbStudent values
('S02','Le Hoang Quan', 1,'Dong Nai', '2010-E0', '22-01-1995'),
('S03','Nguyen Vo Minh Tuan', 1,'Bao Loc', '2010-E0', '30-04-1975'),
('S04','Pham thi Thanh Phuong', 0,'Saigon', '2010-E0', '25-12-1995'),
('S05','Nguyen Duc Trong', 1,'Duc Trong', '2010-E0', '25-12-1996'),
('S06','Tran Manh Hung', 1,'Saigon', '2010-E0', '10-08-1998'),
('S07','Dinh Thanh Bao Nam', 1,'Bao Loc', '2010-E0', '10-08-1999'),
('S08','Tran Tinh', 1,'Nam Dinh', '2010-E0', '15-08-2000'),
('S09','Duong Dinh Phuc', 1,'Saigon', '2010-E0', '23-10-2002'),
('S10','Ly Vinh Phu', 1,'Saigon', '2010-E0', '23-10-1998'),
('S11','Ly Quoc Cuong', 1,'Saigon', '2010-E0', '23-10-2000'),
('S12','Pham Khoi Minh Huan', 1,'Bao Loc', '2008-A0', '05-03-2000'),
('S13','Cao Nguyen Phien', 1,'Long An', '2008-A0', '06-06-1996'),
('S14','Pham Hung Lam', 1,'Saigon', '2008-A0', '09-09-1999'),
('S15','Nguyen Vo Hoang Khanh', 1,'Saigon', '2010-E0', '02-02-2002'),
('S16','Nguyen Dinh Gia Binh', 1,'Bac Ninh', '2010-E0', '06-09-1999')
go

select * from tbStudent
go

