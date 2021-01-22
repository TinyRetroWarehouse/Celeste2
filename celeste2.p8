pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- globals
room = 0
objects = {}

function _init()
	room_load(0)
end
-->8
function _update()
	for i = 1, #objects do
		objects[i]:update()
	end
end
-->8
function _draw()
	cls()
	map((room % 4) * 16, (room / 4) * 16, 0, 0, 16, 16, 1)

	for i=1,#objects do
		local o = objects[i]
		if (o.spr != nil) then
			spr(o.spr, o.x, o.y)
		end
	end
end
-->8
lookup = {}
lookup.__index = function(self, i) return self.base[i] end

object = {}
object.move_x = function(self, x)
	self.x += x
end
object.move_y = function(self, y)
	self.y += y
end

player = {}
player.tile = 2
player.base = object
player.init = function(self)
	self.spr = self.tile
end
player.update = function(self) 
	if (not solid_at(self.x, self.y + 1, 8, 8)) then
		self.y += 1
	end
end
setmetatable(player, lookup)

function create(type, x, y)
	local obj = {}
	obj.base = type
	obj.x = x
	obj.y = y
	setmetatable(obj, lookup)
	add(objects, obj)
	if (obj.init) then obj.init(obj) end
	return obj
end

function solid_at(x, y, w, h)
	for i = flr(x / 8),flr((x + w) / 8) do
		for j = flr(y / 8),flr((y + h) / 8) do
			if (fget(room_tile_at(i, j), 1)) then
				return true
			end
		end
	end

	return false
end

-- gets the tile at the given location in the CURRENT room
function room_tile_at(x, y)
	return mget((room % 4) * 16 + x, (room / 4) * 16 + y)
end

-- loads the given room
function room_load(index)
	room = index
	objects = {}

	local rx = (room % 4) * 16
	local ry = (room / 4) * 16
	for i = 0,15 do
		for j = 0,15 do
			if (mget(rx + i, ry + j) == player.tile) then
				create(player, i * 8, j * 8)
			end
		end
	end
end

__gfx__
00000000777777770888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000070808880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700722222070888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000722222070888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000722222070888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700722222070888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000722222070880088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770880088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000002000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010100000101010100000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010100000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
