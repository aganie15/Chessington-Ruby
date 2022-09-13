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
        if board.get_piece(move_square).nil? && no_obstruction
          available_moves.push(move_square)
        end
        available_moves
      end

      # capture squares is a list containing the possible capture squares
      def add_capture_moves(board, available_moves, capture_squares, current_player)
        capture_squares.each { |capture_square|
          # check if there is a piece here
          unless board.get_piece(capture_square).nil?
            capture_piece = board.get_piece(capture_square)
            if capture_piece.player != current_player
              available_moves.push(capture_square)
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
        []
      end
    end

    ##
    # A class representing a chess bishop.
    class Bishop
      include Piece

      def available_moves(board)
        []
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
