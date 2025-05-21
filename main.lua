local tool = script.Parent
local hitbox = tool.Handle.Hitbox -- replace this with the actual name of your hitbox
local flingForce = 1000 -- adjust this to change the force of the fling

function onHit(target, hitPosition)
	-- apply a BodyVelocity to the player's character
	local character = tool.Parent
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if humanoid then
		local direction = (hitPosition - character.HumanoidRootPart.Position).Unit
		local velocity = direction * flingForce
		local bodyVelocity = Instance.new("BodyVelocity")
		bodyVelocity.Velocity = velocity
		bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bodyVelocity.P = 10000
		bodyVelocity.Parent = humanoid.RootPart

		-- remove the BodyVelocity after a short delay
		wait(0.5)
		bodyVelocity:Destroy()
	end
end

-- connect the onHit function to the hit event of the hammer's hitbox
hitbox.Touched:Connect(function(part)
	local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
	if humanoid and humanoid.Health > 0 then
		onHit(humanoid, part.Position)
	end
end)
