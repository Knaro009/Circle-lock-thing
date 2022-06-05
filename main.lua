--Not finished, Will add silent aim for dh when i feel like it --

--Services--
local ws = game:GetService("Workspace")
local ps = game:GetService("Players")
local cg = game:GetService("StarterGui")

--Yes--
local lp = ps.LocalPlayer
local char = lp.Character
local hrp = char:FindFirstChild("HumanoidRootPart")
local running = false
local locksettings = {
	["Target"] = nil,
	["Speed"] = 2,	
	["CircleLock"] = true,
	["Farness"] = 7
}

--UI stuff--
local uilib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Knaro009/Venyx-UI-Library/main/source.lua"))()
local main = uilib.new("DH Locks", 5013109572)
local homepage = main:addPage("Home", 5012544693)
local hpsec1 = homepage:addSection("Main")
local settingspage = main:addPage("Settings", 5012544693)
local spsec1 = settingspage:addSection("Main")

--Spin stuff--
local pi2 = math.pi * 2
local num = 0.1

--[[
Usefull stuff
main:Notify("Title", "text")


]]
--Functions--
local findplr = function(h)
	for i,v in pairs(ps:GetChildren()) do
		if string.sub(string.lower(v.DisplayName), 1, #h) == string.lower(h) then
			return v
		end
	end
end



--Main script--
hpsec1:addTextbox("Target", "Default", function(val, left)
	if left then
		main:Notify("Target", findplr(val).Name, function(h)
			if h == true then
				locksettings.Target = findplr(val)
				if locksettings.Target ~= "" and running == true then
					if locksettings.Target.Character:FindFirstChild("Humanoid") then
						ws.CurrentCamera.CameraSubject = locksettings.Target.Character.Humanoid
					else
						main:Notify("Error", "No Humanoid")
					end
				end
			else
				locksettings.Target = nil
			end
		end)
	end
end)

hpsec1:addButton("Start", function()
	if locksettings.Target ~= "" then
		running = true
		if locksettings.Target.Character:FindFirstChild("Humanoid") then
			ws.CurrentCamera.CameraSubject = locksettings.Target.Character.Humanoid
		else
			main:Notify("Error", "No Humanoid")
		end
	elseif locksettings.Target == "" then
		main:Notify("No target", "Please set a target in the settings page.")
	end
end)

hpsec1:addButton("Stop", function()
	running = false
	ws.CurrentCamera.CameraSubject = char.Humanoid
end)




spsec1:addToggle("Circle lock", nil, function(val)
	locksettings.CircleLock = val
end)

spsec1:addSlider("Speed", 1, 45, 0.5, function(value)
	locksettings.Speed = value
end)
spsec1:addSlider("Farness", 2, 25, 0.5, function(value)
	locksettings.Farness = value
end)


while task.wait() do
	if running == true and locksettings.Target ~= "" and hrp then
		if locksettings.Target.Name then
			local ratio = 1/1
			local angle = 1 * pi2
			local targetpos = locksettings.Target.Character:FindFirstChild("HumanoidRootPart").Position
			num = num + 0.1
			
			local xm = math.sin((angle / 1) + (num / locksettings.Speed)) * locksettings.Farness
			local zm = math.cos((angle / 1) + (num / locksettings.Speed)) * locksettings.Farness
			
			local vec = Vector3.new(targetpos.X + xm, targetpos.Y, targetpos.Z + zm)
			
			hrp.CFrame = CFrame.new(vec, targetpos)
		end	
	end
end
