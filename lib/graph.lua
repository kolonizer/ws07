local Graph = {}
Graph.__index = Graph

function Graph.new(Name)
	local newGraph = {name = Name}
  newGraph.name = name
	setmetatable(newGraph, Graph)
	return newGraph
end

function Graph:addVertex(newVertex)
  self[newVertex] = {}
end

function Graph:Connect(vert1, vert2)
  self[vert1][vert2] = 1
end

function Graph:IsConnect(vert1, vert2)
  if self[vert1][vert2] == 1 then
    return true
  end
end

--[[Graph.new(kk)
Graph:addVertex(1)
Graph:addVertex(2)
Graph:Connect(1,2)
a = Graph:IsConnect(1,2)
print(a)--]]
