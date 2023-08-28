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

// 게시물 상세 조회
router.get('/:id', async (req, res, next) => {
  try{
    const id = Number(req.params.id);
    const article = await board.findById(id);
    res.json(article);
  }catch(err){
    next(err);
  }
});

// 게시물 등록
router.post('/', async (req, res, next) => {
  try{
    const article = req.body;
    const id = await board.create(article);
    res.json({ id });
  }catch(err){
    next(err);
  }
});

module.exports = router;
