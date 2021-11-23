use sqldb3;

-- 다양한 조인 문 표기 형식

-- (1) WHERE 조건 사용
SELECT client.clientNo, clientName, bsQty FROM client, bookSale
WHERE client.clientNo = bookSale.clientNo;
-- 양쪽 테이블에 공통되는 열 이름 앞에 테이블명 표기 : 모호성을 없애기 위해


-- (2) 양쪽 테이블에 공통되지 않지만 모든 열 이름에 테이블명 붙임
-- 서버에서 찾고자 하는 열의 정확한 위치를 알려주므로 성능이 향상
SELECT client.clientNo, client.clientName, bookSale.bsQty FROM client, bookSale
WHERE client.clientNo = bookSale.clientNo;

-- (3) 테이블명 대신 별칭(Alias) 사용
SELECT C.clientNo, C.clientName, BS.bsQty FROM client C, bookSale BS
WHERE C.clientNo = BS.clientNo;

-- (4) JOIN ON 명시
SELECT C.clientNo, C.clientName, BS.bsQty
FROM bookSale BS JOIN client C ON C.clientNo = BS.clientNo;
    
-- (5) INNER JOIN ON 명시
-- 가장 많이 사용되는 방법으로 우리는 이 방법 사용
SELECT C.clientNo, C.clientName, BS.bsQty
FROM bookSale BS INNER JOIN client C ON C.clientNo = BS.clientNo;


   
-- client 테이블과 bookSale 테이블 조인
-- clientNo 기준 : client (모든 고객) > bookSale (주문한 고객)
-- 두 테이블에 공통으로 들어 있는 값(clientNo)의 의미
-- 한 번이라도 도서를 주문한 적이 있는 고객
-- 출력 열 선택 안 하면 2개 테이블의 모든 열 표시
-- 공통되는 clientNo 열이 중복되서 출력
SELECT * FROM client INNER JOIN booksale ON client.clientNo = bookSale.clientNo;

-- 필요한 열만 추출
-- 테이블명 대신 별칭(Alias) 사용
-- 한 번이라도 도서를 주문한 적이 있는 고객의 고객번호와 고객명 출력
SELECT C.clientNo, C.clientName FROM client C INNER JOIN bookSale BS ON C.clientNo = BS.clientNo;

-- 한 번이라도 도서를 주문한 적이 있는 고객의 고객번호와 고객명 출력
-- 중복되는 행은 한 번만 출력
-- 고객번호 오름차순/내림차순 정렬
SELECT DISTINCT C.clientNo, C.clientName
FROM client C INNER JOIN bookSale BS ON C.clientNo = BS.clientNo
ORDER BY C.clientNo DESC;


-- 3개 테이블 결합
-- 테이블 3개 / 조인 조건 2개
-- 주문된 도서에 대하여 고객명과 도서명 출력
-- 주문된 도서 : bookSale 테이블 필요
-- 고객명 : client 테이블 필요
-- 도서명 : book 테이블 필요
SELECT C.clientName, B.bookName
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo;

-- 3개 테이블 결합
-- 테이블 3개 / 조인 조건 2개
-- 주문된 도서에 대하여 고객명과 도서명 출력
-- 주문된 도서 : bookSale 테이블 필요
-- 고객명 : client 테이블 필요
-- 도서명 : book 테이블 필요
SELECT C.clientName, B.bookName
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo;

-- 도서를 주문한 고객의 고객 정보, 주문 정보, 도서 정보 출력
-- 주문번호, 주문일, 고객번호, 고객명, 도서명, 주문수량
SELECT BS.bsNo, BS.bsDate, C.clientNo,  C.clientName, B.bookName, BS.bsQty
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo;
-- 기본 : bsNo로 오름차순 정렬

-- 최근 주문이 먼저 출력되도록 날짜 기준 정렬
SELECT BS.bsNo, BS.bsDate, C.clientNo,  C.clientName, B.bookName, BS.bsQty
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo
ORDER BY BS.bsDate DESC;

-- 고객별로 총 주문 수량 계산하여
-- 고객번호, 고객명, 총 주문수량 출력
-- 총 주문 수량 기준 내림차순 정렬
SELECT C.clientNo, C.clientName, SUM(bsQty) AS 총주문수량
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
GROUP BY C.clientNo
ORDER BY 총주문수량 DESC;
-- 고객별로 : GROUP BY
-- 고객번호 : client 테이블 필요
-- 총 주문수량 : bookSale 테이블 필요
-- 2개 테이블 사용 --> 조인 (공통된 값 존재하므로 INNER JOIN)
-- 내림차순 정렬 : ORDER BY 

-- 고객번호 출력하지 않고 고객명만 출력 가능
SELECT C.clientName, SUM(bsQty) AS 총주문수량
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
GROUP BY C.clientNo
ORDER BY 총주문수량 DESC;


-- 주문일, 고객명, 도서명, 도서 가격, 주문수량, 주문액 계산하여 출력
-- 주문일 오름차순 정렬
SELECT BS.bsDate, C.clientName, B.bookName, B.bookPrice, BS.bsQty,
	   B.bookPrice * BS.bsQty AS 주문액
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo
ORDER BY BS.bsDate;

-- WHERE 절 추가
-- 2019년 ~ 현재까지 판매된 내용만 출력
SELECT BS.bsDate, C.clientName, B.bookName, B.bookPrice, BS.bsQty,
	   B.bookPrice * BS.bsQty AS 주문액
FROM bookSale BS
	INNER JOIN client C ON C.clientNo = BS.clientNo
    INNER JOIN book B ON B.bookNo = BS.bookNo
WHERE BS.bsDate >= '2019-01-01'
ORDER BY BS.bsDate;



-- 연습문제
-- 1. 모든 도서에 대하여 도서의 도서번호, 도서명, 출판사명 출력
select B.bookNo, B.bookName, P.pubName from book B Inner join publisher P on B.pubNo=P.pubNo;

-- 2. ‘서울 출판사'에서 출간한 도서의 도서명, 저자명, 출판사명 출력 (조건에 출판사명 사용)
select B.bookName, B.bookAuthor, P.PubName from book B Inner join publisher P on B.pubNo=P.pubNo where P.pubName='서울 출판사';

-- 3. ＇종로출판사'에서 출간한 도서 중 판매된 도서의 도서명 출력 (중복된 경우 한 번만 출력) (조건에 출판사명 사용)
select distinct B.bookName
from book B inner join publisher P on B.pubNo=P.pubNo
			inner join booksale BS on B.bookNo=BS.bookNo
where P.pubName='종로출판사';

-- 4. 도서가격이 30,000원 이상인 도서를 주문한 고객의 고객명, 도서명, 도서가격, 주문수량 출력
select C.clientName, B.bookName, B.bookPrice, BS.bsQty
from booksale BS inner join client C on BS.clientNo=C.clientNo
				inner join book B on BS.bookNo=B.bookNo
where B.bookPrice>=30000;

-- 5. '안드로이드 프로그래밍' 도서를 구매한 고객에 대하여 도서명, 고객명, 성별, 주소 출력 (고객명으로 오름차순 정렬)
select B.bookName, C.clientName, C.clientGender, C.clientAddress
from booksale BS inner join client C on C.clientNo=BS.clientNo
				inner join book B on BS.bookNo=B.bookNo
where B.bookName='안드로이드 프로그래밍' order by C.clientName;

-- 6. ‘도서출판 강남'에서 출간된 도서 중 판매된 도서에 대하여 ‘총 매출액’ 출력
select SUM(BS.bsQty * B.bookPrice) as 총매출액
from book B inner join booksale BS on BS.bookNo=B.bookNo
				inner join publisher P on P.pubNo=B.pubNo
where P.pubName='도서출판 강남';

-- 7. ‘서울 출판사'에서 출간된 도서에 대하여 판매일, 출판사명, 도서명, 도서가격, 주문수량, 주문액 출력
select BS.bsDate, P.pubName, B.bookName, B.bookPrice, BS.bsQty, BS.bsQty*B.bookPrice as 주문액
from book B inner join publisher P on P.pubNo=B.pubNo
				 inner join booksale BS on BS.bookNo=B.bookNo
where P.pubName='서울 출판사';

-- 8. 판매된 도서에 대하여 도서별로 도서번호, 도서명, 총 주문 수량 출력
select B.bookNo, B.bookName, SUM(BS.bsQty) as 총주문수량
from book B inner join booksale BS on BS.bookNo=B.bookNo
group by B.bookName;

-- 9. 판매된 도서에 대하여 고객별로 고객명, 총구매액 출력 ( 총구매액이 100,000원 이상인 경우만 해당)
select C.clientName, SUM(BS.bsQty*B.bookPrice) as 총구매액
from booksale BS inner join client C on BS.clientNo=C.clientNo
				inner join book B on BS.bookNo=B.bookNo
group by C.clientName having 총구매액>=100000;

-- 10. 판매된 도서 중 ＇도서출판 강남'에서 출간한 도서에 대하여 고객명, 주문일, 도서명, 주문수량, 출판사명 출력 (고객명으로 오름차순 정렬)
select C.clientName, BS.bsDate, B.bookName, BS.bsQty, P.pubName
from booksale BS inner join client C on BS.clientNo=C.clientNo
				inner join book B on BS.bookNo=B.bookNo
                inner join publisher P on P.pubNo=B.pubNo
where P.pubName='도서출판 강남' order by C.clientName;


select B.bookNo, B.bookName from book B left outer join booksale BS on BS.bookNo=B.bookNo
where BS.bsNo is null order by B.bookNo;

select * from client C right outer join booksale BS on BS.clientNo=C.clientNo
order by C.clientNo;

select C.clientNo, C.clientName from client C right outer join booksale BS on BS.clientNo=C.clientNo
order by C.clientNo;