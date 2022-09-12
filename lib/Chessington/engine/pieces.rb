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

      # checks if the piece is obstructed # TODO: add the push to list here too?
      def obstructed_move?(board, move_square)
        if board.get_piece(move_square).nil?
          false
        else
          true
        end
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
            # maybe outsource all this junk into a new method
            new_position = Square.at(current_square.row + 2, current_square.column)
            unless obstructed_move?(board, new_position)
              available_moves.push(new_position)
            end
          end
          new_position = Square.at(current_square.row + 1, current_square.column)
          unless obstructed_move?(board, new_position)
            available_moves.push(new_position)
          end
        else
          if current_square.row == 6
            new_position = Square.at(current_square.row - 2, current_square.column)
            unless obstructed_move?(board, new_position)
              available_moves.push(new_position)
            end
          end
          new_position = Square.at(current_square.row - 1, current_square.column)
          unless obstructed_move?(board, new_position)
            available_moves.push(new_position)
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
