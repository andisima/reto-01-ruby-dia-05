require 'matrix'
load 'cell.rb'

class Board
  def initialize
  end

  def build
    @size = 10
    @board = Matrix.build(@size){rand (0..1)}
  end

  def read
    temp_board = @board.dup
    (0..9).each do |row|
      (0..9).each do |column|
        cell = @board[row, column]
        status = Cell.new.alive?(cell)
        alive_neighbours = neighbours(row,column)
        status && alive_neighbours >=4 ?
          temp_board[row, column] = 0 : status && alive_neighbours >=2 ?
          temp_board[row, column] = 1 : status && alive_neighbours <=1 ?
          temp_board[row, column] = 0 : status == false && alive_neighbours == 3 ?
          temp_board[row, column] = 1 :
    @board = temp_board
  end

  def print_board
    # Esto nos ayuda para hacer la matrix en cuadrito
    @board.to_a.each {|r| puts r.inspect}
  end
  
  def neighbours(row, column)
    neighbours = []
    neighbours.push(@board[row-1, column]) if inside_board?(row-1, column)
    neighbours.push(@board[row-1, column+1]) if inside_board?(row-1, column+1)
    neighbours.push(@board[row, column+1]) if inside_board?(row, column+1)
    neighbours.push(@board[row+1, column+1]) if inside_board?(row+1, column+1)
    neighbours.push(@board[row+1, column]) if inside_board?(row+1, column)
    neighbours.push(@board[row+1, column-1]) if inside_board?(row+1, column-1)
    neighbours.push(@board[row, column-1]) if inside_board?(row, column-1)
    neighbours.push(@board[row-1, column-1]) if inside_board?(row-1, column-1)
    neighbours.count(1)
  end



  def inside_board?(row, column)
    row < @size && row >= 0 && column < @size && column >= 0
  end
end
end
end

class Matrix
  public :"[]=", :set_element, :set_component
end

board = Board.new

board.build
board.print_board
board.read
puts "="*50
board.print_board
