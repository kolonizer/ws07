math.randomseed(os.time())
inspect=require "inspect"
gen=require "generate"
collide=require "collide"
local function AddLotLoot(id,castl)
	k = (size-2*ws)/Ls
	local Q={}
	Q.x= (id%k)
	if Q.x==0 then
		Q.x = k
	end
	Q.y= collide.XYFromID(id)[2] * size 
	Q.x= collide.XYFromID(id)[1] * size  
	Q.h= size      -- длина
	T={}
	local qwerty={}
	qwer=math.random(1,100)
	d=math.random(((size-2*ws)/Ls)*((size-2*ws)/Ls))
	while (castl[id].T[d]==1) do
		d=math.random(((size-2*ws)/Ls)*((size-2*ws)/Ls))
	end
	castl[id].T[d]=1	
	castl[id].loot[#castl[id].loot+1]={id=d,number=qwer,tip=range[qwer][2]}
end
local function drawLoot(tab,castl) 
	for i=1,#tab do
		for o=1,#castl[tab[i]].loot do
			local e_x= (castl[tab[i]].loot[o].id%k)  --x
			if e_x==0 then
				e_x = k
			end
			local e_y= ((castl[tab[i]].loot[o].id-e_x-1)/k)*Ls        --y
			e_x=(e_x-1)*Ls
			e_x=e_x+castl[tab[i]].x_pix +ws
			e_y=e_y+castl[tab[i]].y_pix +2*ws
			drawSpr(range[castl[tab[i]].loot[o].number][1],e_x,e_y)
		end
	end
end
return {AddLotLoot=AddLotLoot,drawLoot=drawLoot}