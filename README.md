# pony-renderer.rblx

A roblox 2d graphics library made with [wireframe handle adornments](https://create.roblox.com/docs/reference/engine/classes/WireframeHandleAdornment)

# Usage

 ```lua
local RendererClass = require(RendererClass)
local renderer = RendererClass.new()

local RunService = game:GetService("RunService")

-- wireframes' adornments need to be parented in workspace in-order for them to be rendered
Renderer.CameraPart.Parent = workspace

RunService.PreRender:Connect(function()
	renderer:Update()
	renderer:Line(Vector2.new(0, 100), Vector2.new(200, 100), Color3.new(1, 1, 1), 1, -1)
end)
```
