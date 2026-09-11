local function fling(targetPlayer, requireTouchEnabled)
	if destroyed or flinging then
		return false
	end

	if not targetPlayer
		or targetPlayer == localPlayer
		or targetPlayer.Parent ~= Players then
		return false
	end

	if requireTouchEnabled and not settings.TouchFling then
		return false
	end

	local now = os.clock()
	if (targetDebounce[targetPlayer] or 0) > now then
		return false
	end

	local targetCharacter, targetRoot, targetHumanoid =
		livingCharacter(targetPlayer)

	local localCharacter, localRoot, localHumanoid =
		livingCharacter(localPlayer)

	if not targetCharacter or not localCharacter then
		return false
	end

	if localRoot.Anchored or localHumanoid.SeatPart then
		return false
	end

	-- Valores conservadores para reduzir a perda de controle.
	-- Aumentar estes valores não garante lançar o alvo.
	local MAX_LINEAR_SPEED = 85
	local ANGULAR_SPEED = 120
	local MAX_SEPARATION = 35
	local MAX_TARGET_SPEED = 180

	local originalPivot = localCharacter:GetPivot()
	local originalAutoRotate = localHumanoid.AutoRotate

	local parts = {}
	for _, instance in ipairs(localCharacter:GetDescendants()) do
		if instance:IsA("BasePart") then
			table.insert(parts, instance)
		end
	end

	actionToken += 1
	local token = actionToken
	local restored = false
	local startedAt = os.clock()
	local step = 0

	flinging = true
	targetDebounce[targetPlayer] = now + TARGET_DEBOUNCE

	local function zeroVelocity()
		for _, part in ipairs(parts) do
			if part.Parent then
				pcall(function()
					part.AssemblyLinearVelocity = Vector3.zero
					part.AssemblyAngularVelocity = Vector3.zero
				end)
			end
		end
	end

	local function restore()
		if restored then
			return
		end
		restored = true

		-- Uma tarefa antiga não deve restaurar sobre outra ação.
		if activeRestore ~= restore then
			return
		end

		zeroVelocity()

		pcall(function()
			-- Nunca teletransportar o personagem novo após respawn.
			if localPlayer.Character == localCharacter
				and localCharacter.Parent
				and localHumanoid.Health > 0 then
				localCharacter:PivotTo(originalPivot)
			end
		end)

		pcall(function()
			if localHumanoid.Parent then
				localHumanoid.AutoRotate = originalAutoRotate

				if localPlayer.Character == localCharacter
					and localHumanoid.Health > 0 then
					localHumanoid:ChangeState(
						Enum.HumanoidStateType.GettingUp
					)
				end
			end
		end)

		zeroVelocity()

		if targetPlayer.Parent == Players then
			targetDebounce[targetPlayer] =
				os.clock() + TARGET_DEBOUNCE
		end

		activeRestore = nil
		flinging = false
	end

	activeRestore = restore

	local function valid()
		if destroyed or restored or token ~= actionToken then
			return false
		end

		if requireTouchEnabled and not settings.TouchFling then
			return false
		end

		if os.clock() - startedAt >= FLING_DURATION then
			return false
		end

		if targetPlayer.Parent ~= Players then
			return false
		end

		local character, root, humanoid =
			livingCharacter(localPlayer)

		local target, rootTarget, humanoidTarget =
			livingCharacter(targetPlayer)

		return character == localCharacter
			and root == localRoot
			and humanoid == localHumanoid
			and target == targetCharacter
			and rootTarget == targetRoot
			and humanoidTarget == targetHumanoid
			and not localRoot.Anchored
			and not targetRoot.Anchored
			and not localHumanoid.SeatPart
	end

	task.spawn(function()
		local ok, err = pcall(function()
			-- Pode ter sido cancelado antes de task.spawn executar.
			if not valid() then
				return
			end

			localHumanoid.AutoRotate = false

			while valid() do
				RunService.PreSimulation:Wait()

				-- Revalidar depois de qualquer espera.
				if not valid() then
					break
				end

				local targetVelocity =
					targetRoot.AssemblyLinearVelocity

				if targetVelocity.Magnitude > MAX_TARGET_SPEED then
					break
				end

				if localRoot.Position.Y
					< Workspace.FallenPartsDestroyHeight + 25 then
					break
				end

				-- Ignorar distância inicial: o alvo pode estar longe.
				if step > 0
					and (localRoot.Position - targetRoot.Position).Magnitude
						> MAX_SEPARATION then
					break
				end

				step += 1

				local predicted = targetRoot.Position
					+ targetVelocity * PREDICTION_TIME

				-- Evitar offsets abaixo do piso.
				local side = step % 2 == 0 and 1 or -1
				local position = predicted
					+ Vector3.new(side * 1.5, 0.5, 0)

				local towardTarget = predicted - position
				local direction = towardTarget.Magnitude > 0.001
					and towardTarget.Unit
					or Vector3.new(1, 0, 0)

				zeroVelocity()

				-- Posicionar a raiz considerando o pivot real do modelo.
				local pivotToRoot =
					localCharacter:GetPivot():ToObjectSpace(localRoot.CFrame)

				local desiredRoot = CFrame.new(position)
					* originalPivot.Rotation

				localCharacter:PivotTo(
					desiredRoot * pivotToRoot:Inverse()
				)

				local velocity = targetVelocity
					+ direction * 55
					+ Vector3.new(0, 12, 0)

				if velocity.Magnitude > MAX_LINEAR_SPEED then
					velocity = velocity.Unit * MAX_LINEAR_SPEED
				end

				localRoot.AssemblyLinearVelocity = velocity
				localRoot.AssemblyAngularVelocity =
					Vector3.new(0, ANGULAR_SPEED * side, 0)
			end
		end)

		restore()

		if not ok then
			warn("[HMenu] Fling error:", err)
		end
	end)

	return true
end