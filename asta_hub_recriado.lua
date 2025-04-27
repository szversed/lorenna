--[[ Asta Hub Recriado - Sem Bibliotecas ]]

-- Serviços Roblox
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

-- Jogador Local
local Player = Players.LocalPlayer

-- Variáveis Globais (Configurações e Estados)
local guiVisible = false
local menuAberto = false
local animacaoEmProgresso = false

-- Configurações de UI
local corPrincipal = Color3.fromRGB(45, 45, 45) -- Cinza escuro moderno
local corSecundaria = Color3.fromRGB(60, 60, 60)
local corDestaque = Color3.fromRGB(0, 122, 255) -- Azul moderno
local corTexto = Color3.fromRGB(255, 255, 255)
local fonteUI = Enum.Font.GothamSemibold
local tamanhoTextoPadrao = 14

-- Criação da Interface Principal (ScreenGui)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AstaHubRecriadoGui"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true -- Para ocupar a tela toda, útil em mobile
screenGui.Parent = Player:WaitForChild("PlayerGui")

-- Botão para Abrir/Fechar o Menu (Estilo moderno flutuante)
local botaoAbrir = Instance.new("ImageButton")
botaoAbrir.Name = "BotaoAbrirMenu"
botaoAbrir.Size = UDim2.new(0, 50, 0, 50) -- Tamanho fixo para toque
botaoAbrir.Position = UDim2.new(0, 15, 0.5, -25) -- Posição inicial (esquerda, meio da tela)
botaoAbrir.BackgroundColor3 = corDestaque
botaoAbrir.BackgroundTransparency = 0.1
botaoAbrir.Image = "rbxassetid://6034849718" -- Ícone de menu (exemplo, pode ser trocado)
botaoAbrir.ImageColor3 = corTexto
botaoAbrir.ScaleType = Enum.ScaleType.Slice
botaoAbrir.SliceCenter = Rect.new(10, 10, 118, 118) -- Para bordas arredondadas
botaoAbrir.Parent = screenGui

local cantoArredondadoBotao = Instance.new("UICorner")
cantoArredondadoBotao.CornerRadius = UDim.new(0.5, 0) -- Círculo
cantoArredondadoBotao.Parent = botaoAbrir

-- Frame Principal do Menu (Inicialmente fora da tela)
local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuPrincipal"
menuFrame.Size = UDim2.new(0, 280, 1, 0) -- Largura fixa, altura total
menuFrame.Position = UDim2.new(0, -280, 0, 0) -- Começa fora da tela à esquerda
menuFrame.BackgroundColor3 = corPrincipal
menuFrame.BorderSizePixel = 0
menuFrame.Parent = screenGui

local cantoArredondadoMenu = Instance.new("UICorner")
cantoArredondadoMenu.CornerRadius = UDim.new(0, 8)
cantoArredondadoMenu.Parent = menuFrame

-- Layout para organizar os itens do menu
local menuLayout = Instance.new("UIListLayout")
menuLayout.Padding = UDim.new(0, 10)
menuLayout.SortOrder = Enum.SortOrder.LayoutOrder
menuLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
menuLayout.Parent = menuFrame

local menuPadding = Instance.new("UIPadding")
menuPadding.PaddingTop = UDim.new(0, 15)
menuPadding.PaddingBottom = UDim.new(0, 15)
menuPadding.PaddingLeft = UDim.new(0, 10)
menuPadding.PaddingRight = UDim.new(0, 10)
menuPadding.Parent = menuFrame

-- Título do Menu
local tituloLabel = Instance.new("TextLabel")
tituloLabel.Name = "TituloMenu"
tituloLabel.Size = UDim2.new(1, -20, 0, 40)
tituloLabel.BackgroundColor3 = corSecundaria
tituloLabel.Text = "Asta Hub Recriado"
tituloLabel.Font = fonteUI
tituloLabel.TextColor3 = corTexto
tituloLabel.TextSize = tamanhoTextoPadrao + 4
tituloLabel.LayoutOrder = 0
tituloLabel.Parent = menuFrame

local cantoTitulo = Instance.new("UICorner")
cantoTitulo.CornerRadius = UDim.new(0, 6)
cantoTitulo.Parent = tituloLabel

-- Função de Animação para Abrir/Fechar Menu
local function animarMenu(abrir)
	if animacaoEmProgresso then return end
	animacaoEmProgresso = true
	menuAberto = abrir

	local posicaoFinalMenu
	local posicaoFinalBotao

	if abrir then
		posicaoFinalMenu = UDim2.new(0, 0, 0, 0)
		posicaoFinalBotao = UDim2.new(0, 280 + 15, 0.5, -25) -- Move o botão junto com o menu
	else
		posicaoFinalMenu = UDim2.new(0, -menuFrame.AbsoluteSize.X, 0, 0)
		posicaoFinalBotao = UDim2.new(0, 15, 0.5, -25)
	end

	local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)

	local tweenMenu = TweenService:Create(menuFrame, tweenInfo, { Position = posicaoFinalMenu })
	local tweenBotao = TweenService:Create(botaoAbrir, tweenInfo, { Position = posicaoFinalBotao })

	tweenMenu:Play()
	tweenBotao:Play()

	tweenMenu.Completed:Connect(function()
		animacaoEmProgresso = false
	end)
end

-- Evento de clique no botão para abrir/fechar
botaoAbrir.MouseButton1Click:Connect(function()
	animarMenu(not menuAberto)
end)

--[[ Placeholder para Seções e Funcionalidades
   Aqui serão adicionadas as seções (Player, Combat, Visuals, Misc) 
   e os controles (botões, sliders, toggles) para cada funcionalidade.
   Exemplo:

   local secaoPlayer = Instance.new("Frame")
   -- ... configuração da seção ...
   secaoPlayer.LayoutOrder = 1
   secaoPlayer.Parent = menuFrame

   local botaoVelocidade = Instance.new("TextButton")
   -- ... configuração do botão ...
   botaoVelocidade.Parent = secaoPlayer
]]

print("Asta Hub Recriado: Interface básica carregada.")

-- Adicionar lógica das funcionalidades aqui...





-- Função Auxiliar para criar Botão de Toggle Moderno
local function criarBotaoToggle(parent, texto, layoutOrder, callback)
	local container = Instance.new("Frame")
	container.Name = texto .. "ToggleContainer"
	container.Size = UDim2.new(1, 0, 0, 35)
	container.BackgroundColor3 = corSecundaria
	container.BorderSizePixel = 0
	container.LayoutOrder = layoutOrder
	container.Parent = parent

	local cantoContainer = Instance.new("UICorner")
	cantoContainer.CornerRadius = UDim.new(0, 6)
	cantoContainer.Parent = container

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(0.7, -5, 1, 0)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.BackgroundColor3 = corSecundaria
	label.BackgroundTransparency = 1
	label.Font = fonteUI
	label.TextColor3 = corTexto
	label.TextSize = tamanhoTextoPadrao
	label.Text = texto
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local toggleButton = Instance.new("TextButton")
	toggleButton.Name = "ToggleButton"
	toggleButton.Size = UDim2.new(0.3, -10, 0.8, 0)
	toggleButton.Position = UDim2.new(0.7, 0, 0.1, 0)
	toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100) -- Cinza desligado
	toggleButton.Text = "OFF"
	toggleButton.Font = fonteUI
	toggleButton.TextColor3 = corTexto
	toggleButton.TextSize = tamanhoTextoPadrao - 2
	toggleButton.Parent = container

	local cantoToggle = Instance.new("UICorner")
	cantoToggle.CornerRadius = UDim.new(0, 4)
	cantoToggle.Parent = toggleButton

	local ativo = false
	toggleButton.MouseButton1Click:Connect(function()
		ativo = not ativo
		if ativo then
			toggleButton.BackgroundColor3 = corDestaque -- Azul ligado
			toggleButton.Text = "ON"
		else
			toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			toggleButton.Text = "OFF"
		end
		-- Animação suave de cor (opcional, mas adiciona ao visual)
		local tweenInfoColor = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local goalColor = ativo and { BackgroundColor3 = corDestaque } or { BackgroundColor3 = Color3.fromRGB(100, 100, 100) }
		local tweenColor = TweenService:Create(toggleButton, tweenInfoColor, goalColor)
		tweenColor:Play()

		if callback then
			callback(ativo)
		end
	end)

	return container, toggleButton
end

-- Função Auxiliar para criar Slider Moderno
local function criarSlider(parent, texto, minVal, maxVal, defaultVal, layoutOrder, callback)
	local container = Instance.new("Frame")
	container.Name = texto .. "SliderContainer"
	container.Size = UDim2.new(1, 0, 0, 50) -- Altura maior para slider
	container.BackgroundColor3 = corSecundaria
	container.BorderSizePixel = 0
	container.LayoutOrder = layoutOrder
	container.Parent = parent

	local cantoContainer = Instance.new("UICorner")
	cantoContainer.CornerRadius = UDim.new(0, 6)
	cantoContainer.Parent = container

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(1, -10, 0.5, -5)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.BackgroundColor3 = corSecundaria
	label.BackgroundTransparency = 1
	label.Font = fonteUI
	label.TextColor3 = corTexto
	label.TextSize = tamanhoTextoPadrao
	label.Text = texto .. ": " .. defaultVal
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	-- Barra de fundo do slider
	local sliderBack = Instance.new("Frame")
	sliderBack.Name = "SliderBackground"
	sliderBack.Size = UDim2.new(1, -20, 0, 6) -- Barra fina
	sliderBack.Position = UDim2.new(0, 10, 0.5, 5) -- Abaixo do label
	sliderBack.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	sliderBack.BorderSizePixel = 0
	sliderBack.Parent = container

	local cantoSliderBack = Instance.new("UICorner")
	cantoSliderBack.CornerRadius = UDim.new(0.5, 0) -- Arredondado
	cantoSliderBack.Parent = sliderBack

	-- Barra de progresso do slider
	local sliderProgress = Instance.new("Frame")
	sliderProgress.Name = "SliderProgress"
	local percent = (defaultVal - minVal) / (maxVal - minVal)
	sliderProgress.Size = UDim2.new(percent, 0, 1, 0)
	sliderProgress.BackgroundColor3 = corDestaque
	sliderProgress.BorderSizePixel = 0
	sliderProgress.Parent = sliderBack

	local cantoSliderProg = Instance.new("UICorner")
	cantoSliderProg.CornerRadius = UDim.new(0.5, 0)
	cantoSliderProg.Parent = sliderProgress

	-- Botão/Handle do slider (invisível, mas cobre a área para drag)
	local sliderHandle = Instance.new("TextButton")
	sliderHandle.Name = "SliderHandle"
	sliderHandle.Size = UDim2.new(1, 0, 1, 0) -- Cobre toda a barra
	sliderHandle.Position = UDim2.new(0, 0, 0, 0)
	sliderHandle.BackgroundTransparency = 1
	sliderHandle.Text = ""
	sliderHandle.Parent = sliderBack

	local dragging = false
	local currentValue = defaultVal

	sliderHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			local mouseX = input.Position.X
			local backPos = sliderBack.AbsolutePosition.X
			local backSize = sliderBack.AbsoluteSize.X
			local relativeX = math.clamp(mouseX - backPos, 0, backSize)
			local percentage = relativeX / backSize
			currentValue = math.floor(minVal + percentage * (maxVal - minVal) + 0.5) -- Arredonda
			sliderProgress.Size = UDim2.new(percentage, 0, 1, 0)
			label.Text = texto .. ": " .. currentValue
			if callback then callback(currentValue) end
		end
	end)

	sliderHandle.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local mouseX = input.Position.X
			local backPos = sliderBack.AbsolutePosition.X
			local backSize = sliderBack.AbsoluteSize.X
			local relativeX = math.clamp(mouseX - backPos, 0, backSize)
			local percentage = relativeX / backSize
			currentValue = math.floor(minVal + percentage * (maxVal - minVal) + 0.5) -- Arredonda
			sliderProgress.Size = UDim2.new(percentage, 0, 1, 0)
			label.Text = texto .. ": " .. currentValue
			if callback then callback(currentValue) end
		end
	end)

	return container, sliderHandle
end

-- Seção: Player
local secaoPlayer = Instance.new("Frame")
secaoPlayer.Name = "SecaoPlayer"
secaoPlayer.Size = UDim2.new(1, -20, 0, 150) -- Tamanho inicial, ajustará com layout
secaoPlayer.BackgroundTransparency = 1
secaoPlayer.BorderSizePixel = 0
secaoPlayer.LayoutOrder = 1
secaoPlayer.Parent = menuFrame

local layoutSecaoPlayer = Instance.new("UIListLayout")
layoutSecaoPlayer.Padding = UDim.new(0, 5)
layoutSecaoPlayer.SortOrder = Enum.SortOrder.LayoutOrder
layoutSecaoPlayer.Parent = secaoPlayer

local tituloSecaoPlayer = Instance.new("TextLabel")
tituloSecaoPlayer.Name = "TituloSecaoPlayer"
tituloSecaoPlayer.Size = UDim2.new(1, 0, 0, 25)
tituloSecaoPlayer.BackgroundColor3 = corPrincipal
tituloSecaoPlayer.Text = "-- Player --"
tituloSecaoPlayer.Font = fonteUI
tituloSecaoPlayer.TextColor3 = corDestaque
tituloSecaoPlayer.TextSize = tamanhoTextoPadrao + 2
tituloSecaoPlayer.LayoutOrder = 0
tituloSecaoPlayer.Parent = secaoPlayer

-- Controles Player
local velocidadeSliderCont, _ = criarSlider(secaoPlayer, "Velocidade", 16, 500, 100, 1, function(valor)
	print("Velocidade definida para:", valor)
	-- Adicionar lógica de velocidade aqui
end)

local puloSliderCont, _ = criarSlider(secaoPlayer, "Pulo", 50, 500, 100, 2, function(valor)
	print("Pulo definido para:", valor)
	-- Adicionar lógica de pulo aqui
end)

local seguirToggleCont, _ = criarBotaoToggle(secaoPlayer, "Seguir Jogador", 3, function(ativo)
	print("Seguir Jogador:", ativo)
	-- Adicionar lógica de seguir jogador aqui
end)

-- Adicionar mais seções (Combat, Visuals, Misc, etc.) e seus controles aqui...

print("Asta Hub Recriado: Seção Player adicionada.")





-- Função Auxiliar para criar Dropdown Moderno
local function criarDropdown(parent, texto, opcoes, defaultOpcao, layoutOrder, callback)
	local container = Instance.new("Frame")
	container.Name = texto .. "DropdownContainer"
	container.Size = UDim2.new(1, 0, 0, 35)
	container.BackgroundColor3 = corSecundaria
	container.BorderSizePixel = 0
	container.LayoutOrder = layoutOrder
	container.ClipsDescendants = false -- Permitir que o dropdown expanda
	container.Parent = parent

	local cantoContainer = Instance.new("UICorner")
	cantoContainer.CornerRadius = UDim.new(0, 6)
	cantoContainer.Parent = container

	local label = Instance.new("TextLabel")
	label.Name = "Label"
	label.Size = UDim2.new(0.4, -5, 1, 0)
	label.Position = UDim2.new(0, 5, 0, 0)
	label.BackgroundColor3 = corSecundaria
	label.BackgroundTransparency = 1
	label.Font = fonteUI
	label.TextColor3 = corTexto
	label.TextSize = tamanhoTextoPadrao
	label.Text = texto .. ":"
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = container

	local dropdownButton = Instance.new("TextButton")
	dropdownButton.Name = "DropdownButton"
	dropdownButton.Size = UDim2.new(0.6, -10, 0.8, 0)
	dropdownButton.Position = UDim2.new(0.4, 0, 0.1, 0)
	dropdownButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
	dropdownButton.Text = defaultOpcao
	dropdownButton.Font = fonteUI
	dropdownButton.TextColor3 = corTexto
	dropdownButton.TextSize = tamanhoTextoPadrao - 2
	dropdownButton.Parent = container

	local cantoDropdown = Instance.new("UICorner")
	cantoDropdown.CornerRadius = UDim.new(0, 4)
	cantoDropdown.Parent = dropdownButton

	local dropdownFrame = Instance.new("Frame")
	dropdownFrame.Name = "DropdownOptions"
	dropdownFrame.Size = UDim2.new(1, 0, 0, 0) -- Altura inicial 0
	dropdownFrame.Position = UDim2.new(0, 0, 1, 5) -- Abaixo do botão
	dropdownFrame.BackgroundColor3 = corSecundaria
	dropdownFrame.BorderSizePixel = 1
	dropdownFrame.BorderColor3 = Color3.fromRGB(100, 100, 100)
	dropdownFrame.Visible = false
	dropdownFrame.ClipsDescendants = true
	dropdownFrame.ZIndex = 2 -- Para ficar sobre outros elementos
	dropdownFrame.Parent = dropdownButton -- Aninhado para posicionamento relativo

	local cantoDropdownFrame = Instance.new("UICorner")
	cantoDropdownFrame.CornerRadius = UDim.new(0, 4)
	cantoDropdownFrame.Parent = dropdownFrame

	local layoutDropdown = Instance.new("UIListLayout")
	layoutDropdown.Padding = UDim.new(0, 2)
	layoutDropdown.SortOrder = Enum.SortOrder.LayoutOrder
	layoutDropdown.Parent = dropdownFrame

	local dropdownAberto = false

	local function atualizarOpcoes()
		for _, child in ipairs(dropdownFrame:GetChildren()) do
			if child:IsA("TextButton") then
				child:Destroy()
			end
		end

		local alturaTotal = 0
		for i, opcaoTexto in ipairs(opcoes) do
			local opcaoButton = Instance.new("TextButton")
			opcaoButton.Name = opcaoTexto
			opcaoButton.Size = UDim2.new(1, -10, 0, 25)
			opcaoButton.Position = UDim2.new(0, 5, 0, 0)
			opcaoButton.BackgroundColor3 = corSecundaria
			opcaoButton.BackgroundTransparency = 0.5
			opcaoButton.Text = opcaoTexto
			opcaoButton.Font = fonteUI
			opcaoButton.TextColor3 = corTexto
			opcaoButton.TextSize = tamanhoTextoPadrao - 2
			opcaoButton.LayoutOrder = i
			opcaoButton.Parent = dropdownFrame

			alturaTotal = alturaTotal + 25 + layoutDropdown.Padding.Offset

			opcaoButton.MouseEnter:Connect(function()
				opcaoButton.BackgroundTransparency = 0.2
			end)
			opcaoButton.MouseLeave:Connect(function()
				opcaoButton.BackgroundTransparency = 0.5
			end)

			opcaoButton.MouseButton1Click:Connect(function()
				dropdownButton.Text = opcaoTexto
				dropdownAberto = false
				dropdownFrame.Visible = false
				container.Size = UDim2.new(1, 0, 0, 35) -- Volta ao tamanho original
				container.ClipsDescendants = false
				if callback then callback(opcaoTexto) end
			end)
		end
		return alturaTotal + 5 -- Adiciona um pouco de padding extra
	end

	dropdownButton.MouseButton1Click:Connect(function()
		dropdownAberto = not dropdownAberto
		if dropdownAberto then
			local alturaOpcoes = atualizarOpcoes()
			dropdownFrame.Size = UDim2.new(1, 0, 0, alturaOpcoes)
			dropdownFrame.Visible = true
			container.Size = UDim2.new(1, 0, 0, 35 + alturaOpcoes + 5) -- Expande container
			container.ClipsDescendants = false -- Garante que o dropdown seja visível
		else
			dropdownFrame.Visible = false
			container.Size = UDim2.new(1, 0, 0, 35) -- Volta ao tamanho original
			container.ClipsDescendants = false
		end
	end)

	return container, dropdownButton
end

-- Seção: Combat
local secaoCombat = Instance.new("Frame")
secaoCombat.Name = "SecaoCombat"
secaoCombat.Size = UDim2.new(1, -20, 0, 250) -- Tamanho inicial, ajustará com layout
secaoCombat.BackgroundTransparency = 1
secaoCombat.BorderSizePixel = 0
secaoCombat.LayoutOrder = 2
secaoCombat.Parent = menuFrame

local layoutSecaoCombat = Instance.new("UIListLayout")
layoutSecaoCombat.Padding = UDim.new(0, 5)
layoutSecaoCombat.SortOrder = Enum.SortOrder.LayoutOrder
layoutSecaoCombat.Parent = secaoCombat

local tituloSecaoCombat = Instance.new("TextLabel")
tituloSecaoCombat.Name = "TituloSecaoCombat"
tituloSecaoCombat.Size = UDim2.new(1, 0, 0, 25)
tituloSecaoCombat.BackgroundColor3 = corPrincipal
tituloSecaoCombat.Text = "-- Combat --"
tituloSecaoCombat.Font = fonteUI
tituloSecaoCombat.TextColor3 = corDestaque
tituloSecaoCombat.TextSize = tamanhoTextoPadrao + 2
tituloSecaoCombat.LayoutOrder = 0
tituloSecaoCombat.Parent = secaoCombat

-- Controles Combat
local aimbotToggleCont, _ = criarBotaoToggle(secaoCombat, "Aimbot", 1, function(ativo)
	print("Aimbot:", ativo)
	-- Adicionar lógica do Aimbot aqui
end)

local aimbotTeamCheckToggle, _ = criarBotaoToggle(secaoCombat, "  ↳ Team Check", 2, function(ativo)
	print("Aimbot Team Check:", ativo)
	-- Adicionar lógica do Team Check aqui
end)

local aimbotWallCheckToggle, _ = criarBotaoToggle(secaoCombat, "  ↳ Wall Check", 3, function(ativo)
	print("Aimbot Wall Check:", ativo)
	-- Adicionar lógica do Wall Check aqui
end)

local aimbotBlatantToggle, _ = criarBotaoToggle(secaoCombat, "  ↳ Blatant Mode", 4, function(ativo)
	print("Aimbot Blatant Mode:", ativo)
	-- Adicionar lógica do Blatant Mode aqui
end)

local aimKillToggleCont, _ = criarBotaoToggle(secaoCombat, "Aim Kill", 5, function(ativo)
	print("Aim Kill:", ativo)
	-- Adicionar lógica do Aim Kill aqui
end)

local orbitKillToggleCont, _ = criarBotaoToggle(secaoCombat, "Orbit Kill", 6, function(ativo)
	print("Orbit Kill:", ativo)
	-- Adicionar lógica do Orbit Kill aqui
end)

local orbitSpeedSlider, _ = criarSlider(secaoCombat, "  ↳ Orbit Speed", 10, 200, 50, 7, function(valor)
	print("Orbit Speed definido para:", valor)
	-- Adicionar lógica da velocidade de órbita aqui
end)

local orbitRadiusSlider, _ = criarSlider(secaoCombat, "  ↳ Orbit Radius", 1, 20, 5, 8, function(valor)
	print("Orbit Radius definido para:", valor)
	-- Adicionar lógica do raio de órbita aqui
end)

print("Asta Hub Recriado: Seção Combat adicionada.")





-- Seção: Visuals
local secaoVisuals = Instance.new("Frame")
secaoVisuals.Name = "SecaoVisuals"
secaoVisuals.Size = UDim2.new(1, -20, 0, 150) -- Tamanho inicial, ajustará com layout
secaoVisuals.BackgroundTransparency = 1
secaoVisuals.BorderSizePixel = 0
secaoVisuals.LayoutOrder = 3
secaoVisuals.Parent = menuFrame

local layoutSecaoVisuals = Instance.new("UIListLayout")
layoutSecaoVisuals.Padding = UDim.new(0, 5)
layoutSecaoVisuals.SortOrder = Enum.SortOrder.LayoutOrder
layoutSecaoVisuals.Parent = secaoVisuals

local tituloSecaoVisuals = Instance.new("TextLabel")
tituloSecaoVisuals.Name = "TituloSecaoVisuals"
tituloSecaoVisuals.Size = UDim2.new(1, 0, 0, 25)
tituloSecaoVisuals.BackgroundColor3 = corPrincipal
tituloSecaoVisuals.Text = "-- Visuals --"
tituloSecaoVisuals.Font = fonteUI
tituloSecaoVisuals.TextColor3 = corDestaque
tituloSecaoVisuals.TextSize = tamanhoTextoPadrao + 2
tituloSecaoVisuals.LayoutOrder = 0
tituloSecaoVisuals.Parent = secaoVisuals

-- Controles Visuals
local espToggleCont, _ = criarBotaoToggle(secaoVisuals, "ESP", 1, function(ativo)
	print("ESP:", ativo)
	-- Adicionar lógica do ESP aqui
end)

local espModeDropdown, _ = criarDropdown(secaoVisuals, "  ↳ Modo ESP", {"Nome", "Box"}, "Nome", 2, function(opcao)
	print("Modo ESP definido para:", opcao)
	-- Adicionar lógica de mudança de modo ESP aqui
end)

-- Seção: Misc
local secaoMisc = Instance.new("Frame")
secaoMisc.Name = "SecaoMisc"
secaoMisc.Size = UDim2.new(1, -20, 0, 200) -- Tamanho inicial, ajustará com layout
secaoMisc.BackgroundTransparency = 1
secaoMisc.BorderSizePixel = 0
secaoMisc.LayoutOrder = 4
secaoMisc.Parent = menuFrame

local layoutSecaoMisc = Instance.new("UIListLayout")
layoutSecaoMisc.Padding = UDim.new(0, 5)
layoutSecaoMisc.SortOrder = Enum.SortOrder.LayoutOrder
layoutSecaoMisc.Parent = secaoMisc

local tituloSecaoMisc = Instance.new("TextLabel")
tituloSecaoMisc.Name = "TituloSecaoMisc"
tituloSecaoMisc.Size = UDim2.new(1, 0, 0, 25)
tituloSecaoMisc.BackgroundColor3 = corPrincipal
tituloSecaoMisc.Text = "-- Misc --"
tituloSecaoMisc.Font = fonteUI
tituloSecaoMisc.TextColor3 = corDestaque
tituloSecaoMisc.TextSize = tamanhoTextoPadrao + 2
tituloSecaoMisc.LayoutOrder = 0
tituloSecaoMisc.Parent = secaoMisc

-- Controles Misc
local wallPhaseToggle, _ = criarBotaoToggle(secaoMisc, "Wall Phase", 1, function(ativo)
	print("Wall Phase:", ativo)
	-- Adicionar lógica do Wall Phase aqui
end)

local ghostModeToggle, _ = criarBotaoToggle(secaoMisc, "Ghost Mode", 2, function(ativo)
	print("Ghost Mode:", ativo)
	-- Adicionar lógica do Ghost Mode aqui
end)

local flyToggle, _ = criarBotaoToggle(secaoMisc, "Fly", 3, function(ativo)
	print("Fly:", ativo)
	-- Adicionar lógica para ativar/desativar o sistema de voo (ou mostrar/ocultar a GUI de voo)
end)

print("Asta Hub Recriado: Seções Visuals e Misc adicionadas. Design da UI concluído.")

--[[ Próximo passo: Implementar as funcionalidades principais (lógica dos hacks) 
   e conectá-las aos controles da UI criados. 
]]



--[[ Implementação das Funcionalidades Principais ]]

-- Variáveis Globais para Funcionalidades
local velocidadeValor = 100
local puloValor = 100
local velocidadeAtivo = false
local puloAtivo = false

local seguindoJogador = nil
local seguindoConexao = nil
local distanciaSeguir = 5

local espAtivo = false
local espModo = "Nome"
local espObjects = {}

local aimbotEnabled = false
local teamCheck = false
local wallCheck = false
local blatantMode = false

local aimKillEnabled = false
local aimKillConnection = nil
local currentTarget = nil
local attackDelay = 0

local orbitKillEnabled = false
local orbitKillConnection = nil
local orbitSpeed = 50
local orbitRadius = 5
local orbitAngle = 0
local orbitHeight = 0

local wallPhaseEnabled = false
local wallPhaseConnection = nil

local flyGui = nil
local speeds = 1
local nowe = false
local tpwalking = false

-- Variáveis para o Ghost Mode
local ghostEnabled = false
local OriginalCharacter = nil
local DupeCharacter = nil
local ghostModeActivated = false
local characterAddedByGhost = false

-- Função para notificações modernas com animação
local function notificar(titulo, descricao, duracao)
    duracao = duracao or 3
    
    local notifGui = Instance.new("ScreenGui")
    notifGui.Name = "AstaNotification"
    notifGui.Parent = Player:WaitForChild("PlayerGui")
    
    local notifFrame = Instance.new("Frame")
    notifFrame.Name = "NotifFrame"
    notifFrame.Size = UDim2.new(0, 250, 0, 80)
    notifFrame.Position = UDim2.new(1, 20, 0.8, 0) -- Começa fora da tela
    notifFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    notifFrame.BorderSizePixel = 0
    notifFrame.Parent = notifGui
    
    local cantoNotif = Instance.new("UICorner")
    cantoNotif.CornerRadius = UDim.new(0, 8)
    cantoNotif.Parent = notifFrame
    
    local tituloLabel = Instance.new("TextLabel")
    tituloLabel.Name = "Titulo"
    tituloLabel.Size = UDim2.new(1, -20, 0, 25)
    tituloLabel.Position = UDim2.new(0, 10, 0, 5)
    tituloLabel.BackgroundTransparency = 1
    tituloLabel.Font = fonteUI
    tituloLabel.TextColor3 = corDestaque
    tituloLabel.TextSize = tamanhoTextoPadrao + 2
    tituloLabel.Text = titulo
    tituloLabel.TextXAlignment = Enum.TextXAlignment.Left
    tituloLabel.Parent = notifFrame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Name = "Descricao"
    descLabel.Size = UDim2.new(1, -20, 0, 40)
    descLabel.Position = UDim2.new(0, 10, 0, 30)
    descLabel.BackgroundTransparency = 1
    descLabel.Font = fonteUI
    descLabel.TextColor3 = corTexto
    descLabel.TextSize = tamanhoTextoPadrao
    descLabel.Text = descricao
    descLabel.TextWrapped = true
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = notifFrame
    
    -- Animação de entrada
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tweenEntrada = TweenService:Create(notifFrame, tweenInfo, {Position = UDim2.new(1, -270, 0.8, 0)})
    tweenEntrada:Play()
    
    -- Animação de saída após o tempo
    delay(duracao, function()
        local tweenSaida = TweenService:Create(notifFrame, tweenInfo, {Position = UDim2.new(1, 20, 0.8, 0)})
        tweenSaida:Play()
        
        tweenSaida.Completed:Connect(function()
            notifGui:Destroy()
        end)
    end)
end

-- Função para atualizar o Humanoid do jogador
local function atualizarHumanoid()
    local Character = Player.Character or Player.CharacterAdded:Wait()
    local Humanoid = Character:WaitForChild("Humanoid")
    return Character, Humanoid
end

-- Implementação: Velocidade e Pulo
local function setVelocidade(valor, ativo)
    velocidadeValor = valor
    velocidadeAtivo = ativo
    
    local Character, Humanoid = atualizarHumanoid()
    
    if velocidadeAtivo then
        Humanoid.WalkSpeed = velocidadeValor
        notificar("Velocidade", "Ativada: " .. velocidadeValor, 2)
    else
        Humanoid.WalkSpeed = 16 -- Velocidade padrão
        notificar("Velocidade", "Desativada", 2)
    end
end

local function setPulo(valor, ativo)
    puloValor = valor
    puloAtivo = ativo
    
    local Character, Humanoid = atualizarHumanoid()
    
    if puloAtivo then
        Humanoid.JumpPower = puloValor
        notificar("Pulo", "Ativado: " .. puloValor, 2)
    else
        Humanoid.JumpPower = 50 -- Pulo padrão
        notificar("Pulo", "Desativado", 2)
    end
end

-- Implementação: Seguir Jogador
local function seguirJogador(jogadorAlvo)
    if seguindoConexao then
        seguindoConexao:Disconnect()
        seguindoConexao = nil
    end
    
    if not jogadorAlvo then
        notificar("Seguir Jogador", "Selecione um jogador para seguir", 2)
        return
    end
    
    seguindoJogador = jogadorAlvo
    
    notificar("Seguir Jogador", "Seguindo: " .. jogadorAlvo.Name, 2)
    
    seguindoConexao = RunService.Heartbeat:Connect(function()
        if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then return end
        if not jogadorAlvo or not jogadorAlvo.Character or not jogadorAlvo.Character:FindFirstChild("HumanoidRootPart") then
            seguindoConexao:Disconnect()
            seguindoConexao = nil
            notificar("Seguir Jogador", "Alvo perdido", 2)
            return
        end
        
        local meuRoot = Player.Character.HumanoidRootPart
        local alvoRoot = jogadorAlvo.Character.HumanoidRootPart
        
        local direcao = (alvoRoot.Position - meuRoot.Position).Unit
        local distancia = (alvoRoot.Position - meuRoot.Position).Magnitude
        
        if distancia > distanciaSeguir then
            local novaPosicao = alvoRoot.Position - (direcao * distanciaSeguir)
            meuRoot.CFrame = CFrame.new(novaPosicao, alvoRoot.Position)
        end
    end)
end

local function pararSeguir()
    if seguindoConexao then
        seguindoConexao:Disconnect()
        seguindoConexao = nil
        seguindoJogador = nil
        notificar("Seguir Jogador", "Parou de seguir", 2)
    end
end

-- Implementação: ESP
local function criarESP(jogador)
    if jogador == Player then return end
    local char = jogador.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not head or not root then return end
    
    if espModo == "Nome" then
        local esp = Instance.new("BillboardGui")
        esp.Name = "ESP"
        esp.Size = UDim2.new(0, 70, 0, 20)
        esp.AlwaysOnTop = true
        esp.StudsOffset = Vector3.new(0, 2, 0)
        esp.Parent = head
        
        local texto = Instance.new("TextLabel")
        texto.Size = UDim2.new(1, 0, 1, 0)
        texto.BackgroundTransparency = 1
        texto.Text = jogador.Name
        texto.TextColor3 = Color3.fromRGB(0, 255, 0)
        texto.TextStrokeTransparency = 0.5
        texto.Font = fonteUI
        texto.TextSize = 12
        texto.Parent = esp
        
        espObjects[jogador] = esp
    elseif espModo == "Box" then
        local box = Instance.new("BoxHandleAdornment")
        box.Name = "ESP_BOX"
        box.Adornee = root
        box.Size = Vector3.new(4, 6, 2)
        box.Color3 = Color3.fromRGB(0, 255, 0)
        box.Transparency = 0.3
        box.AlwaysOnTop = true
        box.ZIndex = 5
        box.Parent = root
        
        espObjects[jogador] = box
    end
end

local function removerESP(jogador)
    if espObjects[jogador] then
        if typeof(espObjects[jogador]) == "Instance" then
            espObjects[jogador]:Destroy()
        end
        espObjects[jogador] = nil
    end
end

local function atualizarESP()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= Player and plr.Character and plr.Character:FindFirstChild("Head") then
            if espAtivo and not espObjects[plr] then
                criarESP(plr)
            elseif not espAtivo and espObjects[plr] then
                removerESP(plr)
            end
        end
    end
end

local function setESP(ativo, modo)
    espAtivo = ativo
    if modo then espModo = modo end
    
    if espAtivo then
        notificar("ESP", "Ativado - Modo: " .. espModo, 2)
        
        -- Limpar ESP existente se mudar de modo
        for plr, _ in pairs(espObjects) do
            removerESP(plr)
        end
        
        -- Criar novo ESP
        atualizarESP()
        
        -- Conectar eventos para manter ESP atualizado
        if not espUpdateConnection then
            espUpdateConnection = RunService.RenderStepped:Connect(atualizarESP)
        end
        
        if not playerAddedConnection then
            playerAddedConnection = Players.PlayerAdded:Connect(function(plr)
                if espAtivo then
                    plr.CharacterAdded:Connect(function()
                        wait(1) -- Esperar o personagem carregar
                        if espAtivo then criarESP(plr) end
                    end)
                end
            end)
        end
        
        if not playerRemovingConnection then
            playerRemovingConnection = Players.PlayerRemoving:Connect(function(plr)
                removerESP(plr)
            end)
        end
        
        -- Conectar para personagens existentes
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= Player then
                plr.CharacterAdded:Connect(function()
                    wait(1)
                    if espAtivo then criarESP(plr) end
                end)
            end
        end
    else
        notificar("ESP", "Desativado", 2)
        
        -- Limpar ESP
        for plr, _ in pairs(espObjects) do
            removerESP(plr)
        end
        
        -- Desconectar eventos
        if espUpdateConnection then
            espUpdateConnection:Disconnect()
            espUpdateConnection = nil
        end
    end
end

-- Implementação: Aimbot
local function toggleAimbot(ativo)
    aimbotEnabled = ativo
    
    if aimbotEnabled then
        RunService:BindToRenderStep("Aimbot", Enum.RenderPriority.Camera.Value + 1, function()
            if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            local playerPosition = Player.Character.HumanoidRootPart.Position
            local closestPlayer = nil
            local closestDistance = math.huge
            
            for _, player in pairs(Players:GetPlayers()) do
                if ((player ~= Player) and player.Character and player.Character:FindFirstChild("Head") and player.Character:FindFirstChild("HumanoidRootPart")) then
                    if (teamCheck and (player.Team == Player.Team)) then
                        continue
                    end
                    
                    if wallCheck then
                        local ray = Ray.new(workspace.CurrentCamera.CFrame.Position, (player.Character.Head.Position - workspace.CurrentCamera.CFrame.Position).Unit * 500)
                        local hitPart = workspace:FindPartOnRay(ray, Player.Character)
                        if (hitPart and not hitPart:IsDescendantOf(player.Character)) then
                            continue
                        end
                    end
                    
                    local distance = (player.Character.HumanoidRootPart.Position - playerPosition).Magnitude
                    if distance < closestDistance then
                        closestDistance = distance
                        closestPlayer = player
                    end
                end
            end
            
            if closestPlayer then
                local smoothFactor = (blatantMode and 1) or 0.2
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.Position, closestPlayer.Character.Head.Position), smoothFactor)
            end
        end)
        
        notificar("Aimbot", "Ativado", 2)
    else
        RunService:UnbindFromRenderStep("Aimbot")
        notificar("Aimbot", "Desativado", 2)
    end
end

-- Implementação: Aim Kill e Orbit Kill
local function encontrarProximoAlvo()
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local playerPosition = Player.Character.HumanoidRootPart.Position
    local closestPlayer = nil
    local closestDistance = math.huge
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= Player and player.Character and 
           player.Character:FindFirstChild("HumanoidRootPart") and 
           player.Character:FindFirstChild("Humanoid") and 
           player.Character.Humanoid.Health > 0 then
            
            if teamCheck and player.Team == Player.Team then
                continue
            end
            
            local distance = (player.Character.HumanoidRootPart.Position - playerPosition).Magnitude
            if distance < closestDistance then
                closestDistance = distance
                closestPlayer = player
            end
        end
    end
    
    return closestPlayer
end

local function teleportarAtrasDoJogador(jogador)
    if not jogador or not jogador.Character or not jogador.Character:FindFirstChild("HumanoidRootPart") or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local alvoRoot = jogador.Character.HumanoidRootPart
    local meuRoot = Player.Character.HumanoidRootPart
    
    local direcao = alvoRoot.CFrame.LookVector
    local posicaoAtras = alvoRoot.Position - (direcao * 3)
    
    meuRoot.CFrame = CFrame.new(posicaoAtras, alvoRoot.Position)
    
    return true
end

local function orbitarAoRedorDoJogador(jogador)
    if not jogador or not jogador.Character or not jogador.Character:FindFirstChild("HumanoidRootPart") or not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return false
    end
    
    local alvoRoot = jogador.Character.HumanoidRootPart
    local meuRoot = Player.Character.HumanoidRootPart
    
    orbitAngle = orbitAngle + orbitSpeed
    if orbitAngle >= 360 then
        orbitAngle = orbitAngle - 360
    end
    
    local rad = math.rad(orbitAngle)
    local x = math.cos(rad) * orbitRadius
    local z = math.sin(rad) * orbitRadius
    
    local posicaoOrbita = alvoRoot.Position + Vector3.new(x, orbitHeight, z)
    
    meuRoot.CFrame = CFrame.new(posicaoOrbita, alvoRoot.Position)
    
    return true
end

local function atacarJogador(jogador)
    if not jogador or not jogador.Character then return end
    
    local args = {
        [1] = jogador.Character
    }
    
    if workspace:FindFirstChild("Remote") and workspace.Remote:FindFirstChild("Damage") then
        workspace.Remote.Damage:FireServer(unpack(args))
    end
    
    if Player.Character:FindFirstChildOfClass("Tool") then
        local tool = Player.Character:FindFirstChildOfClass("Tool")
        if tool:FindFirstChild("Attack") then
            tool.Attack:FireServer(unpack(args))
        elseif tool:FindFirstChild("Hit") then
            tool.Hit:FireServer(unpack(args))
        end
    end
    
    if game:GetService("ReplicatedStorage"):FindFirstChild("Attack") then
        game:GetService("ReplicatedStorage").Attack:FireServer(unpack(args))
    end
end

local function toggleAimKill(ativo)
    aimKillEnabled = ativo
    
    if aimKillEnabled then
        if aimKillConnection then
            aimKillConnection:Disconnect()
        end
        
        local lastAttackTime = 0
        
        aimKillConnection = RunService.Heartbeat:Connect(function()
            if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            if not currentTarget or 
               not currentTarget.Character or 
               not currentTarget.Character:FindFirstChild("Humanoid") or 
               currentTarget.Character.Humanoid.Health <= 0 then
                
                currentTarget = encontrarProximoAlvo()
                if not currentTarget then return end
                
                teleportarAtrasDoJogador(currentTarget)
            end
            
            if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Head") then
                local smoothFactor = (blatantMode and 1) or 0.5
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.Position, currentTarget.Character.Head.Position), smoothFactor)
                
                local currentTime = tick()
                if currentTime - lastAttackTime >= attackDelay then
                    lastAttackTime = currentTime
                    atacarJogador(currentTarget)
                end
                
                teleportarAtrasDoJogador(currentTarget)
            end
        end)
        
        notificar("Aim Kill", "Ativado com teleporte automático", 2)
    else
        if aimKillConnection then
            aimKillConnection:Disconnect()
            aimKillConnection = nil
        end
        
        currentTarget = nil
        notificar("Aim Kill", "Desativado", 2)
    end
end

local function toggleOrbitKill(ativo)
    orbitKillEnabled = ativo
    
    if orbitKillEnabled then
        if orbitKillConnection then
            orbitKillConnection:Disconnect()
        end
        
        local lastAttackTime = 0
        
        orbitKillConnection = RunService.RenderStepped:Connect(function()
            if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
                return
            end
            
            if not currentTarget or 
               not currentTarget.Character or 
               not currentTarget.Character:FindFirstChild("Humanoid") or 
               currentTarget.Character.Humanoid.Health <= 0 then
                
                currentTarget = encontrarProximoAlvo()
                if not currentTarget then return end
            end
            
            if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild("Head") then
                local smoothFactor = (blatantMode and 1) or 0.5
                workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(CFrame.new(workspace.CurrentCamera.CFrame.Position, currentTarget.Character.Head.Position), smoothFactor)
                
                local currentTime = tick()
                if currentTime - lastAttackTime >= attackDelay then
                    lastAttackTime = currentTime
                    atacarJogador(currentTarget)
                end
                
                orbitarAoRedorDoJogador(currentTarget)
            end
        end)
        
        notificar("Orbit Kill", "Ativado - Girando ao redor do alvo", 2)
    else
        if orbitKillConnection then
            orbitKillConnection:Disconnect()
            orbitKillConnection = nil
        end
        
        currentTarget = nil
        notificar("Orbit Kill", "Desativado", 2)
    end
end

-- Implementação: Wall Phase
local function toggleWallPhase(ativo)
    wallPhaseEnabled = ativo
    
    if wallPhaseEnabled then
        if Player.Character then
            for _, part in pairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            
            if wallPhaseConnection then
                wallPhaseConnection:Disconnect()
            end
            
            wallPhaseConnection = RunService.RenderStepped:Connect(function()
                if Player.Character then
                    for _, part in pairs(Player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        end
        
        notificar("Atravessar Paredes", "Ativado", 2)
    else
        if wallPhaseConnection then
            wallPhaseConnection:Disconnect()
            wallPhaseConnection = nil
        end
        
        if Player.Character then
            for _, part in pairs(Player.Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.CanCollide = true
                end
            end
        end
        
        notificar("Atravessar Paredes", "Desativado", 2)
    end
end

-- Implementação: Ghost Mode
local function toggleGhost(ativo)
    ghostEnabled = ativo
    
    if ghostEnabled then
        ghostModeActivated = true
        
        if not Player or not Player.Character then
            notificar("Ghost Mode", "Falha ao ativar - Personagem não encontrado", 2)
            ghostEnabled = false
            ghostModeActivated = false
            return
        end
        
        local char = Player.Character
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        local rootPart = char:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not rootPart or humanoid.Health <= 0 then
            notificar("Ghost Mode", "Falha ao ativar - Personagem incompleto ou morto", 2)
            ghostEnabled = false
            ghostModeActivated = false
            return
        end
        
        local Camera = workspace.CurrentCamera
        Camera.CameraType = "Fixed"
        
        OriginalCharacter = char
        OriginalCharacter.Archivable = true
        
        local success, result = pcall(function()
            local clone = OriginalCharacter:Clone()
            return clone
        end)
        
        if not success or not result then
            notificar("Ghost Mode", "Falha ao clonar personagem", 2)
            ghostEnabled = false
            ghostModeActivated = false
            Camera.CameraType = "Follow"
            return
        end
        
        DupeCharacter = result
        DupeCharacter.Parent = workspace
        
        if not DupeCharacter:FindFirstChild("HumanoidRootPart") then
            notificar("Ghost Mode", "Falha ao clonar - Clone incompleto", 2)
            DupeCharacter:Destroy()
            ghostEnabled = false
            ghostModeActivated = false
            Camera.CameraType = "Follow"
            return
        end
        
        DupeCharacter.HumanoidRootPart.CFrame = rootPart.CFrame
        
        for _, v in pairs(OriginalCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                pcall(function()
                    local clone = v:Clone()
                    clone.Disabled = true
                    clone.Parent = DupeCharacter
                end)
            end
        end
        
        local dupeHumanoid = DupeCharacter:FindFirstChildOfClass("Humanoid")
        if not dupeHumanoid then
            notificar("Ghost Mode", "Falha ao clonar - Humanoid não encontrado no clone", 2)
            DupeCharacter:Destroy()
            ghostEnabled = false
            ghostModeActivated = false
            Camera.CameraType = "Follow"
            return
        end
        
        pcall(function()
            if humanoid then
                humanoid:UnequipTools()
            end
        end)
        
        characterAddedByGhost = true
        
        pcall(function()
            Player.Character = DupeCharacter
            workspace.CurrentCamera.CameraSubject = dupeHumanoid
        end)
        
        for _, v in pairs(DupeCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                pcall(function()
                    v.Disabled = false
                end)
            end
        end
        
        OriginalCharacter.Parent = nil
        Camera.CameraType = "Follow"
        
        notificar("Ghost Mode", "Ativado - Seu personagem original está oculto", 2)
    else
        if not DupeCharacter or not OriginalCharacter then
            notificar("Ghost Mode", "Falha ao desativar - Personagens não encontrados", 2)
            return
        end
        
        local Camera = workspace.CurrentCamera
        Camera.CameraType = "Fixed"
        
        local dupeHumanoid = DupeCharacter:FindFirstChildOfClass("Humanoid")
        if dupeHumanoid then
            pcall(function()
                dupeHumanoid:UnequipTools()
            end)
        end
        
        local dupeRoot = DupeCharacter:FindFirstChild("HumanoidRootPart")
        local origHumanoid = OriginalCharacter:FindFirstChildOfClass("Humanoid")
        
        characterAddedByGhost = true
        ghostModeActivated = false
        
        pcall(function()
            Player.Character = OriginalCharacter
            OriginalCharacter.Parent = game.workspace
            
            if dupeRoot and OriginalCharacter:FindFirstChild("HumanoidRootPart") then
                OriginalCharacter.HumanoidRootPart.CFrame = dupeRoot.CFrame
            end
            
            if origHumanoid then
                workspace.CurrentCamera.CameraSubject = origHumanoid
            end
        end)
        
        for _, v in pairs(DupeCharacter:GetChildren()) do
            if v:IsA("LocalScript") then
                pcall(function()
                    v.Disabled = true
                end)
            end
        end
        
        pcall(function()
            DupeCharacter:Destroy()
        end)
        
        Camera.CameraType = "Follow"
        
        notificar("Ghost Mode", "Desativado - Seu personagem original foi restaurado", 2)
    end
end

-- Implementação: Sistema de Voo (Fly)
local function criarGUIVoo()
    -- Versão moderna da GUI de voo
    local main = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local up = Instance.new("TextButton")
    local down = Instance.new("TextButton")
    local onof = Instance.new("TextButton")
    local TextLabel = Instance.new("TextLabel")
    local plus = Instance.new("TextButton")
    local speed = Instance.new("TextLabel")
    local mine = Instance.new("TextButton")

    main.Name = "AstaFlyGui"
    main.Parent = Player:WaitForChild("PlayerGui")
    main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    Frame.Parent = main
    Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Frame.BorderColor3 = Color3.fromRGB(60, 60, 60)
    Frame.Position = UDim2.new(0.7, 0, 0.7, 0)
    Frame.Size = UDim2.new(0, 190, 0, 57)
    
    local cantoFrame = Instance.new("UICorner")
    cantoFrame.CornerRadius = UDim.new(0, 8)
    cantoFrame.Parent = Frame

    up.Name = "up"
    up.Parent = Frame
    up.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
    up.Size = UDim2.new(0, 44, 0, 28)
    up.Font = fonteUI
    up.Text = "UP"
    up.TextColor3 = Color3.fromRGB(255, 255, 255)
    up.TextSize = 14.000
    
    local cantoUp = Instance.new("UICorner")
    cantoUp.CornerRadius = UDim.new(0, 4)
    cantoUp.Parent = up

    down.Name = "down"
    down.Parent = Frame
    down.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    down.Position = UDim2.new(0, 0, 0.491228074, 0)
    down.Size = UDim2.new(0, 44, 0, 28)
    down.Font = fonteUI
    down.Text = "DOWN"
    down.TextColor3 = Color3.fromRGB(255, 255, 255)
    down.TextSize = 14.000
    
    local cantoDown = Instance.new("UICorner")
    cantoDown.CornerRadius = UDim.new(0, 4)
    cantoDown.Parent = down

    onof.Name = "onof"
    onof.Parent = Frame
    onof.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
    onof.Position = UDim2.new(0.702823281, 0, 0.491228074, 0)
    onof.Size = UDim2.new(0, 56, 0, 28)
    onof.Font = fonteUI
    onof.Text = "FLY"
    onof.TextColor3 = Color3.fromRGB(0, 0, 0)
    onof.TextSize = 14.000
    
    local cantoOnof = Instance.new("UICorner")
    cantoOnof.CornerRadius = UDim.new(0, 4)
    cantoOnof.Parent = onof

    TextLabel.Parent = Frame
    TextLabel.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
    TextLabel.Position = UDim2.new(0.469327301, 0, 0, 0)
    TextLabel.Size = UDim2.new(0, 100, 0, 28)
    TextLabel.Font = fonteUI
    TextLabel.Text = "Asta Fly"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true
    
    local cantoLabel = Instance.new("UICorner")
    cantoLabel.CornerRadius = UDim.new(0, 4)
    cantoLabel.Parent = TextLabel

    plus.Name = "plus"
    plus.Parent = Frame
    plus.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    plus.Position = UDim2.new(0.231578946, 0, 0, 0)
    plus.Size = UDim2.new(0, 45, 0, 28)
    plus.Font = fonteUI
    plus.Text = "+"
    plus.TextColor3 = Color3.fromRGB(255, 255, 255)
    plus.TextScaled = true
    plus.TextSize = 14.000
    plus.TextWrapped = true
    
    local cantoPlus = Instance.new("UICorner")
    cantoPlus.CornerRadius = UDim.new(0, 4)
    cantoPlus.Parent = plus

    speed.Name = "speed"
    speed.Parent = Frame
    speed.BackgroundColor3 = Color3.fromRGB(255, 85, 0)
    speed.Position = UDim2.new(0.468421042, 0, 0.491228074, 0)
    speed.Size = UDim2.new(0, 44, 0, 28)
    speed.Font = fonteUI
    speed.Text = "1"
    speed.TextColor3 = Color3.fromRGB(255, 255, 255)
    speed.TextScaled = true
    speed.TextSize = 14.000
    speed.TextWrapped = true
    
    local cantoSpeed = Instance.new("UICorner")
    cantoSpeed.CornerRadius = UDim.new(0, 4)
    cantoSpeed.Parent = speed

    mine.Name = "mine"
    mine.Parent = Frame
    mine.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    mine.Position = UDim2.new(0.231578946, 0, 0.491228074, 0)
    mine.Size = UDim2.new(0, 45, 0, 29)
    mine.Font = fonteUI
    mine.Text = "-"
    mine.TextColor3 = Color3.fromRGB(255, 255, 255)
    mine.TextScaled = true
    mine.TextSize = 14.000
    mine.TextWrapped = true
    
    local cantoMine = Instance.new("UICorner")
    cantoMine.CornerRadius = UDim.new(0, 4)
    cantoMine.Parent = mine

    -- Adicionar animação de entrada
    Frame.Position = UDim2.new(1.1, 0, 0.7, 0) -- Começa fora da tela
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tweenEntrada = TweenService:Create(Frame, tweenInfo, {Position = UDim2.new(0.7, 0, 0.7, 0)})
    tweenEntrada:Play()

    Frame.Active = true
    Frame.Draggable = true

    return {
        main = main,
        Frame = Frame,
        up = up,
        down = down,
        onof = onof,
        TextLabel = TextLabel,
        plus = plus,
        speed = speed,
        mine = mine
    }
end

local function configurarSistemaVoo()
    if flyGui then
        flyGui.main:Destroy()
    end
    
    flyGui = criarGUIVoo()
    
    notificar("Asta Fly", "Sistema de voo ativado", 2)
    
    flyGui.onof.MouseButton1Click:Connect(function()
        local speaker = Player
        local chr = speaker.Character
        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")

        if nowe == true then
            nowe = false

            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,true)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,true)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
            
            -- Animação de botão
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenColor = TweenService:Create(flyGui.onof, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 215, 0)})
            tweenColor:Play()
        else 
            nowe = true

            for i = 1, speeds do
                spawn(function()
                    local hb = RunService.Heartbeat
                    tpwalking = true
                    local chr = speaker.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
            
            speaker.Character.Animate.Disabled = true
            local Char = speaker.Character
            local Hum = Char:FindFirstChildOfClass("Humanoid") or Char:FindFirstChildOfClass("AnimationController")

            for i,v in next, Hum:GetPlayingAnimationTracks() do
                v:AdjustSpeed(0)
            end
            
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Climbing,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Flying,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.GettingUp,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Landed,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.PlatformStanding,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Running,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.RunningNoPhysics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.StrafingNoPhysics,false)
            speaker.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Swimming,false)
            speaker.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Swimming)
            
            -- Animação de botão
            local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenColor = TweenService:Create(flyGui.onof, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tweenColor:Play()
        end

        if game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid").RigType == Enum.HumanoidRigType.R6 then
            local plr = Player
            local torso = plr.Character.Torso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            local bg = Instance.new("BodyGyro", torso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = torso.CFrame
            local bv = Instance.new("BodyVelocity", torso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            
            while nowe == true or Player.Character.Humanoid.Health == 0 do
                RunService.RenderStepped:Wait()

                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed+.5+(speed/maxspeed)
                    if speed > maxspeed then
                        speed = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed-1
                    if speed < 0 then
                        speed = 0
                    end
                end
                
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end
                
                bg.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            speaker.Character.Animate.Disabled = false
            tpwalking = false
        else
            local plr = Player
            local UpperTorso = plr.Character.UpperTorso
            local flying = true
            local deb = true
            local ctrl = {f = 0, b = 0, l = 0, r = 0}
            local lastctrl = {f = 0, b = 0, l = 0, r = 0}
            local maxspeed = 50
            local speed = 0

            local bg = Instance.new("BodyGyro", UpperTorso)
            bg.P = 9e4
            bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.cframe = UpperTorso.CFrame
            local bv = Instance.new("BodyVelocity", UpperTorso)
            bv.velocity = Vector3.new(0,0.1,0)
            bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
            
            if nowe == true then
                plr.Character.Humanoid.PlatformStand = true
            end
            
            while nowe == true or Player.Character.Humanoid.Health == 0 do
                wait()

                if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then
                    speed = speed+.5+(speed/maxspeed)
                    if speed > maxspeed then
                        speed = maxspeed
                    end
                elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then
                    speed = speed-1
                    if speed < 0 then
                        speed = 0
                    end
                end
                
                if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*speed
                    lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r}
                elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then
                    bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - workspace.CurrentCamera.CoordinateFrame.p))*speed
                else
                    bv.velocity = Vector3.new(0,0,0)
                end

                bg.cframe = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0)
            end
            
            ctrl = {f = 0, b = 0, l = 0, r = 0}
            lastctrl = {f = 0, b = 0, l = 0, r = 0}
            speed = 0
            bg:Destroy()
            bv:Destroy()
            plr.Character.Humanoid.PlatformStand = false
            speaker.Character.Animate.Disabled = false
            tpwalking = false
        end
    end)

    flyGui.up.MouseButton1Down:Connect(function()
        Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0,2,0)
        
        -- Animação de botão
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenColor = TweenService:Create(flyGui.up, tweenInfo, {BackgroundColor3 = Color3.fromRGB(100, 200, 255)})
        tweenColor:Play()
        
        delay(0.1, function()
            local tweenBack = TweenService:Create(flyGui.up, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 150, 255)})
            tweenBack:Play()
        end)
    end)

    flyGui.down.MouseButton1Down:Connect(function()
        Player.Character.HumanoidRootPart.CFrame = Player.Character.HumanoidRootPart.CFrame * CFrame.new(0,-2,0)
        
        -- Animação de botão
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenColor = TweenService:Create(flyGui.down, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 150, 150)})
        tweenColor:Play()
        
        delay(0.1, function()
            local tweenBack = TweenService:Create(flyGui.down, tweenInfo, {BackgroundColor3 = Color3.fromRGB(255, 100, 100)})
            tweenBack:Play()
        end)
    end)

    flyGui.plus.MouseButton1Down:Connect(function()
        speeds = speeds + 1
        flyGui.speed.Text = speeds
        
        -- Animação de botão
        local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tweenColor = TweenService:Create(flyGui.plus, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 255, 150)})
        tweenColor:Play()
        
        delay(0.1, function()
            local tweenBack = TweenService:Create(flyGui.plus, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 200, 100)})
            tweenBack:Play()
        end)
        
        if nowe == true then
            tpwalking = false
            for i = 1, speeds do
                spawn(function()
                    local hb = RunService.Heartbeat
                    tpwalking = true
                    local chr = Player.Character
                    local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                    while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                        if hum.MoveDirection.Magnitude > 0 then
                            chr:TranslateBy(hum.MoveDirection)
                        end
                    end
                end)
            end
        end
    end)

    flyGui.mine.MouseButton1Down:Connect(function()
        if speeds == 1 then
            flyGui.speed.Text = 'min: 1'
            
            -- Animação de texto
            local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenColor = TweenService:Create(flyGui.speed, tweenInfo, {TextColor3 = Color3.fromRGB(255, 150, 150)})
            tweenColor:Play()
            
            delay(1, function()
                flyGui.speed.Text = speeds
                local tweenBack = TweenService:Create(flyGui.speed, tweenInfo, {TextColor3 = Color3.fromRGB(255, 255, 255)})
                tweenBack:Play()
            end)
        else
            speeds = speeds - 1
            flyGui.speed.Text = speeds
            
            -- Animação de botão
            local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            local tweenColor = TweenService:Create(flyGui.mine, tweenInfo, {BackgroundColor3 = Color3.fromRGB(50, 200, 255)})
            tweenColor:Play()
            
            delay(0.1, function()
                local tweenBack = TweenService:Create(flyGui.mine, tweenInfo, {BackgroundColor3 = Color3.fromRGB(0, 150, 255)})
                tweenBack:Play()
            end)
            
            if nowe == true then
                tpwalking = false
                for i = 1, speeds do
                    spawn(function()
                        local hb = RunService.Heartbeat
                        tpwalking = true
                        local chr = Player.Character
                        local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
                        while tpwalking and hb:Wait() and chr and hum and hum.Parent do
                            if hum.MoveDirection.Magnitude > 0 then
                                chr:TranslateBy(hum.MoveDirection)
                            end
                        end
                    end)
                end
            end
        end
    end)
end

-- Conectar os controles da UI às funcionalidades
local function conectarControlesUI()
    -- Seção Player
    local velocidadeSlider = secaoPlayer:FindFirstChild("VelocidadeSliderContainer")
    if velocidadeSlider then
        local sliderHandle = velocidadeSlider:FindFirstChild("SliderBackground"):FindFirstChild("SliderHandle")
        sliderHandle.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                setVelocidade(velocidadeValor, velocidadeAtivo)
            end
        end)
    end
    
    local puloSlider = secaoPlayer:FindFirstChild("PuloSliderContainer")
    if puloSlider then
        local sliderHandle = puloSlider:FindFirstChild("SliderBackground"):FindFirstChild("SliderHandle")
        sliderHandle.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                setPulo(puloValor, puloAtivo)
            end
        end)
    end
    
    local seguirToggle = secaoPlayer:FindFirstChild("Seguir JogadorToggleContainer")
    if seguirToggle then
        local toggleButton = seguirToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            if toggleButton.Text == "ON" then
                -- Implementar seleção de jogador
                local jogadores = {}
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= Player then
                        table.insert(jogadores, plr.Name)
                    end
                end
                
                if #jogadores > 0 then
                    -- Criar menu de seleção de jogador
                    local selecaoGui = Instance.new("ScreenGui")
                    selecaoGui.Name = "SelecaoJogadorGui"
                    selecaoGui.Parent = Player:WaitForChild("PlayerGui")
                    
                    local selecaoFrame = Instance.new("Frame")
                    selecaoFrame.Name = "SelecaoFrame"
                    selecaoFrame.Size = UDim2.new(0, 250, 0, 300)
                    selecaoFrame.Position = UDim2.new(0.5, -125, 0.5, -150)
                    selecaoFrame.BackgroundColor3 = corPrincipal
                    selecaoFrame.BorderSizePixel = 0
                    selecaoFrame.Parent = selecaoGui
                    
                    local cantoSelecao = Instance.new("UICorner")
                    cantoSelecao.CornerRadius = UDim.new(0, 8)
                    cantoSelecao.Parent = selecaoFrame
                    
                    local tituloSelecao = Instance.new("TextLabel")
                    tituloSelecao.Name = "Titulo"
                    tituloSelecao.Size = UDim2.new(1, 0, 0, 40)
                    tituloSelecao.BackgroundColor3 = corSecundaria
                    tituloSelecao.Text = "Selecione um Jogador"
                    tituloSelecao.Font = fonteUI
                    tituloSelecao.TextColor3 = corTexto
                    tituloSelecao.TextSize = tamanhoTextoPadrao + 2
                    tituloSelecao.Parent = selecaoFrame
                    
                    local cantoTitulo = Instance.new("UICorner")
                    cantoTitulo.CornerRadius = UDim.new(0, 8)
                    cantoTitulo.Parent = tituloSelecao
                    
                    local listaJogadores = Instance.new("ScrollingFrame")
                    listaJogadores.Name = "ListaJogadores"
                    listaJogadores.Size = UDim2.new(1, -20, 1, -50)
                    listaJogadores.Position = UDim2.new(0, 10, 0, 45)
                    listaJogadores.BackgroundTransparency = 1
                    listaJogadores.ScrollBarThickness = 6
                    listaJogadores.Parent = selecaoFrame
                    
                    local layoutLista = Instance.new("UIListLayout")
                    layoutLista.Padding = UDim.new(0, 5)
                    layoutLista.SortOrder = Enum.SortOrder.LayoutOrder
                    layoutLista.Parent = listaJogadores
                    
                    for i, nomeJogador in ipairs(jogadores) do
                        local jogadorButton = Instance.new("TextButton")
                        jogadorButton.Name = nomeJogador
                        jogadorButton.Size = UDim2.new(1, -10, 0, 40)
                        jogadorButton.BackgroundColor3 = corSecundaria
                        jogadorButton.Text = nomeJogador
                        jogadorButton.Font = fonteUI
                        jogadorButton.TextColor3 = corTexto
                        jogadorButton.TextSize = tamanhoTextoPadrao
                        jogadorButton.LayoutOrder = i
                        jogadorButton.Parent = listaJogadores
                        
                        local cantoJogador = Instance.new("UICorner")
                        cantoJogador.CornerRadius = UDim.new(0, 6)
                        cantoJogador.Parent = jogadorButton
                        
                        jogadorButton.MouseButton1Click:Connect(function()
                            local jogadorSelecionado = Players:FindFirstChild(nomeJogador)
                            if jogadorSelecionado then
                                seguirJogador(jogadorSelecionado)
                                selecaoGui:Destroy()
                            end
                        end)
                    end
                    
                    listaJogadores.CanvasSize = UDim2.new(0, 0, 0, layoutLista.AbsoluteContentSize.Y + 10)
                else
                    notificar("Seguir Jogador", "Nenhum outro jogador encontrado", 2)
                    toggleButton.Text = "OFF"
                    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                end
            else
                pararSeguir()
            end
        end)
    end
    
    -- Seção Combat
    local aimbotToggle = secaoCombat:FindFirstChild("AimbotToggleContainer")
    if aimbotToggle then
        local toggleButton = aimbotToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            toggleAimbot(toggleButton.Text == "ON")
        end)
    end
    
    local teamCheckToggle = secaoCombat:FindFirstChild("  ↳ Team CheckToggleContainer")
    if teamCheckToggle then
        local toggleButton = teamCheckToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            teamCheck = toggleButton.Text == "ON"
        end)
    end
    
    local wallCheckToggle = secaoCombat:FindFirstChild("  ↳ Wall CheckToggleContainer")
    if wallCheckToggle then
        local toggleButton = wallCheckToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            wallCheck = toggleButton.Text == "ON"
        end)
    end
    
    local blatantToggle = secaoCombat:FindFirstChild("  ↳ Blatant ModeToggleContainer")
    if blatantToggle then
        local toggleButton = blatantToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            blatantMode = toggleButton.Text == "ON"
        end)
    end
    
    local aimKillToggle = secaoCombat:FindFirstChild("Aim KillToggleContainer")
    if aimKillToggle then
        local toggleButton = aimKillToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            toggleAimKill(toggleButton.Text == "ON")
        end)
    end
    
    local orbitKillToggle = secaoCombat:FindFirstChild("Orbit KillToggleContainer")
    if orbitKillToggle then
        local toggleButton = orbitKillToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            toggleOrbitKill(toggleButton.Text == "ON")
        end)
    end
    
    local orbitSpeedSlider = secaoCombat:FindFirstChild("  ↳ Orbit SpeedSliderContainer")
    if orbitSpeedSlider then
        local sliderHandle = orbitSpeedSlider:FindFirstChild("SliderBackground"):FindFirstChild("SliderHandle")
        sliderHandle.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                orbitSpeed = tonumber(orbitSpeedSlider:FindFirstChild("Label").Text:match("%d+"))
            end
        end)
    end
    
    local orbitRadiusSlider = secaoCombat:FindFirstChild("  ↳ Orbit RadiusSliderContainer")
    if orbitRadiusSlider then
        local sliderHandle = orbitRadiusSlider:FindFirstChild("SliderBackground"):FindFirstChild("SliderHandle")
        sliderHandle.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                orbitRadius = tonumber(orbitRadiusSlider:FindFirstChild("Label").Text:match("%d+"))
            end
        end)
    end
    
    -- Seção Visuals
    local espToggle = secaoVisuals:FindFirstChild("ESPToggleContainer")
    if espToggle then
        local toggleButton = espToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            setESP(toggleButton.Text == "ON", espModo)
        end)
    end
    
    local espModeDropdown = secaoVisuals:FindFirstChild("  ↳ Modo ESPDropdownContainer")
    if espModeDropdown then
        local dropdownButton = espModeDropdown:FindFirstChild("DropdownButton")
        dropdownButton.MouseButton1Click:Connect(function()
            -- O modo é atualizado automaticamente pelo callback do dropdown
            espModo = dropdownButton.Text
            if espAtivo then
                setESP(true, espModo) -- Recriar ESP com novo modo
            end
        end)
    end
    
    -- Seção Misc
    local wallPhaseToggle = secaoMisc:FindFirstChild("Wall PhaseToggleContainer")
    if wallPhaseToggle then
        local toggleButton = wallPhaseToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            toggleWallPhase(toggleButton.Text == "ON")
        end)
    end
    
    local ghostModeToggle = secaoMisc:FindFirstChild("Ghost ModeToggleContainer")
    if ghostModeToggle then
        local toggleButton = ghostModeToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            toggleGhost(toggleButton.Text == "ON")
        end)
    end
    
    local flyToggle = secaoMisc:FindFirstChild("FlyToggleContainer")
    if flyToggle then
        local toggleButton = flyToggle:FindFirstChild("ToggleButton")
        toggleButton.MouseButton1Click:Connect(function()
            if toggleButton.Text == "ON" then
                configurarSistemaVoo()
            else
                if flyGui then
                    -- Animação de saída
                    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
                    local tweenSaida = TweenService:Create(flyGui.Frame, tweenInfo, {Position = UDim2.new(1.1, 0, 0.7, 0)})
                    tweenSaida:Play()
                    
                    tweenSaida.Completed:Connect(function()
                        flyGui.main:Destroy()
                        flyGui = nil
                    end)
                    
                    notificar("Asta Fly", "Sistema de voo desativado", 2)
                end
            end
        end)
    end
}

-- Inicialização
local function inicializar()
    print("Asta Hub Recriado: Inicializando...")
    
    -- Conectar controles da UI às funcionalidades
    conectarControlesUI()
    
    -- Conectar eventos para manter funcionalidades atualizadas
    Player.CharacterAdded:Connect(function(char)
        wait(1) -- Esperar o personagem carregar completamente
        
        -- Restaurar velocidade e pulo se estavam ativos
        if velocidadeAtivo then
            local Humanoid = char:WaitForChild("Humanoid")
            Humanoid.WalkSpeed = velocidadeValor
        end
        
        if puloAtivo then
            local Humanoid = char:WaitForChild("Humanoid")
            Humanoid.JumpPower = puloValor
        end
        
        -- Restaurar ESP se estava ativo
        if espAtivo then
            atualizarESP()
        end
    end)
    
    -- Animação de entrada do menu
    wait(0.5) -- Pequeno atraso para garantir que tudo foi carregado
    
    -- Animação de entrada do botão
    local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    local tweenEntrada = TweenService:Create(botaoAbrir, tweenInfo, {Position = UDim2.new(0, 15, 0.5, -25)})
    tweenEntrada:Play()
    
    -- Notificação de boas-vindas
    notificar("Asta Hub Recriado", "Carregado com sucesso! Clique no botão à esquerda para abrir o menu.", 5)
    
    print("Asta Hub Recriado: Inicialização concluída!")
}

-- Iniciar o script
inicializar()
