game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Melon's (FE) Converts/Scripts"; Text = "Thanks for using!"; Icon = "rbxthumb://type=Asset&id=13446503788&w=150&h=150"})
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "BananaMan/Diegombv03"; Text = "has extreme skibidi ohio sussy rizz"; Icon = "rbxthumb://type=Asset&id=10034527904&w=150&h=150"})

function Reanimate()
local OptionsAccessories = nil
local OptionsRigTransparency = nil
local OptionsRigR15 = nil
local OptionsRigSetHumanoidDescription = nil
local OptionsRigSetCharacter = nil
local OptionsTeleportXandZoffset = nil
local OptionsTeleportYoffset = nil
local OptionsDisableScripts = nil
local OptionsDisableScreenGUIs = nil
local OptionsFlingEnabled = nil
local OptionsFlingToolFling = nil
local OptionsFlingTimeout = nil
local OptionsFlingVelocity = nil
local OptionsFlingHighlightTargets = nil

local BindableEvent = nil
local Boolean = false
local Humanoid = nil
local Rig = nil
local RigHumanoid = nil
local RigHumanoidRootPart = nil
local Success = false
local Time = nil
local DeltaTime = nil
local LastTime = nil

local Attachments = { }
local BaseParts = { }
local Blacklist = { }
local Enableds = { }
local Handles = { }
local Highlights = { }
local RBXScriptConnections = { }
local RigAccessories = { }
local Tables = { }
local Targets = { }

local CFrame = CFrame
local CFrameAngles = CFrame.Angles
local CFrameidentity = CFrame.identity
local CFramenew = CFrame.new

local coroutine = coroutine
local coroutinecreate = coroutine.create
local coroutineclose = coroutine.close
local coroutineresume = coroutine.resume

local Enum = Enum
local HumanoidStateType = Enum.HumanoidStateType
local Physics = HumanoidStateType.Physics
local Running = HumanoidStateType.Running
local Track = Enum.CameraType.Track
local UserInputType = Enum.UserInputType
local MouseButton1 = UserInputType.MouseButton1
local Touch = UserInputType.Touch

local game = game
local Clone = game.Clone
local Destroy = game.Destroy
local FindFirstAncestorOfClass = game.FindFirstAncestorOfClass
local FindFirstChildOfClass = game.FindFirstChildOfClass
local GetPropertyChangedSignal = game.GetPropertyChangedSignal
local GetChildren = game.GetChildren
local GetDescendants = game.GetDescendants
local IsA = game.IsA
local Players = FindFirstChildOfClass(game, "Players")
local CreateHumanoidModelFromUserId = Players.CreateHumanoidModelFromUserId
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = FindFirstChildOfClass(game, "RunService")
local PostSimulation = RunService.PostSimulation
local PreRender = RunService.PreRender
local PreSimulation = RunService.PreSimulation
local Connect = PostSimulation.Connect
local Disconnect = Connect(GetPropertyChangedSignal(game, "Parent"), function() end).Disconnect
local Wait = PostSimulation.Wait
local StarterGui = FindFirstChildOfClass(game, "StarterGui")
local SetCore = StarterGui.SetCore
local UserInputService = FindFirstChildOfClass(game, "UserInputService")
local IsMouseButtonPressed = UserInputService.IsMouseButtonPressed
local Workspace = FindFirstChildOfClass(game, "Workspace")
local CurrentCamera = Workspace.CurrentCamera

local Instancenew = Instance.new
local Humanoid = Instancenew("Humanoid")
local ApplyDescription = Humanoid.ApplyDescription
local ChangeState = Humanoid.ChangeState
local GetAppliedDescription = Humanoid.GetAppliedDescription
local Move = Humanoid.Move
Destroy(Humanoid)
local Part = Instancenew("Part")
local GetJoints = Part.GetJoints
Destroy(Part)

local math = math
local mathabs = math.abs
local mathrandom = math.random
local mathsin = math.sin

local osclock = os.clock

local pairs = pairs
local pcall = pcall

local script = script

local string = string
local stringchar = string.char
local stringfind = string.find
local stringrep = string.rep

local table = table
local tableclear = table.clear
local tablefind = table.find
local tableinsert = table.insert
local tableremove = table.remove

local task = task
local taskdefer = task.defer
local taskdelay = task.delay
local taskspawn = task.spawn
local taskwait = task.wait

local sethiddenproperty = sethiddenproperty or function() end

local type = type
local typeof = typeof

local Vector3 = Vector3
local Vector3new = Vector3.new
local Vector3yAxis = Vector3.yAxis
local Vector3zero = Vector3.zero

local CameraCFrame = CFrameidentity

local LimbSize = Vector3new(1, 2, 1)
local TorsoSize = Vector3new(2, 2, 1)

local function BreakJoints(Parent)
	for _, Instance in pairs(GetDescendants(Parent)) do
		if IsA(Instance, "JointInstance") then
			Destroy(Instance)
		end
	end
end

local function CameraSubject()
	CurrentCamera.CameraSubject = RigHumanoid
	Wait(PreRender)
	CurrentCamera.CFrame = CameraCFrame
end

local function CameraType()
	if CurrentCamera.CameraType ~= Track then
		CurrentCamera.CameraType = Track
	end
end

local function Camera()
	local Camera = Workspace.CurrentCamera

	if Camera then
		CameraCFrame = Camera.CFrame
		CurrentCamera = Camera

		CameraSubject()
		CameraType()

		tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Camera, "CameraSubject"), CameraSubject))
		tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Camera, "CameraType"), CameraType))
	end
end

local function FindFirstChildOfClassAndName(Parent, ClassName, Name)
	for Index, Instance in pairs(GetChildren(Parent)) do
		if IsA(Instance, ClassName) and Instance.Name == Name then
			return Instance
		end
	end
end

local function WaitForChildOfClassAndName(Parent, ...)
	local Instance = FindFirstChildOfClassAndName(Parent, ...)

	while not Instance and typeof(Parent) == "Instance" do
		Instance = FindFirstChildOfClassAndName(Parent, ...)
		Wait(Parent.ChildAdded)
	end

	return Instance
end

local function Invisible(Instance)
	if IsA(Instance, "BasePart") or IsA(Instance, "Decal") then
		Instance.Transparency = OptionsRigTransparency
	elseif IsA(Instance, "ForceField") or IsA(Instance, "Explosion") then
		Instance.Visible = false
	elseif IsA(Instance, "ParticleEmitter") or IsA(Instance, "Fire") or IsA(Instance, "Sparkles") then
		Instance.Enabled = false
	end
end

local function DescendantAdded(Instance)
	if IsA(Instance, "Attachment") then
		local Handle = Instance.Parent

		if IsA(Handle, "BasePart") then
			local AttachmentsAttachment = Attachments[Instance.Name]

			if AttachmentsAttachment then
				local MeshId = ""
				local TextureId = ""

				if IsA(Handle, "MeshPart") then
					MeshId = Handle.MeshId
					TextureId = Handle.TextureID
				else
					local SpecialMesh = FindFirstChildOfClass(Handle, "SpecialMesh")

					if SpecialMesh then
						MeshId = SpecialMesh.MeshId
						TextureId = SpecialMesh.TextureId
					end
				end

				for Index, Table in pairs(OptionsAccessories) do
					if stringfind(MeshId, Table.MeshId or "") and stringfind(TextureId, Table.TextureId or "") then
						local Instance = FindFirstChildOfClassAndName(Rig, "BasePart", Table.Name)

						local AlternativeName = Table.AlternativeName
						local AlternativeInstance = false

						if not Instance and AlternativeName then
							Instance = FindFirstChildOfClassAndName(Rig, "BasePart", AlternativeName)
							AlternativeInstance = true
						end

						if Instance and not tablefind(Blacklist, Instance) then
							if Table.Blacklist then
								tableinsert(Blacklist, Instance)
							end
							BreakJoints(Handle)
							tableinsert(Tables, { Part0 = Handle, Part1 = Instance, CFrame = AlternativeInstance and Table.AllowAlternativeCFrame and Table.AlternativeCFrame or Table.CoordinateFrame, LastPosition = Instance.Position })
							return
						end
					end
				end
				for Index, Table in pairs(RigAccessories) do
					local TableHandle = Table.Handle

					if typeof(TableHandle) == "Instance" and Table.MeshId == MeshId and Table.TextureId == TextureId then
						BreakJoints(Handle)
						tableinsert(Tables, { Part0 = Handle, Part1 = TableHandle, LastPosition = TableHandle.Position })
						return
					end
				end

				local Accessory = Handle.Parent

				if IsA(Accessory, "Accessory") then
					local AccessoryClone = Instancenew("Accessory")
					AccessoryClone.Name = Accessory.Name

					local HandleClone = Clone(Handle)
					Invisible(HandleClone)
					BreakJoints(HandleClone)
					HandleClone.Parent = AccessoryClone

					local Weld = Instancenew("Weld")
					Weld.Name = "AccessoryWeld"
					Weld.C0 = Instance.CFrame
					Weld.C1 = AttachmentsAttachment.CFrame
					Weld.Part0 = HandleClone
					Weld.Part1 = AttachmentsAttachment.Parent
					Weld.Parent = HandleClone

					tableinsert(RigAccessories, { Handle = HandleClone, MeshId = MeshId, TextureId = TextureId })
					tableinsert(Tables, { Part0 = Handle, Part1 = HandleClone, LastPosition = HandleClone.Position })

					AccessoryClone.Parent = Rig
				end
			end
		end
	elseif IsA(Instance, "BasePart") then
		Instance.CanQuery = false
		tableinsert(BaseParts, Instance)
	end
end

local function ApplyDescriptionRig()
	local Description = GetAppliedDescription(Humanoid)
	Description.HatAccessory = ""
	Description.BackAccessory = ""
	Description.FaceAccessory = ""
	Description.HairAccessory = ""
	Description.NeckAccessory = ""
	Description.FrontAccessory = ""
	Description.WaistAccessory = ""
	Description.ShouldersAccessory = ""
	ApplyDescription(RigHumanoid, Description)

	for Index, Instance in pairs(GetDescendants(Rig)) do
		Invisible(Instance)
	end
end

local function SetCharacter()
	taskwait()
	LocalPlayer.Character = Rig
end
local Tools = { }
local function CharacterAdded()
	local Character = LocalPlayer.Character

	if Character and Character ~= Rig then
		if OptionsFlingToolFling then
			for Index, Backpack in pairs(GetChildren(LocalPlayer)) do
				if IsA(Backpack, "Backpack") then
					for Index, Instance in pairs(GetChildren(Backpack)) do
						if IsA(Instance, "Tool") then
							Tools[Instance] = FindFirstChildOfClassAndName(Instance, "BasePart", "Handle")	
							Instance.Parent = Character
						end
					end
				end
			end
		end
		
		if OptionsRigSetCharacter then
			taskspawn(SetCharacter)
		end
		
		tableclear(BaseParts)
		tableclear(Blacklist)
		tableclear(Tables)

		if CurrentCamera then
			CameraCFrame = CurrentCamera.CFrame
		end

		for Index, Instance in pairs(GetDescendants(Character)) do
			DescendantAdded(Instance)
		end

		tableinsert(RBXScriptConnections, Connect(Character.DescendantAdded, DescendantAdded))

		Humanoid = WaitForChildOfClassAndName(Character, "Humanoid", "Humanoid")
		local HumanoidRootPart = WaitForChildOfClassAndName(Character, "BasePart", "HumanoidRootPart")

		if Boolean then
			Camera()

			if HumanoidRootPart then
				RigHumanoidRootPart.CFrame = HumanoidRootPart.CFrame
				Boolean = false
			end

			if OptionsRigSetHumanoidDescription and RigHumanoid and Humanoid then
				pcall(ApplyDescriptionRig)
			end
		end

		if HumanoidRootPart then
			for Index, Table in pairs(Targets) do
				if not HumanoidRootPart then
					break
				end

				if Humanoid then
					ChangeState(Humanoid, Physics)
				end

				local Target = Table.Target

				local Timeout = Time + OptionsFlingTimeout
				local LastPosition = Target.Position

				while Target and HumanoidRootPart do
					if Time > Timeout then
						break
					end

					local Position = Target.Position
					local LinearVelocity = ( Position - LastPosition ) / DeltaTime

					if LinearVelocity.Magnitude > 50 then
						break
					end

					LastPosition = Position

					HumanoidRootPart.AssemblyAngularVelocity = OptionsFlingVelocity
					HumanoidRootPart.AssemblyLinearVelocity = OptionsFlingVelocity
				
					HumanoidRootPart.CFrame = Target.CFrame * CFramenew(0, 0, 4 * mathsin(Time * 30)) * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360)) + ( LinearVelocity * 0.5) 
					taskwait()
				end

				local Highlight = Table.Highlight

				if Highlight then
					Destroy(Highlight)
				end

				Targets[Index] = nil
			end

			if Humanoid then
				ChangeState(Humanoid, Running)
			end

			if RigHumanoidRootPart then
				HumanoidRootPart.AssemblyAngularVelocity = Vector3zero
				HumanoidRootPart.AssemblyLinearVelocity = Vector3zero

				HumanoidRootPart.CFrame = RigHumanoidRootPart.CFrame + Vector3new(mathrandom(- OptionsTeleportXandZoffset, OptionsTeleportXandZoffset), OptionsTeleportYoffset, mathrandom(- OptionsTeleportXandZoffset, OptionsTeleportXandZoffset))
			end
		end
		
		taskwait(0.26 + Wait(PreSimulation))

		if Character then
			BreakJoints(Character)
		end
	end
end

local function PostSimulationConnect()
	sethiddenproperty(LocalPlayer, "SimulationRadius", 2147483647)

	Time = osclock()
	DeltaTime = Time - LastTime
	LastTime = Time

	local Integer = 29 + mathsin(Time)
	local Vector3 = Vector3new(0, 0, 0.002 * mathsin(Time * 25))

	for Index, Table in pairs(Tables) do
		local Part0 = Table.Part0
		local Part1 = Table.Part1

		if Part0 and # GetJoints(Part0) == 0 and Part0.ReceiveAge == 0 and Part1 then
			Part0.AssemblyAngularVelocity = Vector3zero

			local Position = Part1.Position
			local LinearVelocity = ( ( Table.LastPosition - Position ) / DeltaTime ) * Integer
			Table.LastPosition = Position

			Part0.AssemblyLinearVelocity = Vector3new(LinearVelocity.X, Integer, LinearVelocity.Z)

			Part0.CFrame = Part1.CFrame * ( Table.CFrame or CFrameidentity ) + Vector3
		end
	end
	
	local Hit = Mouse.Hit
	local Holding = IsMouseButtonPressed(UserInputService, MouseButton1)
	
	for Tool, BasePart in pairs(Tools) do
		if BasePart.ReceiveAge == 0 and # GetJoints(BasePart) == 0 then
			BasePart.CanCollide = false
			BasePart.AssemblyAngularVelocity = OptionsFlingVelocity
			BasePart.AssemblyLinearVelocity = OptionsFlingVelocity
			
			if Holding then
				BasePart.CFrame = Hit
			elseif RigHumanoidRootPart then
				BasePart.CFrame = RigHumanoidRootPart.CFrame * CFramenew(0, OptionsTeleportYoffset, 0) * CFrameAngles(mathrandom(- 360, 360), mathrandom(- 360, 360), mathrandom(- 360, 360))
			else
				BasePart.CFrame = CFrameidentity
			end
		end
	end

	if RigHumanoid and Humanoid then
		RigHumanoid.Jump = Humanoid.Jump
		Move(RigHumanoid, Humanoid.MoveDirection)
	end

	if not Success then
		Success = pcall(SetCore, StarterGui, "ResetButtonCallback", BindableEvent)
	else
		SetCore(StarterGui, "ResetButtonCallback", BindableEvent)
	end
end

local function PreSimulationConnect()
	for Index, BasePart in pairs(BaseParts) do
		BasePart.CanCollide = false
	end
end

local function Fling(Target)
	if typeof(Target) == "Instance" then
		if IsA(Target, "Humanoid") then
			Target = Target.Parent
		end
		if IsA(Target.Parent, "Accessory") then
			Target = FindFirstAncestorOfClass(Target, "Model")
		end
		if IsA(Target, "Model") then
			Target = FindFirstChildOfClassAndName(Target, "BasePart", "HumanoidRootPart")
		end
		if IsA(Target, "BasePart") then
			for Index, Table in pairs(Targets) do
				if Table.Target == Target then
					return
				end
			end

			local Parent = Target.Parent
			
			local Highlight = nil
			
			if OptionsFlingHighlightTargets then
				Highlight = Instancenew("Highlight")
				Highlight.Adornee = Parent
				Highlight.Parent = Parent
				tableinsert(Highlights, Highlight)
			end
			
			tableinsert(Targets, {Highlight = Highlight, Target = Target})
		end
	end
end

local function InputBegan(InputObject)
	local UserInputType = InputObject.UserInputType

	if UserInputType == MouseButton1 or UserInputType == Touch then
		local Target = Mouse.Target

		if Target and not Target.Anchored then
			local Model = Target.Parent

			if IsA(Model, "Model") and FindFirstChildOfClass(Model, "Humanoid") then
				local HumanoidRootPart = FindFirstChildOfClassAndName(Model, "BasePart", "HumanoidRootPart")

				if HumanoidRootPart then
					Fling(HumanoidRootPart)
				end
			else
				Fling(Target)
			end
		end
	end
end

local function gameDescendantAdded(Instance)
	if ( OptionsDisableScreenGUIs and IsA(Instance, "ScreenGui") ) or ( OptionsDisableScripts and Instance ~= script and ( IsA(Instance, "LocalScript") or IsA(Instance, "Script") ) ) then
		Enableds[Instance] = Instance.Enabled
		Instance.Enabled = false

		tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Instance, "Enabled"), function()
			Enableds[Instance] = Instance.Enabled
			Instance.Enabled = false
		end))
	end
end

local function Stop()
	for Index, RBXScriptConnection in pairs(RBXScriptConnections) do
		Disconnect(RBXScriptConnection)
	end
	for Index, Highlight in pairs(Highlights) do
		Destroy(Highlight)
	end
	for Instance, Boolean in pairs(Enableds) do
		Instance.Enabled = Boolean
	end

	tableclear(Attachments)
	tableclear(BaseParts)
	tableclear(Enableds)
	tableclear(Handles)
	tableclear(Highlights)
	tableclear(RBXScriptConnections)
	tableclear(Tables)
	tableclear(Targets)

	if Rig then
		Destroy(Rig)
	end

	Destroy(BindableEvent)
	SetCore(StarterGui, "ResetButtonCallback", true)
end

local Emperean = {
	Stop = Stop,
	Start = function(Options)
		Options = Options or { }
		OptionsAccessories = Options.Accessories or {}
		local OptionsRig = Options.Rig
		OptionsRigTransparency = OptionsRig.Transparency
		OptionsRigR15 = OptionsRig.R15
		OptionsRigSetHumanoidDescription = OptionsRig.SetHumanoidDescription
		OptionsRigSetCharacter = OptionsRig.SetCharacter
		local OptionsTeleport = Options.Teleport or {}
		local XandYoffset = OptionsTeleport.XandYoffset
		OptionsTeleportXandZoffset = XandYoffset and mathabs(XandYoffset) or 6
		OptionsTeleportYoffset = OptionsTeleport.Yoffset or 0
		local OptionsDisable = Options.Disable
		OptionsDisableScripts = OptionsDisable.Scripts
		OptionsDisableScreenGUIs = OptionsDisable.GUIs
		local OptionsFling = Options.Fling or {}
		OptionsFlingEnabled = OptionsFling.Enabled
		OptionsFlingToolFling = OptionsFling.ToolFling
		OptionsFlingTimeout = OptionsFling.Timeout or 1.5
		OptionsFlingVelocity = OptionsFling.Velocity or Vector3new(0, 4096, 0)
		OptionsFlingHighlightTargets = OptionsFling.HighlightTargets

		if OptionsDisableScripts or OptionsDisableScreenGUIs then
			for Index, Instance in pairs(GetDescendants(game)) do
				gameDescendantAdded(Instance)
			end

			tableinsert(RBXScriptConnections, Connect(game.DescendantAdded, gameDescendantAdded))
		end

		Boolean = true
		LastTime = osclock()

		Rig = OptionsRigR15 and CreateHumanoidModelFromUserId(Players, 5532894300) or CreateHumanoidModelFromUserId(Players, 5532891747)
		Rig.Name = "non"
		RigHumanoid = Rig.Humanoid
		RigHumanoidRootPart = Rig.HumanoidRootPart
		Rig.Parent = Workspace

		for Index, Instance in pairs(GetDescendants(Rig)) do
			if IsA(Instance, "Attachment") then
				Attachments[Instance.Name] = Instance
			else
				Invisible(Instance)
			end
		end

		BindableEvent = Instancenew("BindableEvent")
		Connect(BindableEvent.Event, Stop)

		tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(Workspace, "CurrentCamera"), Camera))

		CharacterAdded()
		tableinsert(RBXScriptConnections, Connect(GetPropertyChangedSignal(LocalPlayer, "Character"), CharacterAdded))

		if OptionsFlingEnabled then
			tableinsert(RBXScriptConnections, Connect(UserInputService.InputBegan, InputBegan))
		end

		tableinsert(RBXScriptConnections, Connect(PreSimulation, PreSimulationConnect))
		tableinsert(RBXScriptConnections, Connect(PostSimulation, PostSimulationConnect))

		return { 
			Rig = Rig,
			Options = Options,
			Fling = Fling,
		},
		taskwait()
	end,
}

Emperean.Start({
	Accessories = {
        --  Free Rig
	{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "4819720316", TextureId = "4819722776", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 0, -0.25), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "3030546036", TextureId = "3033903209", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, -1.57), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "3030546036", TextureId = "3360978739", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, 1.57), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "3030546036", TextureId = "3033898741", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, -1.57), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "3030546036", TextureId = "3409604993", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(-1.57, 0, 1.57), AlternativeCFrame = CFrameidentity },
	
      -- Cheap Paid Rig
	{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "12344206657", TextureId = "12344206675", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(-0.095, 0, 0) * CFrameAngles(- 2, 0, 0), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "12344207333", TextureId = "12344207341", AllowAlternativeCFrame = false, CoordinateFrame = CFramenew(0.095, 0, 0) * CFrameAngles(- 2, 0, 0), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "11263221350", TextureId = "11263219250", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(1.57, - 1.57, 0), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "11159370334", TextureId = "11159284657", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(1.57, 1.57, 0), AlternativeCFrame = CFrameidentity },
 
      -- Accurate Paid Rig
 	{ Blacklist = true, Name = "Torso", AlternativeName = "UpperTorso", MeshId = "14241018198", TextureId = "14251599953", AllowAlternativeCFrame = false, CoordinateFrame = CFrameidentity, AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Right Arm", AlternativeName = "RightLowerArm", MeshId = "14255522247", TextureId = "14255543546", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Left Arm", AlternativeName = "LeftLowerArm", MeshId = "14255522247", TextureId = "14255543546", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Right Leg", AlternativeName = "RightLowerLeg", MeshId = "17374767929", TextureId = "17374768001", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
	{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerLeg", MeshId = "17374767929", TextureId = "17374768001", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },

   -- White legs below
   	{ Blacklist = true, Name = "Left Leg", AlternativeName = "LeftLowerArm", MeshId = "14768684979", TextureId = "14768683674", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
 	{ Blacklist = true, Name = "Right Leg", AlternativeName = "LeftLowerArm", MeshId = "14768684979", TextureId = "14768683674", AllowAlternativeCFrame = false, CoordinateFrame = CFrameAngles(0, 1.57, 1.57), AlternativeCFrame = CFrameidentity },
	},
	Rig = {
		Transparency = 1,
		R15 = false,
		SetHumanoidDescription = true,
		SetCharacter = false
	},
	Teleport = {
		XandZoffset = 145,
		Yoffset = 0
	},
	Disable = {
		Scripts = true,
		ScreenGUIs = false
	},
	Fling = {
		Enabled = true,
		ToolFling = true,
		Timeout = 0.75,
		Velocity = Vector3new(15250, 16250, 15250),
		HighlightTargets = true
	}
})
end

Reanimate()

local script = game:GetObjects("rbxassetid://11162443753")[1].Dreemurr
script.Parent = workspace.non

local qoute = [[
ASRIEL DREEMURR (incomplete)
A script made by Expination
Inspired by SoulShatters
Any other copies of this script will not be updated manually
Anyone else than Expination saying they made it is lying to you
]]

warn(qoute)

local TweenService = game:GetService("TweenService")
local Debris = game:GetService("Debris")

function swait()
	game:GetService("RunService").Stepped:wait()
end

local createSound = function(instance,soundid,volume,destroy,pitch)
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://" .. soundid
	sound.Volume = volume
	sound.Parent = instance
	sound:Play()
	
	if pitch then
		sound.PlaybackSpeed = pitch
	end
	
	if destroy == true then
		task.spawn(function()
		sound.Ended:Wait()
		sound:Destroy()
		end)
	else
		return sound
	end
	
end

local POW = 0 -- up to 9

-- using code from fastcast example gun because i don't know how to raycasting

local DEBUG = false								-- Whether or not to use debugging features of FastCast, such as cast visualization.
local BULLET_SPEED = 100							-- Studs/second - the speed of the bullet
local BULLET_MAXDIST = 1000							-- The furthest distance the bullet can travel 
local BULLET_GRAVITY = Vector3.new(0, 0, 0)		-- The amount of gravity applied to the bullet in world space (so yes, you can have sideways gravity)
local MIN_BULLET_SPREAD_ANGLE = 1-1				-- THIS VALUE IS VERY SENSITIVE. Try to keep changes to it small. The least accurate the bullet can be. This angle value is in degrees. A value of 0 means straight forward. Generally you want to keep this at 0 so there's at least some chance of a 100% accurate shot.
local MAX_BULLET_SPREAD_ANGLE = 1					-- THIS VALUE IS VERY SENSITIVE. Try to keep changes to it small. The most accurate the bullet can be. This angle value is in degrees. A value of 0 means straight forward. This cannot be less than the value above. A value of 90 will allow the gun to shoot sideways at most, and a value of 180 will allow the gun to shoot backwards at most. Exceeding 180 will not add any more angular varience.
local FIRE_DELAY = 0								-- The amount of time that must pass after firing the gun before we can fire again.
local BULLETS_PER_SHOT = 1							-- The amount of bullets to fire every shot. Make this greater than 1 for a shotgun effect.
local PIERCE_DEMO = true	

local RNG = Random.new()							-- Set up a randomizer.
local TAU = math.pi * 2							-- Set up mathematical constant Tau (pi * 2)

local tlerp = function(part,tablee,leinght,easingstyle,easingdirec)
	pcall(function()
		local info = TweenInfo.new(
			leinght,
			easingstyle,
			easingdirec,
			0,
			false,
			0
		)
		local lerp = TweenService:Create(part,info,tablee)
		lerp:Play()
	end)
end

function SetTween(SPart,CFr,MoveStyle2,outorin2,AnimTime)
	local MoveStyle = Enum.EasingStyle[MoveStyle2]
	local outorin = Enum.EasingDirection[outorin2]


	local dahspeed=1

	local tweeningInformation = TweenInfo.new(
		AnimTime/dahspeed,	
		MoveStyle,
		outorin,
		0,
		false,
		0
	)
	local MoveCF = CFr
	local tweenanim = TweenService:Create(SPart,tweeningInformation,MoveCF)
	tweenanim:Play()
end
local Player = game:GetService("Players").LocalPlayer
local Character = workspace.non

local Torso = Character:WaitForChild("Torso",15)
local Head = Character:WaitForChild("Head",15)

local LeftArm = Character:WaitForChild("Left Arm",15)
local RightArm = Character:WaitForChild("Right Arm",15)
local LeftLeg = Character:WaitForChild("Left Leg",15)
local RightLeg = Character:WaitForChild("Right Leg",15)

local Humanoid = Character:FindFirstChildOfClass("Humanoid")


local mode = 1

local effects = script:WaitForChild("effects",60)
local ChaosSaber = effects:WaitForChild("ChaosSaber",60)
local SoulshatterEffects = effects:WaitForChild("SoulshatterEffects")
local CraterCreator = effects:WaitForChild("CraterModule")
local FastCast = effects:WaitForChild("FastCastRedux")
local PartCache = effects:WaitForChild("PartCache")
local Circle = effects:WaitForChild("Circle")
local bezierModule = effects:WaitForChild("BezierModule")
local RaycastHitboxV4 = effects.RaycastHitboxV4
local playerEffectsGui = effects.player

local idle = true
local attack = false
local chaossaber = false
local chaosbuster = false
local usingHYPERGONER = false

local cos = math.cos
local rad = math.rad

local CosmeticBulletsFolder = Instance.new("Folder", workspace)
CosmeticBulletsFolder.Name = "CosmeticBulletsFolder"

--for i,v in pairs(CosmeticBulletsFolder:GetChildren()) do
--	if v:IsA("BasePart") then
--		if v.Position.Y >= 1000000 then
--			v:Destroy()
--		end
--	end
--end

--CosmeticBulletsFolder.ChildAdded:Connect(function(v)
--	if v:IsA("BasePart") then
--		if v.Position.Y >= 1000000 then
--			v:Destroy()
--		end
--	end
--end)

local LightningBolt = effects.LightningBolt
local LightningExplosion = effects.LightningBolt.LightningExplosion
local LightningSparks = effects.LightningBolt.LightningSparks

local StarObject = effects:WaitForChild("Star"):Clone()
effects:WaitForChild("Star"):Destroy()
local ShockwaveObject = effects:WaitForChild("shockwave"):Clone()
effects:WaitForChild("shockwave"):Destroy()
local WarningObject = effects:WaitForChild("Warning"):Clone()
effects:WaitForChild("Warning"):Destroy()
local ShockObject = effects:WaitForChild("Shock"):Clone()
effects:WaitForChild("Shock"):Destroy()
local HYPERGONERObject = effects:WaitForChild("hypergoner"):Clone()
effects:WaitForChild("hypergoner"):Destroy()
local DebrisObject = effects:WaitForChild("debris"):Clone()
effects:WaitForChild("debris"):Destroy()
local SoulObject = effects:WaitForChild("Soul"):Clone()
effects:WaitForChild("Soul"):Destroy()
local Soul_plrObject = effects:WaitForChild("SoulPlayer"):Clone()
effects:WaitForChild("SoulPlayer"):Destroy()
local projectileObject = effects:WaitForChild("projectile"):Clone()
effects:WaitForChild("projectile"):Destroy()

function Added(i)
	if i.Name == "Circle"then

		local t = game:GetService("TweenService"):Create(i,TweenInfo.new(math.random(3,9)*0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = Vector3.new(i.Size.X, 0, i.Size.Z) * math.random(23,30) * 0.1;
			Transparency = 1;
			CFrame = i.CFrame * CFrame.Angles(math.rad(math.random(-50,50)),math.rad(math.random(-50,50)),math.rad(math.random(-50,50)))
		})

		t:Play()
	end
end

local function Typewrite(Element, String)
	spawn(function()
		for i = 1,#String do 
			Element.Text = string.sub(String,5,i)
			--print(string.sub(String,5,i))
			swait()
		end
	end)
end

local function givePlayerEffectsGui(who)
	if who:IsA("Player") then
		local playerGui = who:FindFirstChildOfClass("PlayerGui")
		if not playerGui then
			warn(who.Name .. " doesn't have a PlayerGui!")
		elseif playerGui then
			if playerGui:FindFirstChild(Player.Name) then
				playerGui:FindFirstChild(Player.Name):Destroy()
				
			local efts = playerEffectsGui:Clone()
			efts.Name = Player.Name
			efts.Parent = playerGui
				efts.Effects.Disabled = false
			else
				local efts = playerEffectsGui:Clone()
				efts.Name = Player.Name
				efts.Parent = playerGui
				efts.Effects.Disabled = false
			end
		end	
	end
end

local MUSIC = Instance.new("Sound")
MUSIC.SoundId = "rbxassetid://11162201480"
MUSIC.Looped = true
MUSIC.Parent = Character
local SOUL_KILL = false

local function getRandomPos(part) --Function to call to get the position, will be different every time
	local min = part.Position - (part.Size/2)
	local max = part.Position + (part.Size/2)
	local rx = math.random(min.X,max.X) --Get the x, between the max and min
	local ry = math.random(min.Y,max.Y) --Get the y, between the max and min
	local rz = math.random(min.Z,max.Z) --Get the z, between the max and min
	return Vector3.new(rx, ry, rz)
end

local function createEffect(effectType,sparks,A1,A2,pSpeed,pLenght,color,fade,thickness,exploTable,ran)
	
	-- explo table example: Position, Size, NumBolts, Color, BoltColor, UpVector
	
	--[[ default color
		NewBolt.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0,Color3.new(1, 0.215686, 0.215686)),
		ColorSequenceKeypoint.new(.25,Color3.new(1, 0.968627, 0)),
		ColorSequenceKeypoint.new(.5,Color3.new(0.356863, 1, 0.32549)),
		ColorSequenceKeypoint.new(.60,Color3.new(0, 0.901961, 1)),
		ColorSequenceKeypoint.new(.75,Color3.new(0.419608, 0.368627, 1)),
		ColorSequenceKeypoint.new(1,Color3.new(1, 0.215686, 0.215686)),
	} 

	--]]
	
	--[[
	if effectType == "bolt" then
	local NewBolt = LightningBolt.new(A1, A2, 100)
	NewBolt.CurveSize0, NewBolt.CurveSize1 = workspace.Beam.CurveSize0, workspace.Beam.CurveSize1
	NewBolt.PulseSpeed = pSpeed
	NewBolt.PulseLength = pLenght
	NewBolt.FadeLength = fade
	NewBolt.ColorOffsetSpeed = .1
	NewBolt.Thickness = thickness
		--NewBolt.MaxRadius = 1
		NewBolt.Color = color
		print(effectType)
    if sparks then
			local NewSparks = LightningSparks.new(NewBolt)
			print("yes")
	end
	elseif effectType == "explosion" then
		local Explo = LightningExplosion.new(unpack(exploTable))
		
	end
	]]
end

local mouse = game:GetService("Players").LocalPlayer:GetMouse()
rootW=Character.HumanoidRootPart.RootJoint
rootWO=rootW.C0
moving=false
root=Torso
neckW=root.Neck
neckWO=neckW.C0
rsW=root["Right Shoulder"]
rsWO=rsW.C0
lsW=root["Left Shoulder"]
lsWO=lsW.C0
rhW=root["Right Hip"]
rhWO=rhW.C0
lhW=root["Left Hip"]
lhWO=lhW.C0

RJW=rootW
RootCF=rootWO
NeckW=neckW
RW=rsW
LW=lsW
RH=rhW
LH=lhW
angles=CFrame.Angles
NeckCF=neckWO

local function HealingObject()
	local Attachment = Instance.new("Attachment")
	Attachment.WorldOrientation = Vector3.new(-0, 180, 0)
	Attachment.Parent = Torso
	Attachment.WorldAxis = Vector3.new(-1, 0, 0)

	local HealingWave1 = Instance.new("ParticleEmitter")
	HealingWave1.Name = "HealingWave1"
	HealingWave1.Lifetime = NumberRange.new(1, 1)
	HealingWave1.SpreadAngle = Vector2.new(10, -10)
	HealingWave1.LockedToPart = true
	HealingWave1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1702454, 0.7, 0.014881), NumberSequenceKeypoint.new(0.2254601, 0.03125, 0.03125), NumberSequenceKeypoint.new(0.2852761, 0), NumberSequenceKeypoint.new(0.702454, 0), NumberSequenceKeypoint.new(0.8374233, 0.9125, 0.0601461), NumberSequenceKeypoint.new(1, 1)})
	HealingWave1.LightEmission = 0.4
	HealingWave1.Color = ColorSequence.new(Color3.fromRGB(26, 255, 26))
	HealingWave1.VelocitySpread = 10
	HealingWave1.Speed = NumberRange.new(3, 6)
	HealingWave1.Brightness = 10
	HealingWave1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3.0624998, 1.8805969), NumberSequenceKeypoint.new(0.6420546, 1.9999999, 1.7619393), NumberSequenceKeypoint.new(1, 0.7499999, 0.7499999)})
	HealingWave1.Enabled = false
	HealingWave1.RotSpeed = NumberRange.new(200, 400)
	HealingWave1.Rate = 10
	HealingWave1.Texture = "rbxassetid://8047533775"
	HealingWave1.Rotation = NumberRange.new(-180, 180)
	HealingWave1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	HealingWave1.Parent = Attachment

	local HealingWave2 = Instance.new("ParticleEmitter")
	HealingWave2.Name = "HealingWave2"
	HealingWave2.Lifetime = NumberRange.new(1, 1)
	HealingWave2.SpreadAngle = Vector2.new(10, -10)
	HealingWave2.LockedToPart = true
	HealingWave2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2254601, 0.03125, 0.03125), NumberSequenceKeypoint.new(0.6288344, 0.25625, 0.0593491), NumberSequenceKeypoint.new(0.8374233, 0.9125, 0.0601461), NumberSequenceKeypoint.new(1, 1)})
	HealingWave2.LightEmission = 1
	HealingWave2.Color = ColorSequence.new(Color3.fromRGB(33, 255, 33))
	HealingWave2.VelocitySpread = 10
	HealingWave2.Speed = NumberRange.new(3, 5)
	HealingWave2.Brightness = 10
	HealingWave2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 3.125), NumberSequenceKeypoint.new(0.4165329, 1.3749999, 1.3749999), NumberSequenceKeypoint.new(1, 0.9375, 0.9375)})
	HealingWave2.Enabled = false
	HealingWave2.RotSpeed = NumberRange.new(100, 300)
	HealingWave2.Rate = 10
	HealingWave2.Texture = "rbxassetid://8047796070"
	HealingWave2.Rotation = NumberRange.new(-180, 180)
	HealingWave2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	HealingWave2.Parent = Attachment
	return Attachment
end

local function TPEffect()
	local teleport = Instance.new("Attachment")
	teleport.Name = "teleport"

	local Wave2 = Instance.new("ParticleEmitter")
	Wave2.Name = "Wave2"
	Wave2.Lifetime = NumberRange.new(1, 1)
	Wave2.SpreadAngle = Vector2.new(10, -10)
	Wave2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2254601, 0.03125, 0.03125), NumberSequenceKeypoint.new(0.6288344, 0.25625, 0.0593491), NumberSequenceKeypoint.new(0.8374233, 0.9125, 0.0601461), NumberSequenceKeypoint.new(1, 1)})
	Wave2.LightEmission = 1
	Wave2.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)), ColorSequenceKeypoint.new(0.16609, Color3.fromRGB(255, 226, 0)), ColorSequenceKeypoint.new(0.3356402, Color3.fromRGB(25, 255, 0)), ColorSequenceKeypoint.new(0.550173, Color3.fromRGB(0, 234, 255)), ColorSequenceKeypoint.new(0.7110727, Color3.fromRGB(0, 0, 255)), ColorSequenceKeypoint.new(0.8477509, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))})
	Wave2.VelocitySpread = 10
	Wave2.Speed = NumberRange.new(1, 3)
	Wave2.Brightness = 10
	Wave2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.8805969), NumberSequenceKeypoint.new(0.4098916, 3.4328361, 1.8805971), NumberSequenceKeypoint.new(1, 5.6417904, 2.8059702)})
	Wave2.Enabled = false
	Wave2.RotSpeed = NumberRange.new(100, 300)
	Wave2.Rate = 10
	Wave2.Texture = "rbxassetid://8047796070"
	Wave2.Rotation = NumberRange.new(-180, 180)
	Wave2.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	Wave2.Parent = teleport

	local GroundRadialEffect = Instance.new("ParticleEmitter")
	GroundRadialEffect.Name = "GroundRadialEffect"
	GroundRadialEffect.Lifetime = NumberRange.new(2, 2)
	GroundRadialEffect.LockedToPart = true
	GroundRadialEffect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2099185, 0.9522388), NumberSequenceKeypoint.new(0.3301631, 0.838806), NumberSequenceKeypoint.new(0.5264946, 0.7373134), NumberSequenceKeypoint.new(0.7099185, 0.8298507), NumberSequenceKeypoint.new(0.8831522, 0.9522388), NumberSequenceKeypoint.new(1, 1)})
	GroundRadialEffect.LightEmission = 1
	GroundRadialEffect.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 99, 99)), ColorSequenceKeypoint.new(0.2128028, Color3.fromRGB(255, 247, 153)), ColorSequenceKeypoint.new(0.4429066, Color3.fromRGB(110, 255, 110)), ColorSequenceKeypoint.new(0.7006921, Color3.fromRGB(124, 117, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 123, 125))})
	GroundRadialEffect.Speed = NumberRange.new(0.01, 0.01)
	GroundRadialEffect.Brightness = 1.875
	GroundRadialEffect.Size = NumberSequence.new(0, 10)
	GroundRadialEffect.Enabled = false
	GroundRadialEffect.RotSpeed = NumberRange.new(40, 40)
	GroundRadialEffect.Rate = 5
	GroundRadialEffect.Texture = "rbxassetid://7107683672"
	GroundRadialEffect.Rotation = NumberRange.new(-180, 180)
	GroundRadialEffect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	GroundRadialEffect.Parent = teleport

	local Sparks = Instance.new("ParticleEmitter")
	Sparks.Name = "Sparks"
	Sparks.Lifetime = NumberRange.new(0.7, 0.7)
	Sparks.SpreadAngle = Vector2.new(20, -20)
	Sparks.LightEmission = 1
	Sparks.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 105, 105)), ColorSequenceKeypoint.new(0.3200692, Color3.fromRGB(158, 255, 123)), ColorSequenceKeypoint.new(0.6937717, Color3.fromRGB(119, 107, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 93, 93))})
	Sparks.VelocitySpread = 20
	Sparks.Squash = NumberSequence.new(-0.375, -0.4875002)
	Sparks.Speed = NumberRange.new(-3, 3)
	Sparks.Brightness = 4
	Sparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4.4374995), NumberSequenceKeypoint.new(0.1722158, 6.875, 3.125), NumberSequenceKeypoint.new(1, 0.2499998)})
	Sparks.Enabled = false
	Sparks.Acceleration = Vector3.new(0, 40, 0)
	Sparks.Texture = "rbxassetid://6660412891"
	Sparks.Rotation = NumberRange.new(90, 90)
	Sparks.Orientation = Enum.ParticleOrientation.VelocityParallel
	Sparks.Parent = teleport

	local Wave1 = Instance.new("ParticleEmitter")
	Wave1.Name = "Wave1"
	Wave1.Lifetime = NumberRange.new(1, 1)
	Wave1.SpreadAngle = Vector2.new(10, -10)
	Wave1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1702454, 0.7, 0.014881), NumberSequenceKeypoint.new(0.2254601, 0.03125, 0.03125), NumberSequenceKeypoint.new(0.2852761, 0), NumberSequenceKeypoint.new(0.702454, 0), NumberSequenceKeypoint.new(0.8374233, 0.9125, 0.0601461), NumberSequenceKeypoint.new(1, 1)})
	Wave1.LightEmission = 0.4
	Wave1.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(172, 117, 255))
	Wave1.VelocitySpread = 10
	Wave1.Speed = NumberRange.new(1, 3)
	Wave1.Brightness = 10
	Wave1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 1.8805969), NumberSequenceKeypoint.new(0.4098916, 3.4328361, 1.8805971), NumberSequenceKeypoint.new(1, 5.6417904, 2.8059702)})
	Wave1.Enabled = false
	Wave1.RotSpeed = NumberRange.new(200, 400)
	Wave1.Rate = 10
	Wave1.Texture = "rbxassetid://8047533775"
	Wave1.Rotation = NumberRange.new(-180, 180)
	Wave1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	Wave1.Parent = teleport
	
	return teleport
end

local HealingEffect = HealingObject()

local function FATAL(characterModel)
	if not characterModel:FindFirstChild("SOUL_CRACKING") then
		Instance.new("ObjectValue",characterModel).Name = "SOUL_CRACKING"
	if SOUL_KILL then
	characterModel.HumanoidRootPart.Anchored = true
	local CharacterDescendants = characterModel:GetDescendants()
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	task.spawn(function()
				if not characterModel:FindFirstChild("Dreemurr") then
					local event
		local soul = Soul_plrObject:Clone()
		soul:PivotTo(characterModel.HumanoidRootPart.CFrame)
		soul.Parent = workspace.Terrain
		event = soul.Base.hitbox.Touched:Connect(function(hit)
						if hit.Parent:FindFirstChild("Dreemurr") then
							local humnoid = hit.Parent:FindFirstChildOfClass("Humanoid")
							
							if humnoid then
								humnoid.MaxHealth = humnoid.MaxHealth + 20
								humnoid.Health = humnoid.Health + 20
								createSound(Torso,1005386374,2)
								HealingEffect.HealingWave1:Emit(5)
								HealingEffect.HealingWave2:Emit(5)
							end
							event:Disconnect()
							soul:Destroy()
						end
		end)			
				local randomColor = Color3.fromRGB(math.random(0,255),math.random(0,255),math.random(0,255))
				soul.BottomRight.Color = randomColor
				soul.Left.Color = randomColor
				soul.UpperRight.Color = randomColor
				soul.Base.Color = randomColor
				soul.Base.ParticleEmitter.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, randomColor),
					ColorSequenceKeypoint.new(1, randomColor)
				}
					soul:FindFirstChildOfClass("Script").Disabled = false
					task.wait(1)
					characterModel:Destroy()
		end
	end)

	for index,descendant in pairs(CharacterDescendants) do
		if descendant:IsA("BasePart") then
				descendant.Anchored = true
				descendant.CanCollide = false
				descendant.CanQuery = false
				descendant.CanTouch = false
			local tween = TweenService:Create(descendant,TweenInfo.new(1),{Transparency = 1})
			tween:Play()
		end
		if descendant:IsA("Highlight") then
			local tween = TweenService:Create(descendant,TweenInfo.new(1),{OutlineTransparency = 1})
			tween:Play()
		end
		if descendant:IsA("ParticleEmitter") then
			descendant.Enabled = false
		end
		if descendant:IsA("BasePart") or descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("GuiObject") then
			if descendant.Transparency == 1 or descendant.Parent:IsA("Accessory") or descendant.Parent:IsA("Hat") then
			else
				if descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("BasePart") then
					local tween = TweenService:Create(descendant,TweenInfo.new(1),{Transparency = 1})
					tween:Play()
				end			
			end
		end	

		end 
		end
	end	
end

local function shootProjectile(mousehit, hrpPos, Character, Humrp)

	local Fire = projectileObject:Clone()
	local connection
	--connection = Fire.Touched:Connect(function()
	--	damage()
	--end)
	local StartPosition = hrpPos
	local EndPosition =mousehit.Position

	local Magnitude = (StartPosition - EndPosition).Magnitude
	local Midpoint = (StartPosition - EndPosition) / 2

	local PointA = CFrame.new(CFrame.new(StartPosition) * (Midpoint / -1.5)).Position
	local PointB = CFrame.new(CFrame.new(EndPosition) * (Midpoint / 1.5)).Position

	local Offset = Magnitude / 2
	PointA = PointA + Vector3.new(math.random(-Offset,Offset),math.random(5, 15),math.random(-Offset,Offset))
	PointB = PointB + Vector3.new(math.random(-Offset,Offset),math.random(5, 15),math.random(-Offset,Offset))

	Fire.Parent = workspace.Terrain
	Fire.Position = StartPosition
	Fire.Attachment2.TrailTing.Lifetime = 0.25

	local explo = false

	local colorSpeed = 15;
	task.spawn(function()
		local i = 0
		i = i + math.random(1,10)/10
		while true do
			for i = 0,1,0.001*colorSpeed do

				if not explo then
					local colorProjectile = Color3.fromHSV(i,.25,1)
					local color2 = Color3.fromHSV(i,.25,.7)
					Fire.Color = color2
					if Fire:FindFirstChild("Attachment2") then
						Fire.Attachment2.TrailTing.Color = ColorSequence.new(colorProjectile,colorProjectile) end
					task.wait() end
			end
			if explo then
				break
			end
		end
	end)

	local Speed = math.random(10,40)/10;
	Debris:AddItem(Fire,30)
	for i = 5, Magnitude, Speed do
		local Percent = i/Magnitude
		local Coordinate = bezierModule:cubicBezier(Percent, StartPosition, PointA, PointB, EndPosition)
		Fire.CFrame = Fire.CFrame:Lerp(CFrame.new(Coordinate, EndPosition), Percent)
		if Fire:FindFirstChild("detail") then
			Fire.detail.CFrame = Fire.CFrame
		end
		task.wait()
	end
	if Fire then
		MagniDamage(Fire,15,5,20)
		createSound(Fire,3195202353,2.5,true)
		Debris:AddItem(Fire, 1)
		explo = true
		if Fire:FindFirstChild("detail") then
			Fire.detail:Destroy()
		end
		local tween = TweenService:Create(Fire,TweenInfo.new(math.random(3,9)*0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
			Size = Vector3.new(15, 15, 15);
			Transparency = 1;
			CFrame = Fire.CFrame * CFrame.Angles(math.rad(math.random(-50,50)),math.rad(math.random(-50,50)),math.rad(math.random(-50,50)))
		})

		tween:Play()

		Circle.circleeffects(
			Fire,
			10
		)
	end
end

local function dust()
	Torso.Anchored = true
	Head.Anchored = true
	createSound(Torso,5416548293,1,true)
	Character.HumanoidRootPart.Anchored = true
	local CharacterDescendants = Character:GetDescendants()
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	
	
	task.spawn(function()
		MUSIC:Destroy()
		local soul = SoulObject:Clone()
		soul:PivotTo((Character.HumanoidRootPart.CFrame+Vector3.new(0,3,0))*CFrame.Angles(rad(0), rad(180), rad(180)))
		soul.Parent = workspace.Terrain
		soul:FindFirstChildOfClass("Script").Disabled = false
		task.wait(game.Players.RespawnTime)
		Player:LoadCharacter()
	end)

	for index,descendant in pairs(CharacterDescendants) do
		if descendant:IsA("BasePart") then
			local tween = TweenService:Create(descendant,TweenInfo.new(1),{Transparency = 1})
			tween:Play()
		end
		if descendant:IsA("Highlight") then
			local tween = TweenService:Create(descendant,TweenInfo.new(1),{OutlineTransparency = 1})
			tween:Play()
		end
		if descendant:IsA("ParticleEmitter") then
			descendant.Enabled = false
		end
		if descendant:IsA("BasePart") or descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("GuiObject") then
			if descendant.Transparency == 1 or descendant.Parent:IsA("Accessory") or descendant.Parent:IsA("Hat") then
			else
				local Dust = effects.Dust:Clone()
				Dust.Parent = descendant
				if descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("GuiObject") then
				else
					Dust.Enabled = true
					--Dust.Color = ColorSequence.new(descendant.Color)
					Dust:Emit(10*math.abs(descendant.Size.magnitude))
				end
					spawn(function()
						wait(.5)
						Dust.Enabled = false
					end)
				if descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("BasePart") then
					local tween = TweenService:Create(descendant,TweenInfo.new(1),{Transparency = 1})
					tween:Play()
				end			
			end
		end	
		
	end
end

local function dissapear()
	Torso.Anchored = true
	Head.Anchored = true
	Character.HumanoidRootPart.Anchored = true
	local CharacterDescendants = Character:GetDescendants()
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	Head:WaitForChild("HealthBar").Enabled = false
	if Head:FindFirstChild("NameBillboard") then
		Head.NameBillboard.Enabled = false
	end
	for index,descendant in pairs(CharacterDescendants) do
		if descendant:IsA("BasePart") then
			local tween = TweenService:Create(descendant,TweenInfo.new(1),{Transparency = 1})
			tween:Play()
		end
		if descendant:IsA("Highlight") then
			local tween = TweenService:Create(descendant,TweenInfo.new(1),{OutlineTransparency = 1})
			tween:Play()
		end
		if descendant:IsA("ParticleEmitter") then
			descendant.Enabled = false
		end
		if descendant:IsA("BasePart") or descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("GuiObject") then
			if descendant.Transparency == 1 or descendant.Parent:IsA("Accessory") or descendant.Parent:IsA("Hat") then
			else
				if descendant:IsA("Decal")  or descendant:IsA("Texture") or descendant:IsA("BasePart") then
					local tween = TweenService:Create(descendant,TweenInfo.new(1),{Transparency = 1})
					tween:Play()
				end			
			end
		end	
	end
end

local function setKeybindGui()
	local keybinds = effects:WaitForChild("KeyBinds",60)
	keybinds.Parent = game.CoreGui
	return keybinds
end

local function fixHealth()
	Humanoid.MaxHealth = 350
	Humanoid.Health = 350
end

local function removeAnimations()
	if Character:FindFirstChild("Animate") then
		Character.Animate:Remove()
	end
	if Humanoid:FindFirstChild("Animator") then
		Humanoid.Animator:Remove()
	end
end

function givePlayersGui()

	for _, playerInstance in pairs(game:GetService("Players"):GetPlayers()) do
		givePlayerEffectsGui(playerInstance)
	end
	game:GetService("Players").PlayerAdded:Connect(givePlayerEffectsGui)
end

function chatFunc1(msg, timr, size)
	spawn(function()
		msg = "* " .. msg
		timr = 30
		local MRC_A = BrickColor.new("White")
		local MRC_B = BrickColor.new("Really black")
		local namebillboard = Instance.new("BillboardGui")
		if Head:FindFirstChild("NameBillboard") then
			Head:FindFirstChild("NameBillboard"):Destroy()
		end
		local textt = Instance.new("TextBox")
		namebillboard.Size = UDim2.new(20, 0,1, 0)
		namebillboard.Name = "NameBillboard"
		namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
		namebillboard.Parent = Head
		textt.TextWrapped = true
		textt.BackgroundTransparency = 1
		textt.BackgroundColor3 = Color3.new(1, 1, 1)
		textt.TextSize = size or 14
		textt.TextScaled = true
		textt.Font = Enum.Font.Arcade
		textt.Text = msg or ''
		textt.TextStrokeTransparency = 0
		textt.TextStrokeColor3 = MRC_B.Color
		textt.TextColor = MRC_A
		textt.Size = UDim2.new(1, 0, 1, 0)
		textt.Parent = namebillboard
		for i = 1,string.len(msg),1 do
			local newtxt = string.sub(msg,1,i)
			textt.Text = newtxt
			textt.Text = newtxt
			namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
			--CFuncs["Sound"].Create("rbxassetid://434975206", Torso, 5,1)
			local audio = Instance.new("Sound",Head)
			audio.SoundId = "rbxassetid://434975206"
			audio.Name = "voice"
			Debris:AddItem(audio,.5)
			local random = Random.new()
			audio.PlaybackSpeed = random:NextNumber(.99, 1.01)
			audio:Play()
			task.wait(.01)
		end
		local RM = math.random(1,2)
		local DR = 0
		wait(20)
		for i=1,timr do swait()
			if RM == 1 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			elseif RM == 2 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			end
		end
		namebillboard:Destroy()
	end)
end

function chatFunc4(msg, timr, size)
	spawn(function()
		timr = 5
		local MRC_A = BrickColor.new("White")
		local MRC_B = BrickColor.new("Really black")
		local namebillboard = Instance.new("BillboardGui")
		if Head:FindFirstChild("NameBillboard") then
			Head:FindFirstChild("NameBillboard"):Destroy()
		end
		local textt = Instance.new("TextBox")
		namebillboard.Size = UDim2.new(20, 0,.5, 0)
		namebillboard.Name = "NameBillboard"
		namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
		namebillboard.Parent = Head
		textt.TextWrapped = true
		textt.BackgroundTransparency = 1
		textt.BackgroundColor3 = Color3.new(1, 1, 1)
		textt.TextSize = size or 14
		textt.TextScaled = true
		textt.Font = Enum.Font.Arcade
		textt.Text = msg or ''
		textt.TextStrokeTransparency = 1
		textt.TextStrokeColor3 = MRC_B.Color
		textt.TextColor = MRC_A
		textt.Size = UDim2.new(1, 0, 1, 0)
		textt.Parent = namebillboard
		for i = 1,string.len(msg),1 do
			local newtxt = string.sub(msg,1,i)
			textt.Text = newtxt
			textt.Text = newtxt
			namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
			--CFuncs["Sound"].Create("rbxassetid://434975206", Torso, 5,1)
			local audio = Instance.new("Sound",Head)
			audio.SoundId = "rbxassetid://464049227"
			audio.Name = "voice"
			Debris:AddItem(audio,.5)
			local random = Random.new()
			audio.PlaybackSpeed = random:NextNumber(.99, 1.01)
			audio:Play()
			task.wait(.01)
		end
		local RM = math.random(1,2)
		local DR = 0
		wait(20)
		for i=1,timr do swait()
			if RM == 1 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			elseif RM == 2 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			end
		end
		namebillboard:Destroy()
	end)
end

function chatFunc3(msg, timr, size)
	spawn(function()
		timr = 30
		local r = true
		local MRC_A = BrickColor.new("White")
		local MRC_B = BrickColor.new("Really black")
		local namebillboard = Instance.new("BillboardGui")
		if Head:FindFirstChild("NameBillboard") then
			Head:FindFirstChild("NameBillboard"):Destroy()
		end
		local textt = Instance.new("TextBox")
		namebillboard.Size = UDim2.new(20, 0,3, 0)
		namebillboard.Name = "NameBillboard"
		namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
		namebillboard.Parent = Head
		namebillboard.Brightness = 4
		textt.TextWrapped = true
		textt.BackgroundTransparency = 1
		textt.BackgroundColor3 = Color3.new(1, 1, 1)
		textt.TextSize = size or 35
		textt.TextScaled = true
		textt.Font = Enum.Font.Arcade
		textt.Text = msg or ''
		textt.TextStrokeTransparency = 1
		textt.TextStrokeColor3 = MRC_B.Color
		textt.TextColor = MRC_A
		textt.Size = UDim2.new(1, 0, 1, 0)
		textt.Parent = namebillboard
		local ghost_textt1 = textt:Clone()
		ghost_textt1.Parent = namebillboard
		ghost_textt1.ZIndex = -5
        ghost_textt1.TextTransparency = .05
		local ghost_textt2 = textt:Clone()
		ghost_textt2.Parent = namebillboard
		ghost_textt2.ZIndex = -5
		ghost_textt2.TextTransparency = .05
		local ghost_textt3 = textt:Clone()
		ghost_textt3.Parent = namebillboard
		ghost_textt3.ZIndex = -5
		ghost_textt3.TextTransparency = .05
		task.spawn(function()
			while true do
				pcall(function()
					textt.Position = UDim2.new(0,math.random(-50,50)/10,0,math.random(-50,50)/100)
					ghost_textt1.Position = UDim2.new(0,math.random(-25,25),0,math.random(-25,25))
					ghost_textt1.TextTransparency = .7 - textt.TextTransparency
					ghost_textt1.Text = textt.Text
					ghost_textt2.Position = UDim2.new(0,math.random(-25,25),0,math.random(-25,25))
					ghost_textt2.TextTransparency = .7 - textt.TextTransparency
					ghost_textt2.Text = textt.Text
					ghost_textt3.Position = UDim2.new(0,math.random(-25,25),0,math.random(-25,25))
					ghost_textt3.TextTransparency = .7 - textt.TextTransparency
					ghost_textt3.Text = textt.Text
					task.wait() end)
				if r == false then break end
			end
		end)
		--local audio = Instance.new("Sound",Head)
		--audio.SoundId = "rbxassetid://3015952289"
		--audio.Name = "voice"
		for i = 1,string.len(msg),1 do
			local newtxt = string.sub(msg,1,i)
			textt.Text = newtxt
			textt.Text = newtxt
			namebillboard.StudsOffset = Vector3.new(0, 5.25, 0.01)
			local audio = Instance.new("Sound",Head)
			audio.SoundId = "rbxassetid://3015952289"
			audio.Name = "voice"
			--CFuncs["Sound"].Create("rbxassetid://434975206", Torso, 5,1)
			audio.PlaybackSpeed = 1.2
			audio:Play()
			Debris:AddItem(audio,5)
			task.wait(.2)
		end
		--Debris:AddItem(audio,5)
		local RM = math.random(1,2)
		local DR = 0
		task.wait(20)
		for i=1,timr do swait()
			if RM == 1 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			elseif RM == 2 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			end
		end
		r = true
		namebillboard:Destroy()
	end)
end

function chatFunc2(msg, timr, size)
	spawn(function()
		msg = "* " .. msg
		timr = 30
		local MRC_A = BrickColor.new("White")
		local MRC_B = BrickColor.new("Really black")
		local namebillboard = Instance.new("BillboardGui")
		if Head:FindFirstChild("NameBillboard") then
			Head:FindFirstChild("NameBillboard"):Destroy()
		end
		local textt = Instance.new("TextBox")
		namebillboard.Size = UDim2.new(20, 0,1, 0)
		namebillboard.Name = "NameBillboard"
		namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
		namebillboard.Parent = Head
		textt.TextWrapped = true
		textt.BackgroundTransparency = 1
		textt.BackgroundColor3 = Color3.new(1, 1, 1)
		textt.TextSize = size or 14
		textt.TextScaled = true
		textt.Font = Enum.Font.Arcade
		textt.Text = msg or ''
		textt.TextStrokeTransparency = 0
		textt.TextStrokeColor3 = MRC_B.Color
		textt.TextColor = MRC_A
		textt.Size = UDim2.new(1, 0, 1, 0)
		textt.Parent = namebillboard
		for i = 1,string.len(msg),1 do
			local newtxt = string.sub(msg,1,i)
			textt.Text = newtxt
			textt.Text = newtxt
			namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
			--CFuncs["Sound"].Create("rbxassetid://434975206", Torso, 5,1)
			local audio = Instance.new("Sound",Head)
			audio.SoundId = "rbxassetid://387515658"
			audio.Name = "voice"
			Debris:AddItem(audio,.5)
			local random = Random.new()
			audio.PlaybackSpeed = random:NextNumber(.99, 1.01)
			audio:Play()
			task.wait(.01)
		end
		local RM = math.random(1,2)
		local DR = 0
		wait(20)
		for i=1,timr do swait()
			if RM == 1 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			elseif RM == 2 then
				DR = DR + 1
				namebillboard.StudsOffset = Vector3.new(0, 3.25, 0.01)
				textt.TextStrokeTransparency = i/timr
				textt.TextTransparency = i/timr
			end
		end
		namebillboard:Destroy()
	end)
end

Humanoid.WalkSpeed = 18
Humanoid.JumpPower = 50 
Humanoid.JumpHeight = 7.2
local function addOutline()
	local outline = Instance.new("Highlight")
	outline.Parent = Character
	outline.Adornee = Character
	
	outline.DepthMode = Enum.HighlightDepthMode.Occluded
	outline.FillTransparency = 1
	outline.OutlineTransparency = 1
	TweenService:Create(outline,TweenInfo.new(.9,Enum.EasingStyle.Linear),{OutlineTransparency = 0}):Play()
	
	task.spawn(function()
		while true do
			wait(.5) 
			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(255, 128, 128)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(255, 204, 128)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(255, 255, 128)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(128, 255, 128)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(128, 255, 255)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(128, 168, 255)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(255, 128, 255)}):Play() 
			wait(.5)

			TweenService:Create(outline,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{OutlineColor = Color3.fromRGB(255, 128, 207)}):Play() 
			wait(.5)
		end
	end)
end

local function addHPBar()
	local effects = script:WaitForChild("effects",60)
	local healthBar = effects.HealthBar:Clone()
	healthBar.Enabled = true
	healthBar.Parent = Head
	healthBar.Adornee = Head
	healthBar.Frame:WaitForChild("PName",60).Text = Player.Name
	healthBar.Frame.HealthLabel.Text = tostring(math.floor(Humanoid.Health)) .. "/" .. tostring(math.floor(Humanoid.MaxHealth))
	spawn(function()
		while true do
			wait(.5) 
			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(255, 0, 0)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(255, 155, 0)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(255, 255, 0)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(0, 255, 0)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(0, 255, 255)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(0, 155, 255)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(255, 0, 255)}):Play() 
			wait(.5)

			TweenService:Create(healthBar.Frame.PName,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{TextColor3 = Color3.fromRGB(255, 0, 155)}):Play() 
			wait(.5)
		end
	end)
	spawn(function()
		Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
		Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
			local hp = (Humanoid.Health / Humanoid.MaxHealth)
			healthBar.Frame.HealthLabel.Text = tostring(math.floor(Humanoid.Health)) .. "/" .. tostring(math.floor(Humanoid.MaxHealth))	
			healthBar.Frame.Health.PHealth.Size = UDim2.new(hp,0,1,0)
		end)
		Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
			local hp = (Humanoid.Health / Humanoid.MaxHealth)
			healthBar.Frame.HealthLabel.Text = tostring(math.floor(Humanoid.Health)) .. "/" .. tostring(math.floor(Humanoid.MaxHealth))	
			healthBar.Frame.Health.PHealth.Size = UDim2.new(hp,0,1,0)
		end)
	end)
end

local function addEffects()
	local effects = script:WaitForChild("effects",60)
	
	local spark = effects.Sparkle
	local Trail = effects.TrailElectricityBlur
	
	for i = 1,5 do
		if i == 1 then
			local sparkClone = spark:Clone()
			sparkClone.Parent = Torso
			sparkClone.Enabled = true
			local trailClone = Trail:Clone()
			trailClone.Parent = Torso
			trailClone.Enabled = true
		elseif i == 2 then
			local sparkClone = spark:Clone()
			sparkClone.Parent = LeftArm
			sparkClone.Enabled = true
			local trailClone = Trail:Clone()
			trailClone.Parent = LeftArm
			trailClone.Enabled = true
			local Attachment = Instance.new("Attachment")
			Attachment.Position = Vector3.new(0,-.9,0)
			Attachment.Parent = LeftArm
			effects.Stars:Clone().Parent = Attachment
		elseif i == 3 then
			local sparkClone = spark:Clone()
			sparkClone.Parent = LeftLeg
			sparkClone.Enabled = true
			local trailClone = Trail:Clone()
			trailClone.Parent = LeftLeg
			trailClone.Enabled = true
		elseif i == 4 then
			local sparkClone = spark:Clone()
			sparkClone.Parent = RightArm
			sparkClone.Enabled = true
			local trailClone = Trail:Clone()
			trailClone.Parent = RightArm
			trailClone.Enabled = true
			local Attachment = Instance.new("Attachment")
			Attachment.Position = Vector3.new(0,-.9,0)
			Attachment.Parent = RightArm
			effects.Stars:Clone().Parent = Attachment
		elseif i == 5 then
			local sparkClone = spark:Clone()
			sparkClone.Parent = RightLeg
			sparkClone.Enabled = true
			local trailClone = Trail:Clone()
			trailClone.Parent = RightLeg
			trailClone.Enabled = true
		end
	end
end







local function Damagefunc(target,mindam,maxdam)
	local humanoid = target:FindFirstChildOfClass("Humanoid")
	local damage = math.random(mindam,maxdam)
	print(target)
	if humanoid and humanoid ~= Humanoid then
		if (humanoid.Health-damage) <= 0 then
			else
		end
	end
end
	
	

local qui = Enum.EasingStyle.Quint
local io = Enum.EasingDirection.InOut

local chaosSaber1 = ChaosSaber:Clone()
local chaosSaber2 = ChaosSaber:Clone()
chaosSaber1.Parent = RightArm
chaosSaber2.Parent = LeftArm
chaosSaber1.weld.Part0 = RightArm
chaosSaber2.weld.Part0 = LeftArm
chaosSaber1.Transparency = 1
chaosSaber2.Transparency = 1
ChaosSaber:Destroy()

local ChaosBuster = effects:WaitForChild("ChaosBuster")
for i,v in pairs(ChaosBuster:GetDescendants()) do
	if v:IsA("BasePart") then
		v.Anchored = false
	end
end
ChaosBuster.Parent = LeftArm
ChaosBuster.RootPart.RootPart.Part0 = LeftArm

local rootBuster = ChaosBuster.RootPart



local FirePointObject = rootBuster.GunFirePoint
--local table = require(PartCache.Table)

 
-- Make a base cosmetic bullet object. This will be cloned every time we fire off a ray.
local CosmeticBullet = Instance.new("Part")
CosmeticBullet.Material = Enum.Material.Neon
CosmeticBullet.Color = Color3.fromRGB(145, 145, 145)
CosmeticBullet.CanCollide = false
CosmeticBullet.Anchored = true
CosmeticBullet.Size = Vector3.new(0.5, 0.5, 0.5)
CosmeticBullet.Shape = Enum.PartType.Ball

local Attachment0 = Instance.new("Attachment")
Attachment0.Name = "Attachment0"
Attachment0.CFrame = CFrame.new(0, 0.25, 0)
Attachment0.WorldPosition = Vector3.new(0, 0.25, 0)
Attachment0.WorldCFrame = CFrame.new(0, 0.25, 0)
Attachment0.Position = Vector3.new(0, 0.25, 0)
Attachment0.Parent = CosmeticBullet

local Attachment1 = Instance.new("Attachment")
Attachment1.Name = "Attachment1"
Attachment1.CFrame = CFrame.new(0, -0.25, 0)
Attachment1.WorldPosition = Vector3.new(0, -0.25, 0)
Attachment1.WorldCFrame = CFrame.new(0, -0.25, 0)
Attachment1.Position = Vector3.new(0, -0.25, 0)
Attachment1.Parent = CosmeticBullet

local Trail = Instance.new("Trail")
Trail.FaceCamera = true
Trail.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(91, 91, 91))
Trail.WidthScale = NumberSequence.new(2)
Trail.LightInfluence = 1
Trail.Transparency = NumberSequence.new(0, 1)
Trail.TextureLength = 0.625
Trail.LightEmission = 1
Trail.Enabled = false
Trail.MaxLength = 15
Trail.Texture = "rbxassetid://1978704853"
Trail.MinLength = 0
Trail.Lifetime = 0.23
Trail.Parent = CosmeticBullet

Trail.Attachment0 = Attachment0
Trail.Attachment1 = Attachment1



-- New raycast parameters.
local CastParams = RaycastParams.new()
CastParams.IgnoreWater = true
CastParams.FilterType = Enum.RaycastFilterType.Blacklist
CastParams.FilterDescendantsInstances = {Character}

  
local function Reflect(surfaceNormal, bulletNormal)
	return bulletNormal - (2 * bulletNormal:Dot(surfaceNormal) * surfaceNormal)
end

-- The pierce function can also be used for things like bouncing.
-- In reality, it's more of a function that the module uses to ask "Do I end the cast now, or do I keep going?"
-- Because of this, you can use it for logic such as ray reflection or other redirection methods.
-- A great example might be to pierce or bounce based on something like velocity or angle.
-- You can see this implementation further down in the OnRayPierced function.
function CanRayPierce(cast, rayResult, segmentVelocity)

	-- Let's keep track of how many times we've hit something.
	local hits = cast.UserData.Hits
	if (hits == nil) then
		-- If the hit data isn't registered, set it to 1 (because this is our first hit)
		cast.UserData.Hits = 1
	else
		-- If the hit data is registered, add 1.
		cast.UserData.Hits += 1
	end

	-- And if the hit count is over 3, don't allow piercing and instead stop the ray.
	if (cast.UserData.Hits > 3) then
		return false
	end

	-- Now if we make it here, we want our ray to continue.
	-- This is extra important! If a bullet bounces off of something, maybe we want it to do damage too!
	-- So let's implement that.
	local hitPart = rayResult.Instance
	if hitPart ~= nil and hitPart.Parent ~= nil then
		local humanoid = hitPart.Parent:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if humanoid ~= Humanoid then
				if (humanoid.Health-10) <= 0 then
				else
				end
			end
		end
	end

	-- And then lastly, return true to tell FC to continue simulating.
	return true

	--[[
	-- This function shows off the piercing feature literally. Pass this function as the last argument (after bulletAcceleration) and it will run this every time the ray runs into an object.
	
	-- Do note that if you want this to work properly, you will need to edit the OnRayPierced event handler below so that it doesn't bounce.
	
	if material == Enum.Material.Plastic or material == Enum.Material.Ice or material == Enum.Material.Glass or material == Enum.Material.SmoothPlastic then
		-- Hit glass, plastic, or ice...
		if hitPart.Transparency >= 0.5 then
			-- And it's >= half transparent...
			return true -- Yes! We can pierce.
		end
	end
	return false
	--]]
end

function Fire(direction)
	-- Called when we want to fire the gun.
	
	-- Note: Above isn't in the event as it will prevent the CanFire value from being set as needed.

	-- UPD. 11 JUNE 2019 - Add support for random angles.
	local directionalCF = CFrame.new(Vector3.new(), direction)
	-- Now, we can use CFrame orientation to our advantage.
	-- Overwrite the existing Direction value.
	local direction = (directionalCF * CFrame.fromOrientation(0, 0, RNG:NextNumber(0, TAU)) * CFrame.fromOrientation(math.rad(RNG:NextNumber(MIN_BULLET_SPREAD_ANGLE, MAX_BULLET_SPREAD_ANGLE)), 0, 0)).LookVector

	-- UPDATE V6: Proper bullet velocity!
	-- IF YOU DON'T WANT YOUR BULLETS MOVING WITH YOUR CHARACTER, REMOVE THE THREE LINES OF CODE BELOW THIS COMMENT.
	-- Requested by https://www.roblox.com/users/898618/profile/
	-- We need to make sure the bullet inherits the velocity of the gun as it fires, just like in real life.
	local humanoidRootPart = Character:WaitForChild("HumanoidRootPart", 1)	-- Add a timeout to this.
	local myMovementSpeed = humanoidRootPart.Velocity							-- To do: It may be better to get this value on the clientside since the server will see this value differently due to ping and such.
	local modifiedBulletSpeed = (direction * BULLET_SPEED)-- + myMovementSpeed	-- We multiply our direction unit by the bullet speed. This creates a Vector3 version of the bullet's velocity at the given speed. We then add MyMovementSpeed to add our body's motion to the velocity.

	if PIERCE_DEMO then
 	end

 	-- Optionally use some methods on simBullet here if applicable.

	-- Play the sound
end

---------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------
-- Event Handlers

function OnRayHit(cast, raycastResult, segmentVelocity, cosmeticBulletObject)
	-- This function will be connected to the Caster's "RayHit" event.
	local hitPart = raycastResult.Instance
	local hitPoint = raycastResult.Position
	local normal = raycastResult.Normal
	if hitPart ~= nil and hitPart.Parent ~= nil then -- Test if we hit something
		local humanoid = hitPart.Parent:FindFirstChildOfClass("Humanoid") -- Is there a humanoid?
		if humanoid then
		end
	end
end

function OnRayPierced(cast, raycastResult, segmentVelocity, cosmeticBulletObject)
	-- You can do some really unique stuff with pierce behavior - In reality, pierce is just the module's way of asking "Do I keep the bullet going, or do I stop it here?"
	-- You can make use of this unique behavior in a manner like this, for instance, which causes bullets to be bouncy.
	local position = raycastResult.Position
	local normal = raycastResult.Normal

	local newNormal = Reflect(normal, segmentVelocity.Unit)
	cast:SetVelocity(newNormal * segmentVelocity.Magnitude)
	local rsound = math.random(1,4)
	if rsound == 1 then
		createSound(cast.RayInfo.CosmeticBulletObject,8011829608,1,true,math.random(100,200)/100)
	elseif rsound == 2 then
		createSound(cast.RayInfo.CosmeticBulletObject,8011832613,1,true,math.random(100,200)/100)
	elseif rsound == 3 then
		createSound(cast.RayInfo.CosmeticBulletObject,8011833963,1,true,math.random(100,200)/100)
	elseif rsound == 4 then
		createSound(cast.RayInfo.CosmeticBulletObject,8011834865,1,true,math.random(100,200)/100)
	end
	-- It's super important that we set the cast's position to the ray hit position. Remember: When a pierce is successful, it increments the ray forward by one increment.
	-- If we don't do this, it'll actually start the bounce effect one segment *after* it continues through the object, which for thin walls, can cause the bullet to almost get stuck in the wall.
	cast:SetPosition(position)

	-- Generally speaking, if you plan to do any velocity modifications to the bullet at all, you should use the line above to reset the position to where it was when the pierce was registered.
end

function OnRayUpdated(cast, segmentOrigin, segmentDirection, length, segmentVelocity, cosmeticBulletObject)
	-- Whenever the caster steps forward by one unit, this function is called.
	-- The bullet argument is the same object passed into the fire function.
	if cosmeticBulletObject == nil then return end
	local bulletLength = cosmeticBulletObject.Size.Z / 2 -- This is used to move the bullet to the right spot based on a CFrame offset
	local baseCFrame = CFrame.new(segmentOrigin, segmentOrigin + segmentDirection)
	cosmeticBulletObject.Trail.Enabled = true
	cosmeticBulletObject.CFrame = baseCFrame * CFrame.new(0, 0, -(length - bulletLength))
end

function OnRayTerminated(cast)
	local cosmeticBullet = cast.RayInfo.CosmeticBulletObject
	if cosmeticBullet ~= nil then
		cosmeticBullet:Destroy()
		
	end
end 

for i,v in pairs(rootBuster:GetChildren()) do
	if v:IsA("BasePart") then
		v.Transparency = 1
	end
end
 
local function equipchaossaber()
	--tlerp(rsW,{C0 = CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(90),rad(0))},.7,qui,io)
	task.spawn(function()
		chaossaber = true
		task.spawn(function()
			createSound(Torso,6854065655,5,true)
			for i = 1,20 do
				if chaossaber == false then
					chaosSaber1.Transparency = 1
					chaosSaber2.Transparency = 1
					break
				else
					
				chaosSaber1.Transparency = 0
				chaosSaber2.Transparency = 0
				task.wait(.025)
				chaosSaber1.Transparency = 1
				chaosSaber2.Transparency = 1
				task.wait(.025)
				end
			end
			--task.wait(.5)
			if chaossaber == true then
				createSound(Torso,3204912978,7,true,.95)
			chaosSaber1.Transparency = 0
			chaosSaber2.Transparency = 0
			end
			chaosSaber1.glare.ParticleEmitter:Emit(1)
			chaosSaber2.glare.ParticleEmitter:Emit(1)
			
		end)
		tlerp(rsW,{C0 = CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(30),rad(140))},2,Enum.EasingStyle.Sine,io)
		tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(0),rad(-30),rad(-140))},2,Enum.EasingStyle.Sine,io)
	task.wait(2.7)
		tlerp(rsW,{C0 = CFrame.new(1,.5,0) * CFrame.Angles(rad(15),rad(50),rad(34))},1,Enum.EasingStyle.Sine,io)
		tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(15),rad(-50),rad(-34))},1,Enum.EasingStyle.Sine,io)
		task.wait(1)
    end)
end

local function unequipchaossaber()
	if chaossaber == true then
	chaosSaber1.Transparency = 1
	chaosSaber2.Transparency = 1
	chaossaber = false
	end
end

local function equipchaosbuster()
	--tlerp(rsW,{C0 = CFrame.new(1,.5,0) * CFrame.Angles(rad(0),rad(90),rad(0))},.7,qui,io)
	task.spawn(function()
		chaosbuster = true
		task.spawn(function()
			if chaosbuster == true then
				createSound(Torso,6802318846,2,true,1.5)
				TweenService:Create(LeftArm,TweenInfo.new(.5),{Transparency = 1}):Play()
				for i,v in pairs(rootBuster:GetChildren()) do
					if v:IsA("BasePart") then
						TweenService:Create(v,TweenInfo.new(.5),{Transparency = 0}):Play()
					end
				end
			end

		end)
		tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(90),rad(-90),rad(0)) * CFrame.Angles(rad(-25),rad(-25),rad(0)) },1,Enum.EasingStyle.Sine,io)
		task.wait(1)
	end)
end

local function unequipchaosbuster()
	if chaosbuster == true then
		TweenService:Create(LeftArm,TweenInfo.new(.5),{Transparency = 0}):Play()
		for i,v in pairs(rootBuster:GetChildren()) do
			if v:IsA("BasePart") then
				TweenService:Create(v,TweenInfo.new(.5),{Transparency = 1}):Play()
			end
		end
		chaosbuster = false
	end
end 

local function scanPlayers(origin,radius)
	local Nearby = {}
	for _,ch in next, workspace:GetChildren() do
		local cha = ch:FindFirstChildOfClass("Humanoid")
		if cha and cha.Parent and ch ~= Humanoid and ch:FindFirstChild("HumanoidRootPart") then
			local Magnitude = (origin.Position - ch.HumanoidRootPart.Position).magnitude
			if Magnitude <= radius then
				local characterInformation = {Magnitude,cha}
				table.insert(Nearby, characterInformation)
			end
		end
	end
	return Nearby 
end

local function HYPERGONER()
	if usingHYPERGONER then
		local loop = false
		local hypegon = HYPERGONERObject:Clone()
		dissapear()
		for i,v in pairs(hypegon:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "hitbox" then
				v.Transparency = 1
				TweenService:Create(v,TweenInfo.new(1),{Transparency = 0}):Play()
			end
		end
		hypegon.Parent = workspace.Terrain
		hypegon:PivotTo(Character:WaitForChild("HumanoidRootPart").CFrame*CFrame.new(0,5,0))
		
		local jaw = hypegon.head.jaw
		local hitbox = hypegon.hitbox
		local head = hitbox.head
		
		local originC0_head = head.C0
		local originC0_jaw = jaw.C0
		
		task.wait(1)
		Humanoid.MaxHealth = "nan"
        Humanoid.Health = "nan"
		task.spawn(function()
			createSound(hitbox,3015952289,3,true)
			task.wait(.5)
			createSound(hitbox,3015952289,3,true,.7)
		end)
		for i = 1,6 do
			tlerp(head,{C0 = originC0_head * CFrame.new(3,4,0) * CFrame.Angles(rad(0),rad(0),rad(-25))},.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
			tlerp(jaw,{C0 = originC0_jaw * CFrame.new(3,-5,0) * CFrame.Angles(rad(0),rad(0),rad(35))},.2,Enum.EasingStyle.Sine,Enum.EasingDirection.In)
			task.wait(.2)
			tlerp(head,{C0 = originC0_head * CFrame.new(2,1.5,0) * CFrame.Angles(rad(0),rad(0),rad(-5))},.2,Enum.EasingStyle.Sine,Enum.EasingDirection.In)
			tlerp(jaw,{C0 = originC0_jaw * CFrame.new(1,-2.5,0) * CFrame.Angles(rad(0),rad(0),rad(15))},.2,Enum.EasingStyle.Sine,Enum.EasingDirection.Out)
			task.wait(.2)
		end
		tlerp(head,{C0 = originC0_head * CFrame.new(3.25,4.05,0) * CFrame.Angles(rad(0),rad(0),rad(-27.5))},1,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
		tlerp(jaw,{C0 = originC0_jaw * CFrame.new(3.25,-5.15,0) * CFrame.Angles(rad(0),rad(0),rad(37.5))},1,Enum.EasingStyle.Back,Enum.EasingDirection.Out)
		task.wait(.5)
		loop = true
		for i,v in pairs(hitbox:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = true
			end
		end
		local boxhit
		local debounce = false
		boxhit = hitbox.Touched:Connect(function(part)
			local hum = part.Parent:FindFirstChildOfClass("Humanoid")
			if part.Parent:FindFirstChildOfClass("Humanoid") and part.Parent ~= Character and debounce == false then	
				part:Destroy()
                --debounce = true
				--task.wait(.5)
				--debounce = false
			end
		end)
		task.spawn(function()
			
			while true do
				local rCF = CFrame.new(math.random(1,100)/250,math.random(1,100)/250,math.random(1,100)/250)
				local rCF_A = CFrame.Angles(rad(math.random(1,100)/250),rad(math.random(1,100)/250),rad(math.random(1,100)/250))
				tlerp(head,{C0 = originC0_head * CFrame.new(3.25,4.05,0) * rCF * CFrame.Angles(rad(0),rad(0),rad(-27.5)) * rCF_A },.01,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
				tlerp(jaw,{C0 = originC0_jaw * CFrame.new(3.25,-5.15,0) * rCF * CFrame.Angles(rad(0),rad(0),rad(37.5)) * rCF_A },.01,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
				if loop == false then
					break
				end
				task.wait()
			end
		end)
		task.spawn(function()
			while true do
			local x = hitbox.Position.X + math.random(-hitbox.Size.X*25/2,hitbox.Size.X*25/2)
			local y = hitbox.Position.Y + math.random(-hitbox.Size.Y*25/2,hitbox.Size.Y*25/2)
				local z = hitbox.Position.Z + math.random(-hitbox.Size.Z*25/2,hitbox.Size.Z*25/2)
				task.spawn(function()
					local touch
				local rSizeMultiplier = math.random(80,200)/100
				local flyingdebri = DebrisObject:Clone()
				flyingdebri.Parent = workspace.Terrain
				flyingdebri.Position = Vector3.new(x,y,z)
					flyingdebri.Size = flyingdebri.Size * rSizeMultiplier
					-- i hate having to use touched, theres probably some better way but im lazy ok

					-- i hate setting variables for tweens but unfortunatly i have to
					flyingdebri.Transparency = 1
					local tween1 = TweenService:Create(flyingdebri,TweenInfo.new(rSizeMultiplier*2,Enum.EasingStyle.Sine,Enum.EasingDirection.In),{Position = hitbox.Position,Size = flyingdebri.Size * rSizeMultiplier/4})
					local tween2 = TweenService:Create(flyingdebri,TweenInfo.new(rSizeMultiplier/1.5,Enum.EasingStyle.Linear),{Transparency = 0})
					tween1:Play()
					tween2:Play()
					touch = flyingdebri.Touched:Connect(function(part)
						local hum = part.Parent:FindFirstChildOfClass("Humanoid")
						if part.Parent:FindFirstChildOfClass("Humanoid") and part.Parent ~= Character then							
							createSound(part,3384489343,1)
							task.wait(.01)
							flyingdebri:Destroy()
							touch:Disconnect()
						end
					end)
					tween1.Completed:Wait()					
					touch:Disconnect()
					flyingdebri:Destroy()
					end)
			if loop == false then
				break
			end task.wait(math.random(1,2)/10) end
		end)
		task.spawn(function()
			while true do
				local allHum = scanPlayers(hitbox,125)
				task.spawn(function()
				for index, subTable in ipairs(allHum) do

				 task.spawn(function()
						pcall(function()
							local distance = subTable[1]
							local hum = subTable[2]
							--local allHum = getHumanoid:GetCurrent()
					if distance <= 125 then
					local MOVER_P = Instance.new("BodyPosition")
					MOVER_P.Name = "MOVER_P" -- so i can check the name thing 4 later
					MOVER_P.Parent = hum.Parent.HumanoidRootPart
								MOVER_P.Position = hitbox.Position
								MOVER_P.MaxForce = Vector3.new(3000,3000,3000)
					end
				end) end) end end)
				if loop == false then
					for i,v in pairs(workspace:GetDescendants()) do
						if v.Name == "MOVER_P" then
							v:Destroy()
						end
					end
					break
				end 
				task.wait(1) -- 1 because to save on memory, subject to change
			end
		end)
		createSound(hitbox,3223045506,4,true,.2)
		task.wait(7)
		local colorcorrect = Instance.new("ColorCorrectionEffect")
		colorcorrect.Name = "HYPE"
		colorcorrect.Parent = game:GetService("Lighting")
		Debris:AddItem(colorcorrect,9)
		local beamofcircle = Instance.new("Part")
		beamofcircle.Shape = Enum.PartType.Ball
		beamofcircle.Material = Enum.Material.Neon
		beamofcircle.Size = Vector3.new(0.05,0.05,0.05)
		beamofcircle.CanCollide = false
		beamofcircle.CanTouch = false
		beamofcircle.CanQuery = false
		beamofcircle.Anchored = true
		beamofcircle.CastShadow = false
		beamofcircle.Position = hitbox.Position
		beamofcircle.Parent = workspace.Terrain
		TweenService:Create(beamofcircle,TweenInfo.new(7,Enum.EasingStyle.Linear),{Size = Vector3.new(50,50,50)}):Play()
		TweenService:Create(colorcorrect,TweenInfo.new(7,Enum.EasingStyle.Linear),{Brightness = 2}):Play()
		task.wait(7)
		for i,v in pairs(hypegon:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "hitbox" then
				v.Transparency = 1
			end
		end
		for i,v in pairs(hitbox:GetDescendants()) do
			if v:IsA("ParticleEmitter") then
				v.Enabled = false
			end
		end
		MUSIC:Destroy()
		beamofcircle:Destroy()
		loop = false
		TweenService:Create(colorcorrect,TweenInfo.new(.5,Enum.EasingStyle.Linear),{Brightness = 0}):Play()
		createSound(hitbox,3508218059,5,true,.8)
		task.wait(.5)
		Debris:AddItem(hypegon,3)
		colorcorrect:Destroy()	
		task.wait(5)
		Player:LoadCharacter()
	end
end

function keyBinding(key)
if not usingHYPERGONER then
		task.spawn(function() 
			if key == Enum.KeyCode.M or key == "m" then	
				if not MUSIC.Playing then
					MUSIC.Playing = true
					chatFunc4("MUSIC unmuted!")
				else
					MUSIC.Playing = false
					chatFunc4("MUSIC muted!")
				end
			end
			if key == Enum.KeyCode.N or key == "n" then
				if not SOUL_KILL then
					SOUL_KILL = true
					chatFunc4("SOUL KILL mode Enabled!")
				else
					SOUL_KILL = false
					chatFunc4("SOUL KILL mode Disabled!")
				end
			end
			if key == Enum.KeyCode.Z or key == "z" then
				local tpFX = TPEffect()
				local currentTorsoPosition = Torso.Position
				Character.HumanoidRootPart.Anchored = true
				Humanoid.PlatformStand = false
				local tpPosition = mouse.Hit
				local pos1 = tpFX:Clone()
				local pos2 = tpFX:Clone()
				pos1.Parent = workspace.Terrain
				pos1.Position = currentTorsoPosition
				pos1.Wave1:Emit(10)
				pos1.Wave2:Emit(10)
				pos1.Sparks:Emit(10)
				pos1.GroundRadialEffect:Emit(10)
				createSound(pos1,3790156491,1,true,.8)
				task.wait(.1)
				Character:PivotTo(CFrame.new(tpPosition.Position+Vector3.new(0,3,0)))
				createSound(pos2,3790156491,1,true,.8)
				Character.HumanoidRootPart.Anchored = false
				Humanoid.PlatformStand = false
				pos2.Parent = workspace.Terrain
				pos2.Position = tpPosition.Position+Vector3.new(0,5,0)
				pos2.Wave1:Emit(10)
				pos2.Wave2:Emit(10)
				pos2.Sparks:Emit(10)
				pos2.GroundRadialEffect:Emit(10)
				Debris:AddItem(pos1,5)
				Debris:AddItem(pos2,5)
			end
		if key == Enum.KeyCode.One or key == "1" and mode ~= 2 then
			mode = 2
			attack = true
			RightArm.Attachment.Stars.Enabled = true
			LeftArm.Attachment.Stars.Enabled = true
			script.cameraPoint.Disabled = false
			createSound(Torso,8876214443,1,true,.5)
			chatFunc2("Shocker breaker!")
			unequipchaossaber()
			unequipchaosbuster()
			chaossaber = false
		elseif key == Enum.KeyCode.One or key == "1" and mode == 2 then
			mode = 1
			attack = false
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = true
			unequipchaossaber()
			unequipchaosbuster()
			chaossaber = false
		end		

		if key == Enum.KeyCode.Two or key == "2" and mode ~= 3 then

			mode = 3
			equipchaossaber()
			attack = true
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = false
			unequipchaosbuster()
			chatFunc2("Chaos saber!")
		elseif key == Enum.KeyCode.Two or key == "2" and mode == 3 then
			mode = 1
			attack = false
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = true
			unequipchaossaber()
			unequipchaosbuster()
			chaossaber = false
		end	
		
		if key == Enum.KeyCode.Three or key == "3" and mode ~= 4 then
			mode = 4
			attack = true
			RightArm.Attachment.Stars.Enabled = true
			LeftArm.Attachment.Stars.Enabled = true
			script.cameraPoint.Disabled = false
			createSound(Torso,3140268287,1,true)
			chatFunc2("Star blazing!")
			unequipchaossaber()
			unequipchaosbuster()
			chaossaber = false
		elseif key == Enum.KeyCode.Three or key == "3" and mode == 4 then
			mode = 1
			attack = false
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = true
			unequipchaossaber()
			unequipchaosbuster()
			chaossaber = false
		end	
		
		if key == Enum.KeyCode.Four or key == "4" and mode ~= 5 then
			mode = 5
			equipchaosbuster()
			attack = true
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = false
			chatFunc2("Chaos buster!")
			unequipchaossaber()
			chaossaber = false
		elseif key == Enum.KeyCode.Four or key == "4" and mode == 5 then
			mode = 1
			unequipchaosbuster()
			attack = false
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = true
			unequipchaossaber()
			chaossaber = false
		end				
			if key == Enum.KeyCode.Five or key == "5" and mode ~= 6 then
				mode = 6
				unequipchaosbuster()
				attack = true
				RightArm.Attachment.Stars.Enabled = false
				LeftArm.Attachment.Stars.Enabled = false
				script.cameraPoint.Disabled = false
				createSound(Torso,3733423898,1,true)
				chatFunc2("Angel of Death!")
				unequipchaossaber()
				chaossaber = false
			elseif key == Enum.KeyCode.Five or key == "5" and mode == 6 then
				mode = 1
				unequipchaosbuster()
				attack = false
				RightArm.Attachment.Stars.Enabled = false
				LeftArm.Attachment.Stars.Enabled = false
				script.cameraPoint.Disabled = true
				unequipchaossaber()
				chaossaber = false
		end	
		if key == Enum.KeyCode.Six or key == "6" and mode ~= 7 then
			mode = 7
				unequipchaosbuster()
				unequipchaossaber()
				attack = false
				usingHYPERGONER = true
				chaossaber = false
			RightArm.Attachment.Stars.Enabled = false
			LeftArm.Attachment.Stars.Enabled = false
			script.cameraPoint.Disabled = false
			chatFunc2("Now, ENOUGH messing around!")
				task.wait(3)
				chatFunc2("It's time to purge this timeline once and for all!")
				task.wait(4)
				if Head:FindFirstChild("NameBillboard") then
					Head:FindFirstChild("NameBillboard"):Destroy()
				end
				HYPERGONER()
		end
	end) end

end


function MagniDamage(Part, magni, mindam, maxdam)
	for _, c in pairs(workspace:children()) do
		local hum = c:findFirstChildOfClass("Humanoid")
		if hum ~= nil then
			local head = c:findFirstChild("Head")
			if head ~= nil then
				local targ = head.Position - Part.Position
				local mag = targ.magnitude
				if magni >= mag and c.Name ~= Player.Name then
					Damagefunc(head.Parent, mindam, maxdam)
				end
			end
		end
	end
end

 
local camera = workspace.CurrentCamera
 

local start = tick()


function shakeCamera(initialTrauma, shakeCentre, blur) 
	--initialTrauma (necessary, number) = intensity of camera shake
	--shakeCentre (optional, vector3) = position of shake; distance between shake and camera reduces intensity if shakeCentre is given
	--blur (optional, bool) = create blur effect with camera shake
	
	local iterator = 0
	local seed = Random.new():NextNumber()
	
	local blurEffect = nil
	if blur == true then
		blurEffect = Instance.new("BlurEffect")
		blurEffect.Size = 0
		blurEffect.Parent = game.Lighting
	end
	
	while initialTrauma > 0 do
		
		game:GetService("RunService").Heartbeat:Wait()
		
		local now = tick() - start
		
		iterator += 1
		
		local shake = (initialTrauma ^ 2)
		
		if shakeCentre then
			local distance = (camera.CFrame.Position - shakeCentre).Magnitude
			
			shake = shake / math.clamp((distance * 0.1), 0.7, math.huge)
		end
		
		local noiseX = (math.noise(iterator, now, seed)) * shake
		local noiseY = (math.noise(iterator + 1, now, seed)) * shake
		local noiseZ = (math.noise(iterator + 2 + 1, now, seed)) * shake
		
		Humanoid.CameraOffset = Vector3.new(noiseX, noiseY, noiseZ)
		camera.CFrame = camera.CFrame * CFrame.Angles(noiseX / 50, noiseY / 50, noiseZ / 50)
		
		if blurEffect then
			blurEffect.Size = shake * 12
		end
		
		local falloffSpeed = 1.6
		initialTrauma = math.clamp(initialTrauma - falloffSpeed * game:GetService("RunService").Heartbeat:Wait(), 0, 1)
	end

	Humanoid.CameraOffset = Vector3.new(0, 0, 0)
	
	if blurEffect then
		blurEffect:Destroy()
	end
end

--example of use:

function damage(charmodel,amount)
	if charmodel ~= Character then
	local head = charmodel.Head
	local humanoid = charmodel:FindFirstChildOfClass("Humanoid")
	SoulshatterEffects.LHE(head)
		if humanoid then
			if (humanoid.Health-amount) <= 0 then
				FATAL(humanoid.Parent)
			else
 
			end
	end
	end
end

 
local function mode2Animate()
	spawn(function()
		while true do
			if mode == 2 and attack == true then
			
				local sine = time()
				--print(sine)
			rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3,0,30+cos(sine*1.85)/1.7)*CFrame.Angles(cos(sine*2)/8,0,0),.02)
			--earsW.C0=earsW.C0:lerp(CFrame.new(-cos(sine*2)/20.2,cos(sine*1.22)/18,0)*CFrame.Angles(0,cos(sine*1.779)/12.5,0),.35)
			neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(cos(sine*2.2)/6.6,0,cos(sine*2)/10),.35)
				rsW.C0=rsW.C0:lerp(rsWO*CFrame.new(.5,.25,.5)*CFrame.Angles(-rad(125.72)+cos(sine*15)/3,-rad(76.48)-cos(sine*5)/2.5,0),.01)
				lsW.C0=lsW.C0:lerp(lsWO*CFrame.new(-.5,.25,.5)*CFrame.Angles(-rad(125.72)+cos(sine*15)/3,-rad(-76.48)-cos(sine*5)/2.5,0),.01)
			rhW.C0=rhW.C0:lerp(rhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
			lhW.C0=lhW.C0:lerp(lhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
			end
		swait()
		end
	end)
end

local function mode6Animate()
	spawn(function()
		while true do
			if mode == 6 and attack == true then

				local sine = time()
				--print(sine)
				rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3/2,0,3+cos(sine*1.85)/1.7/2)*CFrame.Angles(cos(sine*2)/8,0,0),.02)
				--earsW.C0=earsW.C0:lerp(CFrame.new(-cos(sine*2)/20.2,cos(sine*1.22)/18,0)*CFrame.Angles(0,cos(sine*1.779)/12.5,0),.35)
				neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(cos(sine*2.2)/6.6,0,cos(sine*2)/10),.35)
				rsW.C0=rsW.C0:lerp(rsWO*CFrame.new(.5,.25,.5)*CFrame.Angles(-rad(125.72)+cos(sine*15)/3,-rad(76.48)-cos(sine*5)/2.5,0),.005)
				lsW.C0=lsW.C0:lerp(lsWO*CFrame.new(-.5,.25,.5)*CFrame.Angles(-rad(125.72)+cos(sine*15)/3,-rad(-76.48)-cos(sine*5)/2.5,0),.005)
				rhW.C0=rhW.C0:lerp(rhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
				lhW.C0=lhW.C0:lerp(lhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
			end
			swait()
		end
	end)
end

local function mode5Animate()
	spawn(function()
		while true do
			if mode == 5 and attack == true then

				local sine = time()
				--print(sine)
				--print(sine)
				rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3,0,3+cos(sine*1.85)/1.7)*CFrame.Angles(cos(sine*2)/8,rad(25),rad(-25)),.02)
				rsW.C0=rsW.C0:lerp(rsWO*CFrame.new(.5,-.25,-1.75)*CFrame.Angles(-rad(23)+cos(sine*2)/9.5,-rad(13)-cos(sine*2)/2.5,0)*CFrame.Angles(rad(100),rad(45),rad(45)),.35)
				neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(cos(sine*2.2)/6.6,0,cos(sine*2)/10) *CFrame.Angles(rad(0),rad(-25),rad(0)) ,.35)
				rhW.C0=rhW.C0:lerp(rhWO*CFrame.new(.60,.5,.05)*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
				lhW.C0=lhW.C0:lerp(lhWO*CFrame.new(-.75,1,.05)*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
			end
			swait()
		end
	end)
end





local function mode3Animate()
	spawn(function()
		while true do
			if mode == 3 and attack == true then

				local sine = time()
				--print(sine)
				rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3,0,3+cos(sine*1.85)/1.7)*CFrame.Angles(cos(sine*2)/8,0,0),.02)
				--earsW.C0=earsW.C0:lerp(CFrame.new(-cos(sine*2)/20.2,cos(sine*1.22)/18,0)*CFrame.Angles(0,cos(sine*1.779)/12.5,0),.35)
				neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(cos(sine*2.2)/6.6,0,cos(sine*2)/10),.35)
				rhW.C0=rhW.C0:lerp(rhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
				lhW.C0=lhW.C0:lerp(lhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
			end
			swait()
		end
	end)
end

local function mode4Animate()
	spawn(function()
		while true do
			if mode == 4 and attack == true then

				local sine = time()
				--print(sine)
				rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3,0,30+cos(sine*1.85)/1.7)*CFrame.Angles(cos(sine*2)/8,0,0),.02)
				--earsW.C0=earsW.C0:lerp(CFrame.new(-cos(sine*2)/20.2,cos(sine*1.22)/18,0)*CFrame.Angles(0,cos(sine*1.779)/12.5,0),.35)
				neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(cos(sine*2.2)/6.6,0,cos(sine*2)/10),.35)
				rsW.C0=rsW.C0:lerp(rsWO*CFrame.Angles(-rad(125.72)+cos(sine*15)/3,-rad(76.48)-cos(sine*5)/2.5,0),.01)
				lsW.C0=lsW.C0:lerp(lsWO*CFrame.Angles(-rad(125.72)+cos(sine*15)/3,-rad(-76.48)-cos(sine*5)/2.5,0),.01)
				rhW.C0=rhW.C0:lerp(rhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
				lhW.C0=lhW.C0:lerp(lhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
			end
			swait()
		end
	end)
end

local debounce = false

local function fallingStar(position,typ)
	if typ == 1 then
		local star = StarObject:Clone()
		star.Position = position+Vector3.new(50,100,0)
		star.Parent = workspace
		star.Size = Vector3.new(2,10,10)
		star.Orientation = Vector3.new(0,90,0)
		createSound(star,2783294896,2,true)
		
		local stop = false
		
		task.defer(function()
			local speed = 10
			while true do
				for i = 0,1,0.001*speed do
					star.Color = Color3.fromHSV(i,.5,1)
					task.wait()
					if stop then
						break
					end
				end
				if stop then
					break
				end
			end
		end)
		
		local color = ColorSequence.new{
			ColorSequenceKeypoint.new(0,Color3.new(1, 0.215686, 0.215686)),
			ColorSequenceKeypoint.new(.25,Color3.new(1, 0.968627, 0)),
			ColorSequenceKeypoint.new(.5,Color3.new(0.356863, 1, 0.32549)),
			ColorSequenceKeypoint.new(.60,Color3.new(0, 0.901961, 1)),
			ColorSequenceKeypoint.new(.75,Color3.new(0.419608, 0.368627, 1)),
			ColorSequenceKeypoint.new(1,Color3.new(1, 0.215686, 0.215686)),
		}
		
		TweenService:Create(star,TweenInfo.new(2,Enum.EasingStyle.Linear),{Position = position}):Play()
		Debris:AddItem(star,2)
		local tableExp = {position, .5, 10,color, color}
		task.defer(function()
			task.wait(1.9)
			stop = true
			local attachment = Instance.new("Attachment",workspace.Terrain)
			attachment.WorldPosition = star.Position
			MagniDamage(attachment,12,20,30)
			createSound(attachment,6859407462,2,true,2)
			Debris:AddItem(attachment,5)
                        shakeCamera(3, workspace.non.HumanoidRootPart.Position, true)
			createEffect("explosion",nil,nil,nil,nil,nil,nil,nil,nil,tableExp)
			local shockwave = ShockwaveObject:Clone()
			shockwave.Position = position + Vector3.new(0,3,0)
			shockwave.Size = Vector3.new(9,15,9)
			shockwave.Orientation = Vector3.new(0,0,-25)
			shockwave.Parent = workspace.Terrain
			local explosion = Instance.new("Part")
			explosion.CanCollide = false
			explosion.CanQuery = false
			explosion.CanTouch = false
			explosion.Anchored = true
			explosion.CastShadow = false
			
			explosion.Transparency = .45
			explosion.Material = Enum.Material.Neon
			explosion.Size = Vector3.new(6,23,6)
			explosion.Orientation = Vector3.new(0,0,-25)
			
			explosion.Position = position
			explosion.Color = Color3.fromHSV(math.random(0,1000)/1000,.5,1)
			explosion.Parent = workspace.Terrain
			local mesh = Instance.new("SpecialMesh")
			mesh.MeshType = Enum.MeshType.Sphere
			mesh.Parent = explosion
			
			TweenService:Create(explosion,TweenInfo.new(.5,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size = Vector3.new(15,6,15),Transparency = 1}):Play()
			TweenService:Create(shockwave,TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Size = Vector3.new(25,3,25),Transparency = 1,Orientation = Vector3.new(0,0,0)}):Play()
			Debris:AddItem(explosion,.5)
			Debris:AddItem(shockwave,1)
		end)
	end
	if typ == 2 then
		local star = StarObject:Clone()
		star.Position = position+Vector3.new(50,100,0)
		star.Parent = workspace
		star.Size = Vector3.new(15,50,50)
		star.Orientation = Vector3.new(0,90,0)
		createSound(star,2783294896,4,true,.6)

		local stop = false

		task.defer(function()
			local speed = 25
			while true do
				for i = 0,1,0.001*speed do
					star.Color = Color3.fromHSV(i,.5,1)
					task.wait()
					if stop then
						break
					end
				end
				if stop then
					break
				end
			end
		end)

		local color = ColorSequence.new{
			ColorSequenceKeypoint.new(0,Color3.new(1, 0.215686, 0.215686)),
			ColorSequenceKeypoint.new(.25,Color3.new(1, 0.968627, 0)),
			ColorSequenceKeypoint.new(.5,Color3.new(0.356863, 1, 0.32549)),
			ColorSequenceKeypoint.new(.60,Color3.new(0, 0.901961, 1)),
			ColorSequenceKeypoint.new(.75,Color3.new(0.419608, 0.368627, 1)),
			ColorSequenceKeypoint.new(1,Color3.new(1, 0.215686, 0.215686)),
		}

		TweenService:Create(star,TweenInfo.new(2.5,Enum.EasingStyle.Linear),{Position = position}):Play()
		Debris:AddItem(star,2.5)
		local tableExp = {position, .5, 10,color, color}
		task.defer(function()
			task.wait(2.4)
			stop = true
			local attachment = Instance.new("Attachment",workspace.Terrain)
			attachment.WorldPosition = star.Position
			MagniDamage(attachment,50,85,100)
			createSound(attachment,6859407462,10,true)
			Debris:AddItem(attachment,5)
                        shakeCamera(3, workspace.non.HumanoidRootPart.Position, true)
			createEffect("explosion",nil,nil,nil,nil,nil,nil,nil,nil,tableExp)
			CraterCreator.Create(30,position,15)
			local shockwave = ShockwaveObject:Clone()
			shockwave.Position = position + Vector3.new(0,15,0)
			shockwave.Size = Vector3.new(45,75,45)
			shockwave.Orientation = Vector3.new(0,0,-25)
			shockwave.Parent = workspace.Terrain
			local explosion = Instance.new("Part")
			explosion.CanCollide = false
			explosion.CanQuery = false
			explosion.CanTouch = false
			explosion.Anchored = true
			explosion.CastShadow = false

			explosion.Transparency = .45
			explosion.Material = Enum.Material.Neon
			explosion.Size = Vector3.new(25,115,25)
			explosion.Orientation = Vector3.new(0,0,-25)

			explosion.Position = position
			explosion.Color = Color3.fromHSV(math.random(0,1000)/1000,.5,1)
			explosion.Parent = workspace.Terrain
			local mesh = Instance.new("SpecialMesh")
			mesh.MeshType = Enum.MeshType.Sphere
			mesh.Parent = explosion

			TweenService:Create(explosion,TweenInfo.new(5,Enum.EasingStyle.Linear,Enum.EasingDirection.In),{Size = Vector3.new(75,25,75),Transparency = 1}):Play()
			TweenService:Create(shockwave,TweenInfo.new(10,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),{Size = Vector3.new(125,15,125),Transparency = 1,Orientation = Vector3.new(0,0,0)}):Play()
			Debris:AddItem(explosion,5)
			Debris:AddItem(shockwave,10)
		end)
	end
end

function lookAt(target, eye)
	local forwardVector = (eye - target).Unit
	local upVector = Vector3.new(0, 1, 0)
	-- You have to remember the right hand rule or google search to get this right
	local rightVector = forwardVector:Cross(upVector)
	local upVector2 = rightVector:Cross(forwardVector)

	return CFrame.fromMatrix(eye, rightVector, upVector2)
end

local mode6Debounce = false
local mode4Debounce = false
function mouseDown()
	spawn(function()
		
		if mode == 2 and debounce == false then
			debounce = true
			task.spawn(function()
				task.wait(.1)
				debounce = false
			end)
			local color = ColorSequence.new{
				ColorSequenceKeypoint.new(0,Color3.new(1, 0.215686, 0.215686)),
				ColorSequenceKeypoint.new(.25,Color3.new(1, 0.968627, 0)),
				ColorSequenceKeypoint.new(.5,Color3.new(0.356863, 1, 0.32549)),
				ColorSequenceKeypoint.new(.60,Color3.new(0, 0.901961, 1)),
				ColorSequenceKeypoint.new(.75,Color3.new(0.419608, 0.368627, 1)),
				ColorSequenceKeypoint.new(1,Color3.new(1, 0.215686, 0.215686)),
			}
			local A1 = Instance.new("Attachment",workspace:FindFirstChildOfClass("Terrain"))
			local A2 = Instance.new("Attachment",workspace:FindFirstChildOfClass("Terrain"))
			local mouseHITPOS = mouse.Hit.Position
			A2.WorldPosition = mouseHITPOS
			A1.WorldPosition = mouseHITPOS + Vector3.new(0,100,0)

			local beam = Instance.new("Beam",workspace)
			beam.Enabled = false
			beam.Attachment0 = A1
			beam.Attachment1 = A2
			Debris:AddItem(beam,5)
			Debris:AddItem(A1,5)
			Debris:AddItem(A2,5)
			local warning = WarningObject:Clone()
			warning.Position = mouseHITPOS
			warning.Parent = workspace:FindFirstChildOfClass("Terrain")
			warning.Orientation = Vector3.new(0,0,0)
			warning.Transparency = 0
			for i = 0,1 do
				warning.Color = Color3.fromRGB(154, 106, 51)
				wait(.1)
				warning.Color = Color3.fromRGB(132, 72, 31)
				wait(.1)
			end
			warning:Destroy()
            local random = Random.new()
			local soundEffect = effects.shocker:Clone()
			soundEffect.Parent = A2
			soundEffect.PlaybackSpeed = random:NextNumber(.8, 1.2)
			createEffect("bolt",true,A1,A2,10,10,color,6,4,nil,true)
			local tableExp = {mouseHITPOS, .5, 10,color, color}
			task.defer(function()
				task.wait(.3)
			end)
			task.wait(.2)
			createEffect("explosion",true,A1,A2,10,10,color,1,2,tableExp)
			--print(mouse.Hit)
			soundEffect:Play()
			MagniDamage(A2,15,30,40)
                        shakeCamera(3, workspace.non.HumanoidRootPart.Position, true)
		end
		
		if chaossaber == true and debounce == false then
			debounce = true
			local arm = math.random(0,1)
			if arm == 0 then
				createSound(chaosSaber1,5666781364,1.5,true,.8)
			tlerp(rsW,{C0 = CFrame.new(1,.5,2) * CFrame.Angles(rad(0),rad(30),rad(140))},.3,Enum.EasingStyle.Quad,io)			
				task.wait(.3)
				createSound(chaosSaber1,6755792451,1,true)
				chaosSaber1.Trail.Enabled = true
 				tlerp(rsW,{C0 = CFrame.new(1,-3,-2.5) * CFrame.Angles(rad(0),rad(120),rad(24))},.1,Enum.EasingStyle.Back,io)
				task.wait(.1)
				chaosSaber1.Trail.Enabled = false
 				tlerp(rsW,{C0 = CFrame.new(1,.5,0) * CFrame.Angles(rad(15),rad(50),rad(34))},1,Enum.EasingStyle.Sine,io)
			end
			if arm == 1 then
				createSound(chaosSaber2,5666781364,1.5,true,.8)
				tlerp(lsW,{C0 = CFrame.new(-1,.5,2) * CFrame.Angles(rad(0),rad(-30),rad(-140))},.3,Enum.EasingStyle.Quad,io)
				task.wait(.3)
				createSound(chaosSaber2,6755792451,1,true)
				chaosSaber2.Trail.Enabled = true
 				tlerp(lsW,{C0 = CFrame.new(-1,-3,-2.5) * CFrame.Angles(rad(0),rad(-120),rad(-24))},.1,Enum.EasingStyle.Back,io)
				task.wait(.1)
				chaosSaber2.Trail.Enabled = false
 				tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(15),rad(-50),rad(-34))},1,Enum.EasingStyle.Sine,io)
			end
			task.spawn(function()
				task.wait(.1)
				debounce = false
			end)
		end
		
		if mode == 4 and mode4Debounce == false then
			mode4Debounce = true
			task.spawn(function()
				task.wait(5)
				mode4Debounce = false
			end)
			local mouseHITPOS = mouse.Hit.Position

			
			local offsetMaxRange = 50
			
			for i = 1,20 do
				local x = math.random(-offsetMaxRange,offsetMaxRange)
				local z = math.random(-offsetMaxRange,offsetMaxRange)
				
				local cf = CFrame.new(mouseHITPOS.X,mouseHITPOS.Y,mouseHITPOS.Z) * CFrame.new(x,0,z)
				
				local pRandom = cf.Position
				
				fallingStar(pRandom,1)

				
				task.wait(math.random(1,100)/100)
			end
			task.wait(1)
			fallingStar(mouseHITPOS,2)
		end
		if chaosbuster == true and debounce == false then
			debounce = true
			
			if POW <= 9 then
				POW = POW + 1
			for i = 1,6 do
				local rotation = math.random(80,100)
				local mousePoint = mouse.Hit.Position
				local mouseDirection = (mousePoint - FirePointObject.WorldPosition).Unit
				Fire(mouseDirection)
				rootBuster.GunFirePoint.ParticleEmitter:Emit(1)
				createSound(rootBuster,6802054509,1,true)
					tlerp(lsW,{C0 = CFrame.new(-1.25,.45,2) * CFrame.Angles(rad(rotation),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.01,Enum.EasingStyle.Linear,io)
			rootBuster.RightBottom.Transparency = 1
			rootBuster.RightBottom.fake.Transparency = 0
			rootBuster.LeftBottom.Transparency = 1
			rootBuster.LeftBottom.fake.Transparency = 0
			task.wait(.025)
					tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(90),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.1,Enum.EasingStyle.Sine,io)
			rootBuster.RightBottom.Transparency = 0
			rootBuster.RightBottom.fake.Transparency = 1
			rootBuster.LeftBottom.Transparency = 0
			rootBuster.LeftBottom.fake.Transparency = 1
			task.wait(.025)
				end
			else
				POW = 0
				rootBuster.Beam.Enabled = true
				createSound(rootBuster,3140269034,2,true,.5)
				TweenService:Create(rootBuster.Attachment0,TweenInfo.new(.25),{Position = Vector3.new(0,-1.25,0)}):Play()
				tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(90),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.3,Enum.EasingStyle.Linear,io)
				task.wait(.3)
				tlerp(lsW,{C0 = CFrame.new(-1.25,.45,1) * CFrame.Angles(rad(0),rad(90),rad(-180))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.3,Enum.EasingStyle.Linear,io)
				task.wait(.3)
				tlerp(lsW,{C0 = CFrame.new(-1,.5,2) * CFrame.Angles(rad(-90),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.3,Enum.EasingStyle.Linear,io)
				task.wait(.3)
				tlerp(lsW,{C0 = CFrame.new(-1,.5,1) * CFrame.Angles(rad(0),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.3,Enum.EasingStyle.Linear,io)
				task.wait(.3)
				tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(90),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.3,Enum.EasingStyle.Sine,io)
				task.wait(.4)
				local rotation = math.random(80,100)
				tlerp(lsW,{C0 = CFrame.new(-1.25,.45,2.5) * CFrame.Angles(rad(rotation),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.5,Enum.EasingStyle.Back,io)
				rootBuster.RightBottom.Transparency = 1
				rootBuster.RightBottom.fake.Transparency = 0
				rootBuster.LeftBottom.Transparency = 1
				rootBuster.LeftBottom.fake.Transparency = 0
				Humanoid.WalkSpeed = 1
				Humanoid.JumpPower = 0 
				Humanoid.JumpHeight = 0
				task.wait(.5)
				TweenService:Create(rootBuster.Attachment1,TweenInfo.new(2),{Position = Vector3.new(0,-1.25,0)}):Play()
				
				
				local rainbowBeam = Instance.new("Part")
				rainbowBeam.Parent = workspace.Terrain
				rainbowBeam.Shape = Enum.PartType.Cylinder
				rainbowBeam.Anchored = true
				rainbowBeam.CanCollide = false
				rainbowBeam.CanQuery = false
				rainbowBeam.CanTouch = true
				rainbowBeam.Locked = true
				rainbowBeam.Material = Enum.Material.Neon
				local origin = Instance.new("Part")
				origin.Parent = rainbowBeam
				origin.Shape = Enum.PartType.Ball
				origin.Anchored = true
				origin.CanCollide = false
				origin.CanQuery = false
				origin.CanTouch = false
				origin.Locked = true
				origin.Material = Enum.Material.Neon
				
				local beamEnd = Instance.new("Part")
				beamEnd.Parent = rainbowBeam
				beamEnd.Shape = Enum.PartType.Ball
				beamEnd.Anchored = true
				beamEnd.CanCollide = false
				beamEnd.CanQuery = false
				beamEnd.CanTouch = false
				beamEnd.Locked = true
				beamEnd.Material = Enum.Material.Neon
				
				local stop = false
				task.defer(function()
				while true do
					for i = 0,1,0.001*10 do
						rainbowBeam.Color = Color3.fromHSV(i,.5,.6)
						origin.Color = Color3.fromHSV(i,.5,.6)
						beamEnd.Color = Color3.fromHSV(i,.5,.6)
						task.wait()
						if stop then
							break
						end
					end
					if stop then
						break
					end
					end end)
				
				local event
				local debounce = false
				
				event = rainbowBeam.Touched:Connect(function(part)
					local hum = part.Parent:FindFirstChildOfClass("Humanoid")
					if part.Parent:FindFirstChildOfClass("Humanoid") and part.Parent ~= Character then
						debounce = true
						
						if (hum.Health-2) <= 0 then
							FATAL(hum.Parent)
						else
						end
						task.wait(.01)
						debounce = false
					end
				end)
                                shakeCamera(3, workspace.non.HumanoidRootPart.Position, true)
				createSound(origin,5880986785,4,true,.7)
				local shock = ShockObject:Clone()
				shock.Parent = workspace.Terrain
				shock.CFrame = lookAt(mouse.Hit.Position,rootBuster.GunFirePoint.WorldPosition) * CFrame.new(0,0,1.5) * CFrame.Angles(0, math.pi / 2, math.pi / 2)
				shock.Anchored = true
				shock.CanCollide = false
				shock.CanQuery = false
				shock.CanTouch = false
				TweenService:Create(shock,TweenInfo.new(1.5),{Size = Vector3.new(10, 5, 10),Transparency = 1}):Play()
				for i = 1,150 do
					local rotation = math.random(80,100)
					tlerp(lsW,{C0 = CFrame.new(-1.25,.45,2.5) * CFrame.Angles(rad(rotation),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },.01,Enum.EasingStyle.Linear,io)
					local magnitude = math.abs((rootBuster.GunFirePoint.WorldPosition - mouse.Hit.Position).Magnitude)
					rainbowBeam.Size = Vector3.new(magnitude,3,3)
					rainbowBeam.CFrame = lookAt(mouse.Hit.Position,rootBuster.GunFirePoint.WorldPosition) * CFrame.new(0,0,magnitude/2+1.5) * CFrame.Angles(0, math.pi / 2, 0)
					origin.Size = Vector3.new(3,3,3)
					origin.CFrame =  lookAt(mouse.Hit.Position,rootBuster.GunFirePoint.WorldPosition) * CFrame.new(0,0,1.5) * CFrame.Angles(0, math.pi / 2, 0)
					beamEnd.Size = Vector3.new(5,5,5)
					beamEnd.Position = mouse.Hit.Position
					shock.Orientation = shock.Orientation + Vector3.new(1,0,0)
					task.wait(.01)
				end
				event:Disconnect()
				TweenService:Create(rainbowBeam,TweenInfo.new(1),{Transparency = 1}):Play()
				TweenService:Create(origin,TweenInfo.new(1),{Transparency = 1}):Play()
				TweenService:Create(beamEnd,TweenInfo.new(1),{Transparency = 1}):Play()
                shock:Destroy()
				task.spawn(function()
					stop = true
					task.wait(1)
					rainbowBeam:Destroy()
					origin:Destroy()
					beamEnd:Destroy()
				end)
				rootBuster.Beam.Enabled = false
				task.wait()
				rootBuster.Attachment1.Position = Vector3.new(0,1.25,0)
				rootBuster.Attachment0.Position = Vector3.new(0,1.25,0)
				rootBuster.RightBottom.Transparency = 0
				rootBuster.RightBottom.fake.Transparency = 1
				rootBuster.LeftBottom.Transparency = 0
				rootBuster.LeftBottom.fake.Transparency = 1
				tlerp(lsW,{C0 = CFrame.new(-1,.5,0) * CFrame.Angles(rad(90),rad(-90),rad(0))* CFrame.Angles(rad(-25),rad(-25),rad(0)) },1,Enum.EasingStyle.Sine,io)
				task.wait(.5)
				Humanoid.WalkSpeed = 18
				Humanoid.JumpPower = 50 
				Humanoid.JumpHeight = 7.2
				task.wait(1)
		end
			task.spawn(function()
				task.wait(.1)
				debounce = false
			end)
		end
		
		if mode == 6 then
			if mode6Debounce == false then
				mode6Debounce = true
				task.spawn(function()
					task.wait(.5)
					mode6Debounce = false
				end)
				local whichArm = math.random(1,2)
				createSound(Torso,382366855,.5,true,math.random(4,8)/10)
				for i = 1,8 do 
					task.spawn(function()
						if whichArm == 1 then
							Circle.circleeffects(
								LeftArm,
								1
							)
							shootProjectile(CFrame.new(math.random(-35,35),0,math.random(-35,35))*mouse.Hit, LeftArm.Position)
						else
							Circle.circleeffects(
								RightArm,
								1
							)
							shootProjectile(CFrame.new(math.random(-35,35),0,math.random(-35,35))*mouse.Hit, RightArm.Position)
						end
					end)
				end

			end
			
		end
	end)
end

function run(bool)
	if bool then
		if root.Velocity.Magnitude>1 then
			moving=true
		elseif root.Velocity.Magnitude<1 then
			moving=false
		end
	end
end
Character.Humanoid.Running:connect(run)
Character.Humanoid.Died:Connect(dust)
mouse.KeyDown:Connect(keyBinding)
mouse.Button1Down:Connect(mouseDown)
Player.Chatted:Connect(chatFunc2)
Character.HumanoidRootPart.Anchored = true
task.wait(.5)
chatFunc1("It's me, your best friend.")
task.wait(2)
if Head:FindFirstChild("NameBillboard") then
	Head:FindFirstChild("NameBillboard"):Destroy()
end
local colorcorrect = Instance.new("ColorCorrectionEffect")
colorcorrect.Name = "HYPE"
colorcorrect.Parent = game:GetService("Lighting")
createSound(Head,3508218059,3,true)
TweenService:Create(colorcorrect,TweenInfo.new(.1,Enum.EasingStyle.Linear),{Brightness = 2}):Play()
Debris:AddItem(colorcorrect,3) -- incase the user gets killed midway the intro
task.wait()
Character.HumanoidRootPart.Anchored = false



task.wait()
removeAnimations()
addEffects()
fixHealth()
addHPBar()
setKeybindGui()
mode2Animate()
mode3Animate()
mode4Animate()
mode5Animate()
mode6Animate()
givePlayersGui()
task.wait(.1)
TweenService:Create(colorcorrect,TweenInfo.new(1,Enum.EasingStyle.Sine,Enum.EasingDirection.In),{Brightness = 0}):Play()
addOutline()
task.wait(.9)
chatFunc3("ASRIEL DREEMURR")
task.spawn(function()
	task.wait(5)
	MUSIC:Play()
	if Head:FindFirstChild("NameBillboard") then
		Head:FindFirstChild("NameBillboard"):Destroy()
	end
end)
Humanoid.BreakJointsOnDeath = false
spawn(function()
	while task.wait(2) do
		local color = ColorSequence.new{
			ColorSequenceKeypoint.new(0,Color3.new(1, 0.215686, 0.215686)),
			ColorSequenceKeypoint.new(.25,Color3.new(1, 0.968627, 0)),
			ColorSequenceKeypoint.new(.5,Color3.new(0.356863, 1, 0.32549)),
			ColorSequenceKeypoint.new(.60,Color3.new(0, 0.901961, 1)),
			ColorSequenceKeypoint.new(.75,Color3.new(0.419608, 0.368627, 1)),
			ColorSequenceKeypoint.new(1,Color3.new(1, 0.215686, 0.215686)),
		}
		local A1 = Instance.new("Attachment",workspace:FindFirstChildOfClass("Terrain"))
		local A2 = Instance.new("Attachment",workspace:FindFirstChildOfClass("Terrain"))
		A2.WorldPosition = getRandomPos(Torso)
		A1.WorldPosition = getRandomPos(Torso)
		local beam = Instance.new("Beam",workspace)
		beam.Enabled = false
		beam.Attachment0 = A1
		beam.Attachment1 = A2
		Debris:AddItem(beam,5)
		Debris:AddItem(A1,5)
		Debris:AddItem(A2,5)
		createEffect("bolt",true,A1,A2,10,1,color,.2,.2,nil)
	end
end)
spawn(function()

	while true do
		swait()

		local sine=time()
		--if not oof then
		if not attack then
			if not moving then
				rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3,0,3+cos(sine*1.85)/1.7)*CFrame.Angles(cos(sine*2)/8,0,0),.35)
				--earsW.C0=earsW.C0:lerp(CFrame.new(-cos(sine*2)/20.2,cos(sine*1.22)/18,0)*CFrame.Angles(0,cos(sine*1.779)/12.5,0),.35)
				neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(cos(sine*2.2)/6.6,0,cos(sine*2)/10),.35)
				rsW.C0=rsW.C0:lerp(rsWO*CFrame.Angles(-rad(23)+cos(sine*2)/9.5,-rad(13)-cos(sine*2)/2.5,0),.35)
				lsW.C0=lsW.C0:lerp(lsWO*CFrame.Angles(-rad(23)+cos(sine*2)/9.5,rad(13)+cos(sine*2)/2.5,0),.35)
				rhW.C0=rhW.C0:lerp(rhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
				lhW.C0=lhW.C0:lerp(lhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
			else
				neckW.C0=neckW.C0:lerp(neckWO*CFrame.Angles(-rad(25)-cos(sine*2)/5,0,0),.35)
				rootW.C0=rootW.C0:lerp(rootWO*CFrame.new(cos(sine)*3,0,3+cos(sine*1.85)/1.7)*CFrame.Angles(rad(35)+cos(sine*2)/9,0,0),.35)
				rsW.C0=rsW.C0:lerp(rsWO*CFrame.Angles(-rad(23)+cos(sine*2)/9.5,0,-rad(90/2)-cos(sine*2)/2),.35)
				lsW.C0=lsW.C0:lerp(lsWO*CFrame.Angles(-rad(23)+cos(sine*2)/9.5,0,rad(90/2)+cos(sine*2)/2),.35)
				rhW.C0=rhW.C0:lerp(rhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,-rad(35)-cos(sine*2)/3),.35)
				lhW.C0=lhW.C0:lerp(lhWO*CFrame.Angles(-rad(8)+cos(sine*2)/10.5,-rad(13)+cos(sine*2)/4.5,rad(24.5)+cos(sine*2)/3),.35)
				--earsW.C0=earsW.C0:lerp(CFrame.new(-cos(sine*2)/13.2,cos(sine*1.22)/15,0)*CFrame.Angles(cos(sine*2.779)/5.59,cos(sine*2.779)/8.5,0),.35)
			end
			--end
		end
	end
end)

spawn(function()
	local Ang = CFrame.Angles
	local aSin = math.asin
	local aTan = math.atan
	
	local Cam = workspace.CurrentCamera
	local headmovementenabled = true
	local Plr = Player
	local Mouse = mouse
	local Body = Plr.Character
	local Head = Head
	local Hum = Humanoid
	local Core = Body:WaitForChild("HumanoidRootPart")
	local IsR6 = (Hum.RigType.Value==0)
	local Trso = (IsR6 and Body:WaitForChild("Torso")) or Body:WaitForChild("UpperTorso")
	local Neck = (IsR6 and Trso:WaitForChild("Neck")) or Head:WaitForChild("Neck")
	local Waist = (not IsR6 and Trso:WaitForChild("Waist"))
	local MseGuide = true
	local TurnCharacterToMouse = false
	local HeadHorFactor = 3 -- 1
	local HeadVertFactor = 3 -- .6
	local BodyHorFactor = 1.5 -- .5
	local BodyVertFactor = 1.4 -- .4
	local UpdateSpeed = 0.1

	local NeckOrgnC0 = Neck.C0
	local WaistOrgnC0 = (not IsR6 and Waist.C0)

	--[Setup]:

	Neck.MaxVelocity = 1/3

	-- Activation]:
	if TurnCharacterToMouse == true then
		MseGuide = true
		HeadHorFactor = 0
		BodyHorFactor = 0
	end
	game:GetService("RunService").Heartbeat:Connect(function()
		if headmovementenabled then
			local CamCF = Cam.CoordinateFrame
			if ((IsR6 and Body["Torso"]) or Body["UpperTorso"])~=nil and Body["Head"]~=nil then	
				local TrsoLV = Trso.CFrame.lookVector
				local HdPos = Head.CFrame.p
				if IsR6 and Neck or Neck and Waist then
					if UpdateSpeed == 0.1 then
						local Dist = nil;
						local Diff = nil;
						if not MseGuide then	
							Dist = (Head.CFrame.p-CamCF.p).magnitude
							Diff = Head.CFrame.Y-CamCF.Y
							if not IsR6 then
								Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang((aSin(Diff/Dist)*HeadVertFactor), -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0), UpdateSpeed/2)
								Waist.C0 = Waist.C0:lerp(WaistOrgnC0*Ang((aSin(Diff/Dist)*BodyVertFactor), -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*BodyHorFactor, 0), UpdateSpeed/2)
							else
								Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang(-(aSin(Diff/Dist)*HeadVertFactor), 0, -(((HdPos-CamCF.p).Unit):Cross(TrsoLV)).Y*HeadHorFactor),UpdateSpeed/2)
							end
						else
							local Point = Mouse.Hit.p
							Dist = (Head.CFrame.p-Point).magnitude
							Diff = Head.CFrame.Y-Point.Y
							if not IsR6 then
								Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang(-(aTan(Diff/Dist)*HeadVertFactor), (((HdPos-Point).Unit):Cross(TrsoLV)).Y*HeadHorFactor, 0), UpdateSpeed/2)
								Waist.C0 = Waist.C0:lerp(WaistOrgnC0*Ang(-(aTan(Diff/Dist)*BodyVertFactor), (((HdPos-Point).Unit):Cross(TrsoLV)).Y*BodyHorFactor, 0), UpdateSpeed/2)
							else
								Neck.C0 = Neck.C0:lerp(NeckOrgnC0*Ang((aTan(Diff/Dist)*HeadVertFactor), 0, (((HdPos-Point).Unit):Cross(TrsoLV)).Y*HeadHorFactor), UpdateSpeed/2)
							end
						end
					end
				end
			end
			if TurnCharacterToMouse == true then
				Hum.AutoRotate = false
				Core.CFrame = Core.CFrame:lerp(CFrame.new(Core.Position, Vector3.new(Mouse.Hit.p.x, Core.Position.Y, Mouse.Hit.p.z)), UpdateSpeed / 2)
			else
				Hum.AutoRotate = true
			end
		end
	end)
end)
