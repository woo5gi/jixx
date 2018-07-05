/* 저장소 */
DROP TABLE REPOSITORY 
	CASCADE CONSTRAINTS;

/* 게시물 */
DROP TABLE POST 
	CASCADE CONSTRAINTS;

/* 회원 */
DROP TABLE MEMBER 
	CASCADE CONSTRAINTS;

/* 회원메타 */
DROP TABLE USER_META 
	CASCADE CONSTRAINTS;

/* 채널리스트 */
DROP TABLE CHANNEL 
	CASCADE CONSTRAINTS;

/* 메세지 */
DROP TABLE MESSAGE 
	CASCADE CONSTRAINTS;
--유저메타2
DROP TABLE USER_META2
CASCADE CONSTRAINTS;

/* 저장소 */
CREATE TABLE REPOSITORY (
	rep_id NUMBER(6) NOT NULL, /* 저장소고유Key */
	rep_name VARCHAR2(30) NOT NULL, /* 저장소 이름 */
	rep_url VARCHAR2(20) NOT NULL /* 저장소URI */
);

COMMENT ON TABLE REPOSITORY IS '저장소';

COMMENT ON COLUMN REPOSITORY.rep_id IS '저장소고유Key';

COMMENT ON COLUMN REPOSITORY.rep_name IS '저장소 이름';

COMMENT ON COLUMN REPOSITORY.rep_url IS '저장소URL';

ALTER TABLE REPOSITORY
	ADD
		CONSTRAINT PK_REPOSITORY
		PRIMARY KEY (
			rep_id
		);

/* 게시물 */
CREATE TABLE POST (
	post_id NUMBER(8) NOT NULL, /* 글번호 */
	repost_id NUMBER(8) DEFAULT 0, /* 원글번호 */
	nickname VARCHAR2(16), /* 작성자닉네임 */
	content CLOB, /* 글내용 */
	user_id NUMBER(8), /* 회원고유Key */
	post_logdate DATE, /* 작성 시간 */
	post_update DATE, /* 수정 시간 */
	file_thumbnail VARCHAR2(150), /* 저장파일썸네일 */
	fil_original VARCHAR2(150), /* 저장파일이름 */
	post_status NUMBER(1) DEFAULT 1, /* 게시물상태 */
	channel_id NUMBER(7) NOT NULL /* 채널번호 */
);

COMMENT ON TABLE POST IS '게시물';

COMMENT ON COLUMN POST.post_id IS '글번호';

COMMENT ON COLUMN POST.repost_id IS '원글번호';

COMMENT ON COLUMN POST.nickname IS '작성자닉네임';

COMMENT ON COLUMN POST.content IS '글내용';

COMMENT ON COLUMN POST.user_id IS '회원고유Key';

COMMENT ON COLUMN POST.post_logdate IS '작성 시간';

COMMENT ON COLUMN POST.post_update IS '수정 시간';

COMMENT ON COLUMN POST.file_thumbnail IS '저장파일썸네일';

COMMENT ON COLUMN POST.fil_original IS '저장파일이름';

COMMENT ON COLUMN POST.post_status IS '게시물상태';

COMMENT ON COLUMN POST.channel_id IS '채널번호';

ALTER TABLE POST
	ADD
		CONSTRAINT PK_POST
		PRIMARY KEY (
			post_id
		);

/* 회원 */
CREATE TABLE MEMBER (
	user_id NUMBER(8) NOT NULL, /* 회원고유Key */
	user_email VARCHAR2(25) NOT NULL, /* 회원아이디(이메일) */
	user_pass VARCHAR2(15) NOT NULL, /* 회원비밀번호 */
	user_name VARCHAR2(15) NOT NULL, /* 회원이름 */
    user_tempkey number(6),
    user_auth NUMBER(1)  DEFAULT 0 NOT NULL
);

COMMENT ON TABLE MEMBER IS '회원';

COMMENT ON COLUMN MEMBER.user_id IS '회원고유Key';

COMMENT ON COLUMN MEMBER.user_email IS '회원아이디(이메일)';

COMMENT ON COLUMN MEMBER.user_pass IS '회원비밀번호';

COMMENT ON COLUMN MEMBER.user_name IS '회원이름';

ALTER TABLE MEMBER
	ADD
		CONSTRAINT PK_MEMBER
		PRIMARY KEY (
			user_id
		);

/* 회원메타 */
CREATE TABLE USER_META (
	user_id NUMBER(8) NOT NULL, /* 회원고유Key */
	rep_id NUMBER(6) NOT NULL, /* 저장소고유Key */	
	channel_id NUMBER(7) NOT NULL, /* 채널번호 */
	alarm_type NUMBER(1) DEFAULT 1 NOT NULL /* 알람설정 */
);

COMMENT ON TABLE USER_META IS '회원메타';

COMMENT ON COLUMN USER_META.user_id IS '회원고유Key';

COMMENT ON COLUMN USER_META.rep_id IS '저장소고유Key';

COMMENT ON COLUMN USER_META.rep_level IS '저장소권한';

COMMENT ON COLUMN USER_META.channel_id IS '채널번호';

COMMENT ON COLUMN USER_META.alarm_type IS '알람설정';

/* 채널리스트 */
CREATE TABLE CHANNEL (
	channel_id NUMBER(7) NOT NULL, /* 채널번호 */
	channel_name varchar2(30) NOT NULL, /* 채널이름 */
	channel_type NUMBER(1) DEFAULT 1 NOT NULL, /* 채널타입 */
	channel_status NUMBER(1) DEFAULT 1 NOT NULL, /* 채널상태 */
	rep_id NUMBER(6) NOT NULL /* 저장소고유Key */
);

COMMENT ON TABLE CHANNEL IS '채널리스트';

COMMENT ON COLUMN CHANNEL.channel_id IS '채널번호';

COMMENT ON COLUMN CHANNEL.channel_name IS '채널이름';

COMMENT ON COLUMN CHANNEL.channel_type IS '채널타입';

COMMENT ON COLUMN CHANNEL.channel_status IS '채널상태';

COMMENT ON COLUMN CHANNEL.rep_id IS '저장소고유Key';

ALTER TABLE CHANNEL
	ADD
		CONSTRAINT PK_CHANNEL
		PRIMARY KEY (
			channel_id
		);

/* 메세지 */
CREATE TABLE MESSAGE (
	message_id NUMBER(10) NOT NULL, /* 메세지번호 */
	nickname VARCHAR2(16), /* 작성자닉네임 */
	content CLOB, /* 글내용 */
	user_id NUMBER(8), /* 회원고유Key */
	logdate DATE, /* 작성 시간 */
	file_thumbnail VARCHAR2(150), /* 저장파일썸네일 */
	fil_original VARCHAR2(150), /* 저장파일이름 */
	message_status NUMBER(1) DEFAULT 1, /* 메세지상태 */
	channel_id NUMBER(7) NOT NULL /* 채널번호 */
);

COMMENT ON TABLE MESSAGE IS '메세지';

COMMENT ON COLUMN MESSAGE.message_id IS '메세지번호';

COMMENT ON COLUMN MESSAGE.nickname IS '작성자닉네임';

COMMENT ON COLUMN MESSAGE.content IS '글내용';

COMMENT ON COLUMN MESSAGE.user_id IS '회원고유Key';

COMMENT ON COLUMN MESSAGE.logdate IS '작성 시간';

COMMENT ON COLUMN MESSAGE.file_thumbnail IS '저장파일썸네일';

COMMENT ON COLUMN MESSAGE.fil_original IS '저장파일이름';

COMMENT ON COLUMN MESSAGE.message_status IS '메세지상태';

COMMENT ON COLUMN MESSAGE.channel_id IS '채널번호';

ALTER TABLE MESSAGE
	ADD
		CONSTRAINT PK_MESSAGE
		PRIMARY KEY (
			message_id
		);

ALTER TABLE POST
	ADD
		CONSTRAINT FK_CHANNEL_TO_POST
		FOREIGN KEY (
			channel_id
		)
		REFERENCES CHANNEL (
			channel_id
		);

ALTER TABLE USER_META
	ADD
		CONSTRAINT FK_MEMBER_TO_USER_META
		FOREIGN KEY (
			user_id
		)
		REFERENCES MEMBER (
			user_id
		);

ALTER TABLE USER_META
	ADD
		CONSTRAINT FK_REPOSITORY_TO_USER_META
		FOREIGN KEY (
			rep_id
		)
		REFERENCES REPOSITORY (
			rep_id
		);

ALTER TABLE USER_META
	ADD
		CONSTRAINT FK_CHANNEL_TO_USER_META
		FOREIGN KEY (
			channel_id
		)
		REFERENCES CHANNEL (
			channel_id
		);

ALTER TABLE CHANNEL
	ADD
		CONSTRAINT FK_REPOSITORY_TO_CHANNEL
		FOREIGN KEY (
			rep_id
		)
		REFERENCES REPOSITORY (
			rep_id
		);

ALTER TABLE MESSAGE
	ADD
		CONSTRAINT FK_CHANNEL_TO_MESSAGE
		FOREIGN KEY (
			channel_id
		)
		REFERENCES CHANNEL (
			channel_id
		);
create table user_meta2 (
user_id NUMBER(8) NOT NULL,
rep_id  NUMBER(6) NOT NULL,
nickname varchar2(50) primary key,
admin_level number(1) NOT NULL,
constraint user_id_fk foreign key (user_id) references member (user_id),
constraint rep_id_fk foreign key (rep_id) references repository (rep_id)
);


       
insert into member values(1,'leyh5@naver.com','asdf','asdf','', default);
insert into repository values(1, 'jixx', 'jixx');
Insert into REPOSITORY (REP_ID,REP_NAME,REP_URl) values (2,'더미데이터','dumi');
Insert into CHANNEL values (1,'general',1,1,1);
Insert into post values (1,1, '닉네임', '글',1,sysdate,null,null,null,1,1);
commit;