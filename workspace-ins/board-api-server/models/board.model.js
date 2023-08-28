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