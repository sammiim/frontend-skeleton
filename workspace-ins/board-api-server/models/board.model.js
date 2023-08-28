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
  },
  async create(article){
    try{
      const sql = `insert into board set ?`;
      const [ result ] = await pool.query(sql, [article]);
      return result.insertId;
    }catch(err){
      throw new Error('DB Error', { cause: err });
    }
  },
  async update(id, article){
    try{
      const sql = `update board set ? where id = ?`;
      const [ result ] = await pool.query(sql, [article, id]);
      return result.affectedRows;
    }catch(err){
      throw new Error('DB Error', { cause: err });
    }
  },
  async delete(id){
    try{
      const sql = `update board set ? where id = ?`;
      const [ result ] = await pool.query(sql, [article, id]);
      return result.affectedRows;
    }catch(err){
      throw new Error('DB Error', { cause: err });
    }
  }
};

module.exports = boardModel;
