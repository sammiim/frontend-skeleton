const pool = require('./pool');

const boardModel = {
  // 게시물 목록 조회
  // find: async function(){
  async find(){
    try{
      const sql = `
        select board.*, user.name
        from board
        left join user on board.userId = user.id
      `;
      const [ result ] = await pool.query(sql);
      return result;
    }catch(err){
      throw new Error('DB Error', { cause: err });
    }
  },
  async findById(id){
    try{
      const sql = `
        select board.*, user.name
        from board
        left join user on board.userId = user.id
        where board.id = ?
      `;
      const [ result ] = await pool.query(sql, [id]);
      return result[0];
    }catch(err){
      throw new Error('DB Error', { cause: err });
    }
  }
};

module.exports = boardModel;
