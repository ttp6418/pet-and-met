// ============ 테이블 초기화 ============

DROP TABLE RESERVATION;
DROP TABLE PHOTO;
DROP TABLE FILES;
DROP TABLE COMMENTS;
DROP TABLE CONSULTING;
DROP TABLE LIKES;
DROP TABLE REVIEW;
DROP TABLE MEMBER;
DROP TABLE BOARD;
DROP TABLE ROOM;
DROP TABLE PAYMENT;


// =============================================================================

// ============ 테이블 시퀀스 초기화 ============

// DROP SEQUENCE SEQ_PHOTO;

DROP SEQUENCE SEQ_BOARD;
DROP SEQUENCE SEQ_COMMENTS;
DROP SEQUENCE SEQ_CONSULTING;
DROP SEQUENCE SEQ_FILES;
DROP SEQUENCE SEQ_LIKES;
DROP SEQUENCE SEQ_MEMBER;
DROP SEQUENCE SEQ_REVIEW;
DROP SEQUENCE SEQ_PAYMENT;
DROP SEQUENCE SEQ_RESERVATION;

// ============ 테이블 시퀀스 생성 ============

// CREATE SEQUENCE SEQ_PHOTO;

CREATE SEQUENCE SEQ_BOARD NOCYCLE;
CREATE SEQUENCE SEQ_COMMENTS NOCYCLE;
CREATE SEQUENCE SEQ_CONSULTING NOCYCLE;
CREATE SEQUENCE SEQ_FILES NOCYCLE;
CREATE SEQUENCE SEQ_LIKES NOCYCLE;
CREATE SEQUENCE SEQ_MEMBER NOCYCLE;
CREATE SEQUENCE SEQ_REVIEW NOCYCLE;
CREATE SEQUENCE SEQ_PAYMENT NOCYCLE;
CREATE SEQUENCE SEQ_RESERVATION NOCYCLE;

// =============================================================================


// ============ 객실 테이블 생성 ============

CREATE TABLE ROOM (
    ROOM_NO	        NUMBER		PRIMARY KEY NOT NULL,
	ROOM_TYPE       CHAR(1)	    DEFAULT 'A'	NOT NULL    CHECK(ROOM_TYPE IN ('A', 'B')),
	ROOM_FEE        NUMBER	    DEFAULT 0	NOT NULL,
	ROOM_USEABLE    NUMBER	    DEFAULT 1	NOT NULL    CHECK(ROOM_USEABLE IN (0,1)),
	ROOM_SIZE       NUMBER
);


// ============ 객실 테이블 컬럼명 ============

COMMENT ON COLUMN ROOM.ROOM_NO IS '객실번호';
COMMENT ON COLUMN ROOM.ROOM_TYPE IS '객실타입';
COMMENT ON COLUMN ROOM.ROOM_FEE IS '객실요금';
COMMENT ON COLUMN ROOM.ROOM_USEABLE IS '객실사용가능여부';
COMMENT ON COLUMN ROOM.ROOM_SIZE IS '객실면적';


// ============ 결제 테이블 생성 ============
CREATE TABLE PAYMENT (
	PAYMENT_NO	NUMBER		NOT NULL PRIMARY KEY,
	PAYMENT_TID	VARCHAR2(80)	NOT NULL,
    PAYMENT_AID VARCHAR2(80) NULL,
    PAYMENT_METHOD VARCHAR2(30) NULL,
	PAYMENT_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	PAYMENT_CANCEL	DATE NULL,
    PAYMENT_APPROVED VARCHAR2(30) NULL,
	PAYMENT_RESERVATION_NO	NUMBER		NOT NULL,
    PAYMENT_USER_NO NUMBER NOT NULL,
    PAYMENT_STATUS_CODE NUMBER DEFAULT 0 NOT NULL
);

// ============ 회원 테이블 생성 ============
CREATE TABLE MEMBER(
	MEMBER_NO NUMBER PRIMARY KEY,
	MEMBER_ID VARCHAR2(40) NOT NULL UNIQUE,
	MEMBER_PWD	VARCHAR2(80) NOT NULL,
	MEMBER_NAME	VARCHAR2(40) NOT NULL,
	MEMBER_PHONE VARCHAR2(16) NOT NULL UNIQUE,
	MEMBER_EMAIL	VARCHAR2(40)		NOT NULL UNIQUE,
	MEMBER_ADDRESS	VARCHAR2(200)		NOT NULL,
    MEMBER_ADDRESS_DETAIL	VARCHAR2(200)		NOT NULL,
    MEMBER_BIRTH	DATE NOT NULL,
    MEMBER_DESCRIPTION	VARCHAR2(2000)		NULL,
	MEMBER_JOIN	DATE	DEFAULT SYSDATE	NOT NULL,
	MEMBER_LEAVE	DATE		NULL,
    MEMBER_STATUS NUMBER DEFAULT 1 CHECK(MEMBER_STATUS IN (0, 1)) NOT NULL,
    MEMBER_LEAVE_REASON VARCHAR2(100) NULL,
    MEMBER_ADMIN NUMBER DEFAULT 0 CHECK(MEMBER_ADMIN IN (0,1)) NOT NULL
);

// ============ 리뷰 테이블 생성 ============
CREATE TABLE REVIEW(
	REVIEW_NO	NUMBER PRIMARY KEY,
	REVIEW_NAME	VARCHAR2(100)	DEFAULT '이름없는 게시글'	NOT NULL,
	REVIEW_CONTENT	VARCHAR2(4000)		NULL,
    REVIEW_AUTHOR	NUMBER NOT NULL,
	REVIEW_INSERT	DATE	DEFAULT SYSDATE	NOT NULL,
	REVIEW_UPDATE	DATE		NULL,
	REVIEW_DELETE	DATE		NULL,
	REVIEW_VIEW	NUMBER	DEFAULT 0	NOT NULL,
	REVIEW_IP	VARCHAR2(40)		NULL,
    FOREIGN KEY (REVIEW_AUTHOR) REFERENCES MEMBER(MEMBER_NO)
);

// ============ 파일 테이블 생성 ============
CREATE TABLE FILES(
	FILES_NO	NUMBER PRIMARY KEY,
    FILES_REVIEW_NO NUMBER NOT NULL,
	FILES_ORIGIN_NAME	VARCHAR2(80)		NOT NULL,
	FILES_CHANGE_NAME	VARCHAR2(80)		NOT NULL UNIQUE,
	FILES_PATH	VARCHAR2(40)		NULL,
	FILES_UPLOAD_DATE	DATE	DEFAULT SYSDATE	NOT NULL,
	FILES_STATUS NUMBER DEFAULT 1 CHECK(FILES_STATUS IN (0, 1)) NOT NULL,
    FOREIGN KEY (FILES_REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

// ============ 댓글 테이블 생성 ============
CREATE TABLE COMMENTS (
	COMMENTS_NO	NUMBER PRIMARY KEY,
	COMMENTS_CONTENT	VARCHAR2(4000) NULL,
	COMMENTS_INSERT	DATE DEFAULT SYSDATE NOT NULL,
	COMMENTS_UPDATE	DATE NULL,
	COMMENTS_DELETE	DATE NULL,
	COMMENTS_REVIEW_NO NUMBER NOT NULL,
	COMMENTS_MEMBER_NO	NUMBER NOT NULL,
	COMMENTS_IP	VARCHAR2(40) NULL,
    FOREIGN KEY (COMMENTS_MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY (COMMENTS_REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

// ============ 추천수 테이블 생성 ============
CREATE TABLE LIKES(
    LIKES_NO NUMBER PRIMARY KEY,
    LIKES_MEMBER_NO NUMBER NOT NULL,
    LIKES_REVIEW_NO NUMBER NOT NULL,
    LIKES_STATUS NUMBER DEFAULT 0 CHECK(LIKES_STATUS IN (0,1)) NOT NULL,
    FOREIGN KEY (LIKES_MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY (LIKES_REVIEW_NO) REFERENCES REVIEW(REVIEW_NO)
);

// ============ 게시판 테이블 생성 ============
CREATE TABLE BOARD (
	BOARD_NO	NUMBER PRIMARY KEY,
	BOARD_NAME	VARCHAR2(100) DEFAULT '이름없는 게시글' NOT NULL,
	BOARD_CONTENT	VARCHAR2(4000)		NULL,
    BOARD_ACCENT    NUMBER DEFAULT 0 NOT NULL,
	BOARD_INSERT	DATE DEFAULT SYSDATE	NOT NULL,
	BOARD_UPDATE	DATE		NULL,
	BOARD_DELETE	DATE		NULL,
	BOARD_VIEW	NUMBER	DEFAULT 0	NOT NULL,
	BOARD_IP	VARCHAR2(40)		NULL
);

// ============ 문의 테이블 생성 ============
CREATE TABLE CONSULTING (
    CONSULTING_NO NUMBER PRIMARY KEY,
    CONSULTING_MEMBER_NO NUMBER NOT NULL,
    FOREIGN KEY (CONSULTING_MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);


// ============ 예약 테이블 생성 ============
CREATE TABLE RESERVATION (	
    RESERVATION_NO	            NUMBER		        PRIMARY KEY NOT NULL,
    MEMBER_NO	                NUMBER	            REFERENCES MEMBER(MEMBER_NO) NOT NULL,
	ROOM_NO	                    NUMBER	            REFERENCES ROOM(ROOM_NO) NOT NULL,
	RESERVATION_START_DATE	    DATE		        NOT NULL,
	RESERVATION_END_DATE	    DATE		        NOT NULL,
    RESERVATION_STAY_DATE	    NUMBER		        NOT NULL,
	RESERVATION_MEMO	        VARCHAR2(1000)		,
	RESERVATION_USER_NAME	    VARCHAR2(40)		NOT NULL,
    RESERVATION_USER_EMAIL      VARCHAR2(40)        NOT NULL,
	RESERVATION_PHONE	        VARCHAR2(16)		NOT NULL,
	RESERVATION_REGIST_DATE	    DATE	            DEFAULT SYSDATE	NOT NULL,
	RESERVATION_CANCLE_DATE	    DATE		        
);

// ============ 예약 테이블 컬럼명 ============

COMMENT ON COLUMN RESERVATION.RESERVATION_NO            IS '예약번호';
COMMENT ON COLUMN RESERVATION.RESERVATION_START_DATE    IS '입실날짜';
COMMENT ON COLUMN RESERVATION.RESERVATION_END_DATE      IS '퇴실날짜';
COMMENT ON COLUMN RESERVATION.RESERVATION_STAY_DATE     IS '숙박일수';
COMMENT ON COLUMN RESERVATION.RESERVATION_MEMO          IS '요청사항';
COMMENT ON COLUMN RESERVATION.RESERVATION_USER_NAME     IS '예약자이름';
COMMENT ON COLUMN RESERVATION.RESERVATION_USER_EMAIL    IS '예약자이메일';
COMMENT ON COLUMN RESERVATION.RESERVATION_PHONE         IS '예약자연락처';
COMMENT ON COLUMN RESERVATION.RESERVATION_REGIST_DATE   IS '예약날짜';
COMMENT ON COLUMN RESERVATION.RESERVATION_CANCLE_DATE   IS '예약취소날짜';
COMMENT ON COLUMN RESERVATION.MEMBER_NO                 IS '유저번호';
COMMENT ON COLUMN RESERVATION.ROOM_NO                   IS '객실번호';

// =============================================================================


// ============ 객실 사진 테이블 생성 ============
--CREATE TABLE PHOTO (
--    PHOTO_NO	    NUMBER		    PRIMARY KEY NOT NULL,
--    PHOTO_TYPE       CHAR(2)	    DEFAULT 'A'	NOT NULL,
--    PHOTO_ORIGINAL	VARCHAR2(100)	NOT NULL,
--	PHOTO_NAME	    VARCHAR2(100)	NOT NULL,
--	PHOTO_PATH	    VARCHAR2(100)	,
--	PHOTO_DATE	    DATE	        DEFAULT SYSDATE	NOT NULL
--);
--
--// ============ 객실 사진 테이블 컬럼명 ============
--COMMENT ON COLUMN PHOTO.PHOTO_NO IS '사진번호';
--
--COMMENT ON COLUMN PHOTO.PHOTO_TYPE IS '객실타입';
--
--COMMENT ON COLUMN PHOTO.PHOTO_ORIGINAL IS '원본명';
--
--COMMENT ON COLUMN PHOTO.PHOTO_NAME IS '수정명';
--
--COMMENT ON COLUMN PHOTO.PHOTO_PATH IS '파일경로';
--
--COMMENT ON COLUMN PHOTO.PHOTO_DATE IS '파일등록일';


// =============================================================================


// ============ 객실 테이블 데이터 입력 ============

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(101
                , 'A'
                , 80000
                , 1
                , 8);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(102
                , 'A'
                , 80000
                , 1
                , 8);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(103
                , 'A'
                , 80000
                , 1
                , 8);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(104
                , 'A'
                , 80000
                , 1
                , 8);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(105
                , 'A'
                , 80000
                , 1
                , 8);
                
INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(201
                , 'B'
                , 120000
                , 1
                , 15);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(202
                , 'B'
                , 120000
                , 1
                , 15);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(203
                , 'B'
                , 120000
                , 1
                , 15);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(204
                , 'B'
                , 120000
                , 1
                , 15);

INSERT INTO ROOM (ROOM_NO
                , ROOM_TYPE
                , ROOM_FEE
                , ROOM_USEABLE
                , ROOM_SIZE)                                      
           VALUES(205
                , 'B'
                , 120000
                , 1
                , 15);


// ============ 객실 사진 테이블 데이터 입력 ============


--INSERT INTO PHOTO (PHOTO_NO
--                 , PHOTO_TYPE
--                 , PHOTO_ORIGINAL
--                 , PHOTO_NAME)                                      
--            VALUES(SEQ_PHOTO.NEXTVAL
--                 , 'A'
--                 , 'portfolio-1.jpg'
--                 , 'portfolio-1.jpg');
--
--INSERT INTO PHOTO (PHOTO_NO
--                 , PHOTO_TYPE
--                 , PHOTO_ORIGINAL
--                 , PHOTO_NAME)                                      
--            VALUES(SEQ_PHOTO.NEXTVAL
--                 , 'B'
--                 , 'portfolio-2.jpg'
--                 , 'portfolio-2.jpg');   


// ============ 예약 테이블 데이터 입력 ============ 

INSERT INTO RESERVATION (RESERVATION_NO
                       , MEMBER_NO
                       , ROOM_NO
                       , RESERVATION_START_DATE
                       , RESERVATION_END_DATE
                       , RESERVATION_STAY_DATE
                       , RESERVATION_USER_NAME
                       , RESERVATION_USER_EMAIL
                       , RESERVATION_PHONE)                                      
                 VALUES (SEQ_RESERVATION.NEXTVAL
                        , 1
                        , 102
                        , TO_DATE(20231018)
                        , TO_DATE(20231020)
                        , 2
                        , '천재영'
                        , 'gojoseon@gmail.com'
                        ,'010-212-1213');



// =============================================================================

// ============ 테이터 커밋 ============

COMMIT;

--
--// 검색된 날짜가 떠야한다.
--SELECT ROOM_NO 
--  FROM RESERVATION 
-- WHERE RESERVATION_START_DATE = TO_DATE(20231017)
--    OR (TO_DATE(20231017) BETWEEN RESERVATION_START_DATE AND RESERVATION_END_DATE)
--    OR ((TO_DATE(20231017) < RESERVATION_START_DATE) AND (RESERVATION_START_DATE < TO_DATE(20231019)))
--GROUP BY ROOM_NO;
--
--
--
--
---- 결국 구한건 해당 날짜 사이에 예약 불가능한 방만 보여짐
--SELECT * -- 전체 방 목록
--  FROM ROOM
--MINUS
--
--SELECT * -- 해당 날짜 사이에 예약 가능한 방들
--  FROM ROOM
-- WHERE ROOM_NO IN (
--        SELECT ROOM_NO
--          FROM ROOM -- 선행쿼리 (전체 방번호 모두 뽑기)
--        MINUS
--        SELECT ROOM_NO
--          FROM RESERVATION 
--         WHERE RESERVATION_START_DATE = TO_DATE(20231017)
--            OR (TO_DATE(20231017) BETWEEN RESERVATION_START_DATE AND RESERVATION_END_DATE)
--            OR ((TO_DATE(20231017) < RESERVATION_START_DATE) AND (RESERVATION_START_DATE < TO_DATE(20231019)))
--        GROUP BY ROOM_NO -- 후행쿼리 (현재 해당 날짜 사이에 예약된 방번호)
--);
--
--SELECT ROOM_TYPE -- 해당 날짜 사이에 예약 가능한 방들
--  FROM ROOM
-- WHERE ROOM_NO IN (
--        SELECT ROOM_NO
--          FROM ROOM -- 선행쿼리 (전체 방번호 모두 뽑기)
--        MINUS
--        SELECT ROOM_NO
--          FROM RESERVATION 
--         WHERE RESERVATION_START_DATE = TO_DATE(20231018)
--            OR (TO_DATE(20231018) BETWEEN RESERVATION_START_DATE AND RESERVATION_END_DATE)
--            OR ((TO_DATE(20231018) < RESERVATION_START_DATE) AND (RESERVATION_START_DATE < TO_DATE(20231019)))
--        GROUP BY ROOM_NO -- 후행쿼리 (현재 해당 날짜 사이에 예약된 방번호)
--)
--GROUP BY ROOM_TYPE;





 

