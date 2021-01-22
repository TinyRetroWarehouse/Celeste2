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
		objects[i]:draw()
	end

	print("CPU: " .. stat(1))
end

-->8

-- Objects:
#include object.lua
#include player.lua

crate = {}
crate.tile = 3
crate.base = object
crate.geom = g_solid
crate.init = function(self)
	self.spr = self.tile
end
crate.update = function(self) 
	self:move_y(1)
end

setmetatable(crate, lookup)
add(types, crate)

-->8

-- gets the tile at the given location in the CURRENT room
function room_tile_at(x, y)
	return mget((room % 4) * 16 + x, (room / 4) * 16 + y)
end

-- loads the given room
function room_load(index)
	room = index
	objects = {}

	for i = 0,15 do
		for j = 0,15 do
			for n=1,#types do
				if (room_tile_at(i, j) == types[n].tile) then
					create(types[n], i * 8, j * 8)
				end
			end
		end
	end
end

function sign(x)
	if (x < 0) then
		return -1
	elseif (x > 0) then
		return 1
	else
		return 0
	end
end

__gfx__
00000000777777770888888099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000070808880090000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700722222070888888090400409000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000722222070888888090440009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000722222070888888090044009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700722222070888888090404409000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000722222070880088090000009000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770880088099999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000300000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000300000300000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100030000000300000003000000030100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000300000000030000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000030100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000002000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000003000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0100000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010100000101010100000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010100000000000000000101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
