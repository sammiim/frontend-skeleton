const mysql2 = require('mysql2/promise');
const { mysql } = require('../config');
const pool = mysql2.createPool(mysql);
console.log(`${mysql.host}:${mysql.port} DB 연결 완료`);
module.exports = pool;