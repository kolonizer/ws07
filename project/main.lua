
function love.load()
	collide=require "collide"
	control=require "control"
	draw=require "draw"
	gra=  require "generate"
	RoomCollision=require "RoomCollision"
	drawMiniMap=require "drawMiniMap"
	math.randomseed(os.time())

	siz =100
	n=10
	if n%2==1 then
		id=((n-1)/2)*n+(n+1)/2
		heroId=((n-1)/2)*n+(n+1)/2
	else
		id=(n/2-1)*n+n/2
		heroId=(n/2-1)*n+n/2
	end
	Mous={Type="circle",mode="line",x=(id%n)*siz+siz/2,y=(id%n)*siz+siz/2,radius=10}
	heroX=id%n
	heroY=math.floor(id/n)+1
	height = love.graphics.getHeight()
	size=height/n
	dourSize=size/5
	X=400
	Y=300
	castl,graph,Dours=gra.generate()
end
function love.draw()
	love.graphics.setColor( 255, 255, 255, 255 )
	love.graphics.print(math.floor(fps),780,0)
	love.graphics.print(heroId,0,0)
	love.graphics.print(heroX.." "..heroY,0,10)
	--love.graphics.print(X2.." "..Y2,0,20)
	if love.keyboard.isDown("tab") then
		drawMiniMap.drawMiniMap()
	else
		draw.draw(Objects)
	end
end
function love.update(dt)
	fps=1/dt
	local speed=150*dt
	local GrowthSpeed=100*dt
	Objects={Mous}
	visited={}
	heroX=(Mous.x-(Mous.x%siz))/siz
	heroY=(Mous.y-(Mous.y%siz))/siz
	heroId=(heroY-1)*n+heroX
	RoomCollision.dfs(graph,heroId,n,visited,heroX*siz+siz/2,heroY*siz+siz/2,siz,5,3)
	control.control("keyboard",speed,GrowthSpeed)
end