local keys = {}

KS_RELEASED = 1
KS_DOWN = 2
KS_UP = 3

function IsKeyDown(key)
	return keys[key] == KS_DOWN || keys[key] == KS_RELEASED
end

function IsKeyUp(key)
	return keys[key] == KS_UP
end

function WasKeyReleased(key)
	return keys[key] == KS_RELEASED
end

function WasKeyPressed(key)
	return keys[key] == KS_RELEASED
end

hook.Add("PlayerButtonDown", "HRP_DoorUiKeysDown", function (ply, btn)
	if !IsFirstTimePredicted() then
		return
	end
	
	keys[btn] = KS_DOWN
end)

hook.Add("PlayerButtonUp", "HRP_DoorUiKeysDown", function (ply, btn)
	if !IsFirstTimePredicted() then
		return
	end
	
	if keys[btn] == KS_DOWN then
		keys[btn] = KS_RELEASED
	else
		keys[btn] = KS_UP
	end
end)

hook.Add("PostRender", "HRP_KeysReset", function ()
	for i = 1, BUTTON_CODE_COUNT do
		if keys[i] == KS_RELEASED then
			keys[i] = KS_UP
		end
	end
end)