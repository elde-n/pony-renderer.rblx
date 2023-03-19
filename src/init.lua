local Renderer = {}
Renderer.__index = Renderer

local camera = workspace.CurrentCamera
local camera_part = Instance.new("Part")

camera_part.Name = ''
camera_part.Anchored = true
camera_part.CanCollide, camera_part.CanTouch = false, false

Renderer.CameraPart = camera_part

export type Renderer = typeof(Renderer.new())


local function screen_to_world_space(position: Vector2, depth: number?)
	depth = typeof(depth) == "number" and depth or 1

	local screen_size = camera.ViewportSize
	local field_of_view = camera.FieldOfView

	local width, height = screen_size.X, screen_size.Y
	local aspect_ratio = width / height
	local tangent = math.tan(math.rad(field_of_view)) / 2

	local fx = (2 * depth) * (position.X / width) - depth
	local fy = (2 * depth) * (position.Y / height) - depth
	local nx, ny = aspect_ratio * tangent * fx, -tangent * fy

	return Vector3.new(nx, ny, -depth)
end

function Renderer.new(): Renderer
	local renderer = setmetatable({
		Context = Instance.new("WireframeHandleAdornment", Renderer.CameraPart)
	}, Renderer)

	renderer.Context.Name = ''
	renderer.Context.AlwaysOnTop = true
	renderer.Context.Adornee = Renderer.CameraPart
	renderer.Context.Color3 = Color3.new(1, 1, 1)

	return renderer
end

function Renderer:Line(from: Vector2, to: Vector2, color: Color3, opacity: number, z_index: number)
	self.Context.Color3, self.Context.Transparency, self.Context.ZIndex = color, 1 - opacity, z_index

	local v3_from, v3_to = screen_to_world_space(from, 1), screen_to_world_space(to, 1)
	self.Context:AddLine(v3_from, v3_to)
end

function Renderer:Update()
	camera = workspace.CurrentCamera
	self.Context:Clear()
	Renderer.CameraPart.CFrame = camera.CFrame * CFrame.new(0, 0, -1)
end


return Renderer
