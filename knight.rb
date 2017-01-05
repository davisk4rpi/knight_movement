class GameBoard
	attr_reader :board
	def initialize
		@board = board
	end

	def board
		game_board = []
		i = 0
		until i == 8
			j = 0
			until j == 8
				game_board << [i,j]
				j += 1
			end
			i += 1
		end
		game_board
	end

end

class Knight
	attr_accessor :value, :chain, :parent

	def initialize(value, parent = nil, chain = [value])
		@value = value
		@parent = parent
		@chain = chain
	end
end

def knight_moves(start, finish)
	root = Knight.new(start)
	fastest = breadth_first_search(root, finish)
	puts "\nTo move from #{start} to #{finish} move your piece in this order:\n#{fastest}\n"
end

def breadth_first_search (root, value)
	queue = [root]
	board = GameBoard.new.board
	queue.each do |node|
		return node.chain if node.value == value
		potential_moves = [[-1,-2],[-1,2],[1,2],[1,-2],[-2,-1],[-2,1],[2,1],[2,-1]]
		potential_moves.each_with_index do | move, i |
			new_move = [node.value[0] + move[0], node.value[1] + move[1]] 
			if board.include? new_move
				unless node.chain.include? new_move	
					x = Knight.new(new_move, node)
					x.chain = x.parent.chain + [x.value]
					queue << x
				end
			end
		end
	end
	return Knight.new(nil)
end

knight_moves([0,0], [1,2])
knight_moves([0,0], [3,3])
knight_moves([3,3], [0,0])
knight_moves([0,0], [1,4])