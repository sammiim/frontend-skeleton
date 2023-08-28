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