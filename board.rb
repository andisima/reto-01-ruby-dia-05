require_relative 'cell'
class Board
  # attr_reader :board
  # attr_writer :size
  def initialize
    @board = [[1,0,1,0], [1,0,1,1], [1,1,1,1], [0,1,0,1]]
    @size = 4
  end

  def dead_cell(status, alive_neighbours)
    status == false && alive_neighbours == 3 ? 1 : 0
  end

  def evaluate(row, column)
    cell = @board[row, column]
    status = Cell.new.alive?(cell)
    neighbours = neighbours(row, column)
    status && neighbours >=4 ? status = 0 : (status && neighbours >=2 ? status = 1 : (status && neighbours >=1 ? status = 0 : (!status && neighbours == 3 ? status = 1 : (nil))))
    @new_board
  end

  def new_board(row = 0, column = 0)
    row == @board.size-1 && column == @board.size ? (return @new_board) : (nil)
    @new_board[row][column] = evaluate(row, column)
  end

  def neighbours(row, column)
    neighbours = []
    inside_board?(row-1, column) ? (neighbours << @board [row-1] [column]) : (nil)
    inside_board?(row-1, column+1) ? (neighbours << @board [row-1] [column+1]) : (nil)
    inside_board?(row-1, column+1) ? (neighbours << @board [row-1] [column-1]) : (nil)
    inside_board?(row, column-1) ? (neighbours << @board [row] [column-1]) : (nil)
    inside_board?(row+1, column-1) ? (neighbours << @board [row+1] [column-1]) : (nil)
    inside_board?(row+1, column) ? (neighbours << @board [row+1] [column]) : (nil)
    inside_board?(row+1, column+1) ? (neighbours << @board [row+1] [column+1]) : (nil)
    inside_board?(row, column+1) ? (neighbours << @board [row] [column+1]) :(nil)
    neighbours.count(1)
    end

  def inside_board?(row, column)
    row < @size && row >= 0 && column < @size && column >= 0
  end

  def print_board #esto nos ayuda hacer la matrix en cuadrito
    @board.to_a.each {|r| puts r.inspect}
  end

  def create
    @new_board = []
    @size.times do |row|
      @new_board << []
      @size.times { |column| @new_board[row][column] = 0 }
    end
    # return @new_board
  end

  def read
    @new_board = create
    @board = new_board
  end
end

game = Board.new
game.print_board
game.read
puts "= "*50
game.print_board
