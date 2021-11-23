use sqldb3;

-- 테이블 복사 (1)
-- 속성과 값들은 복사되지만, 제약조건은 복사 안 됨
-- 복사 후 제약조건 설정 필요
create table new_book1 as select * from book;
-- 기본키 제약조건 추가
alter table new_book1 add constraint PK_new_book1_bookNo primary key (bookNo);
desc new_book2;



-- 테아블 복사 (2) - 새 테이블로 일부만 복사
create table new_book2 as select * from book where bookDate like '2020%';
-- 기본키 제약조건 추가
alter table new_book2 add constraint PK_new_book2_bookNo primary key (bookNo);
desc new_book2;



-- (3) 기존 테이블로 데이터만 복사
-- 테이블 구조가 동일한 경우에만 가능
-- new_book2 테이블의 전체 데이터 삭제
delete from new_book2;
-- new_book2 테이블에 book 테이블의 데이터 복사
insert into new_book2 select * from book;


-- (4) 다른 데이터베이스의 테이블로부터 데이터 복사
-- 새 테이블로 일부 복사
create table product2 as select * from sqldb2.product where prdPrice>=1000000;
-- 기본키 제약조건 추가
alter table product2 add constraint PK_product2_prdNo primary key (prdNo);
desc product2;