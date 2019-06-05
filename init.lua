local function on_timer(pos, elapsed)
	local node = minetest.get_node(pos)
	local basename = minetest.registered_nodes[node.name]

	if not basename then return end
	local objs   = minetest.get_objects_inside_radius(pos, 0.8)
	
	for _,obj in ipairs(objs) do
		if obj:is_player() then
			local objpos = obj:getpos()
			if objpos.y > pos.y-1 and objpos.y < pos.y then
					minetest.set_node(pos, {name = "air"})		
					minetest.after(0.8, function()
						pos.y = pos.y - 1
						minetest.set_node(pos, {name = "air"})
					end)							
			end				
		end
	end

	return true
end

minetest.register_node("tnt_run:runblock", {
	description = "Run Block",
	tiles = {"doors_blank.png"},
	groups = {not_in_creative_inventory = 1, fall_damage_add_percent = -100},
	paramtype = "light",
	drawtype = "nodebox",
	use_texture_alpha = true,
	light_source = 8,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	},
	-- selection_box = {
		-- type = "fixed",
		-- fixed = {-0.5, -0.5, -0.5, 0.5, -0.5, 0.5},
	-- },
	pointable = false,
	on_timer = on_timer,
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(0.1)
	end,	
})