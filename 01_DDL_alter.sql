use sqldb1;

-- ALTER

-- 열 추가
alter table student add stdTel varchar(13);
describe student;

-- 여러 개의 열 추가
alter table student add (stdAge varchar(2), stdAddress2 varchar(50));

-- 열의 데이터 형식 변경
alter table student modify stdAge int;

-- 열의 제약조건 변경
alter table student modify stuName varchar(5) null;

-- 열 이름 변경
alter table student rename column stuName to stdName;
alter table student rename column stdTel to stdHP;

-- 열 이름과 데이터 타입 변경
alter table student change stdAddress stdAddress1 varchar(30);
alter table student drop column stdHP;

-- 여러 개의 열 삭제
alter table student drop stdAge,
					drop stdAddress1,
                    drop stdAddress2;
                    
                    
                    
-- 연습문제
alter table product add (prdStock int, prdDate DATE);
alter table product modify prdCompany varchar(30) not null;
alter table publisher add (pubPhone varchar(13), pubAddress varchar(50));
alter table publisher drop pubPhone;

describe product;
describe publisher;





-- 기본키 삭제 (외래키 제약조건이 설정되어 있는 경우 기본키 테이블의 기본키 삭제 시 오류 발생
-- -> 외래키 제약조건 먼저 삭제 후 기본키 삭제 가능
-- (학생 테이블과 교수 테이블에서 학과번호 참조중이므로 두 테이블의 외래키 제약조건 삭제)
alter table student drop constraint FK_student_department;
alter table professor drop constraint FK_professor_department;
alter table department drop primary key;

-- 기본키/외래키 추가

-- 기본키 제약조건 추가
alter table department add primary key (dptNo);
-- 또는
alter table department add constraint PK_department_dptNo primary key (dptNo);

-- 외래키 제약조건 추가
alter table student add constraint FK_student_department foreign key (dptNo) references department(dptNo);
alter table professor add constraint FK_professor_department foreign key (dptNo) references department(dptNo);





-- on delete cascade
-- student 테이블의 기존 외래키 삭제하고
-- on delete cascade로 다시 외래키 설정
alter table student drop constraint FK_student_department;
alter table student add constraint FK_student_department foreign key(dptNo) references department(dptNo) on delete cascade;

DROP TABLE book;
DROP TABLE publisher;
