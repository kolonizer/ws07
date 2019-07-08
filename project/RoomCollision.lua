function containElem(g,n)
	for i=1,#g do
		if g[i]==n then
			return true
		end
	end
	return false
end
function neighbours(visited)
	local A={}
	for i=1,#visited do
		if visited[i]-1>=0 and graph[visited[i]][visited[i]-1]==1 and containElem(A,visited[i]-1)==false then
			A[#A+1]=visited[i]-1
		end
		if visited[i]+1>=0 and graph[visited[i]][visited[i]+1]==1 and containElem(A,visited[i]+1)==false then
			A[#A+1]=visited[i]+1
		end
		if visited[i]-n>=0 and graph[visited[i]][visited[i]-n]==1 and containElem(A,visited[i]-n)==false then
			A[#A+1]=visited[i]-n
		end
		if visited[i]+n>=0 and graph[visited[i]][visited[i]+n]==1 and containElem(A,visited[i]+n)==false then
			A[#A+1]=visited[i]+n
		end
	end
	return A
end
function dfs(graph,id,n,x,y,size,w,q,colour)
	visited[#visited+1]=id
	if (id-1>=0 and graph[id][id-1]==0 and containElem(visited,id-1)==false) or id%n==1 then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x-size/2,y=y,wigth=w,height=size+w,colour=colour}
	end
    if (id+1<=n^2 and graph[id][id+1]==0 and containElem(visited,id+1)==false) or id%n==0 then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x+size/2,y=y,wigth=w,height=size+w,colour=colour}
	end
	if (id-n>=0 and graph[id][id-n]==0 and containElem(visited,id-n)==false) or id<=n then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x,y=y-size/2,wigth=size+w,height=w,colour=colour}
	end
	if (id+n<=n^2 and graph[id][id+n]==0 and containElem(visited,id+n)==false) or id>=n*(n-1)+1 then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x,y=y+size/2,wigth=size+w,height=w,colour=colour}
	end
	if id-1>=0 and graph[id][id-1]==1 and containElem(visited,id-1)==false then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x-size/2,y=y-size*(q+1)/4/q,wigth=w,height=size*(q-1)/2/q+w,colour=colour}
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x-size/2,y=y+size*(q+1)/4/q,wigth=w,height=size*(q-1)/2/q+w,colour=colour}
	end
	if id+1<=n^2 and graph[id][id+1]==1 and containElem(visited,id+1)==false then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x+size/2,y=y-size*(q+1)/4/q,wigth=w,height=size*(q-1)/2/q+w,colour=colour}
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x+size/2,y=y+size*(q+1)/4/q,wigth=w,height=size*(q-1)/2/q+w,colour=colour}
	end
	if id-n>=0 and graph[id][id-n]==1 and containElem(visited,id-n)==false then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x-size*(q+1)/4/q,y=y-size/2,wigth=size*(q-1)/2/q+w,height=w,colour=colour}
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x+size*(q+1)/4/q,y=y-size/2,wigth=size*(q-1)/2/q+w,height=w,colour=colour}
	end
	if id+n<=n^2 and graph[id][id+n]==1 and containElem(visited,id+n)==false then
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x-size*(q+1)/4/q,y=y+size/2,wigth=size*(q-1)/2/q+w,height=w,colour=colour}
		Objects[#Objects+1]={Type="rectangle",mode="line",x=x+size*(q+1)/4/q,y=y+size/2,wigth=size*(q-1)/2/q+w,height=w,colour=colour}
	end
	if id-1>=0 and graph[id][id-1]==2 and containElem(visited,id-1)==false then
		dfs(graph,id-1,n,x-size,y,size,w,q,colour)
	end
	if id+1<=n^2 and graph[id][id+1]==2 and containElem(visited,id+1)==false then
		dfs(graph,id+1,n,x+size,y,size,w,q,colour)
	end
	if id-n>=0 and graph[id][id-n]==2 and containElem(visited,id-n)==false then
		dfs(graph,id-n,n,x,y-size,size,w,q,colour)
	end
	if id+n<=n^2 and graph[id][id+n]==2 and containElem(visited,id+n)==false then
		dfs(graph,id+n,n,x,y+size,size,w,q,colour)
	end
end
return {dfs=dfs}
