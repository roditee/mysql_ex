-- 사용자 계정 조회
use mysql;
select * from user;

-- 사용자 계정 생성
create user newuser1@'%' identified by '1111';
-- newuser1으로 Connection 생성해서 서버에 연결되는지 확인
-- 서버 연결은 가능하나, 아직 권한을 부여받지 않은 상태이므로 스키마 접근 불가

-- 비밀번호 변겅
-- set password for 'newuser1'@'%' = '1234';

-- 서버 연결 (변경된 비밀번호로 접속)

-- 계정 삭제 (users and privieleges에서 확인 가능, 앞서 생성했던 connection 연결 불가능해짐)
-- drop user 'newuser1'@'%';




-- 권한 부여 : GRANT 권한 ON 데이터베이스.테이블 TO 계정@호스트;
-- 모든 권한 부여 : GRANT ALL PRIVILEGES ON *.* TO 계정@호스트;

-- 특정 DB의 모든 테이블에 특정 권한 부여
-- GRANT select, insert, update, delete ON DB명.* TO 계정@호스트;

-- 특정 DB의 모든 테이블에 대한 권한 삭제
-- REVOKE ALL PRIVILEGES ON DB명.* FROM 계정@호스트;

-- 특정 DB의 모든 테이블에 대해 특정 권한 삭제
-- REVOKE select, insert, update, delete ON DB명.* FROM 계정@호스트;




-- 권한 실습

-- 사용자 계정 생성
create user newuser1@'%' identified by '1111';

-- 권한 조회
show grants for newuser1;
-- 서버 접속 가능, 스키마 사용 권한 없음

-- 모든 권한 부여
grant all privileges on *.* to newuser1@'%';
show grants for newuser1;
-- 다시 커넥션 접속해보면 모든 스키마/테이블 접근 가능 (*.*)

-- newuser1의 select 권한 삭제
REVOKE select ON *.* FROM newuser1@'%';

-- sqldb3의 모든 테이블에 대한 select 권한 부여
-- sqldb3의 테이블만 접근 가능
GRANT select ON sqldb3.* TO newuser1@'%';
show grants for newuser1;



-- 백업 및 복구
-- Server / Data Export
-- Server / Data Import


-- import한 데이터베이스 테이블에서 동영상 파일 내보내기 테스트
use sqldb6;
select movieFilm from movie where movieId = '1' into outfile 'C:/dbworkspacefile/movies/Schindler_export.mp4';