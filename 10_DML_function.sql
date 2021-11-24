-- 수학 함수 : ROUND()  함수
-- 반올림한 값을 구하는 함수
-- ROUND(값, 자리수)
-- 자리수 아래에서 반올림하여 자리수까지 출력
-- 양수 값 : 소수점 오른쪽 자릿수 (소수점 이하)
-- 음수 값 : 소수점 왼쪽 자릿수 (1의 자리부터 ~)
-- 예 : 소수점 이하 첫째 자리까지 반올림한 값 출력
-- ROUND(3.456, 1) : 3.500

-- 고객별 평균 주문액을 출력
SELECT clientNo, ROUND(AVG(bookPrice * bsQty)) AS "평균 주문액",
				 ROUND(AVG(bookPrice * bsQty), 0) AS "1의 자리까지 출력", 
                 ROUND(AVG(bookPrice * bsQty), -1) AS "10의 자리까지 출력", 
                 ROUND(AVG(bookPrice * bsQty), -2) AS "100의 자리까지 출력", 
                 ROUND(AVG(bookPrice * bsQty), -3) AS "1000의 자리까지 출력"
FROM book, bookSale WHERE book.bookNo = bookSale.bookNo GROUP BY clientNo;


-- 순위 출력 함수
-- RANK() / DENSE_RANK() / ROW_NUMBER()
-- RANK() : 값의 순위 반환 (동일 순위 개수만큼 증가) 1 1 3
-- DENSE_RANK() : 값의 순위 반환 (동일 순위 상관없이 1 증가) 1 1 2
-- ROW_NUMBER() : 행위 순위 

SELECT bookPrice,
	RANK() OVER (ORDER BY bookPrice DESC) "RANK",
    DENSE_RANK() OVER (ORDER BY bookPrice DESC) "DENSE_RANK",
    ROW_NUMBER() OVER (ORDER BY bookPrice DESC) "ROW_NUMBER"
FROM book;


-- 문자 함수
-- REPLACE() : 문자열을 치환(대체)하는 함수
-- CHAR_LENGTH() : 문자열 길이(글자 수)를 반환하는 함수
-- LENGTH() : 바이트 수
-- SUBSTR() : 지정한 길이만큼의 문자열을 반환하는 함수

-- REPLACE() : 문자열을 치환(대체)하는 함수
-- 도서명에 '안드로이드'가 포함된 도서에 대해
-- '안드로이드'를 'Android'로 변경해서 출력
-- book 테이블의 실제 데이터는 변경되지 않음
SELECT bookNo, REPLACE(bookName, '안드로이드', 'Android') bookName, bookAuthor, bookPrice
FROM book WHERE bookName LIKE '%안드로이드%';

-- book 테이블 확인
-- 실제 데이터는 변경되지 않음
-- '안드로이드'가 'Android'로 변경되지 않음
SELECT bookNo, bookName FROM book;


-- CHAR_LENGTH() : 문자열 길이(글자 수)를 반환하는 함수
	-- 스페이스도 1자
    -- '자바 프로그래밍' : 스페이스까지 포함해서 8자
-- LENGTH() : 바이트 수
	-- utf8 : 한글은 3바이트
    -- 유니코드 : 한글 2바이트
	-- '자바 프로그래밍' : 22 바이트
    -- 'HTML & CSS' : 10 바이트 (10자 : 영문자 1바이트)
    -- 'MFC 입문' : 10 바이트
-- '서울 출판사'에서 출간한 도서의 도서명과 바이트 수, 문자열 길이, 출판사명 출력
SELECT B.bookName AS "도서명",
	   LENGTH(B.bookName) AS "바이트 수",
       CHAR_LENGTH(B.bookName) AS "길이",
       P.pubName AS "출판사"
FROM book B INNER JOIN publisher P ON B.pubNo = P.pubNo
WHERE P.pubName = '서울 출판사';

-- SUBSTR() : 지정한 길이만큼의 문자열을 반환하는 함수
-- SUBSTR(전체문자열, 시작, 길이)

-- 도서 테이블의 '저자' 열에서 성만 출력
SELECT SUBSTR(bookAuthor, 1, 1) AS "성" FROM book;

-- 도서 테이블의 '저자' 열에서 이름만 출력
SELECT SUBSTR(bookAuthor, 2, 2) AS "이름" FROM book;

-- 저자 중에서 성이 '손'인 모든 저자 출력
select bookAuthor from book where substr(bookAuthor, 1, 1) = '손';

-- 저자 중에서 같은 성을 가진 사람이 몇 명이나 되는지 알아보기 위해 성 별로 그룹지어 인원수 출력
select substr(bookAuthor, 1, 1) as 성, count(*) as 인원수 from book group by 성;

-- 날짜 함수
-- DATE(NOW()) : 현재 날짜 출력
-- TIME(NOW()) : 현재 시간 출력
-- YEAR(CURDATE()) : 현재 날짜 연도 출력
-- MONTH(CURDATE()) : 현재 날짜 월 출력
-- DAYOFMONTH(CURDATE()) : 현재 날짜 일 출력
-- DATEDIFF() : 날짜 차이 계산
-- TIMEDIFF() : 시간 차이 계산

-- 현재 날짜와 시간 출력
SELECT DATE(NOW()), TIME(NOW());

-- 날짜에서 연, 월, 일 추출
SELECT YEAR(CURDATE()), MONTH(CURDATE()), DAYOFMONTH(CURDATE());

-- 시간에서 시, 분, 초, 마이크로초 출력
SELECT HOUR(CURTIME()),
       MINUTE(CURTIME()),
       SECOND(CURTIME()),
       MICROSECOND(CURTIME());
-- 또는       
SELECT HOUR(CURRENT_TIME()),
       MINUTE(CURRENT_TIME()),
       SECOND(CURRENT_TIME()),
       MICROSECOND(CURRENT_TIME());

-- 날짜/시간 차이 계산 예제
select datediff('2021-11-26', now());
select timediff('23:23:23', '12:11:10');
-- LOAD_FILE() 함수
-- 대용량 데이터 저장
-- 대본 : text 타입
-- 동영상 파일 : LONGBLOB  타입
-- LOAD_FILE(파일 경로)

CREATE TABLE movie (
	movieId VARCHAR(10) NOT NULL PRIMARY KEY,
    movieTitle VARCHAR(30),
    movieDirector VARCHAR(20),
    movieStar VARCHAR(20),
    movieScript LONGTEXT,
    movieFilm LONGBLOB
);

INSERT INTO movie 
	   VALUES ('1', '쉰드러 리스트', '스필버그', '리암 니슨',
			   LOAD_FILE('C:/dbworkspacefile/movies/Schindler.txt'),
               LOAD_FILE('C:/dbworkspacefile/movies/Schindler.mp4'));

-- (1) 저장할 수 있는 파일의 최대 크기 변수 확인
SHOW variables LIKE 'max_allowed_packet';
-- (2) 파일 업로드/다운로드 경로 변수 확인
SHOW variables LIKE 'secure_file_priv';

delete from movie;

SELECT * FROM sqldb3.movie;

-- LONGTEXT 타입의 영화 대본 데이터를 텍스트 파일로 내보내기
select movieScript from movie where movieId='1'
INTO OUTFILE 'C:/dbworkspacefile/movies/Schindler_out.txt'
LINES TERMINATED BY '\\n'; -- 줄바꿈 문자도 저장

-- 동영상 파일 (바이너리 파일)로 내보내기
select movieFilm from movie where movieId='1'
INTO OUTFILE 'C:/dbworkspacefile/movies/Schindler_out.mp4';

-- 도서 테이블의 모든 데이터를 텍스트 파일로 내보내기
select * from book into outfile 'C:/dbworkspacefile/movies/book_out.txt';