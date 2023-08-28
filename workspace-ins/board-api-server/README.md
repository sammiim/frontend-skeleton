# Back-End Express 기반의 API 서버
## 개발 환경 구축
### Express 보일러 플레이트 생성
```
npx express-generator board-api-server --no-view
cd board-api-server
npm install
```

### 포트 변경
* bin/www 파일 수정
```
var port = normalizePort(process.env.PORT || '30443');
```

### 서버 구동 명령 변경
* package.json 파일 수정
```
"scripts": {
  "start": "nodemon ./bin/www"
}
```

### 불필요한 파일 제거
* public 폴더 삭제

### 공통 에러 처리
* app.js에 에러 처리 미들웨어 추가
```
// 404 에러 처리
app.use((req, res, next) => {
  console.error(404, req.url);
  res.json({error: {message: '존재하지 않는 API입니다.'}});
});
// 500 에러 처리
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.json({error: {message: '요청을 처리할 수 없습니다. 잠시 후 다시 요청해 주세요.'}});
});
```

### API 서버 구동
```
npm start
```

### 테스트
* 웹 브라우저로 접속
  - http://localhost:30443

## DB 설계
### MySQL Workbench 실행
* File > New Model
* mydb 마우스 우클릭 > Edit Schema
  - Name: boarddb

### user 테이블
* Model Overwiew > Add Diagram 더블 클릭해서 새로운 다이어그램 추가
#### 생성
* boarddb > Tables > Place a New Table > 화면 클릭
#### 수정
* 생성된 table1 더블 클릭
* Table Name: user
* Column Name
  - id: INT, PK, NN, AI 체크, Comments: 사용자 아이디
  - name: VARCHAR(45), NN, 사용자 이름
  - email: VARCHAR(45), NN, 사용자 이메일
  - cellphone: VARCHAR(11), 사용자 휴대폰 번호
  - password: VARCHAR(45), NN, 사용자 비밀번호
  - createdAt: DATETIME, NN, default: CURRENT_TIMESTAMP, 생성일
  - updatedAt: DATETIME, defualt: CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 수정일

### board 테이블
#### 생성
* boarddb > Tables > Place a New Table > 화면 클릭
#### 수정
* 생성된 table1 더블 클릭
* Table Name: board
* Column Name
  - id: INT, PK, NN, AI 체크, Comments: 게시물 아이디
  - userId: INT, NN, 작성자 아이디
  - title: VARCHAR(1024), NN, 제목
  - content: VARCHAR(1024), NN, 내용
  - filePath: VARCHAR(1024), 첨부파일 경로
  - createdAt: DATETIME, NN, default: CURRENT_TIMESTAMP, 생성일
  - updatedAt: DATETIME, defualt: CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, 수정일
#### userId에 FK 추가
* Foreign Keys 탭 선택
* Foreign Key Name: fk_board_userId
* Referenced Table: 'boarddb'.'user'
* Column: userId
* Referenced Column: id

### board_comment 테이블
#### 생성
* boarddb > Tables > Place a New Table > 화면 클릭
#### 수정
* 생성된 table1 더블 클릭
* Table Name: board_comment
* Column Name
  - id: INT, PK, NN, AI 체크, Comments: 댓글 아이디
  - boardId: INT, NN, 게시물 아이디
  - userId: INT, NN, 작성자 아이디
  - content: VARCHAR(1024), NN, 댓글 내용
  - createdAt: DATETIME, NN, default: CURRENT_TIMESTAMP, 생성일

#### boardId에 FK 추가
* Foreign Keys 탭 선택
* Foreign Key Name: fk_board_comment_boardId
* Referenced Table: 'boarddb'.'board'
* Column: boardId
* Referenced Column: id

#### userId에 FK 추가
* Foreign Keys 탭 선택
* Foreign Key Name: fk_board_comment_userId
* Referenced Table: 'boarddb'.'user'
* Column: userId
* Referenced Column: id

### ERD 저장
* workspace/docs/boarddb 지정

### ERD로 테이블 생성
* Database > Forward Engineer
* Next 클릭 후 다음 항목 체크
  - Generate separate CREATE INDEX statements
  - DROP objects before each CREATE object
  - Generate DROP SCHEMA
* 계속 Next 후 Close

