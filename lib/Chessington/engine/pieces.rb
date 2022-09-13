module Chessington
  module Engine
    ##
    # An abstract base class from which all pieces inherit.
    module Piece
      attr_reader :player

      def initialize(player)
        @player = player
      end

      ##
      #  Get all squares that the piece is allowed to move to.
      def available_moves(board)
        raise "Not implemented"
      end

      ##
      # Move this piece to the given square on the board.
      def move_to(board, new_square)
        current_square = board.find_piece(self)
        board.move_piece(current_square, new_square)
      end

      # checks if the move_square is obstructed in any way
      # intermediate squares is a list which holds all the squares we have to 'jump' over -
      # these must be clear for our move to be possible
      def add_unobstructed_move(board, available_moves, move_square, intermediate_squares = [])
        no_obstruction = true
        intermediate_squares.each { |square|
          unless board.get_piece(square).nil?
            no_obstruction = false
          end
        }
        if valid_move_square?(move_square)
          if board.get_piece(move_square).nil? && no_obstruction
            available_moves.push(move_square)
          end
        end
      end

      def valid_move_square?(move_square)
        ((move_square.row <= 7) && (move_square.row >= 0) && (move_square.column <= 7) && (move_square.column >= 0))
      end

      # capture squares is a list containing the possible capture squares
      def add_capture_moves(board, available_moves, capture_squares, current_player)
        capture_squares.each { |capture_square|
          # check if the move is valid
          if valid_move_square?(capture_square)
            # check if there is a piece at capture square
            unless board.get_piece(capture_square).nil?
              capture_piece = board.get_piece(capture_square)
              if capture_piece.player != current_player && !capture_piece.is_a?(King)
                available_moves.push(capture_square)
              end
            end
          end
        }
      end

    end

    ##
    # A class representing a chess pawn.
    class Pawn
      include Piece

      def available_moves(board)
        current_square = board.find_piece(self)
        available_moves = []
        if self.player == Player::WHITE
          if current_square.row == 1
            new_position = Square.at(current_square.row + 2, current_square.column)
            # must check we are not jumping over any pieces
            middle_tile = Square.at(current_square.row + 1, current_square.column)
            add_unobstructed_move(board, available_moves, new_position, [middle_tile])
          end
          if current_square.row != 7
            new_position = Square.at(current_square.row + 1, current_square.column)
            add_unobstructed_move(board, available_moves, new_position)
            # check for possible captures
            capture_squares = [Square.at(current_square.row + 1, current_square.column + 1), Square.at(current_square.row + 1, current_square.column - 1)]
            add_capture_moves(board, available_moves, capture_squares, self.player)
          end
        else
          if current_square.row == 6
            new_position = Square.at(current_square.row - 2, current_square.column)
            middle_tile = Square.at(current_square.row - 1, current_square.column)
            add_unobstructed_move(board, available_moves, new_position, [middle_tile])
          end
          if current_square.row != 0
            new_position = Square.at(current_square.row - 1, current_square.column)
            add_unobstructed_move(board, available_moves, new_position)
            # check for possible captures
            capture_squares = [Square.at(current_square.row - 1, current_square.column + 1), Square.at(current_square.row - 1, current_square.column - 1)]
            add_capture_moves(board, available_moves, capture_squares, self.player)
          end
        end
        available_moves
      end
    end

    ##
    # A class representing a chess knight.
    class Knight
      include Piece

      def available_moves(board)
        current_square = board.find_piece(self)
        available_moves = []
        new_position_list = [
          # Up and right
          Square.at(current_square.row + 2, current_square.column + 1),
          Square.at(current_square.row + 1, current_square.column + 2),
          # Down and right
          Square.at(current_square.row - 1, current_square.column + 2),
          Square.at(current_square.row - 2, current_square.column + 1),
          # Down and left
          Square.at(current_square.row - 2, current_square.column - 1),
          Square.at(current_square.row - 1, current_square.column - 2),
          # Up and left
          Square.at(current_square.row + 1, current_square.column - 2),
          Square.at(current_square.row + 2, current_square.column - 1)
        ]
        new_position_list.each { |new_position|
          add_unobstructed_move(board, available_moves, new_position)
        }
        add_capture_moves(board, available_moves, new_position_list, self.player)
        available_moves
      end
    end

    ##
    # A class representing a chess bishop.
    class Bishop
      include Piece

      def find_all_diagonal_moves_in_one_direction(current_square, row_modifier, column_modifier)
        current = current_square
        possible_moves = []
        while valid_move_square?(current)
          current = Square.at(current.row + row_modifier, current.column + column_modifier)
          if valid_move_square?(current)
            possible_moves.push(current)
          end
        end
        possible_moves
      end

      def find_possible_diagonal_moves(current_square)
        possible_moves_lists = []
        # Up + right moves
        possible_moves_lists.push(find_all_diagonal_moves_in_one_direction(current_square, 1, 1))
        # Down + right moves
        possible_moves_lists.push(find_all_diagonal_moves_in_one_direction(current_square, -1, 1))
        # Up + left moves
        possible_moves_lists.push(find_all_diagonal_moves_in_one_direction(current_square, 1, -1))
        # Down + left moves
        possible_moves_lists.push(find_all_diagonal_moves_in_one_direction(current_square, -1, -1))
        possible_moves_lists
      end

      def available_moves(board)
        current_square = board.find_piece(self)
        available_moves = []
        diagonal_moves_lists = find_possible_diagonal_moves(current_square)
        for move_list in diagonal_moves_lists
          for i in 0...move_list.length
            add_unobstructed_move(board, available_moves, move_list[i], move_list[0..i])
          end
          add_capture_moves(board, available_moves, move_list, self.player)
        end
        available_moves
      end
    end

    ##
    # A class representing a chess rook.
    class Rook
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess queen.
    class Queen
      include Piece

      def available_moves(board)
        []
      end
    end

    ##
    # A class representing a chess king.
    class King
      include Piece

      def available_moves(board)
        []
      end
    end
  end
end
