inspect=require "inspect"
--gra="GraphFunctions"
--level=gra.graphInit('level')

function bliz(x,y)
	while true do
		local A={}
		local number=(y-1)*n+x
		if x>=2 then
			A[#A+1]=number-1;end
		if x<=n-1 then
			A[#A+1]=number+1;end
		if y>=2 then
			A[#A+1]=number-n;end
		if y<=n-1 then
			A[#A+1]=number+n;end
		norm_id=A[math.random(#A)]
		q_x=norm_id%n
		if q_x==0 then
			q_x=n
		end
		q_y=(norm_id-q_x)/n-1
		kal=0
		print(norm_id)
		if q_x>=2 and norm_id-1>0 and norm_id-1<=n*n then
			if castl[norm_id-1].use then
				kal=kal+1
			end
		end
		if q_x<=n-1 and norm_id+1>0 and norm_id+1<=n*n   then
			if castl[norm_id+1].use then
				kal=kal+1
			end
		end
		if q_y>=2 and norm_id-n>0 and norm_id-n<=n*n then
			if castl[norm_id-n].use then
				kal=kal+1
			end
		end
		if q_y<=n-1 and norm_id+n>0 and norm_id+n<=n*n then
			if castl[norm_id+n].use then
				kal=kal+1
			end
		end
		
		chans=math.random(1,100)
		if kal==1 then
			return norm_id
		end
		if kal==2 then
			if chans<=50 then
				return norm_id
			end
		end
		if kal==3 then
			if chans<=5 then
				return norm_id
			end
		end
		if kal==4 then
			if chans<=3 then
				return norm_id
			end
		end
	end
end

function schet()
	local q=0
	for i=1,#castl do
		if castl[i].use then
			q=q+1
		end
	end
	return q
end

function poisk(w)
	--print("!!!")
	local q=0
	for i=1,#castl do
		if castl[i].use==true then
			--print(castl[i].x..castl[i].y)
			if q+1==w then
				--print(inspect( castl[i], { depth = 2 } ) )
				return castl[i].id,castl[i].x,castl[i].y
			end
			q=q+1
		end
	end
	return -1, -1, -1
end

function generate()
	castl={}
	graph={}

	for yc=1,n do
	    for xc=1,n do
	    	castl[(yc-1)*n+xc]={x_pix=xc*size,y_pix=yc*size,loot={},x=xc,y=yc,tip=-1,id=(yc-1)*n+xc,use=false}--{xc,yc,-1,(xc-1)*n+yc,false}
	    end
    end
    for xc=1,#castl,1 do
	    graph[xc]={}
	    for yc=1,#castl,1 do
	    	graph[xc][yc]=0
	    end
    end
	if n%2==1 then
		castl[(n-1)/2*(n+1)+1].use=true
	else
		castl[(n/2-1)*n+n/2].use=true
	end
	Dours={}
	for i=1,math.random((n-4)*(n-3),(n-3)*(n-3)),1 do
		while true do
			local verch,wx,wy=poisk(math.random(1,schet()))
			local q_id=bliz(castl[verch].x,castl[verch].y)
			if graph[verch][q_id]==0 then
				if (castl[q_id].use and math.random(1,4)==1) or castl[q_id].use==false  then
					if math.random(1,4)==1 then
						graph[verch][q_id]=2
						graph[q_id][verch]=2
					else
						graph[verch][q_id]=1
						graph[q_id][verch]=1
					end
					Dours[#Dours+1]={verch,q_id,graph[verch][q_id]}
					--print(verch,q_id,graph[verch][q_id])
					castl[q_id].use=true
					break
				end
			end
		end
		--print(inspect( graph, { depth = 2 } ) )
	end
	return castl,graph,Dours
end
return {generate=generate}