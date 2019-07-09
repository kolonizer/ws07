math.randomseed(os.time())
inspect=require "inspect"
gen=require "generate"
k=13 --корень из максимального числа лута это для ошибки(если number_of_loot>k^2 то будет ошибка,без k прога зависнет) 
--n = 5    -- размер сетки         ___KACTblJIb___=castl
--ws= 1               --
--Ls = 31   --loot size размер лута             
--size = k*Ls            -- ширина внутренней полости комнаты
local function AddLotLoot(id,castl)
	print('qqqqqqqqqqqqqq')
	--ширина стенки комнаты
	local Q={}                 --комната\	
	Q.x= (id%n)  --x
	if Q.x==0 then
		Q.x = n
	end
	Q.y= ((id-Q.x)/n)*(size+2*ws)        --y
	Q.x=(Q.x-1)*(size+2*ws)
	--print(Q.x,Q.y)
	Q.h= size +2*ws      -- длина
	--Q[4]= size +2*ws      -- высота
	T={}
	local qwerty={}         --разновидность лута(пока рандомная)
	qwer=math.random(1,100)
	d=math.random((size/Ls)*(size/Ls))
	
	while (castl[id].T[d]==1) do
		d=math.random((size/Ls)*(size/Ls))
	end
	castl[id].T[d]=1
	
	castl[id].loot[#castl[id].loot+1]={id=d,tip=qwer}
end
local function drawLoot(tab,castl) 
	--love.graphics.setBackgroundColor( 255, 255, 255, 100 )
	--love.graphics.setColor( 0,0, 0, 255 )
	--love.graphics.rectangle("line",Q.x,Q.y,Q.h,Q.h)
	--print(inspect( castl, { depth = 5 } ) )
	for i=1,#tab do
		for o=1,#castl[tab[i]].loot do
			--print(inspect(castl[i].loot[o], { depth = 2 } ) )
			local e_x= (castl[tab[i]].loot[o].id%n)  --x
			if e_x==0 then
				e_x = n
			end
			local e_y= ((castl[tab[i]].loot[o].id-e_x-1)/n)*Ls        --y
			e_x=(e_x-1)*Ls
			e_x=e_x+castl[tab[i]].x_pix
			e_y=e_y+castl[tab[i]].y_pix
			--print(castl[tab[i]].loot[o].tip)
			if castl[tab[i]].loot[o].tip<= 5 then
				love.graphics.setColor( 250,250, 0, 200 )  --желтый 5%
			elseif castl[tab[i]].loot[o].tip<=20 then
				love.graphics.setColor( 250,0, 0, 200 )    --красный 15%
			elseif castl[tab[i]].loot[o].tip<=30 then
				love.graphics.setColor( 0,150, 0, 200 )     --зеленый 10%
			elseif castl[tab[i]].loot[o].tip<=55 then
				love.graphics.setColor( 0,0, 250, 200 )     --синий 25%
			elseif castl[tab[i]].loot[o].tip<=100 then                  
				love.graphics.setColor( 255,255, 255, 255 )        --белый 45%
			end
			love.graphics.rectangle("fill",e_x,e_y,Ls,Ls)
		end
	end
end
--love.graphics.rectangle("fill",Q.x+Ls*(x-1)+ws,Q.y+Ls*(y)+ws,Ls,Ls)
--print(x,y)
--function love.draw()
--	drawLoot()
--end
return {AddLotLoot=AddLotLoot,drawLoot=drawLoot}