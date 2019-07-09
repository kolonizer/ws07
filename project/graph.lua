function graphInit(name)
    local graph = { name = name, vertexes = {}, edges = {} }
    return graph
end
function graphAddVertex(graph, vert)
    graph.vertexes[#graph.vertexes + 1] = vert
    local n = #graph.vertexes
    for i = 1, n do
        if not graph.edges[n] then
            graph.edges[n] = {}
        end
        graph.edges[i][n] = 0
        graph.edges[n][i] = 0
    end
end
function GetN(graph, vert)
    for i = 1, #graph.vertexes do
        if graph.vertexes[i].name == vert then
            return i
        end
    end
    error("This vertex not in graph")
end
function graphConnectVertex(graph, vert1, vert2)
    graph.edges[GetN(graph, vert1)][GetN(graph, vert2)] = 1
    graph.edges[GetN(graph, vert2)][GetN(graph, vert1)] = 1
end
function graphRemoveVert(graph, vert)
    local n = GetN(graph, vert)
    for i = 1, #graph.vertexes do
        table.remove(graph.edges[i], n)
    end
    table.remove(graph.edges, n)
    table.remove(graph.vertexes, n)
end
function graphConnected(graph, vert1, vert2)
    if vert1 == vert2 then
        error("You can't connect two identical vertexes")
    end
    if graph.edges[GetN(graph, vert1)][GetN(graph, vert2)] == 1 then
        return true
    else
        return false
    end
end
function graphContainsVert(graph, vert)
    for i = 1, #graph.vertexes do
        if graph.vertexes[i][1] == vert then
            return true
        end
    end
    return false
end
function printGraph(graph)
    for i = 1, #graph.vertexes do
        a = ""
        for j = 1, #graph.vertexes do
            a = a .. graph.edges[i][j] .. " "
        end
        print(a)
    end
end
--[[g = graphInit("G1")
graphAddVertex(g,{name="v1"})
graphAddVertex(g,{name="v2"})
graphAddVertex(g,{name="v3"})
graphConnectVertex(g,'v1','v2')
print(graphConnected(g,'v1','v2'))
print(graphConnected(g,'v1','v3'))
printGraph(g)
graphRemoveVert(g,"v3")
printGraph(g)
print(graphContainsVert(g,"v4"))
print(graphContainsVert(g,"v2"))--]]