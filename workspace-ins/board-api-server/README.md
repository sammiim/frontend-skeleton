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

## 개발
### 설정 파일 작성
* config/index.js 파일 생성
```
module.exports = {
  mysql: {
    host: 'localhost',
    port: '33306',
    database: 'boarddb',
    user: 'node',
    password: 'node'
  }
};
```

### model 작성
* models/pool.js 파일 생성
```
const mysql2 = require('mysql2/promise');
const { mysql } = require('../config');
const pool = mysql2.createPool(mysql);
module.exports = pool;
```
* models/board.model.js 작성
```
const pool = require('./pool');

const boardModel = {
  // 게시물 목록 조회
  // find: async function(){
  async find(){
    try{
      const sql = `
        select board.* from board
      `;
      const [ result ] = await pool.query(sql);
      return result;
    }catch(err){
      throw new Error('DB Error', { cause: err });
    }
  }
};

module.exports = boardModel;
```
### router 작성
* app.js 수정
```
app.use('/api', indexRouter);
```
* routes/index.js 파일 수정
```
var express = require('express');
var router = express.Router({mergeParams: true});

const boardRouter = require('./board');
const userRouter = require('./users');

router.use('/boards', boardRouter);
router.use('/users', userRouter);

module.exports = router;
```
* routes/board.js 파일 생성
```
var express = require('express');
var router = express.Router();

const board = require('../models/board.model');

// 게시물 목록 조회
router.get('/', async (req, res, next) => {
  try{
    const list = await board.find();
    res.json(list);
  }catch(err){
    next(err);
  }
});

module.exports = router;
```
### 브라우저 테스트
* http://localhost:30443/api/boards
### postman 테스트
#### Workspace 생성
* Workspaces > Create Workspace > Blank workspace
  - Name: board DB
  - Create
* Collections > Create new collection
  - Name: board
* board 컬렉션에서 마우스 우클릭 > add request
  - method: GET
  - url: http://localhost:30443/api/boards
  - Send
