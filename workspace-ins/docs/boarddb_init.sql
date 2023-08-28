INSERT INTO user (name, email, password) VALUES ('kim', 'kim@bbb', 123);
INSERT INTO user (name, email, password) VALUES ('lee', 'lee@bbb', 456);

INSERT INTO board (title, content, userId) VALUES ('샘플1', '샘플 데이터1', 1);
INSERT INTO board (title, content, userId) VALUES ('샘플2', '샘플 데이터2', 2);

INSERT INTO board_comment (boardId, content, userId) VALUES (1, '댓글1', 1);
INSERT INTO board_comment (boardId, content, userId) VALUES (1, '댓글2', 2);
INSERT INTO board_comment (boardId, content, userId) VALUES (2, '댓글3', 1);
INSERT INTO board_comment (boardId, content, userId) VALUES (2, '댓글4', 1);