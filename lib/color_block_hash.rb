require 'rgl/adjacency'
require 'rgl/transitivity'
require 'rgl/connected_components'
require 'rgl/traversal'

module Piet
  class ColorBlockHash < ::Hash
    def self.from_array(arr)
      coords = []
      graph = RGL::DirectedAdjacencyGraph.new
      arr.each_with_index do |row, y|
        row.each_with_index do |column, x|
          coords << coord = [x, y]
          graph.add_edge(coord, coord)
          graph.add_edge(coord, [x+1, y]) if right_neighbor_match?(x, y, arr)
          graph.add_edge(coord, [x-1, y]) if left_neighbor_match?(x, y, arr)
          graph.add_edge(coord, [x, y+1]) if bottom_neighbor_match?(x, y, arr)
          graph.add_edge(coord, [x, y-1]) if top_neighbor_match?(x, y, arr)
        end
      end

      path_closure = graph.transitive_closure

      coords.inject(self.new) do |hash, coord|
        hash[coord] = path_closure.each_adjacent(coord).length
        hash
      end

    end

    private

    def self.right_neighbor_match?(x, y, arr)
      row = arr[y]
      x + 1 < row.length && row[x] == row[x+1]
    end
    def self.left_neighbor_match?(x, y, arr)
      row = arr[y]
      x - 1 >= 0 && row[x] == row[x-1]
    end
    def self.bottom_neighbor_match?(x, y, arr)
      y + 1 < arr.length && arr[y+1][x] == arr[y][x]
    end
    def self.top_neighbor_match?(x, y, arr)
      y - 1 >= 0 && arr[y-1][x] == arr[y][x]
    end

  end
end