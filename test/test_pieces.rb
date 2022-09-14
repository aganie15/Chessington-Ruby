require_relative "test_helper"
require "Chessington/engine"

class TestPieces < Minitest::Test
  class TestPawn < Minitest::Test
    include Chessington::Engine

    def test_white_pawns_can_move_up_one_square

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(2, 4))
    end

    def test_black_pawns_can_move_down_one_square

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(5, 4))
    end

    def test_white_pawn_can_move_up_two_squares_if_not_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(1, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(3, 4))
    end

    def test_black_pawn_can_move_down_two_squares_if_not_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(6, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(4, 4))
    end

    def test_white_pawn_cannot_move_up_two_squares_if_already_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      starting_square = Square.at(1, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(2, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))

    end

    def test_black_pawn_cannot_move_down_two_squares_if_already_moved

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      starting_square = Square.at(6, 4)
      board.set_piece(starting_square, pawn)

      intermediate_square = Square.at(5, 4)
      pawn.move_to(board, intermediate_square)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))

    end

    def test_white_pawn_cannot_move_if_piece_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_black_pawn_cannot_move_if_piece_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(4, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_white_pawn_cannot_move_two_squares_if_piece_two_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(3, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)

    end

    def test_black_pawn_cannot_move_two_squares_if_piece_two_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(4, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, obstructing_square)

    end

    def test_white_pawn_cannot_move_two_squares_if_piece_one_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(1, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(2, 4)
      obstruction = Pawn.new(Player::BLACK)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(3, 4))

    end

    def test_black_pawn_cannot_move_two_squares_if_piece_one_in_front

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(6, 4)
      board.set_piece(pawn_square, pawn)

      obstructing_square = Square.at(5, 4)
      obstruction = Pawn.new(Player::WHITE)
      board.set_piece(obstructing_square, obstruction)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 4))

    end

    def test_white_pawn_cannot_move_at_top_of_board

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      square = Square.at(7, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_black_pawn_cannot_move_at_bottom_of_board

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      square = Square.at(0, 4)
      board.set_piece(square, pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_equal(moves.length, 0)

    end

    def test_white_pawns_can_capture_diagonally

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::BLACK)
      enemy1_square = Square.at(4, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::BLACK)
      enemy2_square = Square.at(4, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)

    end

    def test_black_pawns_can_capture_diagonally

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy1 = Pawn.new(Player::WHITE)
      enemy1_square = Square.at(2, 5)
      board.set_piece(enemy1_square, enemy1)

      enemy2 = Pawn.new(Player::WHITE)
      enemy2_square = Square.at(2, 3)
      board.set_piece(enemy2_square, enemy2)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, enemy1_square)
      assert_includes(moves, enemy2_square)

    end

    def test_white_pawns_cannot_move_diagonally_except_to_capture

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(4, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 3))
      refute_includes(moves, Square.at(4, 5))

    end

    def test_black_pawns_cannot_move_diagonally_except_to_capture

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(2, 5)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 3))
      refute_includes(moves, Square.at(2, 5))
    end

    def test_white_pawns_cannot_capture_king

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy_king = King.new(Player::BLACK)
      enemy_king_square = Square.at(4, 5)
      board.set_piece(enemy_king_square, enemy_king)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(4, 5))
    end

    def test_black_pawns_cannot_capture_king

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 4)
      board.set_piece(pawn_square, pawn)

      enemy_king = King.new(Player::BLACK)
      enemy_king_square = Square.at(2, 5)
      board.set_piece(enemy_king_square, enemy_king)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(2, 5))
    end

    def test_white_pawns_can_capture_en_passant

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(4, 5)
      board.set_piece(pawn_square, pawn)

      enemy_pawn = Pawn.new(Player::BLACK)
      enemy_pawn_square = Square.at(4, 4)
      board.set_piece(enemy_pawn_square, enemy_pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(5, 4))
    end

    def test_black_pawns_can_capture_en_passant

      # Arrange
      board = Board.empty
      pawn = Pawn.new(Player::BLACK)
      pawn_square = Square.at(3, 7)
      board.set_piece(pawn_square, pawn)

      enemy_pawn = Pawn.new(Player::WHITE)
      enemy_pawn_square = Square.at(3, 6)
      board.set_piece(enemy_pawn_square, enemy_pawn)

      # Act
      moves = pawn.available_moves(board)

      # Assert
      assert_includes(moves, Square.at(2, 6))
    end

    # EN PASSANT REQUIREMENTS
    # - The captured pawn must have moved two squares in one move,
    # landing right next to the capturing pawn.
    # - The en passant capture must be performed on the turn immediately
    # after the pawn being captured moves. If the player does not capture
    # en passant on that turn, they no longer can do it later.
    def test_white_pawn_can_only_capture_en_passant_when_requirements_above_are_fulfilled
      # Arrange
      board = Board.empty

      enemy_pawn = Pawn.new(Player::BLACK)
      enemy_pawn_square = Square.at(6, 4)
      board.set_piece(enemy_pawn_square, enemy_pawn)

      pawn = Pawn.new(Player::WHITE)
      pawn_square = Square.at(4, 5)
      board.set_piece(pawn_square, pawn)

      # Black pawn moves two squares in one move
      board.current_player = Player::BLACK
      board.move_piece(enemy_pawn_square, Square.at(4, 4))

      # Act
      moves_before = pawn.available_moves(board)

      friendly_pawn = Pawn.new(Player::WHITE)
      friendly_pawn_square = Square.at(3, 1)
      board.set_piece(friendly_pawn_square, friendly_pawn)
      board.move_piece(friendly_pawn_square, Square.at(4, 1))

      unrelated_enemy_pawn = Pawn.new(Player::BLACK)
      unrelated_enemy_pawn_square = Square.at(6, 0)
      board.set_piece(unrelated_enemy_pawn_square, unrelated_enemy_pawn)
      board.move_piece(unrelated_enemy_pawn_square, Square.at(5, 0))

      moves_after = pawn.available_moves(board)

      # Assert
      assert_includes(moves_before, Square.at(5, 4))
      refute_includes(moves_after, Square.at(5, 4))

    end

    def test_black_pawn_can_only_capture_en_passant_when_requirements_above_are_fulfilled
      # Arrange
      board = Board.empty

      enemy_pawn = Pawn.new(Player::WHITE)
      enemy_pawn_square = Square.at(1, 6)
      board.set_piece(enemy_pawn_square, enemy_pawn)

      pawn = Pawn.new(Player::BLACK) #b
      pawn_square = Square.at(3, 7)
      board.set_piece(pawn_square, pawn)

      # Black pawn moves two squares in one move
      board.current_player = Player::WHITE
      board.move_piece(enemy_pawn_square, Square.at(3, 6))

      # Act
      moves_before = pawn.available_moves(board)

      friendly_pawn = Pawn.new(Player::BLACK) # b
      friendly_pawn_square = Square.at(6, 0)
      board.set_piece(friendly_pawn_square, friendly_pawn)
      board.move_piece(friendly_pawn_square, Square.at(5, 0))

      unrelated_enemy_pawn = Pawn.new(Player::WHITE)
      unrelated_enemy_pawn_square = Square.at(6, 7)
      board.set_piece(unrelated_enemy_pawn_square, unrelated_enemy_pawn)
      board.move_piece(unrelated_enemy_pawn_square, Square.at(7, 7))

      moves_after = pawn.available_moves(board)

      # Assert
      assert_includes(moves_before, Square.at(2, 6))
      refute_includes(moves_after, Square.at(2, 6))

    end
  end

  class TestKnight < Minitest::Test
    include Chessington::Engine

    def test_white_knights_can_move_in_L_shape

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      knight_square = Square.at(4, 4)
      board.set_piece(knight_square, knight)

      # Act
      moves = knight.available_moves(board)

      # Assert
      # Up and right
      assert_includes(moves, Square.at(5, 6))
      assert_includes(moves, Square.at(6, 5))
      # Down and right
      assert_includes(moves, Square.at(3, 6))
      assert_includes(moves, Square.at(2, 5))
      # Down and left
      assert_includes(moves, Square.at(2, 3))
      assert_includes(moves, Square.at(3, 2))
      # Up and left
      assert_includes(moves, Square.at(5, 2))
      assert_includes(moves, Square.at(6, 3))

    end

    def test_black_knights_can_move_in_L_shape

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::BLACK)
      knight_square = Square.at(4, 4)
      board.set_piece(knight_square, knight)

      # Act
      moves = knight.available_moves(board)

      # Assert
      # Up and right
      assert_includes(moves, Square.at(5, 6))
      assert_includes(moves, Square.at(6, 5))
      # Down and right
      assert_includes(moves, Square.at(3, 6))
      assert_includes(moves, Square.at(2, 5))
      # Down and left
      assert_includes(moves, Square.at(2, 3))
      assert_includes(moves, Square.at(3, 2))
      # Up and left
      assert_includes(moves, Square.at(5, 2))
      assert_includes(moves, Square.at(6, 3))

    end

    def test_white_knight_can_only_move_if_unobstructed

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      knight_square = Square.at(4, 4)
      board.set_piece(knight_square, knight)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(2, 3)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = knight.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)

    end

    def test_black_knight_can_only_move_if_unobstructed

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      knight_square = Square.at(4, 4)
      board.set_piece(knight_square, knight)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(3, 6)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = knight.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)

    end

    def test_white_knight_can_capture_enemies

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      knight_square = Square.at(4, 4)
      board.set_piece(knight_square, knight)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(3, 6)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = knight.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_black_knight_can_capture_enemies

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::BLACK)
      knight_square = Square.at(4, 4)
      board.set_piece(knight_square, knight)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(5, 2)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = knight.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_knight_cannot_jump_off_board

      # Arrange
      board = Board.empty
      knight = Knight.new(Player::WHITE)
      knight_square = Square.at(7, 7)
      board.set_piece(knight_square, knight)

      # Act
      moves = knight.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(8, 9))
      refute_includes(moves, Square.at(9, 8))
      refute_includes(moves, Square.at(6, 9))
      refute_includes(moves, Square.at(9, 6))

    end
  end

  class TestBishop < Minitest::Test
    include Chessington::Engine

    def test_white_bishop_can_move_diagonally

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      bishop_square = Square.at(2, 3)
      board.set_piece(bishop_square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      # Down + left
      assert_includes(moves, Square.at(1, 2))
      assert_includes(moves, Square.at(0, 1))
      # Up + left
      assert_includes(moves, Square.at(3, 2))
      assert_includes(moves, Square.at(4, 1))
      assert_includes(moves, Square.at(5, 0))
      # Down + right
      assert_includes(moves, Square.at(1, 4))
      assert_includes(moves, Square.at(0, 5))
      # Up + right
      assert_includes(moves, Square.at(3, 4))
      assert_includes(moves, Square.at(4, 5))
      assert_includes(moves, Square.at(5, 6))
      assert_includes(moves, Square.at(6, 7))

    end

    def test_black_bishop_can_move_diagonally

      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      bishop_square = Square.at(2, 3)
      board.set_piece(bishop_square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      # Down + left
      assert_includes(moves, Square.at(1, 2))
      assert_includes(moves, Square.at(0, 1))
      # Up + left
      assert_includes(moves, Square.at(3, 2))
      assert_includes(moves, Square.at(4, 1))
      assert_includes(moves, Square.at(5, 0))
      # Down + right
      assert_includes(moves, Square.at(1, 4))
      assert_includes(moves, Square.at(0, 5))
      # Up + right
      assert_includes(moves, Square.at(3, 4))
      assert_includes(moves, Square.at(4, 5))
      assert_includes(moves, Square.at(5, 6))
      assert_includes(moves, Square.at(6, 7))

    end

    def test_white_bishop_cannot_move_if_obstructed
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      bishop_square = Square.at(2, 3)
      board.set_piece(bishop_square, bishop)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(3, 4)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
      refute_includes(moves, Square.at(4, 5))
      refute_includes(moves, Square.at(5, 6))
      refute_includes(moves, Square.at(6, 7))

    end

    def test_black_bishop_cannot_move_if_obstructed
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      bishop_square = Square.at(2, 3)
      board.set_piece(bishop_square, bishop)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(1, 2)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
      refute_includes(moves, Square.at(0, 1))

    end

    def test_white_bishop_cannot_leave_board
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      bishop_square = Square.at(7, 7)
      board.set_piece(bishop_square, bishop)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      refute_includes(moves, Square.at(8, 8))
      refute_includes(moves, Square.at(6, 8))
      refute_includes(moves, Square.at(8, 6))
      refute_includes(moves, Square.at(-1, -1))

    end

    def test_white_bishop_can_capture_in_diagonal_lines
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::WHITE)
      bishop_square = Square.at(2, 3)
      board.set_piece(bishop_square, bishop)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(5, 0)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_black_bishop_can_capture_in_diagonal_lines
      # Arrange
      board = Board.empty
      bishop = Bishop.new(Player::BLACK)
      bishop_square = Square.at(2, 3)
      board.set_piece(bishop_square, bishop)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 2)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = bishop.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end
  end

  class TestRook < Minitest::Test
    include Chessington::Engine

    def test_rook_can_move_in_straight_lines
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      rook_square = Square.at(4, 3)
      board.set_piece(rook_square, rook)

      # Act
      moves = rook.available_moves(board)

      # Assert
      # Right
      assert_includes(moves, Square.at(4, 4))
      assert_includes(moves, Square.at(4, 5))
      assert_includes(moves, Square.at(4, 6))
      assert_includes(moves, Square.at(4, 7))
      # Down
      assert_includes(moves, Square.at(3, 3))
      assert_includes(moves, Square.at(2, 3))
      assert_includes(moves, Square.at(1, 3))
      assert_includes(moves, Square.at(0, 3))
      # Left
      assert_includes(moves, Square.at(4, 2))
      assert_includes(moves, Square.at(4, 1))
      assert_includes(moves, Square.at(4, 0))
      # Up
      assert_includes(moves, Square.at(4, 5))
      assert_includes(moves, Square.at(4, 6))
      assert_includes(moves, Square.at(4, 7))

    end

    def test_white_rook_can_capture_in_straight_lines
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      rook_square = Square.at(4, 3)
      board.set_piece(rook_square, rook)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(4, 1)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_black_rook_can_capture_in_straight_lines
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::BLACK)
      rook_square = Square.at(4, 3)
      board.set_piece(rook_square, rook)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(1, 3)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = rook.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_rook_cannot_move_if_obstructed
      # Arrange
      board = Board.empty
      rook = Rook.new(Player::WHITE)
      rook_square = Square.at(4, 3)
      board.set_piece(rook_square, rook)

      friendly = Pawn.new(Player::WHITE)
      friendly_square = Square.at(3, 3)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = rook.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
      refute_includes(moves, Square.at(2, 3))
      refute_includes(moves, Square.at(1, 3))
      refute_includes(moves, Square.at(0, 3))

    end

  end

  class TestQueen < Minitest::Test
    include Chessington::Engine

    def test_queen_can_move_in_diagonal_and_straight_lines
      # Arrange
      board = Board.empty
      queen = Queen.new(Player::BLACK)
      queen_square = Square.at(5, 1)
      board.set_piece(queen_square, queen)

      # Act
      moves = queen.available_moves(board)

      # Assert
      # Diagonal lines
      # Down + left
      assert_includes(moves, Square.at(4, 0))
      # Up + left
      assert_includes(moves, Square.at(6, 0))
      # Down + right
      assert_includes(moves, Square.at(4, 2))
      assert_includes(moves, Square.at(3, 3))
      assert_includes(moves, Square.at(2, 4))
      assert_includes(moves, Square.at(1, 5))
      assert_includes(moves, Square.at(0, 6))
      # Up + right
      assert_includes(moves, Square.at(6, 2))
      assert_includes(moves, Square.at(7, 3))

      # Straight Lines
      # Right
      assert_includes(moves, Square.at(5, 2))
      assert_includes(moves, Square.at(5, 3))
      assert_includes(moves, Square.at(5, 4))
      assert_includes(moves, Square.at(5, 5))
      assert_includes(moves, Square.at(5, 6))
      assert_includes(moves, Square.at(5, 7))
      # Down
      assert_includes(moves, Square.at(4, 1))
      assert_includes(moves, Square.at(3, 1))
      assert_includes(moves, Square.at(2, 1))
      assert_includes(moves, Square.at(1, 1))
      assert_includes(moves, Square.at(0, 1))
      # Left
      assert_includes(moves, Square.at(5, 0))
      # Up
      assert_includes(moves, Square.at(6, 1))
      assert_includes(moves, Square.at(7, 1))

    end

    def test_queen_can_capture_in_diagonal_and_straight_lines
      # Arrange
      board = Board.empty
      queen = Queen.new(Player::WHITE)
      queen_square = Square.at(4, 6)
      board.set_piece(queen_square, queen)

      enemy = Pawn.new(Player::BLACK)
      enemy_square = Square.at(6, 4)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = queen.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)
    end

    def test_queen_cannot_move_if_obstructed
      # Arrange
      board = Board.empty
      queen = Queen.new(Player::BLACK)
      queen_square = Square.at(5, 1)
      board.set_piece(queen_square, queen)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(5, 4)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = queen.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
      refute_includes(moves, Square.at(5, 5))
      refute_includes(moves, Square.at(5, 6))
      refute_includes(moves, Square.at(5, 7))

    end

  end

  class TestKing < Minitest::Test
    include Chessington::Engine

    def test_king_can_move_by_one_square_in_all_directions
      # Arrange
      board = Board.empty
      king = King.new(Player::BLACK)
      king_square = Square.at(5, 1)
      board.set_piece(king_square, king)

      # Act
      moves = king.available_moves(board)

      # Assert
      # Up
      assert_includes(moves, Square.at(6, 1))
      # Up-right
      assert_includes(moves, Square.at(6, 2))
      # Right
      assert_includes(moves, Square.at(5, 2))
      # Down-right
      assert_includes(moves, Square.at(4, 2))
      # Down
      assert_includes(moves, Square.at(4, 1))
      # Down-left
      assert_includes(moves, Square.at(4, 0))
      # Left
      assert_includes(moves, Square.at(5, 0))
      # Up-left
      assert_includes(moves, Square.at(6, 0))

    end

    def test_king_can_move_by_one_square_in_all_directions
      # Arrange
      board = Board.empty
      king = King.new(Player::BLACK)
      king_square = Square.at(5, 1)
      board.set_piece(king_square, king)

      # Act
      moves = king.available_moves(board)

      # Assert
      # Up
      assert_includes(moves, Square.at(6, 1))
      # Up-right
      assert_includes(moves, Square.at(6, 2))
      # Right
      assert_includes(moves, Square.at(5, 2))
      # Down-right
      assert_includes(moves, Square.at(4, 2))
      # Down
      assert_includes(moves, Square.at(4, 1))
      # Down-left
      assert_includes(moves, Square.at(4, 0))
      # Left
      assert_includes(moves, Square.at(5, 0))
      # Up-left
      assert_includes(moves, Square.at(6, 0))

    end

    def test_king_can_capture_on_one_square_in_all_directions
      # Arrange
      board = Board.empty
      king = King.new(Player::BLACK)
      king_square = Square.at(3, 4)
      board.set_piece(king_square, king)

      enemy = Pawn.new(Player::WHITE)
      enemy_square = Square.at(4, 4)
      board.set_piece(enemy_square, enemy)

      # Act
      moves = king.available_moves(board)

      # Assert
      assert_includes(moves, enemy_square)

    end

    def test_king_cannot_move_if_obstructed
      # Arrange
      board = Board.empty
      king = King.new(Player::BLACK)
      king_square = Square.at(3, 4)
      board.set_piece(king_square, king)

      friendly = Pawn.new(Player::BLACK)
      friendly_square = Square.at(4, 4)
      board.set_piece(friendly_square, friendly)

      # Act
      moves = king.available_moves(board)

      # Assert
      refute_includes(moves, friendly_square)
      refute_includes(moves, Square.at(5, 4))
      refute_includes(moves, Square.at(6, 4))
      refute_includes(moves, Square.at(7, 4))

    end

  end

end
