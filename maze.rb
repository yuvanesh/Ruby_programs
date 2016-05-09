class Maze

  def initialize(maze)
  	@maze = maze.split("\n")
  	@start_i = find_i("A")
  	@start_j = find_j("A")
  	@end_i = find_i("B")
  	@end_j = find_j("B")
  	@max = @maze.length*@maze[0].length+1
  	@final_map = Array.new(maze.length) { Array.new(maze[0].length)  }
  	for i in 0...@maze.length
  	  for j in 0...@maze[0].length
  	  	@final_map[i][j] = @max
  	  	@final_map[i][j] = "#" if @maze[i][j] == "#"
  	  end
  	end
  	@final_map[@start_i][@start_j] = 0

  	solve_maze(@start_i,@start_j,0)
  end


  def path_exists(i,j)
  	return "No" if i<0 || i>=@maze.length || j<0 || j>=@maze[0].length || @final_map == "#"
  	return "Yes"
  end


  def solve_maze(i,j,old_plus_one)
  	return if  path_exists(i,j) == "No" || old_plus_one > @final_map[i][j].to_i
  	@final_map[i][j] = old_plus_one
  	solve_maze(i-1,j,old_plus_one+1)
  	solve_maze(i+1,j,old_plus_one+1)
  	solve_maze(i,j-1,old_plus_one+1)
  	solve_maze(i,j+1,old_plus_one+1)
  	return
  end


  def find_i(elt)
  	for i in 0...@maze.length
  	  for j in 0...@maze[0].length
  	  	return i if @maze[i][j] == elt
  	  end
  	end
  end


  def find_j(elt)
  	for i in 0...@maze.length
  	  for j in 0...@maze[0].length
  	  	return j if @maze[i][j] == elt
  	  end
  	end
  end


  def min(a,b)
  	return a.to_i>b.to_i ? b : a
  end


  def solvable
  	return @final_map[@end_i][@end_j] < @max ? true : false
  end

  def steps
  	return @final_map[@end_i][@end_j] < @max ? @final_map[@end_i][@end_j] : "Not Possible"
  end


end


MAZE1 = %{#####################################
# #   #     #A        #     #       #
# # # # # # ####### # ### # ####### #
# # #   # #         #     # #       #
# ##### # ################# # #######
#     # #       #   #     # #   #   #
##### ##### ### ### # ### # # # # # #
#   #     #   # #   #  B# # # #   # #
# # ##### ##### # # ### # # ####### #
# #     # #   # # #   # # # #       #
# ### ### # # # # ##### # # # ##### #
#   #       #   #       #     #     #
#####################################}



MAZE2 = %{#####
#A #B
## # 
     
}


MAZE3 = %{#####################################
# #   #           #                 #
# ### # ####### # # # ############# #
#   #   #     # #   # #     #     # #
### ##### ### ####### # ##### ### # #
# #       # #  A  #   #       #   # #
# ######### ##### # ####### ### ### #
#               ###       # # # #   #
# ### ### ####### ####### # # # # ###
# # # #   #     #B#   #   # # #   # #
# # # ##### ### # # # # ### # ##### #
#   #         #     #   #           #
#####################################}


MAZE4 = %{#####################################
# #       #             #     #     #
# ### ### # ########### ### # ##### #
# #   # #   #   #   #   #   #       #
# # ###A##### # # # # ### ###########
#   #   #     #   # # #   #         #
####### # ### ####### # ### ####### #
#       # #   #       # #       #   #
# ####### # # # ####### # ##### # # #
#       # # # #   #       #   # # # #
# ##### # # ##### ######### # ### # #
#     #   #                 #     #B#
#####################################}

maze1 = Maze.new(MAZE1)
maze2 = Maze.new(MAZE2)
maze3 = Maze.new(MAZE3)
maze4 = Maze.new(MAZE4)

puts maze1.solvable
puts maze1.steps

puts maze2.solvable
puts maze2.steps

puts maze3.solvable
puts maze3.steps

puts maze4.solvable
puts maze4.steps
