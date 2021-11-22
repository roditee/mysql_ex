use sqldb2;

CREATE TABLE publisher(
		pubNo VARCHAR(10) NOT NULL PRIMARY KEY,
        pubName VARCHAR(30) NOT NULL
    );
    
    CREATE TABLE book (
		bookNo VARCHAR(10) NOT NULL PRIMARY KEY,
		bookName VARCHAR(30) NOT NULL,
		bookPrice INT DEFAULT 10000 CHECK(bookPrice > 1000),
		bookDate DATE,
		pubNo VARCHAR(10) NOT NULL,	
        CONSTRAINT FK_book_publisher FOREIGN KEY (pubNo) REFERENCES publisher (pubNo)
	);

-- publisher 테이블에 데이터 입력
-- INSERT INTO 테이블명 (열이름 리스트)  VALUES (값리스트);
insert into publisher values('1', '서울 출판사');
insert into publisher values('2', '강남 출판사');
insert into publisher values('3', '멀티 출판사');

-- publisher 테이블 내용 조회
SELECT * FROM publisher;  

-- book 테이블에 데이터 입력
INSERT INTO book (bookNo, bookName, bookPrice, bookDate, pubNo)
	VALUES('1', '자바', 20000, '2021-05-17', '1');
    
-- 모든 열에 데이터를 입력할 경우 열이름 생략 가능
INSERT INTO book 
	VALUES('2', '자바스크립트', 23000, '2019-05-17', '3');   

-- 여러 개의 데이터를 한 번에 INSERT
INSERT INTO book (bookNo, bookName, bookPrice, bookDate, pubNo)
	VALUES('3', '데이터베이스', 35000, '2021-07-11', '2'),
		  ('4', '알고리즘', 18000, '2021-01-15', '3'),
          ('5', '웹프로그래밍', 22000, '2019-09-15', '2');
    
-- 여러 개의 데이터를 한 번에 INSERT
-- 모든 열에 데이터를 입력할 경우 열이름 생략 가능
INSERT INTO book 
	VALUES('6', '데이터베이스', 35000, '2021-07-11', '2'),
		  ('7', '알고리즘', 18000, '2021-01-15', '3'),
          ('8', '웹프로그래밍', 22000, '2019-09-15', '2');    

-- book 테이블 내용 조회          
SELECT * FROM book;





     -- 학과 테이블 생성
    CREATE TABLE department(
        dptNo VARCHAR(10) NOT NULL PRIMARY KEY,
        dptName VARCHAR(30) NOT NULL,
        dptTel VARCHAR(13)
    );

  -- 학생 테이블 생성 
	CREATE TABLE student (
		stdNo VARCHAR(10) NOT NULL PRIMARY KEY,
		stdName VARCHAR(30) NOT NULL,
		stdYear INT DEFAULT 4 CHECK(stdYear >= 1 AND stdYear <= 4),
        stdAddress VARCHAR(50), 
		stdBirthDay DATE,
		dptNo VARCHAR(10) NOT NULL,
        CONSTRAINT FK_student_department FOREIGN KEY (dptNo) REFERENCES department (dptNo)
	);

insert into department values('1', '컴퓨터학과', '02-1111-1111');
insert into department values('2', '경영학과', '02-2222-2222');
insert into department values('3', '수학과', '02-7777-7777');

insert into student values('2018002', '이몽룡', 4, '서울시 강남구', '1998-05-07', '1');
insert into student values('2019003', '홍길동', 3, '경기도 안양시', '1999-11-11', '2');
insert into student values('2021003', '성춘향', 1, '전라북도 남원시', '2002-01-02', '3');
insert into student values('2021004', '변학도', 1, '서울시 종로구', '2000-11-11', '2');



-- product.csv 파일 임포트해서 product 테이블 생성
DESCRIBE product;
DESC product;

-- 파일 임포트 시 제약조건 없어잠 -> 추가해주어야 함

-- 기본키 추가
-- 기본키 추가 전, text타입을 varchar() 타입으로 변경
-- 변경하지 않으면 text 길이가 없다는 오류 발생
alter table product modify prdNo varchar(10) not null;
-- 기본키 제약조건 추가
alter table product add constraint PK_product_prdNo primary key (prdNo);

alter table product modify prdName varchar(20) not null,
					modify prdMaker varchar(30) not null,
					modify prdColor varchar(10) not null,
					modify ctgNo varchar(10);
                    

select * from product;

-- update
update product set prdName = 'UHD TV' where prdNo='1005';

-- delete
delete from product where prdName='그늘막 텐트';

-- 연습문제
insert into book values('9', 'JAVA 프로그래밍', 30000, '2021-03-10', '1');
insert into book values('10', '파이썬 데이터 과학', 24000, '2018-02-05', '2');
update book set bookPrice=22000 where bookName='자바';
delete from book where bookDate>='2018-01-01' and bookDate<='2018-12-31';


-- 종합 연습문제
create table customer (
	custNo varchar(10) not null primary key,
	custName varchar(30),
    custPhone varchar(13),
    custAddress varchar(50)
);

alter table customer modify custPhone varchar(13) not null;
alter table customer add custSex varchar(2), add custAge int;
insert into customer values('1001', '홍길동', '010-1111-1111', '서울시 강남구', '남', 27),
							('1002', '이순신', '010-2222-2222', '인천광역시 남동구', '남', 32),
                            ('1003', '신사임당', '010-3333-3333', '전북 전주시', '여', 45);
update customer set custPhone='010-1234-2222' where custName='홍길동';
delete from customer where custAge<=20;



use sqldb3;
-- 연습문제
alter table book modify bookNo varchar(10),
				modify bookName varchar(20),
                modify bookAuthor varchar(20),
                modify bookDate DATE,
                modify bookStock varchar(10),
                modify pubNo varchar(10);
                
alter table booksale modify bsNo varchar(10),
					modify bsDate DATE,
					modify bsQty varchar(10),
					modify clientNo varchar(10),
					modify bookNo varchar(10);
                
alter table client modify clientNo varchar(10),
					modify clientName varchar(10),
					modify clientPhone varchar(13),
					modify clientAddress varchar(30),
					modify clientBirth DATE,
                    modify clientHobby varchar(10),
                    modify clientGender varchar(10);

alter table publisher modify pubNo varchar(10),
					modify pubName varchar(20);
                    
alter table book add constraint PK_book primary key (bookNo);
alter table booksale add constraint PK_booksale primary key (bsNo);
alter table client add constraint PK_client primary key (clientNo);
alter table publisher add constraint PK_publisher primary key (pubNo);

alter table book add constraint FK_book foreign key (pubNo) references publisher (pubNo);
alter table booksale add constraint FK_booksale_clientNo foreign key (clientNo) references client (clientNo);
alter table booksale add constraint FK_booksale_bookNo foreign key (bookNo) references book (bookNo);

describe book;
describe booksale;
describe client;
describe publisher;