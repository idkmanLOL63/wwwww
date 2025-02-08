local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local ChamsAdjustments = {
 Enabled = false,
 OutlineColor = Color3.fromRGB(255, 255, 255),
 OutlineTransparency = 0,
 FillColor = Color3.fromRGB(120, 255, 0),
 FillTransparency = 0,
 
 Keybind = Enum.KeyCode.Z,
}

local function AddChams(v)
 if v and v.Character and not v.Character:FindFirstChild(v.Name.."_Chams") then
  local ChamsESP = Instance.new("Highlight")
  
  ChamsESP.Name = v.Name.."_Chams"
  
  ChamsESP.OutlineColor = ChamsAdjustments.OutlineColor
  ChamsESP.OutlineTransparency = ChamsAdjustments.OutlineTransparency
  ChamsESP.FillColor = ChamsAdjustments.FillColor
  ChamsESP.FillTransparency = ChamsAdjustments.FillTransparency
  
  ChamsESP.Parent = v.Character
  ChamsESP.Adornee = v.Character
 end
end

local function UpdateChams(v)
 if v and v.Character and v.Character:FindFirstChild(v.Name.."_Chams") then
  local ChamsESP = v.Character:FindFirstChild(v.Name.."_Chams")
  ChamsESP.Enabled = ChamsAdjustments.Enabled
  ChamsESP.OutlineColor = ChamsAdjustments.OutlineColor
  ChamsESP.OutlineTransparency = ChamsAdjustments.OutlineTransparency
  ChamsESP.FillColor = ChamsAdjustments.FillColor
  ChamsESP.FillTransparency = ChamsAdjustments.FillTransparency
 end
end

local function RemoveChams(v)
 if v and v.Character and v.Character:FindFirstChild(v.Name.."_Chams") then
  v.Character:FindFirstChild(v.Name.."_Chams"):Destroy()
 end
end

UserInputService.InputBegan:Connect(function(Key)
 if Key.KeyCode == ChamsAdjustments.Keybind and UserInputService:GetFocusedTextBox() == nil then
  ChamsAdjustments.Enabled = not ChamsAdjustments.Enabled
 end
end)

RunService.Stepped:Connect(function()
 if ChamsAdjustments.Enabled == true then
  for _,v in pairs(Players:GetPlayers()) do
   if v ~= LocalPlayer and v.Character then
    if not v.Character:FindFirstChild(v.Name.."_Chams") then
     AddChams(v)
    elseif v.Character:FindFirstChild(v.Name.."_Chams") then
     UpdateChams(v)
    end
   end
  end
 elseif ChamsAdjustments.Enabled == false then
  for _,v in pairs(Players:GetPlayers()) do
   if v ~= LocalPlayer and v.Character then
    if v.Character:FindFirstChild(v.Name.."_Chams") then
     RemoveChams(v)
    end
   end
  end
 end
end)
