function drawDour(d1,d2,Type)
	x1,y1=d1%n,math.floor(d1/n)+1
	x2,y2=d2%n,math.floor(d2/n)+1
	if x1==0 then
		x1,y1=n,y1-1
	end
	if x2==0 then
		x2,y2=n,y2-1
	end
	local widthLine = love.graphics.getLineWidth()
	if Type==1 then
		love.graphics.rectangle("fill",(x1+x2)/2*size-dourSize/2-size/2,(y1+y2)/2*size-dourSize/2-size/2,dourSize,dourSize)
	elseif Type==2 then
		love.graphics.rectangle("fill",(x1+x2)/2*size-size+1,(y1+y2)/2*size-size+1,size-2,size-2)
	end
end
function drawMiniMap()
    love.graphics.clear(255,255,255)
	q=0
	for y=0,(n-1)*size,size do
		for x=0,(n-1)*size,size do
			q=q+1
			if castl[q].use then
				love.graphics.setColor( 200,200,200,255)
				love.graphics.rectangle("fill",x,y,size,size)
				love.graphics.setColor( 0,0,0,255)
				love.graphics.rectangle("line",x,y,size,size)
			end
		end
	end
	love.graphics.setColor( 200,200,200,255)
	for i=1,#Dours do
		drawDour(Dours[i][1],Dours[i][2],Dours[i][3])
	end
end
return {drawMiniMap=drawMiniMap}