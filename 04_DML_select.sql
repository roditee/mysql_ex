select * from book;
SELECT bookName, bookPrice FROM book;
SELECT bookAuthor FROM book;

SELECT DISTINCT bookAuthor FROM book;

select bookname, bookAuthor from book where bookAuthor='홍길동';
select bookName, bookPrice, bookStock from book where bookPrice >= 30000;
select bookName, bookStock from book where bookStock >= 3 and bookStock<=5;
select bookName, bookStock from book where bookStock between 3 and 5;
select bookName, bookStock from book where bookStock in (3,4,5);
select bookName, pubNo from book where pubNo in (1,2);

update client set clientHobby=null where clientName='호날두';
update client set clientHobby=null where clientName='샤라포바';
select * from client where clientHobby is null;
select * from client where clientHobby is not null;
select * from client where clientHobby='';

select * from publisher where pubName Like '%출판사%';
select * from client where clientBirth like '199%';
select * from client where clientName like '____';
SELECT bookName FROM book WHERE bookName NOT LIKE '%안드로이드%';


-- 연습문제
select clientName, clientBirth, clientGender from client;
select distinct clientAddress from client;
select clientName, clientHobby from client where clientHobby in ('축구', '등산');
select distinct bookAuthor from book where bookAuthor like '_길%';
select bookName, bookAuthor, bookDate from book where bookDate like '2019%';
select * from booksale where clientNo not in ('1', '2');
select clientName, clientAddress, clientHobby from client where clientHobby is not null and clientAddress='서울';
select bookName, bookAuthor, bookPrice, bookStock from book where bookPrice>=25000 and bookAuthor like '%길동%';
select * from book where bookPrice between 20000 and 25000;
select bookName, bookAuthor from book where bookAuthor not like '%길동%';

