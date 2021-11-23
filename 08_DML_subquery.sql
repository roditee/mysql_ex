-- 단일 행 서브쿼리
-- 고객 호날두의 주문수량 조회
select bsDate, bsQty from booksale
where clientNo = (select clientNo from client where clientName='호날두');

-- 호날두가 주문한 총 주문수량 출력
select SUM(bsQty) as 총주문수량 from booksale
where clientNo = (select clientNo from client where clientName='호날두')
group by clientNo;

-- 가장 비싼 도서의 도서명과 가격 출력
select bookName, bookPrice from book where bookprice = (select MAX(bookPrice) from book);

-- 도서의 평균 가격보다 비싼 도서의 도서명, 가격 출력
select bookName, bookPrice from book where bookPrice > (select AVG(bookPrice) from book);




-- 다중 행 서브쿼리 (in, not in)

-- 도서를 구매한 적이 있는 고객의 고객명 출력
select C.clientName from client C
where C.clientNo in (select BS.clientNo from booksale BS);

-- 한 번도 주문한 적이 없는 고괙의 고객번호, 고객명 출력
select C.clientNo, C.clientName from client C where C.clientNo not in (select BS.clientNo from booksale BS);

-- 도서명이 '안드로이드 프로그래밍'인 도서를 구매한 고객의 고객명 출력
select clientName from client
where clientNo in (select clientNo from booksale
					where bookNo = (select bookNo from book where bookName='안드로이드 프로그래밍'));

-- 도서명이 '안드로이드 프로그래밍'인 도서를 구매한 고객의 고객명을 고객명 기준으로 출력
select clientName from client
where clientNo in (select clientNo from booksale
					where bookNo = (select bookNo from book where bookName='안드로이드 프로그래밍'))
order by clientName;


-- 다중 행 서브쿼리 (exists, not exists)
-- EXISTS : 서브 쿼리의 결과가 행을 반환하면 참이 되는 연산자
-- 도서를 구매한 적이 있는 고객
-- 1. bookSale에 조건에 해당되는 행이 존재하면 참 반환
-- 2. client 테이블에서 이 clientNo에 해당되는 고객의
-- 고객번호, 고객명 출력
SELECT clientNo, clientName
FROM client
WHERE EXISTS (SELECT clientNo
			  FROM bookSale
			  WHERE client.clientNo = bookSale.clientNo);

-- NOT EXISTS
-- 한 번도 주문적이 없는 고객의 고객번호, 고객명 출력
-- 서브 쿼리에 조건에 해당되는 행이 없으면 TRUE 반환
SELECT clientNo, clientName
FROM client
WHERE NOT EXISTS (SELECT clientNo
			     FROM bookSale
			     WHERE client.clientNo = bookSale.clientNo);


-- NULL인 경우 IN과 EXISTS 차이
-- clientHobby에 null 값 포함
 SELECT clientHobby FROM client;
 -- null 2개

-- EXISTS : 서브 쿼리 결과에 NULL 값 포함
-- NULL 값 포함하여 모든 clientNo 출력
SELECT clientHobby
FROM client
WHERE EXISTS (SELECT clientHobby
			  FROM client);
-- NULL과 공백 다 출력 : 9개


-- IN : 서브 쿼리 결과에 NULL 값 포함되지 않음
-- NULL 값을 갖지 않는 clientHobby만 출력
SELECT clientHobby
FROM client
WHERE clientHobby IN (SELECT clientHobby
			          FROM client);
-- NULL 제외, 공백 포함해서 7개



-- all / any


-- 2번 고괙이 주문한 모든 수량보다 큰 경우
select clientNo, bsNo, bsQty from booksale where bsQty > ALL (select bsQty from booksale where clientNo='2');

-- 2번 고객보다 한 번이라도 더 많은 주문을 한 적이 있는 고객 (최소한 한 번이라도 크면 됨)
select clientNo, bsNo, bsQty from booksale where bsQty > ANY (select bsQty from booksale where clientNo='2');
-- 2번 고객 자신도 포함된 결과 도출됨

-- 2번 고객 자신을 포함하지 않도록 하기
select clientNo, bsNo, bsQty from booksale
where bsQty > ANY (select bsQty from booksale where clientNo='2')
	and clientNo!='2';
    
    

-- 연습문제
-- 1. 호날두(고객명)가 주문한 도서의 총 구매량 출력
select sum(BS.bsQty) from booksale BS where BS.clientNo=(select C.clientNo from client C where C.clientName='호날두');

-- 2. ‘종로출판사’에서 출간한 도서를 구매한 적이 있는 고객명 출력
select C.clientName from client C 
where C.clientNo = (select BS.clientNo from booksale BS
					where BS.bookNo in (select B.bookNo from book B
										where B.pubNo in (select P.pubNo from publisher P
															where P.pubName='종로출판사')));
                                                            
-- 3. 베컴이 주문한 도서의 최고 주문수량보다 더 많은 도서를 구매한 고객명 출력
SELECT clientName FROM client
WHERE  clientNo IN (SELECT clientNo FROM bookSale
					WHERE  bsQty > ALL (SELECT bsQty FROM bookSale
										WHERE  clientNo IN (SELECT clientNo FROM client
															WHERE clientName = '베컴')));	

SELECT clientName FROM client
WHERE  clientNo IN (SELECT clientNo FROM bookSale
					WHERE  bsQty > ALL (SELECT bsQty FROM bookSale
										WHERE  clientNo = (SELECT clientNoFROM client
														   WHERE  clientName = '베컴')));
                                                                    
select clientName from client
where clientNo in (select clientNo from booksale
					where bsQty > (select MAX(bsQty) from booksale
									where clientNo in (select clientNo from client
														where clientName='베컴')));
                                                        
select C.clientName from client C where C.clientNo in (select BS.clientNo from booksale BS where bsQty > (select MAX(bsQty) from booksale BS where BS.clientNo in (select C.clientNo from client C where clientName='베컴')));
-- 4. 서울에 거주하는 고객에게 판매한 도서의 총 판매량 출력
select SUM(bsQty) from booksale BS where BS.clientNo in (select C.clientNo from client C where clientAddress='서울');




-- 스칼라 서브 쿼리
-- 고객별로 고객번호, 고객명, 총 주문수량 출력
select clientNo, (select clientName from client where client.clientNo = booksale.clientNo), sum(bsQty) from booksale group by clientNo;

-- 인라인 뷰 서브 쿼리
-- 도서 가격이 25000원 이상인 도서에 대하여
-- 도서별로 도서명, 도서가격, 총 판매 수량, 총 판매액 출력
-- 총 판매액으로 내림차순 설정
select bookName, bookPrice, sum(bsQty) as 총판매량, sum(bookPrice*bsQty) as 총판매액
from (select bookNo, bookName, bookPrice from book where bookPrice >= 25000) book, booksale
where book.bookNo = booksale.bookNo
group by book.bookNo
order by 총판매량 DESC;

