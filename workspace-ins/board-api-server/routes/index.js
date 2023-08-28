var express = require('express');
var router = express.Router({mergeParams: true});

const boardRouter = require('./board');
const userRouter = require('./users');

router.use('/boards', boardRouter);
router.use('/users', userRouter);

module.exports = router;
