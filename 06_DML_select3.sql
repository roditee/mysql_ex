-- GROUP BY  절
-- 그룹 쿼리를 기술할 때 사용
-- 특정 열로 그룹화한 후 각 그룹에 대해 한 행씩 쿼리 결과 생성

-- 도서판매 테이블에서 도서별로 판매수량 합계 출력
SELECT bookNo, SUM(bsQty) AS "판매량 합계" FROM booksale GROUP BY bookNo;

-- GROUP BY 절에서 정렬 : 열이름으로 정렬
SELECT bookNo, SUM(bsQty) AS "판매량 합계" FROM booksale GROUP BY bookNo ORDER BY bookNo;

-- 또는 열 순서로 정렬해도 됨
SELECT bookNo, SUM(bsQty) AS "판매량 합계" FROM booksale GROUP BY bookNo ORDER BY 1; -- 첫 번째 열(bookNo)로 정렬
-- 두 번째 열(판매량 합계)로 정렬
SELECT bookNo, SUM(bsQty) AS "판매량 합계" FROM booksale GROUP BY bookNo ORDER BY 2; 

SELECT bookNo, SUM(bsQty) AS "판매량 합계" FROM booksale GROUP BY bookNo ORDER BY "판매량 합계"; -- 정렬 안 됨 -- 열 이름에 따옴표 있으면 정렬 안됨
SELECT bookNo, SUM(bsQty) AS 판매량합계 FROM booksale GROUP BY bookNo ORDER BY 판매량합계; -- 열 이름에 따옴표 없으면 정렬됨 (열 이름에 공백 없어야 함)




/*
	HAVING 절
	HAVING 조건
	GROUP BY 절에 의해 구성된 그룹들에 대해 적용할 조건 기술
	SUM(), AVG(), MAX(), MIN(), COUNT() 등의 집계 함수와 함께 사용
	주의 !!
	반드시  GROUP BY 절과 함께 사용
	WHERE 절보다 뒤에
	검색 조건에 집계함수가 와야 함
*/

-- 도서 테이블에서 가격이 25000원 도서에 대해서
-- 출판사별로 도서 수 합계 (출판사별 : 그룹화)
-- 단, '도서 수 합계'가 2인 이상만 출력
SELECT pubNo, COUNT(*) AS "도서 수 합계" FROM book WHERE bookPrice >= 25000 GROUP BY pubNo HAVING COUNT(*) >= 2;

-- HAVING 조건이 없는 경우
SELECT pubNo, COUNT(*) AS "도서 수 합계" FROM book WHERE bookPrice >= 25000 GROUP BY pubNo;





-- 연습문제
select bookName, bookAuthor, bookPrice from book order by bookPrice DESC, bookAuthor ASC;
select SUM(bookStock) from book where bookAuthor like '%길동%';
select MAX(bookPrice), MIN(bookPrice) from book where pubNo='1';
select SUM(bookStock) 총재고수량, round(AVG(bookStock),2) 평균재고수량 from book group by pubNo order by 총재고수량 DESC;
select SUM(bsQty) 총주문수량, count(bsNo) 총주문건수 from booksale group by clientNo having 총주문건수>=2;
select SUM(bsQty) 총주문수량, count(bsNo) 총주문건수 from booksale group by clientNo having count(*)>=2;
