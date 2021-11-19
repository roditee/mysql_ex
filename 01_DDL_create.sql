-- 스키마(DB) 생성 및 삭제
-- SCHEMA / DATABASE 동일 표현
CREATE SCHEMA sqldb DEFAULT CHARACTER SET utf8;
CREATE DATABASE sqldb2 DEFAULT CHARACTER SET utf8MB4;

-- 스키마 삭제
DROP SCHEMA sqldb;
DROP DATABASE sqldb2;

CREATE SCHEMA sqldb1 DEFAULT CHARACTER SET utf8;

-- 사용할 데이터베이스 지정
use sqldb1;

-- 테이블 생성
CREATE TABLE product (
	prdNo varchar(10) NOT NULL PRIMARY KEY,
    prdName varchar(30) NOT NULL,
    prdPrice int,
    prdCompany varchar(30)
);

-- 상세 정보 출력
describe product;

-- 기본키 제약 조건 설정 방법 2
CREATE TABLE product2 (
	prdNo varchar(10) NOT NULL,
    prdName varchar(30) NOT NULL,
    prdPrice int,
    prdCompany varchar(30),
	PRIMARY KEY(prdNo)
);

-- 기본키 제약 조건 설정 방법 3
CREATE TABLE product3 (
	prdNo varchar(10) NOT NULL,
    prdName varchar(30) NOT NULL,
    prdPrice int,
    prdCompany varchar(30),
	constraint PK_product_prdNo primary key(prdNo)
);

describe product3;





-- 출판사 테이블과 도서 테이블 생성
create table publisher (
	pubNo varchar(10) not null primary key,
    pubName varchar(30) not null
);

create table book (
	bookNo varchar(10) not null primary key,
    bookName varchar(30) not null,
    bookPrice int default 10000 check(bookPrice>100),
    bookDate DATE,
    pubNo varchar(10) not null,
    foreign key (pubNo) references publisher (pubNo)
);

create table book2 (
	bookNo varchar(10) not null primary key,
    bookName varchar(30) not null,
    bookPrice int default 10000 check(bookPrice>100),
    bookDate DATE,
    pubNo varchar(10) not null,
    constraint FK_book_pubook2blisher foreign key (pubNo) references publisher (pubNo)
);

describe book;




-- 학생 테이블과 학과 테이블 생성
create table department (
	dptNo varchar(10) not null primary key,
	dptName varchar(15) not null,
    dptTel varchar(13)
);

create table student (
	stdId varchar(10) not null primary key,
	stuName varchar(10) not null,
    stuGrade int default 4 check(stuGrade>=1 and stuGrade<=4),
    stdAddress varchar(50),
    stdBirthday DATE,
    dptNo varchar(10) not null,
    CONSTRAINT FK_student_department FOREIGN KEY (dptNo) REFERENCES department(dptNo)
);

-- 교수, 과목, 성적 테이블 생성
create table professor (
	profId varchar(10) not null primary key,
	profName varchar(10) not null,
    profPosition varchar(20),
    profTel varchar(13),
    dptNo varchar(10) not null,
    CONSTRAINT FK_professor_department FOREIGN KEY (dptNo) REFERENCES department(dptNo)
);

create table course (
	courseId varchar(10) not null primary key,
	courseName varchar(10) not null,
    courseCredit int,
    profId varchar(10) not null,
    CONSTRAINT FK_course_professorId foreign key (profId) references professor(profId)
);

create table scores (
	stdId varchar(10) not null,
	courseId varchar(10) not null,
    scScore int,
    scLevel varchar(2),
    CONSTRAINT score_Composite_Key primary key(stdId, courseId), -- 복합키
    CONSTRAINT FK_score_student foreign key (stdId) references student(stdId),
    CONSTRAINT FK_score_course foreign key (courseId) references course(courseId)
);





-- 자동 증가 auto_increment
-- 기본 1부터 1씩 증가
create table board (
	boardNo int auto_increment not null primary key,
	boardTitle varchar(30) not null,
    boardWriter varchar(20),
    boardContent varchar(100) not null
);

-- 초기값 100으로 설정하고 3씩 증가
create table board2 (
	boardNo int auto_increment not null primary key,
	boardTitle varchar(30) not null,
    boardWriter varchar(20),
    boardContent varchar(100) not null
);
alter table board2 auto_increment=100;
set @@auto_increment_increment=3;

-- board2
-- 100부터 시작해서 3씩 증가하는 것을
-- 1부터 1씩 증가하는 것으로 변경
set @count = 0;
update board2 set boardNo = @count:=@count+1;
-- 자바에서 sum+=1과 같은 원리

-- boardNo 2에 해당하는 행 삭제 후 새로운 행 하나 추가 -> 기존의 auto_increment에 의해 106까지 생성되었었기 때문에
-- boardNo가 109부터 생성됨
-- 다시 1부터 시작되도록 해주기 위해서 변수 다시 초기화하여 1부터 1씩 증가하도록 적용
set @count = 0;
update board2 set boardNo = @count:=@count+1;
alter table board2 auto_increment=1;