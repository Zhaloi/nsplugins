ITEM.name = "Door Breach"
ITEM.model = Model("models/props_wasteland/prison_padlock001a.mdl")
ITEM.desc = "Used to breach doors."

ITEM.functions = {}
ITEM.functions.Place = {
	alias = "Place Breach",
	icon = "icon16/tag_blue_edit.png",
	menuOnly = true,
	onRun = function(item)
	if (SERVER) then
		local client = item.player
		local raytrace = client:GetEyeTraceNoCursor()
		local door = raytrace.Entity
		
		if (IsValid(door)) then
			if (door:GetPos():Distance( client:GetPos() ) <= 128 ) then
				if (!IsValid(door.combinelock)) then
					if (door:GetClass() == "prop_door_rotating") then
					local angs = raytrace.HitNormal:Angle() + Angle(0, 0, 0)
					local pos = raytrace.HitPos + (raytrace.HitNormal * 1) + Vector( 0, 0, 0 )

					local breach = ents.Create("nut_breach")
					breach:SetPos(pos)
					breach:SetAngles(angs)
					breach:SetParent(door)
					breach:Spawn()
						timer.Simple(10, function() 
							nut.util.BlastDoor(door, pos)
						end)
					else
						nut.util.Notify("You cannot breach this.", client)
					end
				end
			end
		end
	end
	end
}