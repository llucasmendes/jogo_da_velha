class ArtificialPlayer {
  List<List<int>> board;

  ArtificialPlayer({
    required this.board,
  });

  List<int> getTheBestMove() {
    Move bestMove = findBestMove(board);
    return [bestMove.row, bestMove.col];
  }
}

class Move {
  int row = 0;
  int col = 0;
}

int max(int num1, int num2) {
  return (num1 > num2) ? num1 : num2;
}

int min(int num1, int num2) {
  return (num1 > num2) ? num2 : num1;
}

int player = -1, opponent = 1;

bool isMovesLeft(List<List<int>> board) {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        return true;
      }
    }
  }

  return false;
}

int evaluate(List<List<int>> b) {
  for (int row = 0; row < 3; row++) {
    if (b[row][0] == b[row][1] && b[row][1] == b[row][2]) {
      if (b[row][0] == player) {
        return 10;
      } else if (b[row][0] == opponent) {
        return -10;
      }
    }
  }

  for (int col = 0; col < 3; col++) {
    if (b[0][col] == b[1][col] && b[1][col] == b[2][col]) {
      if (b[0][col] == player) {
        return 10;
      } else if (b[0][col] == opponent) {
        return -10;
      }
    }
  }

  if (b[0][0] == b[1][1] && b[1][1] == b[2][2]) {
    if (b[0][0] == player) {
      return 10;
    } else if (b[0][0] == opponent) {
      return -10;
    }
  }

  if (b[0][2] == b[1][1] && b[1][1] == b[2][0]) {
    if (b[0][2] == player) {
      return 10;
    } else if (b[0][2] == opponent) {
      return -10;
    }
  }

  return 0;
}

int minimax(List<List<int>> board, int depth, bool isMax) {
  int score = evaluate(board);

  if (score == 10) {
    return score;
  }

  if (score == -10) {
    return score;
  }

  if (isMovesLeft(board) == false) {
    return 0;
  }

  if (isMax) {
    int best = -1000;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == 0) {
          board[i][j] = player;

          best = max(best, minimax(board, depth + 1, !isMax));

          board[i][j] = 0;
        }
      }
    }
    return best;
  } else {
    int best = 1000;

    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == 0) {
          board[i][j] = opponent;

          best = min(best, minimax(board, depth + 1, !isMax));

          board[i][j] = 0;
        }
      }
    }
    return best;
  }
}

Move findBestMove(List<List<int>> board) {
  int bestVal = -1000;
  Move bestMove = Move();
  bestMove.row = 0;
  bestMove.col = 0;

  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (board[i][j] == 0) {
        board[i][j] = player;

        int moveVal = minimax(board, 0, false);

        board[i][j] = 0;

        if (moveVal > bestVal) {
          bestMove.row = i;
          bestMove.col = j;
          bestVal = moveVal;
        }
      }
    }
  }

  return bestMove;
}
