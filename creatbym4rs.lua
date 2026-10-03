
do
	if not game:IsLoaded() then
		pcall(function()
			game.Loaded:Wait();
		end);
	end
	function LPH_NO_VIRTUALIZE(f)
		return f;
	end
	function LPH_JIT_MAX(f)
		return f;
	end
	function LPH_JIT(f)
		return f;
	end
	function LPH_ENCFUNC(f)
		return f;
	end
	function eli_inext(t, i)
		i = i + 1;
		local v = t[i];
		if (v == nil) then
		else
			return i, v;
		end
	end
	function eli_ipairs(t)
		return eli_inext, t, 0;
	end
	function eli_pairs(t)
		return next, t, nil;
	end
	if not cloneref then
		function cloneref(ref)
			return ref;
		end
	end
	local Players = game:GetService("Players");
	local LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait();
	do
		if (hookfunction and newcclosure and getcallingscript) then
			pcall(function()
				local Old1 = nil;
				Old1 = hookfunction(setmetatable, newcclosure(function(Table, MetaTable)
					if ((type(MetaTable) == "table") and (rawget(MetaTable, "__mode") == "kv")) then
						local Caller = getcallingscript();
						if (Caller and (Caller.Name == "MiscellaneousController")) then
							return Old1(Table, {});
						end
					end
					return Old1(Table, MetaTable);
				end));
			end);
			pcall(function()
				local Ol2 = nil;
				Ol2 = hookfunction(rawlen, newcclosure(function(Table)
					if (type(Table) ~= "table") then
					else
						local Caller = getcallingscript();
						if (Caller and (Caller.Name == "MiscellaneousController")) then
							return 3;
						end
					end
					return Ol2(Table);
				end));
			end);
		end
	end
	print("[M4rs] Initializing security layer...");
	task.wait(6);
	pcall(function()
		if not (hookfunction and newcclosure and getrenv) then
			return;
		end
		local oldtable;
		oldtable = hookfunction(getrenv().setmetatable, newcclosure(function(Table, Metatable)
			if (Metatable and (typeof(Metatable) == "table") and (rawget(Metatable, "__mode") == "kv")) then
				local trace = debug.traceback();
				if trace:find("MiscellaneousController") then
					return oldtable({1,2,3}, {});
				end
			end
			return oldtable(Table, Metatable);
		end));
	end);
	coroutine.wrap(function()
		pcall(function()
			local acWords = {"anticheat","ac","detection","ban","kick","security","moderation"};
			local function disableScript(obj)
				obj.Disabled = true;
			end
			local function checkScript(obj)
				if (obj:IsA("LocalScript") or obj:IsA("ModuleScript")) then
					local n = string.lower(obj.Name);
					for _, ac in eli_ipairs(acWords) do
						if string.find(n, ac, 1, true) then
							pcall(disableScript, obj);
							break;
						end
					end
				end
			end
			local function blockScript(obj)
				pcall(checkScript, obj);
			end
			pcall(function()
				game.DescendantAdded:Connect(blockScript);
			end);
			pcall(function()
				local descendants = game:GetDescendants();
				for index = 1, #descendants do
					blockScript(descendants[index]);
					if ((index % 4000) == 0) then
						task.wait();
					end
				end
			end);
		end);
		pcall(function()
			local networkClient = game:GetService("NetworkClient");
			if networkClient then
				networkClient.ChildAdded:Connect(function(child)
					pcall(function()
						local ok, n = pcall(function()
							return child.Name:lower();
						end);
						if (ok and n) then
							if (n:find("anticheat") or n:find("detection")) then
								pcall(function()
									child:Destroy();
								end);
							end
						end
					end);
				end);
			end
		end);
	end)();
	pcall(function()
		local fake = Instance.new("RemoteEvent");
		fake.Name = "ClientAlert";
		fake.Parent = LocalPlayer;
	end);
	task.spawn(function()
		pcall(function()
			if (type(getgc) ~= "function") then
				return;
			end
			local rf = game:GetService("ReplicatedFirst");
			local ls3 = rf:WaitForChild("LocalScript3", 10);
			local gc = getgc(false);
			for index = 1, #gc do
				local f = gc[index];
				if ((type(f) == "function") and ((type(islclosure) ~= "function") or islclosure(f))) then
					local ok, e = pcall(getfenv, f);
					if (ok and (type(e) == "table")) then
						local ok2, scr = pcall(function()
							return rawget(e, "script");
						end);
						if (ok2 and scr and (typeof(scr) == "Instance")) then
							local ok3, scrStr = pcall(tostring, scr);
							if (ok3 and ((scr == ls3) or ((type(scrStr) == "string") and scrStr:find("LoadingScreen")))) then
								local ok4, cs = pcall(debug.getconstants, f);
								if (ok4 and (type(cs) == "table")) then
									for _, k in eli_ipairs(cs) do
										if ((type(k) == "string") and (k:find("TakeTheL") or k:find("ban") or k:find("kick"))) then
											pcall(function()
												hookfunction(f, function()
												end);
											end);
											break;
										end
									end
								end
							end
						end
					end
				end
				if ((index % 1500) ~= 0) then
				else
					task.wait();
				end
			end
		end);
	end);
	local antidetect = true;
	local detecteds = {localscript3=true,miscellaneouscontroller=true};
	local callerVerdicts = setmetatable({}, {__mode="k"});
	local originalIndex;
	pcall(function()
		if not (hookmetamethod and newcclosure and getcallingscript) then
			return;
		end
		originalIndex = hookmetamethod(game, "__index", newcclosure(function(self, key)
			if (antidetect and ((key == "Name") or (key == "Text"))) then
				local caller = getcallingscript();
				if caller then
					local blocked = callerVerdicts[caller];
					if (blocked ~= nil) then
					else
						local ok, result = pcall(function()
							return detecteds[string.lower(originalIndex(caller, "Name"))] == true;
						end);
						blocked = (ok and result) or false;
						callerVerdicts[caller] = blocked;
					end
					if blocked then
						return "";
					end
				end
			end
			return originalIndex(self, key);
		end));
	end);
	pcall(function()
		local hookmetamethod = hookmetamethod;
		local getrawmetatable = getrawmetatable;
		local setreadonly = setreadonly;
		local checkcaller = checkcaller;
		local getnamecallmethod = getnamecallmethod;
		if (hookmetamethod and getrawmetatable and setreadonly) then
			local mt = getrawmetatable(game);
			setreadonly(mt, false);
			local oldNamecall;
			oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
				local method = getnamecallmethod and getnamecallmethod();
				if ((method == "Kick") and (self == LocalPlayer)) then
					return;
				end
				if ((method == "FireServer") or (method == "InvokeServer")) then
					local name = tostring(self.Name):lower();
					if (name:find("exploit") or name:find("cheat") or name:find("detect") or name:find("ban") or name:find("flag") or name:find("validate") or name:find("integrity") or name:find("security") or name:find("anticheat") or name:find("ac_")) then
						return;
					end
				end
				if ((method == "FireServer") and (self.Name == "UseItem")) then
					local redirect = rawget(_G, "__M4rsSilentAimRedirect");
					if redirect then
						local args = {...};
						local redirected = redirect(self, args[1], args[2], args[3]);
						if redirected then
							args[3] = redirected;
							return oldNamecall(self, unpack(args));
						end
					end
				end
				return oldNamecall(self, ...);
			end);
			local oldIndexHook;
			oldIndexHook = hookmetamethod(game, "__index", function(self, key)
				if (checkcaller and checkcaller() and (key == "Kick") and (self == LocalPlayer)) then
					return function()
					end;
				end
				return oldIndexHook(self, key);
			end);
			setreadonly(mt, true);
		end
	end);
	pcall(function()
		local pgui = LocalPlayer:WaitForChild("PlayerGui", 20);
		if pgui then
			local startWait = tick();
			while (tick() - startWait) < 8 do
				if pgui:FindFirstChild("LoadingScreen") then
					break;
				end
				task.wait(0.2);
			end
			if pgui:FindFirstChild("LoadingScreen") then
				repeat
					task.wait(0.3);
				until not pgui:FindFirstChild("LoadingScreen") 
			end
		end
	end);
	task.wait(1);
	local Library, ThemeManager, SaveManager, DismissLoader;
	do
		local CoreGui = game:GetService("CoreGui");
		local hudParent = CoreGui;
		pcall(function()
			if gethui then
				hudParent = gethui();
			elseif (syn and syn.protect_gui) then
				local sg = Instance.new("ScreenGui");
				syn.protect_gui(sg);
				hudParent = CoreGui;
			end
		end);
		if (not hudParent or not pcall(function()
			return hudParent.Name;
		end)) then
			hudParent = game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui");
		end
		local loaderGui, statusLabel;
		if hudParent then
			pcall(function()
				local old = hudParent:FindFirstChild("M4rsStartupLoader");
				if old then
					old:Destroy();
				end
				loaderGui = Instance.new("ScreenGui");
				loaderGui.Name = "M4rsStartupLoader";
				loaderGui.ResetOnSpawn = false;
				local card = Instance.new("Frame");
				card.Name = "LoadingCard";
				card.Size = UDim2.new(0, 260, 0, 72);
				card.Position = UDim2.new(0.5, -130, 0.45, 0);
				card.BackgroundColor3 = Color3.fromRGB(10, 10, 12);
				card.BorderSizePixel = 0;
				card.Parent = loaderGui;
				local corner = Instance.new("UICorner");
				corner.CornerRadius = UDim.new(0, 8);
				corner.Parent = card;
				local stroke = Instance.new("UIStroke");
				stroke.Color = Color3.fromRGB(255, 255, 255);
				stroke.Thickness = 1.2;
				stroke.Transparency = 0.25;
				stroke.Parent = card;
				local title = Instance.new("TextLabel");
				title.Size = UDim2.new(1, -20, 0, 24);
				title.Position = UDim2.new(0, 10, 0, 8);
				title.BackgroundTransparency = 1;
				title.Font = Enum.Font.GothamBold;
				title.Text = "M4rs.win | Rivals";
				title.TextColor3 = Color3.fromRGB(255, 255, 255);
				title.TextSize = 14;
				title.TextXAlignment = Enum.TextXAlignment.Center;
				title.Parent = card;
				statusLabel = Instance.new("TextLabel");
				statusLabel.Size = UDim2.new(1, -20, 0, 20);
				statusLabel.Position = UDim2.new(0, 10, 0, 36);
				statusLabel.BackgroundTransparency = 1;
				statusLabel.Font = Enum.Font.Code;
				statusLabel.Text = "Downloading library...";
				statusLabel.TextColor3 = Color3.fromRGB(180, 180, 180);
				statusLabel.TextSize = 12;
				statusLabel.TextXAlignment = Enum.TextXAlignment.Center;
				statusLabel.Parent = card;
				loaderGui.Parent = hudParent;
			end);
		end
		local function updateStatus(txt)
			pcall(function()
				if (statusLabel and statusLabel.Parent) then
					statusLabel.Text = tostring(txt);
				end
			end);
		end
		function DismissLoader()
			pcall(function()
				if (loaderGui and loaderGui.Parent) then
					loaderGui:Destroy();
				end
			end);
		end
		local obsidianRepo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/";
		local obsidianFallback = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/";
		local function loadLibFile(filename, subpath)
			updateStatus("Loading " .. filename .. "...");
			local cachePath = "m4rs/obsidian/" .. filename;
			if (isfile and isfile(cachePath)) then
				local ok, str = pcall(readfile, cachePath);
				if (ok and str and (#str > 500)) then
					local fn = loadstring(str);
					if fn then
						return fn();
					end
				end
			end
			local content;
			local ok1, res1 = pcall(function()
				return game:HttpGet(obsidianRepo .. subpath, true);
			end);
			if (ok1 and res1 and (#res1 > 500)) then
				content = res1;
			else
				local ok2, res2 = pcall(function()
					return game:HttpGet(obsidianFallback .. subpath, true);
				end);
				if (ok2 and res2 and (#res2 > 500)) then
					content = res2;
				end
			end
			if not content then
				error("[M4rs] Failed to fetch library file: " .. filename);
			end
			if writefile then
				pcall(function()
					if (makefolder and not isfolder("m4rs")) then
						makefolder("m4rs");
					end
					if (makefolder and not isfolder("m4rs/obsidian")) then
						makefolder("m4rs/obsidian");
					end
					writefile(cachePath, content);
				end);
			end
			local fn = loadstring(content);
			if not fn then
				error("[M4rs] Failed to compile: " .. filename);
			end
			return fn();
		end
		Library = loadLibFile("Library.lua", "Library.lua");
		ThemeManager = loadLibFile("ThemeManager.lua", "addons/ThemeManager.lua");
		SaveManager = loadLibFile("SaveManager.lua", "addons/SaveManager.lua");
		if not Library.SetWatermark then
			Library.SetWatermark = function(self, text)
			end;
			Library.SetWatermarkVisibility = function(self, vis)
			end;
		end
		local rawNotify = Library.Notify;
		Library.Notify = function(self, content, time)
			if (type(content) == "string") then
				return rawNotify(self, {Title="M4rs.win",Description=content,Time=(time or 5)});
			elseif (type(content) ~= "table") then
			else
				return rawNotify(self, content);
			end
		end;
		local Toggles = Library.Toggles;
		local Options = Library.Options;
		getgenv().Toggles = Toggles;
		getgenv().Options = Options;
		getgenv().Library = Library;
		_G.Library = Library;
		updateStatus("Building user interface...");
	end
	local Players = game:GetService("Players");
	local RunService = game:GetService("RunService");
	local UserInputService = game:GetService("UserInputService");
	local TweenService = game:GetService("TweenService");
	local Lighting = game:GetService("Lighting");
	local TeleportService = game:GetService("TeleportService");
	local HttpService = game:GetService("HttpService");
	local SoundService = game:GetService("SoundService");
	local ReplicatedStorage = game:GetService("ReplicatedStorage");
	local LocalPlayer = Players.LocalPlayer;
	Library.BackgroundColor = Color3.fromRGB(0, 0, 0);
	Library.MainColor = Color3.fromRGB(12, 12, 12);
	Library.AccentColor = Color3.fromRGB(255, 255, 255);
	Library.OutlineColor = Color3.fromRGB(255, 255, 255);
	Library.FontColor = Color3.fromRGB(255, 255, 255);
	local Window = Library:CreateWindow({Title="M4rs.win | Rivals",Center=true,AutoShow=true,NotifySide="Right",TabPadding=8,MenuFadeTime=0.2});
	local Tabs = {Combat=Window:AddTab("Combat", "swords"),Character=Window:AddTab("Character", "user"),Visuals=Window:AddTab("Visuals", "eye"),World=Window:AddTab("World", "globe"),Misc=Window:AddTab("Misc", "sliders"),["UI Settings"]=Window:AddTab("UI Settings", "settings")};
	local HPlist = {"Head","HumanoidRootPart","Torso","UpperTorso","LowerTorso","Left Arm","LeftHand","LeftLowerArm","LeftUpperArm","Right Arm","RightHand","RightLowerArm","RightUpperArm","Left Leg","LeftFoot","LeftLowerLeg","LeftUpperLeg","Right Leg","RightFoot","RightLowerLeg","RightUpperLeg","Neck","Back","Front","Closest","Random"};
	local mats = {"ForceField","Neon","SmoothPlastic","Glass","Ice","Plastic","Wood","Marble","Granite","Brick","Cobblestone","Concrete","Slate","Foil"};
	local animPresets = {Meditate="96579993895076",Orbit="133811691098518",["Orbit V2"]="73208745607037",["Orbit V3"]="137869087140582",Floss="72174079036035",OJ="110064349530772",["Kicking Feet"]="131879764029003",Tweaking="114353590132838",Crazy="120819498172771",["Crazy V2"]="105670906411750",["Take the L"]="112884830175040",Hype="80055417516516",["Small / Hide"]="91194251426204",["Sea Lion"]="117932365044349",Gangnam="104142334418357",NLE="125783279336153",["The Man"]="88737074755910",["Spider Shit"]="74716792202343",["Low Cortisol"]="125822752810863",Rampage="120605439830304"};
	local animPresetNames = {"Meditate","Orbit","Orbit V2","Orbit V3","Floss","OJ","Kicking Feet","Tweaking","Crazy","Crazy V2","Take the L","Hype","Small / Hide","Sea Lion","Gangnam","NLE","The Man","Spider Shit","Low Cortisol","Rampage"};
	local weaponList = {"Assault Rifle","Sniper","Bow","Burst Rifle","Crossbow","Gunblade","RPG","Shotgun","Energy Rifle","Flamethrower","Grenade Launcher","Minigun","Paintball Gun","Distortion","Permafrost","Handgun","Daggers","Flare Gun","Revolver","Shorty","Spray","Uzi","Energy Pistols","Exogun","Slingshot","Warper","Fists","Battle Axe","Chainsaw","Katana","Knife","Riot Shield","Scythe","Maul","Trowel","Grenade","Flashbang","Freeze Ray","Jump Pad","Molotov","Satchel","Smoke Grenade","War Horn","Medkit","Subspace Tripmine","Warpstone","Hook","Spear"};
	local Misc = {};
	local Hub = {};
	local hitSoundAssets = {["Rust HS"]="rbxassetid://5043539486",Neverlose="rbxassetid://97643101798871",["Minecraft Bow"]="rbxassetid://3442683707",["Minecraft Hit"]="rbxassetid://8766809464",CSGO="rbxassetid://5764885315",Bubble="rbxassetid://6534947588",Lazer="rbxassetid://130791043",Pick="rbxassetid://1347140027",Pop="rbxassetid://198598793",Rust="rbxassetid://1255040462",Sans="rbxassetid://3188795283",Fart="rbxassetid://130833677",Big="rbxassetid://5332005053",Vine="rbxassetid://5332680810",UwU="rbxassetid://8679659744",Bruh="rbxassetid://4578740568",Skeet="rbxassetid://5633695679",Fatality="rbxassetid://6534947869",Bonk="rbxassetid://5766898159",Minecraft="rbxassetid://5869422451",Gamesense="rbxassetid://4817809188",RIFK7="rbxassetid://9102080552",Bamboo="rbxassetid://3769434519",Crowbar="rbxassetid://546410481",Weeb="rbxassetid://6442965016",Beep="rbxassetid://8177256015",Bambi="rbxassetid://8437203821",Stone="rbxassetid://3581383408",["Old Fatality"]="rbxassetid://6607142036",Click="rbxassetid://8053704437",Ding="rbxassetid://7149516994",Snow="rbxassetid://6455527632",Laser="rbxassetid://7837461331",Mario="rbxassetid://2815207981",Steve="rbxassetid://4965083997",["Call of Duty"]="rbxassetid://5952120301",Bat="rbxassetid://3333907347",["TF2 Critical"]="rbxassetid://296102734",Saber="rbxassetid://8415678813",Baimware="rbxassetid://3124331820",Osu="rbxassetid://7149255551",TF2="rbxassetid://2868331684",Slime="rbxassetid://6916371803",["Among Us"]="rbxassetid://5700183626",One="rbxassetid://7380502345",["Soft Bell"]="rbxassetid://9114487369",["Minecraft Bow Hit"]="rbxassetid://1053296915"};
	local hitSoundList = {};
	for name, _ in pairs(hitSoundAssets) do
		table.insert(hitSoundList, name);
	end
	table.sort(hitSoundList);
	local Skyboxes = {Default={SkyboxBk="rbxassetid://91458024",SkyboxDn="rbxassetid://91457980",SkyboxFt="rbxassetid://91458024",SkyboxLf="rbxassetid://91458024",SkyboxRt="rbxassetid://91458024",SkyboxUp="rbxassetid://91458002"},Neptune={SkyboxBk="rbxassetid://218955819",SkyboxDn="rbxassetid://218953419",SkyboxFt="rbxassetid://218954524",SkyboxLf="rbxassetid://218958493",SkyboxRt="rbxassetid://218957134",SkyboxUp="rbxassetid://218950090"},["Among Us"]={SkyboxBk="rbxassetid://5752463190",SkyboxDn="rbxassetid://5752463190",SkyboxFt="rbxassetid://5752463190",SkyboxLf="rbxassetid://5752463190",SkyboxRt="rbxassetid://5752463190",SkyboxUp="rbxassetid://5752463190"},Nebula={SkyboxBk="rbxassetid://159454299",SkyboxDn="rbxassetid://159454296",SkyboxFt="rbxassetid://159454293",SkyboxLf="rbxassetid://159454286",SkyboxRt="rbxassetid://159454300",SkyboxUp="rbxassetid://159454288"},Vaporwave={SkyboxBk="rbxassetid://1417494030",SkyboxDn="rbxassetid://1417494146",SkyboxFt="rbxassetid://1417494253",SkyboxLf="rbxassetid://1417494402",SkyboxRt="rbxassetid://1417494499",SkyboxUp="rbxassetid://1417494643"},Clouds={SkyboxBk="rbxassetid://570557514",SkyboxDn="rbxassetid://570557775",SkyboxFt="rbxassetid://570557559",SkyboxLf="rbxassetid://570557620",SkyboxRt="rbxassetid://570557672",SkyboxUp="rbxassetid://570557727"},Twilight={SkyboxBk="rbxassetid://264908339",SkyboxDn="rbxassetid://264907909",SkyboxFt="rbxassetid://264909420",SkyboxLf="rbxassetid://264909758",SkyboxRt="rbxassetid://264908886",SkyboxUp="rbxassetid://264907379"},DaBaby={SkyboxBk="rbxassetid://7245418472",SkyboxDn="rbxassetid://7245418472",SkyboxFt="rbxassetid://7245418472",SkyboxLf="rbxassetid://7245418472",SkyboxRt="rbxassetid://7245418472",SkyboxUp="rbxassetid://7245418472"},Minecraft={SkyboxBk="rbxassetid://1876545003",SkyboxDn="rbxassetid://1876544331",SkyboxFt="rbxassetid://1876542941",SkyboxLf="rbxassetid://1876543392",SkyboxRt="rbxassetid://1876543764",SkyboxUp="rbxassetid://1876544642"},Chill={SkyboxBk="rbxassetid://5084575798",SkyboxDn="rbxassetid://5084575916",SkyboxFt="rbxassetid://5103949679",SkyboxLf="rbxassetid://5103948542",SkyboxRt="rbxassetid://5103948784",SkyboxUp="rbxassetid://5084576400"},Redshift={SkyboxBk="rbxassetid://401664839",SkyboxDn="rbxassetid://401664862",SkyboxFt="rbxassetid://401664960",SkyboxLf="rbxassetid://401664881",SkyboxRt="rbxassetid://401664901",SkyboxUp="rbxassetid://401664936"},["Blue Stars"]={SkyboxBk="rbxassetid://149397684",SkyboxDn="rbxassetid://149397686",SkyboxFt="rbxassetid://149397688",SkyboxLf="rbxassetid://149397692",SkyboxRt="rbxassetid://149397697",SkyboxUp="rbxassetid://149397702"},["Blue Aurora"]={SkyboxBk="rbxassetid://12063984",SkyboxDn="rbxassetid://12064107",SkyboxFt="rbxassetid://12064152",SkyboxLf="rbxassetid://12064121",SkyboxRt="rbxassetid://12064115",SkyboxUp="rbxassetid://12064131"},Realistic={SkyboxBk="rbxassetid://144933338",SkyboxDn="rbxassetid://144931530",SkyboxFt="rbxassetid://144933262",SkyboxLf="rbxassetid://144933244",SkyboxRt="rbxassetid://144933299",SkyboxUp="rbxassetid://144931564"},StarsShader={SkyboxBk="rbxassetid://169210090",SkyboxDn="rbxassetid://169210108",SkyboxFt="rbxassetid://169210121",SkyboxLf="rbxassetid://169210133",SkyboxRt="rbxassetid://169210143",SkyboxUp="rbxassetid://169210149"},Gloomy={SkyboxBk="rbxassetid://5346760450",SkyboxDn="rbxassetid://5346760689",SkyboxFt="rbxassetid://5346760919",SkyboxLf="rbxassetid://5346761102",SkyboxRt="rbxassetid://5346761335",SkyboxUp="rbxassetid://5346761509"},["Nebula Purple"]={SkyboxBk="rbxassetid://129876530632297",SkyboxDn="rbxassetid://108406529909981",SkyboxFt="rbxassetid://104400530594543",SkyboxLf="rbxassetid://73372229972523",SkyboxRt="rbxassetid://87408857415924",SkyboxUp="rbxassetid://13781740568136"},Jungle={SkyboxBk="rbxassetid://214399891",SkyboxDn="rbxassetid://214399887",SkyboxFt="rbxassetid://214399894",SkyboxLf="rbxassetid://214405668",SkyboxRt="rbxassetid://214399899",SkyboxUp="rbxassetid://214399889"},Spongebob={SkyboxBk="rbxassetid://15962101128",SkyboxDn="rbxassetid://15970246218",SkyboxFt="rbxassetid://15962101128",SkyboxLf="rbxassetid://15962101128",SkyboxRt="rbxassetid://15962101128",SkyboxUp="rbxassetid://15962901054"},["mountain scape"]={SkyboxBk="rbxassetid://12474836637",SkyboxDn="rbxassetid://12474837052",SkyboxFt="rbxassetid://12474836748",SkyboxLf="rbxassetid://12474836935",SkyboxRt="rbxassetid://12474836446",SkyboxUp="rbxassetid://12474835757"},["yellowy cloud"]={SkyboxBk="rbxassetid://252760981",SkyboxDn="rbxassetid://252763035",SkyboxFt="rbxassetid://252761439",SkyboxLf="rbxassetid://252760980",SkyboxRt="rbxassetid://252760986",SkyboxUp="rbxassetid://252762652"},Aurora={SkyboxBk="rbxassetid://340908398",SkyboxDn="rbxassetid://340908450",SkyboxFt="rbxassetid://340908468",SkyboxLf="rbxassetid://340908504",SkyboxRt="rbxassetid://340908530",SkyboxUp="rbxassetid://340908586"},["winter mountain"]={SkyboxBk="rbxassetid://402229526",SkyboxDn="rbxassetid://402229596",SkyboxFt="rbxassetid://402229293",SkyboxLf="rbxassetid://402229368",SkyboxRt="rbxassetid://402229417",SkyboxUp="rbxassetid://402229564"},stormy={SkyboxBk="rbxassetid://255027929",SkyboxDn="rbxassetid://255027967",SkyboxFt="rbxassetid://255027923",SkyboxLf="rbxassetid://255027938",SkyboxRt="rbxassetid://255027946",SkyboxUp="rbxassetid://255027960"}};
	local skyboxList = {};
	for name, _ in pairs(Skyboxes) do
		table.insert(skyboxList, name);
	end
	table.sort(skyboxList);
	local ambientSounds = {None=nil,Rain=132717551555191,Night=125710682931536,["Birds Chirping"]=9112831327,["Jungle Birds"]=9114892930,["Campfire Crackling"]=109494611784143,["Night Crickets"]=9112764040,["Snow Storm"]=551546110};
	local function PlayUiSound(soundId, customVol)
	end
	getgenv().Config = {Enabled=true,SilentAim=false,Desync=true,FireRate=0.0005,MaxDistance=500,HitPart="Head",TeamCheck=true,KnifeDesyncOffset=Vector3.new(0, 6, 0),NormalDesyncOffset=Vector3.new(0, 1, 2),RandomSpread=0.1,Rage=false,RageTeleport=true,RageTeleportDistance=200,RageTeleportJitter=10};
	local preRage = {};
	local function applyRage(on)
		getgenv().Config.Rage = on;
		if on then
			preRage = {FireRate=0.0005,RandomSpread=0.1,TeamCheck=((Toggles.TeamCheck and Toggles.TeamCheck.Value) ~= false),MaxDistance=500,HitPart=((Options.HitPartDropdown and Options.HitPartDropdown.Value) or "Head"),SilentAim=((Toggles.SilentAim and Toggles.SilentAim.Value) or false),Desync=((Toggles.Desync and Toggles.Desync.Value) ~= false)};
			pcall(function()
				if Toggles.SilentAim then
					Toggles.SilentAim:SetValue(true);
				end
				if Toggles.Desync then
					Toggles.Desync:SetValue(true);
				end
				if Toggles.TeamCheck then
					Toggles.TeamCheck:SetValue(true);
				end
				if Options.HitPartDropdown then
					Options.HitPartDropdown:SetValue("Head");
				end
			end);
			getgenv().Config.Enabled = true;
			getgenv().Config.SilentAim = true;
			getgenv().Config.Desync = true;
			getgenv().Config.TeamCheck = true;
			getgenv().Config.FireRate = 0.0001;
			getgenv().Config.RandomSpread = 0;
			getgenv().Config.MaxDistance = (Options.RageTeleportDistance and Options.RageTeleportDistance.Value) or 200;
			getgenv().Config.HitPart = "Head";
			Library:Notify("Rage ON (Teleport)", 2);
		else
			pcall(function()
				if Toggles.SilentAim then
					Toggles.SilentAim:SetValue(preRage.SilentAim or false);
				end
				if Toggles.Desync then
					Toggles.Desync:SetValue(preRage.Desync ~= false);
				end
				if Toggles.TeamCheck then
					Toggles.TeamCheck:SetValue(preRage.TeamCheck ~= false);
				end
				if Options.HitPartDropdown then
					Options.HitPartDropdown:SetValue(preRage.HitPart or "Head");
				end
			end);
			getgenv().Config.Enabled = false;
			getgenv().Config.SilentAim = preRage.SilentAim or false;
			getgenv().Config.Desync = preRage.Desync ~= false;
			getgenv().Config.TeamCheck = preRage.TeamCheck ~= false;
			getgenv().Config.FireRate = preRage.FireRate or 0.0005;
			getgenv().Config.RandomSpread = preRage.RandomSpread or 0.1;
			getgenv().Config.MaxDistance = preRage.MaxDistance or 500;
			getgenv().Config.HitPart = preRage.HitPart or "Head";
			if rawget(_G, "__M4rsStopVoidCsync") then
				_G.__M4rsStopVoidCsync();
			end
			Library:Notify("Rage OFF", 2);
		end
	end
	do
		local SilentAimBox = Tabs.Combat:AddLeftTabbox();
		local silenttab = SilentAimBox:AddTab("silent");
		local silentcustomization = SilentAimBox:AddTab("custom");
		local triggerTab = SilentAimBox:AddTab("triggerbot");
		silenttab:AddToggle("SilentAim", {Text="enable",Default=false,Callback=function(v)
			PlayUiSound(6895079853);
			if getgenv().Config then
				getgenv().Config.SilentAim = v;
			end
		end}):AddKeyPicker("SilentAimKey", {Text="Silent Aim",Default="None",Mode="Toggle"});
		silenttab:AddToggle("Desync", {Text="desync",Default=true,Tooltip="Desync player position relative to target",Callback=function(v)
			if getgenv().Config then
				getgenv().Config.Desync = v;
			end
		end});
		silenttab:AddToggle("TeamCheck", {Text="team check",Default=true,Callback=function(v)
			if getgenv().Config then
				getgenv().Config.TeamCheck = v;
			end
		end});
		silenttab:AddToggle("SilentWallCheck", {Text="wall check",Default=true,Tooltip="Obstacle check to prevent shooting through walls"});
		silenttab:AddSlider("HitChance", {Text="hit chance",Default=100,Min=0,Max=100,Rounding=0,Compact=true,Callback=function(v)
		end});
		silenttab:AddDropdown("HitPartDropdown", {Text="hit part",Default=1,Values=HPlist,Callback=function(v)
			if getgenv().Config then
				getgenv().Config.HitPart = v;
			end
		end});
		silenttab:AddDropdown("TargetPriority", {Text="target priority",Default=1,Values={"Closest (Distance)","Lowest HP","Closest (FOV)"},Tooltip="Target priority: Distance, Lowest HP, or FOV"});
		silenttab:AddSlider("HeadshotChance", {Text="headshot chance",Default=100,Min=0,Max=100,Rounding=0,Compact=true,Suffix="%"});
		silenttab:AddToggle("Manipulation", {Text="manipulation (wall shoot)",Default=false,Tooltip="Scan vertical offsets to shoot around barriers"});
		silentcustomization:AddToggle("ShowFOV", {Text="show fov",Default=false,Callback=function(v)
		end}):AddColorPicker("FOVOutlineColor1", {Default=Color3.fromRGB(255, 255, 255),Title="outline color 1"}):AddColorPicker("FOVOutlineColor2", {Default=Color3.fromRGB(255, 255, 255),Title="outline color 2"});
		silentcustomization:AddToggle("SilentFOVFilled", {Text="fov fill",Default=false,Callback=function(v)
		end}):AddColorPicker("SilentFOVFillColor1", {Default=Color3.fromRGB(255, 255, 255),Title="fill color 1"}):AddColorPicker("SilentFOVFillColor2", {Default=Color3.fromRGB(0, 0, 0),Title="fill color 2"});
		silentcustomization:AddToggle("SilentFOVFillAnimated", {Text="animated fill",Default=false,Callback=function(v)
		end});
		silentcustomization:AddSlider("FOVRadius", {Text="fov radius",Default=100,Min=10,Max=750,Rounding=1,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVOutlineThickness", {Text="outline thickness",Default=1.5,Min=0.5,Max=5,Rounding=1,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVOutlineTransparency", {Text="outline transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVOutlineRotation", {Text="outline rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVFillTransparency", {Text="fill transparency",Default=0.7,Min=0,Max=1,Rounding=2,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVFillRotation", {Text="fill rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVFillSpeed", {Text="fill speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddToggle("SilentFOVSpin", {Text="fov spin",Default=false,Callback=function(v)
		end});
		silentcustomization:AddSlider("SilentFOVSpinSpd", {Text="spin speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true,Callback=function(v)
		end});
		silentcustomization:AddToggle("SilentFOVFollowMuzzle", {Text="follow muzzle",Default=false,Callback=function(v)
		end});
		triggerTab:AddToggle("TriggerbotEnabled", {Text="enable triggerbot",Default=false,Tooltip="Fires instantly when crosshair hovers over enemy",Callback=function(v)
			PlayUiSound(6895079853);
		end}):AddKeyPicker("TriggerbotKey", {Text="Triggerbot Key",Default="None",Mode="Hold"});
		triggerTab:AddToggle("TriggerHeadOnly", {Text="headshot only",Default=false,Tooltip="Only triggers when aiming at the head"});
		triggerTab:AddSlider("TriggerDelay", {Text="fire delay (ms)",Default=0,Min=0,Max=250,Rounding=0,Compact=true,Suffix="ms"});
		triggerTab:AddToggle("TargetHUDToggle", {Text="target card hud",Default=true,Tooltip="Displays target info & health card when locked on"});
		local AimbotBox = Tabs.Combat:AddLeftTabbox();
		local aimbotTab = AimbotBox:AddTab("aimbot");
		local aimbotCustomTab = AimbotBox:AddTab("custom");
		aimbotTab:AddToggle("AimbotToggle", {Text="enable",Default=false,Callback=function(v)
			PlayUiSound(6895079853);
		end}):AddKeyPicker("AimbotKey", {Text="Aimbot",Default="None",Mode="Toggle"});
		aimbotTab:AddSlider("AimbotSmoothness", {Text="smoothness",Default=100,Min=1,Max=100,Rounding=0,Suffix="%",Compact=true,Tooltip="100% is maximum strength (instant mouse lock)",Callback=function(v)
		end});
		aimbotTab:AddDropdown("AimbotCurve", {Text="aim curve",Default=1,Values={"Linear","Expo","EaseIn","EaseOut","EaseInOut","Cubic","Instant"},Callback=function(v)
		end});
		aimbotTab:AddDropdown("AimbotHitPart", {Text="hit part",Default=1,Values={"Head","HumanoidRootPart","Torso","UpperTorso","LowerTorso"},Callback=function(v)
		end});
		aimbotTab:AddToggle("AimbotWallCheck", {Text="wall check",Default=true,Tooltip="Enables wall check to prevent aiming through walls"});
		aimbotCustomTab:AddToggle("ShowAimbotFOV", {Text="show fov",Default=false,Callback=function(v)
		end}):AddColorPicker("AimbotFOVOutlineColor1", {Default=Color3.fromRGB(255, 255, 255),Title="outline color 1"}):AddColorPicker("AimbotFOVOutlineColor2", {Default=Color3.fromRGB(255, 255, 255),Title="outline color 2"});
		aimbotCustomTab:AddToggle("AimbotFOVFilled", {Text="fov fill",Default=false,Callback=function(v)
		end}):AddColorPicker("AimbotFOVFillColor1", {Default=Color3.fromRGB(255, 255, 255),Title="fill color 1"}):AddColorPicker("AimbotFOVFillColor2", {Default=Color3.fromRGB(0, 0, 0),Title="fill color 2"});
		aimbotCustomTab:AddToggle("AimbotFOVFillAnimated", {Text="animated fill",Default=false,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOV", {Text="fov radius",Default=500,Min=10,Max=1000,Rounding=0,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVOutlineThickness", {Text="outline thickness",Default=1.5,Min=0.5,Max=5,Rounding=1,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVOutlineTransparency", {Text="outline transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVOutlineRotation", {Text="outline rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVFillTransparency", {Text="fill transparency",Default=0.7,Min=0,Max=1,Rounding=2,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVFillRotation", {Text="fill rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVFillSpeed", {Text="fill speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddToggle("AimbotFOVSpin", {Text="fov spin",Default=false,Callback=function(v)
		end});
		aimbotCustomTab:AddSlider("AimbotFOVSpinSpd", {Text="spin speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true,Callback=function(v)
		end});
		aimbotCustomTab:AddToggle("AimbotFOVFollowMuzzle", {Text="follow muzzle",Default=false,Callback=function(v)
		end});
		local GunGroup = Tabs.Combat:AddLeftGroupbox("gun");
		GunGroup:AddToggle("NoCooldown", {Text="rapid fire",Default=false,Callback=function(v)
		end});
		GunGroup:AddToggle("NoSpread", {Text="no spread",Default=false,Callback=function(v)
		end});
		GunGroup:AddToggle("NoRecoil", {Text="no recoil",Default=false,Callback=function(v)
		end});
		GunGroup:AddToggle("MaxAccuracy", {Text="max accuracy",Default=false,Callback=function(v)
		end});
		GunGroup:AddToggle("RapidAttack", {Text="rapid attack",Default=false,Callback=function(v)
		end});
		GunGroup:AddToggle("NoMuzzleFlash", {Text="no muzzle flash",Default=false,Callback=function(v)
		end});
		local RageGroup = Tabs.Combat:AddRightGroupbox("ragebot");
		RageGroup:AddToggle("TargetOn", {Text="rage mode",Default=false,Tooltip="Max fire rate, no spread, 200 studs range, head only, 瞬移到目標腳下射擊",Callback=function(v)
			PlayUiSound(6895079853);
			applyRage(v);
		end}):AddKeyPicker("TargetKey", {Text="Ragebot",Default="None",Mode="Toggle"});
		RageGroup:AddToggle("RageTeleport", {Text="teleport to feet",Default=true,Tooltip="Rage 開啟時，瞬移到目標腳下附近射擊",Callback=function(v)
			if getgenv().Config then
				getgenv().Config.RageTeleport = v;
			end
		end});
		RageGroup:AddToggle("VoidSpam", {Text="void spam",Default=false,Tooltip="Desync player into void coordinates on server while client stays normal",Callback=function(v)
			if getgenv().Config then
				getgenv().Config.VoidSpam = v;
			end
			if not v and rawget(_G, "__M4rsStopVoidCsync") then
				_G.__M4rsStopVoidCsync();
			end
		end});
		RageGroup:AddSlider("RageTeleportDistance", {Text="detect distance",Default=200,Min=20,Max=2000,Rounding=0,Suffix=" studs",Tooltip="目標在這個範圍內才會被鎖定/瞬移攻擊",Callback=function(v)
			if getgenv().Config then
				getgenv().Config.RageTeleportDistance = v;
				if getgenv().Config.Rage then
					getgenv().Config.MaxDistance = v;
				end
			end
		end});
		RageGroup:AddSlider("RageTeleportJitter", {Text="teleport jitter",Default=10,Min=0,Max=50,Rounding=1,Suffix=" studs",Tooltip="每次瞬移到腳下時的隨機偏移範圍",Callback=function(v)
			if getgenv().Config then
				getgenv().Config.RageTeleportJitter = v;
			end
		end});
		RageGroup:AddSlider("ShootAttempts", {Text="shoot attempts",Default=1,Min=1,Max=15,Rounding=0,Suffix="x",Compact=true});
		RageGroup:AddDropdown("PreferredWeapon", {Text="preferred weapon",Default=1,Values={"primary","secondary","melee"}});
		RageGroup:AddDropdown("RageSettings", {Text="settings",Values={"swap weapons when no ammo"},Multi=true,Default={"swap weapons when no ammo"}});
		local AntiAimBox = Tabs.Combat:AddRightGroupbox("anti aim");
		AntiAimBox:AddToggle("AntiAimEnable", {Text="enable",Default=false,Callback=function(v)
		end});
		AntiAimBox:AddDropdown("AntiAimYaw", {Values={"none","jitter","spinbot","random"},Default=1,Text="yaw"});
		AntiAimBox:AddDropdown("AntiAimPitch", {Values={"none","jitter","spinbot","random"},Default=1,Text="pitch"});
		AntiAimBox:AddDropdown("AntiAimAngle", {Values={"none","tilt 45","tilt 90","upside down","custom"},Default=1,Text="angle"});
		AntiAimBox:AddSlider("AntiAimCustomAngle", {Text="custom angle",Default=0,Min=0,Max=360,Rounding=1,Suffix="°"});
		AntiAimBox:AddSlider("speedslider", {Text="min speed",Default=10,Min=1,Max=50,Rounding=1,Compact=true});
		AntiAimBox:AddSlider("angleslider", {Text="max speed",Default=20,Min=1,Max=100,Rounding=1,Compact=true});
		AntiAimBox:AddSlider("minangleslider", {Text="min angle",Default=30,Min=1,Max=180,Rounding=1,Suffix="°",Compact=true});
		AntiAimBox:AddSlider("maxangleslider", {Text="max angle",Default=60,Min=1,Max=180,Rounding=1,Suffix="°",Compact=true});
		AntiAimBox:AddToggle("randomangle", {Text="random angle",Default=false});
		AntiAimBox:AddToggle("AntiAimUnderground", {Text="underground",Default=false});
		AntiAimBox:AddLabel("Invert 180°"):AddKeyPicker("AntiAimInvertKey", {Default="None",NoUI=true,Mode="Toggle",Text="Anti-Aim Inverter"});
	end
	do
		local fakeStatsBox = Tabs.Character:AddLeftTabbox();
		local skinTab = fakeStatsBox:AddTab("skin");
		local fpsTab = fakeStatsBox:AddTab("fps");
		local msTab = fakeStatsBox:AddTab("ms");
		local regionTab = fakeStatsBox:AddTab("region");
		skinTab:AddToggle("SkinChangerEnabled", {Text="enable",Default=false});
		skinTab:AddInput("SkinChangerValue", {Text="user id",Default="1",Numeric=true,Finished=true});
		fpsTab:AddToggle("FPSSpoofEnabled", {Text="enable",Default=false});
		fpsTab:AddToggle("FPSSpoofFraud", {Text="fraud",Default=false});
		fpsTab:AddInput("FPSSpoofValue", {Text="fps value",Default="1",Numeric=true,Finished=false});
		msTab:AddToggle("MSSpoofEnabled", {Text="enable",Default=false});
		msTab:AddToggle("MSSpoofFraud", {Text="fraud",Default=false});
		msTab:AddInput("MSSpoofValue", {Text="ms value",Default="1",Numeric=true,Finished=false});
		regionTab:AddToggle("RegionSpoofEnabled", {Text="enable",Default=false});
		regionTab:AddInput("RegionSpoofValue", {Text="region value",Default="m4rs",Numeric=false,Finished=false});
		local charMovement = Tabs.Character:AddRightGroupbox("movement & physics");
		charMovement:AddToggle("InfiniteJump", {Text="infinite jump",Default=false,Tooltip="Jump indefinitely in mid-air"});
		charMovement:AddSlider("JumpPowerSlider", {Text="jump power",Default=50,Min=50,Max=300,Rounding=0,Compact=true});
		charMovement:AddToggle("cframespf_enabled", {Text="walkspeed",Default=false,Tooltip="Smooth physical walkspeed acceleration"}):AddKeyPicker("cframespf_key", {Default="None",NoUI=true,Mode="Toggle",Text="Velocity Walkspeed"});
		charMovement:AddSlider("spdd_value", {Text="walkspeed speed",Default=32,Min=16,Max=250,Rounding=0,Compact=true});
		charMovement:AddToggle("cframefly_enabled", {Text="fly",Default=false,Tooltip="Omnidirectional flight via WASD + Space/Shift"}):AddKeyPicker("cframefly_key", {Default="None",NoUI=true,Mode="Toggle",Text="Velocity Fly"});
		charMovement:AddSlider("cframefly_speed", {Text="fly speed",Default=50,Min=16,Max=350,Rounding=0,Compact=true});
		charMovement:AddToggle("noclip", {Text="noclip",Default=false,Tooltip="Phase completely through map geometry and walls"});
		local SlideBoostGroup = Tabs.Character:AddRightGroupbox("slide boost");
		SlideBoostGroup:AddToggle("slide_boost", {Text="enable",Default=false});
		SlideBoostGroup:AddSlider("slide_speed", {Text="slide boost",Default=300,Min=50,Max=1000,Compact=true,Rounding=0});
		local cameraSection = Tabs.Character:AddRightGroupbox("camera & view");
		cameraSection:AddToggle("CustomFOV", {Text="custom fov",Default=false,Tooltip="Expands camera FOV to easily spot flanking enemies"});
		cameraSection:AddSlider("CustomFOVValue", {Text="field of view",Default=90,Min=60,Max=130,Rounding=0,Compact=true});
		cameraSection:AddToggle("ThirdPerson", {Text="third person",Default=false,Tooltip="Switches camera to third person perspective"}):AddKeyPicker("ThirdPersonKey", {Default="None",NoUI=true,Mode="Toggle",Text="Third Person"});
		cameraSection:AddSlider("ThirdPersonDist", {Text="camera distance",Default=12,Min=4,Max=32,Rounding=0,Compact=true});
		local characterSection = Tabs.Character:AddLeftTabbox();
		local slfMtrlTab = characterSection:AddTab("self material");
		local animPlayerTab = characterSection:AddTab("animation player");
		slfMtrlTab:AddToggle("SlfMtrlEnable", {Text="enable",Default=false}):AddColorPicker("SlfMtrlColor1", {Title="color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("SlfMtrlColor2", {Title="color 2",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("SlfMtrlColor3", {Title="color 3",Default=Color3.fromRGB(255, 255, 255)});
		slfMtrlTab:AddDropdown("SlfMtrlMaterial", {Text="material",Default=2,Values=mats});
		slfMtrlTab:AddSlider("SlfMtrlTransparency", {Text="transparency",Default=0.1,Min=0,Max=1,Rounding=2});
		slfMtrlTab:AddSlider("SlfMtrlPulseSpeed", {Text="pulse speed",Default=3,Min=0.1,Max=12,Rounding=1});
		animPlayerTab:AddToggle("AnimEnabled", {Text="enabled",Default=false}):AddKeyPicker("AnimKey", {Default="None",SyncToggleState=true,Mode="Toggle",Text="anim"});
		animPlayerTab:AddToggle("AnimServerVisible", {Text="server side",Default=true});
		animPlayerTab:AddToggle("AnimJitter", {Text="jitter mode",Default=false});
		animPlayerTab:AddSlider("JitterSpeed", {Text="jitter interval",Default=0.1,Min=0.01,Max=2,Rounding=2,Suffix="s"});
		animPlayerTab:AddToggle("AnimLoop", {Text="loop",Default=true});
		animPlayerTab:AddToggle("AnimAutoRespawn", {Text="spawn proof",Default=true});
		animPlayerTab:AddInput("AnimForceID", {Default="96579993895076",Text="primary anim id",Placeholder="numbers",Numeric=false,Finished=true});
		animPlayerTab:AddInput("AnimJitterID", {Default="120819498172771",Text="jitter anim id",Placeholder="numbers",Numeric=false,Finished=true});
		animPlayerTab:AddSlider("AnimSpeed", {Text="play speed",Default=2,Min=0.1,Max=200,Rounding=1});
		animPlayerTab:AddDropdown("AnimPresetSelector", {Text="primary presets",Values=animPresetNames,Default=1});
		animPlayerTab:AddDropdown("AnimJitterSelector", {Text="jitter presets",Values=animPresetNames,Default=9});
		local currentAnimTrack = nil;
		animPlayerTab:AddButton("play", function()
			pcall(function()
				local player = game:GetService("Players").LocalPlayer;
				local char = player.Character;
				if not char then
					return;
				end
				local hum = char:FindFirstChildOfClass("Humanoid");
				if not hum then
					return;
				end
				local animator = hum:FindFirstChildOfClass("Animator") or hum;
				local rawId = (Options.AnimForceID and Options.AnimForceID.Value) or "";
				local cleanId = rawId:gsub("%D", "");
				if (cleanId ~= "") then
				else
					return;
				end
				local animId = "rbxassetid://" .. cleanId;
				if currentAnimTrack then
					currentAnimTrack:Stop();
				end
				local animObj = Instance.new("Animation");
				animObj.AnimationId = animId;
				currentAnimTrack = animator:LoadAnimation(animObj);
				currentAnimTrack.Looped = (Toggles.AnimLoop and Toggles.AnimLoop.Value) or false;
				currentAnimTrack:Play();
				if (Options.AnimSpeed and Options.AnimSpeed.Value) then
					currentAnimTrack:AdjustSpeed(Options.AnimSpeed.Value);
				end
			end);
		end);
		animPlayerTab:AddButton("stop", function()
			pcall(function()
				if currentAnimTrack then
					currentAnimTrack:Stop();
					currentAnimTrack = nil;
				end
				local player = game:GetService("Players").LocalPlayer;
				local char = player.Character;
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid");
					if hum then
						local animator = hum:FindFirstChildOfClass("Animator");
						if animator then
							for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
								track:Stop();
							end
						end
					end
				end
			end);
		end);
	end
	do
		local EspGroup = Tabs.Visuals:AddLeftGroupbox("esp");
		EspGroup:AddToggle("box_enabled", {Text="enable",Default=false,Callback=function(v)
			PlayUiSound(6895079853);
		end});
		local BoxDepBox = EspGroup:AddDependencyBox();
		BoxDepBox:SetupDependencies({{Toggles.box_enabled,true}});
		BoxDepBox:AddToggle("box_enabled2", {Text="boxes",Default=false}):AddColorPicker("box_outline_color", {Title="box color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("box_outline_color2", {Title="box color 2",Default=Color3.fromRGB(255, 255, 255)});
		BoxDepBox:AddToggle("box_filled", {Text="box fill",Default=false}):AddColorPicker("box_filled_color_start", {Title="fill color start",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("box_filled_color_end", {Title="fill color end",Default=Color3.fromRGB(255, 255, 255)});
		BoxDepBox:AddToggle("box_filled_animated", {Text="fill rotation",Default=false});
		BoxDepBox:AddToggle("box_glow", {Text="box glow",Default=false}):AddColorPicker("box_glow_color_start", {Title="glow color start",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("box_glow_color_end", {Title="glow color end",Default=Color3.fromRGB(255, 255, 255)});
		BoxDepBox:AddToggle("healthbar", {Text="healthbar",Default=false}):AddColorPicker("ColorPicker121212", {Default=Color3.fromRGB(255, 255, 255),Title="high health"}):AddColorPicker("ColorPicker21", {Default=Color3.fromRGB(255, 255, 255),Title="mid health"}):AddColorPicker("ColorPicker45", {Default=Color3.fromRGB(255, 255, 255),Title="low health"});
		EspGroup:AddToggle("esp_visible_check", {Text="visible check",Default=false,Tooltip="Changes color based on line of sight"}):AddColorPicker("esp_visible_color", {Title="visible color",Default=Color3.fromRGB(0, 255, 120)}):AddColorPicker("esp_occluded_color", {Title="occluded color",Default=Color3.fromRGB(255, 50, 50)});
		EspGroup:AddToggle("esp_hit_flash", {Text="hit flash",Default=false,Tooltip="Brief white flash when target is damaged"});
		EspGroup:AddToggle("esp_text_flow", {Text="text wave flow",Default=false,Tooltip="Smooth sine wave displacement for ESP text"});
		EspGroup:AddToggle("textesp", {Text="names",Default=false}):AddColorPicker("name_color", {Title="name color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("name_color2", {Title="name color 2",Default=Color3.fromRGB(255, 255, 255)});
		EspGroup:AddToggle("textesp_distance", {Text="distance",Default=false}):AddColorPicker("distance_color", {Title="distance color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("distance_color2", {Title="distance color 2",Default=Color3.fromRGB(255, 255, 255)});
		EspGroup:AddToggle("textesp_tools", {Text="tools",Default=false}):AddColorPicker("tool_color", {Title="tool color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("tool_color2", {Title="tool color 2",Default=Color3.fromRGB(255, 255, 255)});
		EspGroup:AddToggle("skeleton", {Text="skeleton",Default=false}):AddColorPicker("skeleton_color", {Title="skeleton color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("skeleton_color2", {Title="skeleton color 2",Default=Color3.fromRGB(255, 255, 255)});
		EspGroup:AddToggle("tracers", {Text="tracers",Default=false}):AddColorPicker("tracers_color", {Title="tracer color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("tracers_color2", {Title="tracer color 2",Default=Color3.fromRGB(255, 255, 255)});
		EspGroup:AddToggle("chams", {Text="chams",Default=false}):AddColorPicker("chams_color", {Title="chams color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("chams_color2", {Title="chams color 2",Default=Color3.fromRGB(255, 255, 255)});
		local fillDep = EspGroup:AddDependencyBox();
		fillDep:SetupDependencies({{Toggles.box_filled,true}});
		fillDep:AddSlider("box_filled_transparency", {Text="fill transparency",Default=0.7,Min=0,Max=1,Rounding=2,Compact=true});
		fillDep:AddSlider("box_filled_rotation", {Text="fill rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true});
		fillDep:AddSlider("box_filled_speed", {Text="fill speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true});
		local glowDep = EspGroup:AddDependencyBox();
		glowDep:SetupDependencies({{Toggles.box_glow,true}});
		glowDep:AddSlider("box_glow_transparency", {Text="glow transparency",Default=0.8,Min=0,Max=1,Rounding=2,Compact=true});
		glowDep:AddSlider("box_glow_rotation", {Text="glow rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true});
		local nameDep = EspGroup:AddDependencyBox();
		nameDep:SetupDependencies({{Toggles.textesp,true}});
		nameDep:AddSlider("textesp_namesize", {Text="name size",Default=8,Min=8,Max=16,Rounding=1,Compact=true});
		local distDep = EspGroup:AddDependencyBox();
		distDep:SetupDependencies({{Toggles.textesp_distance,true}});
		distDep:AddSlider("textesp_distancesize", {Text="distance size",Default=8,Min=8,Max=14,Rounding=1,Compact=true});
		local toolDep = EspGroup:AddDependencyBox();
		toolDep:SetupDependencies({{Toggles.textesp_tools,true}});
		toolDep:AddSlider("textesp_toolssize", {Text="tools size",Default=8,Min=8,Max=14,Rounding=1,Compact=true});
		local skelDep = EspGroup:AddDependencyBox();
		skelDep:SetupDependencies({{Toggles.skeleton,true}});
		skelDep:AddSlider("skeleton_thickness", {Text="skeleton thickness",Default=1,Min=0.5,Max=5,Rounding=1,Compact=true});
		local tracerDep = EspGroup:AddDependencyBox();
		tracerDep:SetupDependencies({{Toggles.tracers,true}});
		tracerDep:AddSlider("tracers_thickness", {Text="tracer thickness",Default=1,Min=0.5,Max=5,Rounding=1,Compact=true});
		local chamDep = EspGroup:AddDependencyBox();
		chamDep:SetupDependencies({{Toggles.chams,true}});
		chamDep:AddSlider("chams_transparency", {Text="chams transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		local utilEsp = Tabs.Visuals:AddLeftGroupbox("utility");
		utilEsp:AddToggle("utilenable", {Text="enable",Default=false}):AddColorPicker("utilcolor", {Title="text color 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("utilcolor2", {Title="text color 2",Default=Color3.fromRGB(255, 255, 255)});
		utilEsp:AddDropdown("utilitems", {Text="utilities",Values={"grenade","subspace tripmine","flashbang","satchel","warpstone","molotov","smoke grenade"},Multi=true,Default={}});
		utilEsp:AddToggle("utildistance", {Text="distance",Default=false});
		utilEsp:AddToggle("utilimages", {Text="images",Default=false});
		local dmgNumbersGroup = Tabs.Visuals:AddLeftGroupbox("damage numbers");
		dmgNumbersGroup:AddToggle("DamageNumbersEnable", {Text="enable",Default=false}):AddColorPicker("DamageNumbersColor1", {Title="color 1",Default=Color3.fromRGB(255, 80, 80)}):AddColorPicker("DamageNumbersColor2", {Title="color 2",Default=Color3.fromRGB(255, 200, 50)});
		dmgNumbersGroup:AddDropdown("DamageNumbersColorType", {Text="color mode",Default=1,Values={"Solid","Gradient","Rainbow"}});
		dmgNumbersGroup:AddSlider("DamageNumbersSize", {Text="font size",Default=18,Min=12,Max=32,Rounding=0,Compact=true});
		dmgNumbersGroup:AddSlider("DamageNumbersRise", {Text="rise height",Default=42,Min=10,Max=100,Rounding=0,Compact=true});
		dmgNumbersGroup:AddSlider("DamageNumbersDuration", {Text="duration",Default=0.8,Min=0.3,Max=2.5,Rounding=1,Suffix="s",Compact=true});
		local ViewModelTabbox = Tabs.Visuals:AddRightTabbox();
		local vmTab = ViewModelTabbox:AddTab("view model");
		local viewportTab = ViewModelTabbox:AddTab("viewport");
		vmTab:AddToggle("GunChams", {Text="gun chams",Default=false}):AddColorPicker("GunColor1", {Default=Color3.fromRGB(255, 255, 255),Title="gun color 1"}):AddColorPicker("GunColor2", {Default=Color3.fromRGB(255, 255, 255),Title="gun color 2"}):AddColorPicker("GunColor3", {Default=Color3.fromRGB(255, 255, 255),Title="gun color 3"});
		local gunChamsDep = vmTab:AddDependencyBox();
		gunChamsDep:SetupDependencies({{Toggles.GunChams,true}});
		gunChamsDep:AddDropdown("GunMaterial", {Text="gun material",Default=2,Values=mats});
		gunChamsDep:AddSlider("GunChamSpeed", {Text="gradient speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true});
		gunChamsDep:AddSlider("GunChamTransparency", {Text="gun transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		vmTab:AddToggle("ArmChams", {Text="arm chams",Default=false}):AddColorPicker("ArmColor1", {Default=Color3.fromRGB(255, 255, 255),Title="arm color 1"}):AddColorPicker("ArmColor2", {Default=Color3.fromRGB(255, 255, 255),Title="arm color 2"}):AddColorPicker("ArmColor3", {Default=Color3.fromRGB(255, 255, 255),Title="arm color 3"});
		local armChamsDep = vmTab:AddDependencyBox();
		armChamsDep:SetupDependencies({{Toggles.ArmChams,true}});
		armChamsDep:AddDropdown("ArmMaterial", {Text="arm material",Default=1,Values=mats});
		armChamsDep:AddSlider("ArmChamSpeed", {Text="gradient speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true});
		armChamsDep:AddSlider("ArmChamTransparency", {Text="arm transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		vmTab:AddToggle("GunOutline", {Text="gun outline",Default=false}):AddColorPicker("GunOutlineColor1", {Title="gun outline 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("GunOutlineColor2", {Title="gun outline 2",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("GunOutlineColor3", {Title="gun outline 3",Default=Color3.fromRGB(255, 255, 255)});
		vmTab:AddToggle("ArmOutline", {Text="arm outline",Default=false}):AddColorPicker("ArmOutlineColor1", {Title="arm outline 1",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("ArmOutlineColor2", {Title="arm outline 2",Default=Color3.fromRGB(255, 255, 255)}):AddColorPicker("ArmOutlineColor3", {Title="arm outline 3",Default=Color3.fromRGB(255, 255, 255)});
		vmTab:AddToggle("GunHighlight", {Text="gun highlight",Default=false}):AddColorPicker("GunHighlightTop", {Default=Color3.fromRGB(255, 255, 255),Title="gun top"}):AddColorPicker("GunHighlightBottom", {Default=Color3.fromRGB(200, 200, 255),Title="gun bottom"});
		local gunHighlightDep = vmTab:AddDependencyBox();
		gunHighlightDep:SetupDependencies({{Toggles.GunHighlight,true}});
		gunHighlightDep:AddDropdown("GunHighlightMaterial", {Text="gun highlight material",Default=2,Values=mats});
		gunHighlightDep:AddSlider("GunHighlightFillTransparency", {Text="transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		gunHighlightDep:AddSlider("GunHighlightOutlineTransparency", {Text="outline transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		vmTab:AddToggle("ArmHighlight", {Text="arm highlight",Default=false}):AddColorPicker("ArmHighlightTop", {Default=Color3.fromRGB(255, 255, 255),Title="arm top"}):AddColorPicker("ArmHighlightBottom", {Default=Color3.fromRGB(200, 200, 255),Title="arm bottom"});
		local armHighlightDep = vmTab:AddDependencyBox();
		armHighlightDep:SetupDependencies({{Toggles.ArmHighlight,true}});
		armHighlightDep:AddDropdown("ArmHighlightMaterial", {Text="arm highlight material",Default=2,Values=mats});
		armHighlightDep:AddSlider("ArmHighlightFillTransparency", {Text="arm highlight fill transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		armHighlightDep:AddSlider("ArmHighlightOutlineTransparency", {Text="arm highlight outline transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		vmTab:AddToggle("DisableArms", {Text="disable arms",Default=false});
		vmTab:AddToggle("InvisibleArms", {Text="invisible arms",Default=false,Tooltip="Completely hides arms in first person"});
		vmTab:AddToggle("DisableClothes", {Text="disable clothes",Default=false,Tooltip="Removes shirts and pants for clean textures"});
		vmTab:AddToggle("BodyCustomEnable", {Text="custom body appearance",Default=false}):AddColorPicker("BodyCustomColor", {Default=Color3.fromRGB(255, 255, 255),Title="body color"});
		vmTab:AddDropdown("BodyCustomMaterial", {Text="body material",Default=1,Values=mats});
		vmTab:AddSlider("BodyCustomTrans", {Text="body transparency",Default=0,Min=0,Max=1,Rounding=2,Compact=true});
		viewportTab:AddToggle("EnableViewport", {Text="enable",Default=false});
		viewportTab:AddSlider("OffsetX", {Text="offset x",Default=0,Min=-10,Max=10,Rounding=2,Compact=true});
		viewportTab:AddSlider("OffsetY", {Text="offset y",Default=0,Min=-10,Max=10,Rounding=2,Compact=true});
		viewportTab:AddSlider("OffsetZ", {Text="offset z",Default=0,Min=-10,Max=10,Rounding=2,Compact=true});
		viewportTab:AddToggle("NoAnimations", {Text="no animations",Default=false});
		local noAnimDepBox = viewportTab:AddDependencyBox();
		noAnimDepBox:SetupDependencies({{Toggles.NoAnimations,true}});
		noAnimDepBox:AddDropdown("NoAnimationsList", {Text="disabled animations",Values={"Idle","Reloading","Sprinting","Crouching","Shooting","Aiming","Equip","Jump"},Default={},Multi=true});
		local fxTabbox = Tabs.Visuals:AddRightTabbox();
		local colorTab = fxTabbox:AddTab("color");
		local bloomTab = fxTabbox:AddTab("bloom");
		local shaderTab = fxTabbox:AddTab("shaders");
		colorTab:AddToggle("lighting_color_correction", {Text="enable",Default=false});
		colorTab:AddSlider("lighting_cc_contrast", {Text="contrast",Min=-10,Max=10,Default=0,Rounding=1,Compact=true});
		colorTab:AddSlider("lighting_cc_saturation", {Text="saturation",Min=-10,Max=10,Default=0,Rounding=1,Compact=true});
		colorTab:AddSlider("lighting_cc_brightness", {Text="brightness",Min=-10,Max=10,Default=0,Rounding=1,Compact=true});
		bloomTab:AddToggle("lighting_bloom_modifier", {Text="enable",Default=false});
		bloomTab:AddSlider("lighting_bloom_multiplier", {Text="emissive intensity",Min=0,Max=1.5,Default=0.3,Rounding=2,Compact=true});
		bloomTab:AddSlider("lighting_bloom_size", {Text="glow size",Min=2,Max=8,Default=4,Rounding=1,Compact=true});
		bloomTab:AddSlider("lighting_bloom_threshold", {Text="brightness threshold",Min=0.5,Max=1,Default=0.7,Rounding=2,Compact=true});
		shaderTab:AddToggle("motion_blur_enable", {Text="motion blur",Default=false});
		shaderTab:AddSlider("motion_blur_intensity", {Text="blur intensity",Min=1,Max=10,Default=3,Rounding=0,Compact=true});
		shaderTab:AddToggle("depth_of_field_enable", {Text="depth of field",Default=false});
		shaderTab:AddSlider("dof_focus_dist", {Text="focus distance",Min=0,Max=100,Default=20,Rounding=0,Compact=true});
		shaderTab:AddToggle("sunrays_enable", {Text="sun rays",Default=false});
		shaderTab:AddSlider("sunrays_intensity", {Text="ray intensity",Min=0.05,Max=1,Default=0.25,Rounding=2,Compact=true});
		local vcrosshair = Tabs.Visuals:AddRightGroupbox("crosshair");
		vcrosshair:AddToggle("crosshaireeee", {Text="enable",Default=false}):AddColorPicker("CrosshairColor", {Default=Color3.fromRGB(0, 200, 255),Title="Crosshair Color"}):AddColorPicker("GradientColor1", {Default=Color3.fromRGB(0, 200, 255),Title="Text Color 1"}):AddColorPicker("GradientColor2", {Default=Color3.fromRGB(0, 153, 255),Title="Text Color 2"}):AddColorPicker("GradientColor3", {Default=Color3.fromRGB(0, 107, 255),Title="Text Color 3"});
		vcrosshair:AddToggle("RainbowCrosshair", {Text="rainbow crosshair",Default=false,Tooltip="Dynamic rainbow cycling crosshair color"});
		vcrosshair:AddDropdown("CrosshairStyle", {Text="style",Default=1,Values={"cross","t","x","circle","dot"}});
		vcrosshair:AddSlider("CrosshairLength", {Text="length",Default=12,Min=2,Max=50,Rounding=0,Compact=true});
		vcrosshair:AddSlider("CrosshairGap", {Text="gap",Default=5,Min=0,Max=35,Rounding=0,Compact=true});
		vcrosshair:AddSlider("CrosshairThickness", {Text="thickness",Default=1.5,Min=0.5,Max=8,Rounding=1,Compact=true});
		vcrosshair:AddToggle("CrosshairRotating", {Text="auto rotating",Default=false});
		vcrosshair:AddSlider("CrosshairRotateSpeed", {Text="rotate speed",Default=60,Min=10,Max=360,Rounding=0,Compact=true});
		vcrosshair:AddToggle("CrosshairSpread", {Text="velocity spread",Default=false});
		vcrosshair:AddDropdown("CrosshairAnimMode", {Text="animation",Default=1,Values={"none","breathe","pulse"}});
		vcrosshair:AddToggle("CrosshairShimmer", {Text="shimmer pulse",Default=false});
		vcrosshair:AddToggle("CrosshairFollowTarget", {Text="follow target / gunpoint",Default=false});
		vcrosshair:AddToggle("CrosshairTargetText", {Text="crosshair text info",Default=false});
		vcrosshair:AddToggle("showlines", {Text="crosshair lines",Default=true});
		vcrosshair:AddToggle("showammo", {Text="ammo text",Default=false});
		vcrosshair:AddSlider("ooetg", {Text="speed",Default=150,Min=0,Max=340,Rounding=2,Compact=true});
		vcrosshair:AddSlider("GradientRotation", {Text="rotation",Default=0,Min=0,Max=360,Rounding=0,Compact=true});
		vcrosshair:AddDropdown("crosshairmode", {Text="crosshair anchor",Default=1,Values={"static","follow muzzle","follow target"}});
	end
	do
		local HitGroup = Tabs.World:AddRightTabbox();
		local hitEffectsTab = HitGroup:AddTab("hit effects");
		local hitSoundsTab = HitGroup:AddTab("hit sounds");
		local hitNotifTab = HitGroup:AddTab("hit notif");
		hitEffectsTab:AddToggle("HitEffects", {Text="enable",Default=false}):AddColorPicker("HitEffectColorPicker", {Default=Color3.fromRGB(159, 133, 195),Title="Hit Effect Color"});
		local hitEffectDepBox = hitEffectsTab:AddDependencyBox();
		hitEffectDepBox:SetupDependencies({{Toggles.HitEffects,true}});
		hitEffectDepBox:AddSlider("HitEffectFloatSpeed", {Text="float speed",Default=7,Min=1,Max=25,Rounding=1});
		hitEffectDepBox:AddSlider("HitEffectAliveTime", {Text="alive time",Default=2.8,Min=0.5,Max=8,Rounding=1,Suffix="s"});
		hitEffectsTab:AddDropdown("HitEffectStyleDropdown", {Text="style",Default={"Particles"},Values={"Particles","Fortnite","Shockwave","Lightning","Blood","Fire","Ice","Hearts","Stars","Confetti","Ripple","Sparks","Neon","Void","Plasma","Glitch","Cosmic Shit"},Multi=true});
		hitSoundsTab:AddToggle("HitSounds", {Text="enable",Default=false});
		hitSoundsTab:AddInput("SoundSearch", {Text="search sounds",Placeholder="",ClearTextOnFocus=false});
		hitSoundsTab:AddDropdown("SoundStyleDropdown", {Text="sound",Default=38,Values=hitSoundList});
		hitSoundsTab:AddSlider("SoundVolume", {Text="volume",Default=50,Min=1,Max=100,Rounding=0,Compact=true});
		hitSoundsTab:AddSlider("SoundPitch", {Text="pitch",Default=100,Min=50,Max=200,Rounding=0,Compact=true});
		hitSoundsTab:AddToggle("DisableGunSounds", {Text="disable gun sounds",Default=false});
		hitNotifTab:AddToggle("HitNotifications", {Text="hit notifications",Default=false}):AddColorPicker("HitNotificationsColor", {Default=Color3.fromRGB(235, 235, 235),Title="text color"});
		local hitNotifDepBox = hitNotifTab:AddDependencyBox();
		hitNotifDepBox:SetupDependencies({{Toggles.HitNotifications,true}});
		hitNotifDepBox:AddSlider("HitNotifDuration", {Text="duration",Default=3,Min=1,Max=8,Rounding=1,Compact=true,Suffix="s"});
		hitNotifDepBox:AddSlider("HitNotifTextSize", {Text="text size",Default=14,Min=10,Max=24,Rounding=0,Compact=true});
		hitNotifDepBox:AddSlider("HitNotifMaxVisible", {Text="max on screen",Default=8,Min=1,Max=25,Rounding=0,Compact=true});
		hitNotifDepBox:AddDropdown("HitNotifPosition", {Text="position",Default=1,Values={"Top Left","Top Center","Top Right","Center Left","Center","Center Right","Bottom Left","Bottom Center","Bottom Right","Custom"}});
		hitNotifDepBox:AddSlider("HitNotifStackGap", {Text="stack gap",Default=6,Min=2,Max=24,Rounding=0,Compact=true});
		hitNotifDepBox:AddDropdown("HitNotifInAnim", {Text="in animation",Default=6,Values={"fade","slide left","slide right","slide down","bounce","fade bounce","scale"}});
		hitNotifDepBox:AddDropdown("HitNotifOutAnim", {Text="out animation",Default=1,Values={"fade","slide left","slide right","slide down","bounce","fade bounce","scale"}});
		hitNotifDepBox:AddSlider("HitNotifInSpeed", {Text="in speed",Default=0.52,Min=0.15,Max=1.5,Rounding=2,Compact=true,Suffix="s"});
		hitNotifDepBox:AddSlider("HitNotifOutSpeed", {Text="out speed",Default=0.38,Min=0.15,Max=1.5,Rounding=2,Compact=true,Suffix="s"});
		local lightbox = Tabs.World:AddRightGroupbox("lighting");
		lightbox:AddToggle("lighting_master", {Text="enable",Default=false});
		lightbox:AddToggle("lighting_ambient", {Text="custom ambient",Default=false}):AddColorPicker("lighting_ambient_color", {Default=Color3.fromRGB(255, 255, 255),Title="ambient color"});
		lightbox:AddToggle("lighting_outdoorambient", {Text="custom outdoor ambient",Default=false}):AddColorPicker("lighting_outdoorambient_color", {Default=Color3.fromRGB(255, 255, 255),Title="outdoor ambient color"});
		lightbox:AddToggle("lighting_suncolor", {Text="custom sun color",Default=false}):AddColorPicker("lighting_suncolor_color", {Default=Color3.fromRGB(255, 255, 255),Title="sun color"});
		lightbox:AddToggle("lighting_globalshadows", {Text="global shadows",Default=true});
		lightbox:AddToggle("lighting_shadowsoftness", {Text="custom shadow softness",Default=false});
		lightbox:AddToggle("lighting_colorshifttop", {Text="color shift top",Default=false}):AddColorPicker("lighting_colorshifttop_color", {Default=Color3.fromRGB(255, 255, 255),Title="top color"});
		lightbox:AddToggle("lighting_colorshiftbottom", {Text="color shift bottom",Default=false}):AddColorPicker("lighting_colorshiftbottom_color", {Default=Color3.fromRGB(255, 255, 255),Title="bottom color"});
		lightbox:AddToggle("lighting_clocktime", {Text="custom time",Default=false});
		lightbox:AddToggle("lighting_latitude", {Text="custom latitude",Default=false});
		lightbox:AddToggle("lighting_fog", {Text="custom fog",Default=false}):AddColorPicker("lighting_fog_color", {Default=Color3.fromRGB(255, 255, 255),Title="fog color"});
		lightbox:AddToggle("lighting_diffuse", {Text="custom diffuse scale",Default=false});
		lightbox:AddToggle("lighting_specular", {Text="custom specular scale",Default=false});
		lightbox:AddSlider("lighting_shadowsoftness_value", {Text="shadow softness",Min=0,Max=1,Default=0.2,Rounding=2,Compact=true});
		lightbox:AddSlider("lighting_clocktime_value", {Text="hour",Min=0,Max=24,Default=12,Rounding=1,Compact=true});
		lightbox:AddSlider("lighting_latitude_value", {Text="geographic latitude",Min=-90,Max=90,Default=41.8,Rounding=1,Compact=true});
		lightbox:AddSlider("lighting_fogstart", {Text="fog start",Min=0,Max=1000,Default=0,Rounding=0,Compact=true});
		lightbox:AddSlider("lighting_fogend", {Text="fog end",Min=0,Max=100000,Default=100,Rounding=0,Compact=true});
		lightbox:AddSlider("lighting_diffuse_value", {Text="diffuse scale",Min=0,Max=2,Default=1,Rounding=2,Compact=true});
		lightbox:AddSlider("lighting_specular_value", {Text="specular scale",Min=0,Max=2,Default=1,Rounding=2,Compact=true});
		local TexturesGroup = Tabs.World:AddLeftGroupbox("world textures");
		TexturesGroup:AddToggle("world_textures_enable", {Text="enable textures",Default=false}):AddColorPicker("world_textures_color", {Default=Color3.fromRGB(244, 244, 244),Title="texture color"});
		TexturesGroup:AddDropdown("world_textures_material", {Values={"Brick","Air","Asphalt","Basalt","Cardboard","Carpet","Ceramic Tiles","Clay Roof Tiles","Cobblestone","Concrete","Corroded Metal","Cracked Lava","Diamond Plate","Fabric","Foil","Forcefield","Glacier","Glass","Granite","Grass","Ground","Ice","Leafy Grass","Leather","Limestone","Marble","Metal","Minecraft","Mud","Neon","Pavement","Pebble","Plaster","Plastic","Rock","Roof Shingles","Rubber","Salt","Sand","Sandstone","Slate","Smooth Plastic","Snow","Water","Wood","Wood Planks"},Default=1,Text="material"});
		TexturesGroup:AddToggle("world_textures_apply_vm", {Text="apply to viewmodel",Default=false});
		TexturesGroup:AddToggle("smooth_textures", {Text="smooth textures",Default=false});
		TexturesGroup:AddToggle("dark_textures", {Text="dark textures",Default=false});
		TexturesGroup:AddToggle("transparent_textures", {Text="transparent textures",Default=false});
		TexturesGroup:AddSlider("TransparentStrength", {Text="transparency",Default=0.6,Min=0.5,Max=1,Rounding=2,Compact=true});
		local TracersGroup = Tabs.World:AddLeftGroupbox("bullet tracers");
		TracersGroup:AddToggle("TracerEnabled", {Text="enable",Default=true}):AddColorPicker("TracerColor", {Default=Color3.fromRGB(255, 255, 255),Title="tracer color 1"}):AddColorPicker("TracerColorEnd", {Default=Color3.fromRGB(180, 200, 255),Title="tracer color 2"});
		TracersGroup:AddDropdown("TracerStyle", {Text="texture",Default=1,Values={"Line","Laser","Lightning","Heartrate","Chain","Glitch","Swirl","Neon","Plasma","Cross","Dots","Arrows","Wave","Stripes","ZigZag","Barcode","DNA","Hexagon","Pulse","Spiral","Vortex","Circuit","Grid","Matrix","Particles","Sakura","Flame","Electric","Stardust","Rays","Rings","Segments","Flow","Binary","Cyber","Nebula","Spectrum","Energy","Constellation","Runes","Vapor","Hyper","Solid"}});
		TracersGroup:AddSlider("TracerDuration", {Text="duration",Default=3,Min=0.1,Max=10,Rounding=1,Compact=true});
		TracersGroup:AddSlider("TracerSize", {Text="width 0",Default=1,Min=0.5,Max=5,Rounding=1,Compact=true});
		TracersGroup:AddSlider("TracerSize1", {Text="width 1",Default=1,Min=0.5,Max=5,Rounding=1,Compact=true});
		TracersGroup:AddSlider("TracerFade", {Text="fade time",Default=0.5,Min=0,Max=2,Rounding=1,Compact=true});
		TracersGroup:AddSlider("TracerSpeed", {Text="texture speed",Default=1,Min=0.1,Max=10,Rounding=1,Compact=true});
		TracersGroup:AddToggle("TracerSpringExpand", {Text="spring expand",Default=true});
		TracersGroup:AddSlider("TracerExpandSpeed", {Text="spring speed",Default=14,Min=1,Max=35,Rounding=0,Compact=true});
		TracersGroup:AddSlider("TracerExpandDamper", {Text="spring damper",Default=0.55,Min=0.1,Max=1,Rounding=2,Compact=true});
		TracersGroup:AddToggle("TracerCurveAround", {Text="curve around obstacles",Default=false,Tooltip="Raycasts around map obstacles so beam bends"});
		TracersGroup:AddSlider("TracerCurveHeight", {Text="curve height",Default=14,Min=5,Max=40,Rounding=0,Compact=true});
		TracersGroup:AddToggle("TracerThroughWalls", {Text="through walls line",Default=false,Tooltip="Draws 2D overlay line through geometry"});
		local skyboxTabbox = Tabs.World:AddLeftTabbox();
		local skyTab = skyboxTabbox:AddTab("skybox");
		local aspectTab = skyboxTabbox:AddTab("aspect ratio");
		skyTab:AddToggle("skybox_master", {Text="enable",Default=false});
		skyTab:AddDropdown("skybox_selection", {Text="skybox",Default=1,Values={"Default","SpongeBob","Deep Space","Crazy Hello City","One Piece","Matcha","Abyssal Blues","Pink Sky","Green Sky","Purple Nebula","Vaporwave","Redshift","Minecraft","PurpleDay","RedNight","Trollge","Night","Space","VibeMorning","VibeNight","PurpleSplash","GreenSpace","Snowy","Spongebob","PinkDay","AlienRed","WallsOfAutumn","ColdWinterness","Oblivion","ClassicSky","PurpleNight","PurpleDayClear","YellowDay","MinecraftSky","Sunset","CartoonSky","Anime","HellSky","StarryNight","Omori","c00lkidd","ClearDay","Mountains","Forest","LargeForest","Crimson","PumpkinHill","AnimeIsland","SnowyMountains","Desert","Cloudy","Island","OrangeFog","FadeNight","Office","Spongebob2","PurpleFog","EarthSpace","GreenCloudy","SummerDay","SnowyPlains","Underwater","BlueAbyss","Poison","BlueSpace","AnimeMountains","PinkGradient","YellowGradient","BlueGradient","GreenNebula","OrangeGradient","GreenAurora","Blank","Clouds","Cloudy Skies","Elegant Morning","Fade Blue","Neptune","Night Sky","Purple And Blue","Purple Clouds","Purple Galaxy","Red Night Sky","Setting Sun","Twighlight","Vivid Skies","Elisium Sky"}});
		skyTab:AddDropdown("disable_elements", {Text="disable elements",Values={"Sun","Moon","Stars"},Default={},Multi=true});
		skyTab:AddToggle("skybox_rotate", {Text="skybox rotator",Default=false});
		skyTab:AddDropdown("skybox_rotate_method", {Text="rotation mode",Default=1,Values={"Spin","Wave","Alternate"}});
		skyTab:AddDropdown("skybox_rotate_direction", {Text="rotation axis",Default=1,Values={"Horizontal","Vertical","Diagonal"}});
		skyTab:AddSlider("skybox_rotate_speed", {Text="rotation speed",Default=2,Min=0.1,Max=10,Rounding=1,Compact=true});
		local deathEffectsBox = Tabs.World:AddRightGroupbox("death effects");
		deathEffectsBox:AddToggle("DeathEffectsEnable", {Text="enable death effects",Default=false}):AddColorPicker("DeathEffectsColor", {Default=Color3.fromRGB(150, 80, 255),Title="particle color"});
		deathEffectsBox:AddDropdown("DeathEffectsType", {Text="effect style",Default=1,Values={"Explosion","Fire","Sparkles","Neon Burst"}});
		aspectTab:AddToggle("aspect_ratio_master", {Text="enable",Default=false});
		aspectTab:AddSlider("aspect_ratio_x", {Text="X ratio",Default=13,Min=1,Max=13,Compact=true,Rounding=0});
		aspectTab:AddSlider("aspect_ratio_y", {Text="Y ratio",Default=10,Min=10,Max=32,Compact=true,Rounding=0});
		local atmotabbox = Tabs.World:AddRightTabbox();
		local atmotab = atmotabbox:AddTab("atmosphere");
		local ambienceTab = atmotabbox:AddTab("ambience");
		atmotab:AddToggle("atmosphere_master", {Text="enable",Default=false}):AddColorPicker("atmosphere_color", {Default=Color3.fromRGB(140, 160, 190),Title="atmosphere color"}):AddColorPicker("atmosphere_decay", {Default=Color3.fromRGB(90, 110, 140),Title="decay color"});
		atmotab:AddSlider("atmosphere_density", {Text="density",Min=0,Max=1,Default=0.5,Rounding=1,Compact=true});
		atmotab:AddSlider("atmosphere_haze", {Text="haze",Min=0,Max=5,Default=1,Rounding=1,Compact=true});
		atmotab:AddSlider("atmosphere_glare", {Text="glare",Min=0,Max=5,Default=0.6,Rounding=2,Compact=true});
		atmotab:AddSlider("atmosphere_offset", {Text="offset",Min=0,Max=1,Default=0.25,Rounding=2,Compact=true});
		ambienceTab:AddToggle("atmosphere_sound_toggle", {Text="enable",Default=false});
		ambienceTab:AddDropdown("atmosphere_ambient_sound", {Text="ambient sound",Values={"None","Rain","Night","Birds Chirping","Jungle Birds","Campfire Crackling","Night Crickets","Snow Storm"},Default=1});
		ambienceTab:AddSlider("atmosphere_sound_volume", {Text="volume",Min=0,Max=10,Default=0.6,Rounding=2,Compact=true});
		local killSoundsTab = Tabs.World:AddRightGroupbox("kill sounds");
		killSoundsTab:AddToggle("KillSoundsEnabled", {Text="enable",Default=false});
		local killSoundsDep = killSoundsTab:AddDependencyBox();
		killSoundsDep:SetupDependencies({{Toggles.KillSoundsEnabled,true}});
		killSoundsDep:AddDropdown("KillSoundStyle", {Text="sound",Default=1,Values={"sound 1","sound 2","sound 3"}});
		killSoundsDep:AddSlider("KillSoundVolume", {Text="volume",Default=50,Min=0,Max=100,Rounding=0,Compact=true});
		killSoundsDep:AddSlider("KillSoundPitch", {Text="pitch",Default=100,Min=50,Max=200,Rounding=0,Compact=true});
		local weatherBox = Tabs.World:AddLeftGroupbox("weather");
		weatherBox:AddToggle("weather_master_enable", {Text="enable",Default=false}):AddColorPicker("weather_color", {Default=Color3.fromRGB(255, 255, 255),Title="color"});
		weatherBox:AddDropdown("weather_effects", {Text="effects",Values={"rain","snow","light rain","stars","hearts"},Default={},Multi=true});
		weatherBox:AddSlider("weather_rate", {Text="rate",Default=100,Min=0,Max=100,Rounding=0,Suffix="%",Compact=true});
		weatherBox:AddSlider("weather_speed_min", {Text="speed min",Default=40,Min=0,Max=200,Rounding=1,Compact=true});
		weatherBox:AddSlider("weather_speed_max", {Text="speed max",Default=60,Min=0,Max=200,Rounding=1,Compact=true});
		weatherBox:AddSlider("weather_size_min", {Text="size min",Default=0.33,Min=0.1,Max=50,Rounding=2,Compact=true});
		weatherBox:AddSlider("weather_size_max", {Text="size max",Default=0.4,Min=0.1,Max=50,Rounding=2,Compact=true});
		weatherBox:AddSlider("weather_opacity_min", {Text="opacity min",Default=50,Min=0,Max=100,Rounding=0,Suffix="%",Compact=true});
		weatherBox:AddSlider("weather_opacity_max", {Text="opacity max",Default=0,Min=0,Max=100,Rounding=0,Suffix="%",Compact=true});
		weatherBox:AddSlider("weather_spread", {Text="spread",Default=0,Min=0,Max=180,Rounding=0,Suffix="°",Compact=true});
		weatherBox:AddSlider("weather_brightness", {Text="brightness",Default=100,Min=0,Max=500,Rounding=0,Suffix="%",Compact=true});
		weatherBox:AddSlider("weather_emission", {Text="light emission",Default=50,Min=0,Max=100,Rounding=0,Suffix="%",Compact=true});
		weatherBox:AddSlider("weather_glow", {Text="glow",Default=0,Min=0,Max=5,Rounding=2,Suffix="x",Compact=true});
		weatherBox:AddSlider("weather_sizescale", {Text="particle size",Default=1,Min=0.1,Max=5,Rounding=2,Suffix="x",Compact=true});
	end
	do
		local primaryWeapons = {"Assault Rifle","Sniper","Bow","Burst Rifle","Crossbow","Gunblade","RPG","Shotgun","Energy Rifle","Flamethrower","Grenade Launcher","Minigun","Paintball Gun","Distortion","Permafrost","Slingshot","Warper"};
		local secondaryWeapons = {"Handgun","Daggers","Flare Gun","Revolver","Shorty","Spray","Uzi","Energy Pistols","Exogun"};
		local meleeWeapons = {"Knife","Fists","Battle Axe","Chainsaw","Katana","Riot Shield","Scythe","Maul","Hook","Spear"};
		local utilityWeapons = {"Medkit","Grenade","Flashbang","Freeze Ray","Jump Pad","Molotov","Satchel","Smoke Grenade","War Horn","Subspace Tripmine","Warpstone","Trowel"};
		local rivalsMaps = {"Arena","Big Graveyard","Docks","Splash","Bridge","Crossroads","Big Crossroads","Big Backrooms","Battleground","Big Arena","Construction","Playground","Onyx","Graveyard","Big Splash","Big Onyx","Backrooms","Station","Dimension"};
		local MatchmakingTabbox = Tabs.Misc:AddLeftTabbox();
		local AutoQueueTab = MatchmakingTabbox:AddTab("auto queue");
		AutoQueueTab:AddToggle("queueenabled", {Text="enable auto queue",Default=false});
		AutoQueueTab:AddDropdown("queuemode", {Text="queue mode",Values={"1v1","2v2","3v3","4v4","5v5","2v2_beginner"},Default=1});
		AutoQueueTab:AddToggle("ranked", {Text="ranked match",Default=false});
		AutoQueueTab:AddToggle("autoleave", {Text="auto return to lobby",Default=true,Tooltip="Automatically clicks leave match / return to lobby upon game finish"});
		AutoQueueTab:AddSlider("queue_delay", {Text="retry delay",Default=3,Min=1,Max=10,Rounding=1,Suffix="s",Compact=true});
		local AutoVoteTab = MatchmakingTabbox:AddTab("auto vote map");
		AutoVoteTab:AddToggle("AutoVoteMap", {Text="enable auto vote",Default=false,Tooltip="Automatically votes for your selected map when vote starts"});
		AutoVoteTab:AddDropdown("AutoVoteMapSelect", {Text="target map",Values=rivalsMaps,Default=1});
		local AutoLoadoutTab = MatchmakingTabbox:AddTab("auto loadout");
		AutoLoadoutTab:AddToggle("AutoLoadout", {Text="enable auto loadout",Default=false,Tooltip="Automatically picks your selected weapons during match loadout"});
		AutoLoadoutTab:AddDropdown("AutoLoadoutPrimary", {Text="primary",Values=primaryWeapons,Default=1});
		AutoLoadoutTab:AddDropdown("AutoLoadoutSecondary", {Text="secondary",Values=secondaryWeapons,Default=1});
		AutoLoadoutTab:AddDropdown("AutoLoadoutMelee", {Text="melee",Values=meleeWeapons,Default=1});
		AutoLoadoutTab:AddDropdown("AutoLoadoutUtility", {Text="utility",Values=utilityWeapons,Default=1});
		local IdentityTabbox = Tabs.Misc:AddLeftTabbox();
		local StatsSpoofTab = IdentityTabbox:AddTab("stats spoof");
		StatsSpoofTab:AddToggle("StreakSpoof", {Text="spoof win streak",Default=false});
		StatsSpoofTab:AddInput("StreakSpoofVal", {Text="win streak",Default="99",Numeric=true});
		StatsSpoofTab:AddToggle("LevelSpoof", {Text="spoof level",Default=false});
		StatsSpoofTab:AddInput("LevelSpoofVal", {Text="level",Default="100",Numeric=true});
		StatsSpoofTab:AddToggle("ELOSpoof", {Text="spoof elo",Default=false});
		StatsSpoofTab:AddInput("ELOSpoofVal", {Text="elo rating",Default="60000",Numeric=true});
		StatsSpoofTab:AddToggle("RankSpoof", {Text="spoof rank & icon",Default=false,Tooltip="Spoofs rank title & leaderstat icon in player list"});
		StatsSpoofTab:AddDropdown("RankSpoofVal", {Text="rank",Values={"Bronze","Silver","Gold","Diamond","Onyx","Nemesis","Arch Nemesis"},Default=7});
		StatsSpoofTab:AddToggle("StatusSpoof", {Text="spoof status",Default=false});
		StatsSpoofTab:AddDropdown("StatusSpoofVal", {Text="player status",Values={"Online","In Match","In Lobby","AFK","Do Not Disturb"},Default=1});
		local ProfileSpoofTab = IdentityTabbox:AddTab("profile spoof");
		ProfileSpoofTab:AddInput("ProfileSpoofUsername", {Text="target roblox username",Default="",Placeholder="Username to clone..."});
		ProfileSpoofTab:AddButton("Clone User & Appearance", function()
			if Misc.ApplyFullProfileSpoof then
				Misc.ApplyFullProfileSpoof();
			end
		end);
		ProfileSpoofTab:AddButton("Restore Original Profile", function()
			if Misc.RestoreOriginalProfile then
				Misc.RestoreOriginalProfile();
			end
		end);
		local DeviceSpoofTab = IdentityTabbox:AddTab("device spoof");
		DeviceSpoofTab:AddToggle("device_spoof", {Text="enable device spoof",Default=false});
		DeviceSpoofTab:AddDropdown("device_type", {Text="device type",Default=2,Values={"Mobile","Console","VR","PC"}});
		local CombatMiscGroup = Tabs.Misc:AddRightGroupbox("combat & survival");
		CombatMiscGroup:AddToggle("VoidSpamReload", {Text="void spam on reload",Default=false,Tooltip="Teleports player to void while reloading any weapon to dodge damage, then restores original position instantly"});
		CombatMiscGroup:AddSlider("VoidSpamDepth", {Text="void Y depth",Default=-5000,Min=-10000,Max=-1000,Rounding=0,Suffix=" studs",Compact=true});
		CombatMiscGroup:AddToggle("AutoMedkit", {Text="auto medkit (low hp)",Default=false,Tooltip="Automatically switches to Slot 4 Medkit and heals when HP falls below threshold, then switches back"}):AddKeyPicker("QuickMedkitKey", {Default="None",NoUI=true,Mode="Toggle",Text="Quick Medkit"});
		CombatMiscGroup:AddSlider("AutoMedkitHP", {Text="medkit hp threshold",Default=40,Min=15,Max=80,Rounding=0,Suffix="%",Compact=true});
		CombatMiscGroup:AddToggle("AntiFlashbang", {Text="anti flashbang",Default=false,Tooltip="100% blind immunity: cleans workspace effects, screen GUIs, and resets duration"});
		CombatMiscGroup:AddToggle("AntiTrip", {Text="anti subspace tripmine",Default=false,Tooltip="Safely detonates/disarms nearby enemy subspace tripmines without taking damage"});
		CombatMiscGroup:AddSlider("AntiTripDist", {Text="tripmine range",Default=35,Min=10,Max=70,Rounding=0,Suffix=" studs",Compact=true});
		CombatMiscGroup:AddToggle("AutoRespawn", {Text="fast respawn",Default=false,Tooltip="Bypasses death timer via Duels.RespawnNow to respawn instantly"});
		local UtilityGroup = Tabs.Misc:AddRightGroupbox("utility & arcade");
		UtilityGroup:AddToggle("GrabDrops", {Text="arcade grab drops",Default=false,Tooltip="Automatically collects all _drop items dropped in arcade & duel servers"});
		UtilityGroup:AddToggle("SoundSpammer", {Text="sound spammer",Default=false,Tooltip="Rapidly plays movement audio to distract and confuse enemies"});
		UtilityGroup:AddDropdown("SoundSpammerType", {Text="sound type",Values={"DoubleJump","Slide"},Default=1});
		UtilityGroup:AddSlider("SoundSpammerDelay", {Text="spam speed",Default=0.1,Min=0.05,Max=0.5,Rounding=2,Suffix="s",Compact=true});
		UtilityGroup:AddToggle("moddetector", {Text="mod / staff detector",Default=false,Tooltip="Alerts immediately if any moderator, developer, or staff member is in the server"});
		UtilityGroup:AddToggle("AntiAFK", {Text="anti afk (prevent kick)",Default=true,Tooltip="Bypasses the 20-minute idle kick timer"});
		UtilityGroup:AddToggle("handcaps", {Text="enable handicaps",Default=false});
		local AutoBanGroup = Tabs.Misc:AddRightGroupbox("auto ban - ranked");
		AutoBanGroup:AddToggle("AutoBanQueueEnable", {Text="enable auto ban",Default=false});
		AutoBanGroup:AddDropdown("first", {Text="weapon 1",Values=weaponList,Default=32});
		AutoBanGroup:AddInput("search1", {Text="search weapon 1",Placeholder="Search weapon...",ClearTextOnFocus=false});
		AutoBanGroup:AddDropdown("second", {Text="weapon 2",Values=weaponList,Default=30});
		AutoBanGroup:AddInput("search2", {Text="search weapon 2",Placeholder="Search weapon...",ClearTextOnFocus=false});
		local CosmeticsGroup = Tabs.Misc:AddRightGroupbox("cosmetics");
		CosmeticsGroup:AddToggle("AnySkinMode", {Text="any skin mode",Default=false,Tooltip="Enables weapon skin model overrides and cosmetic changer compatibility"});
		CosmeticsGroup:AddButton("Open Cosmetic Changer Menu", function()
			if Hub.OpenCosmeticChanger then
				Hub.OpenCosmeticChanger();
			end
		end);
		CosmeticsGroup:AddButton("Unlock All Client Cosmetics", function()
			if Misc.UnlockAllCosmeticsClient then
				Misc.UnlockAllCosmeticsClient();
			end
		end);
	end
	do
		local MenuGroup = Tabs["UI Settings"]:AddLeftGroupbox("Menu & Aesthetics");
		MenuGroup:AddButton("Unload Hub", function()
			PlayUiSound(6895079853);
			Library:Unload();
		end);
		MenuGroup:AddLabel("Menu bind"):AddKeyPicker("MenuKeybind", {Default="RightShift",NoUI=true,Text="Menu keybind"});
		Library.ToggleKeybind = Options.MenuKeybind;
		MenuGroup:AddToggle("KeybindList", {Text="Keybind List",Default=false,Tooltip="Displays floating HUD showing all active keybinds",Callback=function(v)
			if Library.KeybindFrame then
				Library.KeybindFrame.Visible = v;
			end
		end});
		local ServerGroup = Tabs["UI Settings"]:AddLeftGroupbox("server & connectivity");
		local function ServerHop(sortOrder, targetType)
			local placeId = game.PlaceId;
			local currentJobId = game.JobId;
			local success, result = pcall(function()
				local url = string.format("https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=100", tostring(placeId), sortOrder or "Desc");
				return HttpService:JSONDecode(game:HttpGet(url));
			end);
			if (not success or not result or not result.data) then
				Library:Notify("Failed to fetch server list, please try again later", 3);
				return;
			end
			local validServers = {};
			for _, s in ipairs(result.data) do
				if ((type(s) == "table") and (s.id ~= currentJobId) and ((s.maxPlayers or 0) > (s.playing or 0)) and ((s.playing or 0) > 0)) then
					table.insert(validServers, s);
				end
			end
			if (#validServers ~= 0) then
			else
				Library:Notify("No suitable server found!", 3);
				return;
			end
			if (targetType == "lowest") then
				table.sort(validServers, function(a, b)
					return a.playing < b.playing;
				end);
				local target = validServers[1];
				Library:Notify(string.format("Joining lowest player server (%d/%d players)...", target.playing, target.maxPlayers), 3);
				TeleportService:TeleportToPlaceInstance(placeId, target.id, Players.LocalPlayer);
			elseif (targetType == "biggest") then
				table.sort(validServers, function(a, b)
					return a.playing > b.playing;
				end);
				local target = validServers[1];
				Library:Notify(string.format("Joining largest server (%d/%d players)...", target.playing, target.maxPlayers), 3);
				TeleportService:TeleportToPlaceInstance(placeId, target.id, Players.LocalPlayer);
			else
				local target = validServers[math.random(1, #validServers)];
				Library:Notify(string.format("Randomly hopping server (%d/%d players)...", target.playing, target.maxPlayers), 3);
				TeleportService:TeleportToPlaceInstance(placeId, target.id, Players.LocalPlayer);
			end
		end
		ServerGroup:AddButton("Rejoin Server", function()
			Library:Notify("Reconnecting to current server...", 3);
			pcall(function()
				if (#Players:GetPlayers() <= 1) then
					Players.LocalPlayer:Kick("\n[m4rs] Rejoining...");
					task.wait();
					TeleportService:Teleport(game.PlaceId, Players.LocalPlayer);
				else
					TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer);
				end
			end);
		end);
		ServerGroup:AddButton("Server Hop (Random)", function()
			ServerHop("Desc", "random");
		end);
		ServerGroup:AddButton("Join Lowest Players Server", function()
			ServerHop("Asc", "lowest");
		end);
		ServerGroup:AddButton("Join Biggest Server", function()
			ServerHop("Desc", "biggest");
		end);
		ServerGroup:AddButton("Copy Join Script", function()
			local scriptCode = string.format("game:GetService('TeleportService'):TeleportToPlaceInstance(%d, '%s', game:GetService('Players').LocalPlayer)", game.PlaceId, game.JobId);
			local setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set);
			if setclip then
				setclip(scriptCode);
				Library:Notify("Server join script copied to clipboard!", 3);
			else
				Library:Notify("Copy failed: Clipboard API not supported", 3);
			end
		end);
		ServerGroup:AddButton("Copy Server Job ID", function()
			local setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set);
			if setclip then
				setclip(game.JobId);
				Library:Notify("Job ID copied to clipboard!", 3);
			else
				Library:Notify("Job ID: " .. tostring(game.JobId), 5);
			end
		end);
		local DiscordGroup = Tabs["UI Settings"]:AddRightGroupbox("community");
		DiscordGroup:AddButton({Text="Copy Discord Invite",Func=function()
			local invite = "https://discord.gg/m4rs";
			local setclip = setclipboard or toclipboard or (Clipboard and Clipboard.set);
			if setclip then
				setclip(invite);
				Library:Notify("Discord invite link copied to clipboard!", 3);
			else
				Library:Notify("Join Discord community: " .. invite, 5);
			end
		end});
		DiscordGroup:AddLabel("m4rs community");
	end
	ThemeManager:SetLibrary(Library);
	SaveManager:SetLibrary(Library);
	SaveManager:IgnoreThemeSettings();
	SaveManager:SetIgnoreIndexes({"MenuKeybind"});
	ThemeManager:SetFolder("m4rs");
	SaveManager:SetFolder("m4rs/rivals");
	SaveManager:BuildConfigSection(Tabs["UI Settings"]);
	ThemeManager:ApplyToTab(Tabs["UI Settings"]);
	local TargetHUD = {};
	do
		local CoreGui = game:GetService("CoreGui");
		local hudParent = CoreGui;
		pcall(function()
			if gethui then
				hudParent = gethui();
			elseif (syn and syn.protect_gui) then
				local sg = Instance.new("ScreenGui");
				syn.protect_gui(sg);
				hudParent = CoreGui;
			end
		end);
		if (not hudParent or not pcall(function()
			return hudParent.Name;
		end)) then
			hudParent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 3) or LocalPlayer:FindFirstChild("PlayerGui");
		end
		local oldTargetGui = hudParent:FindFirstChild("M4rsTargetHUD");
		if oldTargetGui then
			oldTargetGui:Destroy();
		end
		TargetHUD.Gui = Instance.new("ScreenGui");
		TargetHUD.Gui.Name = "M4rsTargetHUD";
		TargetHUD.Gui.ResetOnSpawn = false;
		TargetHUD.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		TargetHUD.Gui.Parent = hudParent;
		TargetHUD.Frame = Instance.new("Frame");
		TargetHUD.Frame.Name = "TargetCard";
		TargetHUD.Frame.Size = UDim2.new(0, 210, 0, 52);
		TargetHUD.Frame.Position = UDim2.new(0.5, -105, 0.68, 0);
		TargetHUD.Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 15);
		TargetHUD.Frame.BackgroundTransparency = 0.3;
		TargetHUD.Frame.BorderSizePixel = 0;
		TargetHUD.Frame.Visible = false;
		TargetHUD.Frame.Active = true;
		TargetHUD.Frame.Draggable = true;
		TargetHUD.Frame.Parent = TargetHUD.Gui;
		local targetCorner = Instance.new("UICorner");
		targetCorner.CornerRadius = UDim.new(0, 6);
		targetCorner.Parent = TargetHUD.Frame;
		TargetHUD.Stroke = Instance.new("UIStroke");
		TargetHUD.Stroke.Color = Library.AccentColor;
		TargetHUD.Stroke.Thickness = 1.2;
		TargetHUD.Stroke.Transparency = 0.3;
		TargetHUD.Stroke.Parent = TargetHUD.Frame;
		TargetHUD.Name = Instance.new("TextLabel");
		TargetHUD.Name.Name = "Name";
		TargetHUD.Name.Size = UDim2.new(1, -12, 0, 18);
		TargetHUD.Name.Position = UDim2.new(0, 8, 0, 4);
		TargetHUD.Name.BackgroundTransparency = 1;
		TargetHUD.Name.Font = Enum.Font.Code;
		TargetHUD.Name.Text = "Target: None";
		TargetHUD.Name.TextColor3 = Color3.fromRGB(255, 255, 255);
		TargetHUD.Name.TextSize = 12;
		TargetHUD.Name.TextXAlignment = Enum.TextXAlignment.Left;
		TargetHUD.Name.Parent = TargetHUD.Frame;
		TargetHUD.Dist = Instance.new("TextLabel");
		TargetHUD.Dist.Name = "Distance";
		TargetHUD.Dist.Size = UDim2.new(0, 80, 0, 18);
		TargetHUD.Dist.Position = UDim2.new(1, -88, 0, 4);
		TargetHUD.Dist.BackgroundTransparency = 1;
		TargetHUD.Dist.Font = Enum.Font.Code;
		TargetHUD.Dist.Text = "0m";
		TargetHUD.Dist.TextColor3 = Color3.fromRGB(180, 180, 190);
		TargetHUD.Dist.TextSize = 11;
		TargetHUD.Dist.TextXAlignment = Enum.TextXAlignment.Right;
		TargetHUD.Dist.Parent = TargetHUD.Frame;
		local healthBarBg = Instance.new("Frame");
		healthBarBg.Name = "HealthBg";
		healthBarBg.Size = UDim2.new(1, -16, 0, 8);
		healthBarBg.Position = UDim2.new(0, 8, 0, 26);
		healthBarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 30);
		healthBarBg.BorderSizePixel = 0;
		healthBarBg.Parent = TargetHUD.Frame;
		local healthBarCorner = Instance.new("UICorner");
		healthBarCorner.CornerRadius = UDim.new(0, 4);
		healthBarCorner.Parent = healthBarBg;
		TargetHUD.HealthBarFill = Instance.new("Frame");
		TargetHUD.HealthBarFill.Name = "HealthFill";
		TargetHUD.HealthBarFill.Size = UDim2.new(1, 0, 1, 0);
		TargetHUD.HealthBarFill.BackgroundColor3 = Color3.fromRGB(45, 255, 120);
		TargetHUD.HealthBarFill.BorderSizePixel = 0;
		TargetHUD.HealthBarFill.Parent = healthBarBg;
		local healthFillCorner = Instance.new("UICorner");
		healthFillCorner.CornerRadius = UDim.new(0, 4);
		healthFillCorner.Parent = TargetHUD.HealthBarFill;
		TargetHUD.HealthText = Instance.new("TextLabel");
		TargetHUD.HealthText.Name = "HealthText";
		TargetHUD.HealthText.Size = UDim2.new(1, -16, 0, 14);
		TargetHUD.HealthText.Position = UDim2.new(0, 8, 0, 36);
		TargetHUD.HealthText.BackgroundTransparency = 1;
		TargetHUD.HealthText.Font = Enum.Font.Code;
		TargetHUD.HealthText.Text = "100 / 100 HP (100%)";
		TargetHUD.HealthText.TextColor3 = Color3.fromRGB(220, 220, 230);
		TargetHUD.HealthText.TextSize = 10;
		TargetHUD.HealthText.TextXAlignment = Enum.TextXAlignment.Center;
		TargetHUD.HealthText.Parent = TargetHUD.Frame;
	end
	local Utility = nil;
	local EnumLibrary = nil;
	local localFighter = nil;
	local FighterController = nil;
	local SpectateController = nil;
	local CameraController = nil;
	local MechanicsController = nil;
	local GunModule = nil;
	local MeleeModule = nil;
	local GameplayUtility = nil;
	local deflecting = {};
	local undergroundSavedCF = nil;
	local function SafeRequire(obj)
		if (not obj or not obj:IsA("ModuleScript")) then
			return nil;
		end
		local ok, res = pcall(require, obj);
		return (ok and res) or nil;
	end
	local function LoadRivalsModules()
		pcall(function()
			local mods = ReplicatedStorage:WaitForChild("Modules", 6);
			if mods then
				Utility = SafeRequire(mods:FindFirstChild("Utility"));
				EnumLibrary = SafeRequire(mods:FindFirstChild("EnumLibrary"));
			end
		end);
		pcall(function()
			local ps = LocalPlayer:WaitForChild("PlayerScripts", 6);
			local ctrl = ps and ps:WaitForChild("Controllers", 6);
			if ctrl then
				FighterController = SafeRequire(ctrl:FindFirstChild("FighterController"));
				if FighterController then
					localFighter = FighterController.LocalFighter;
				end
				SpectateController = SafeRequire(ctrl:FindFirstChild("SpectateController"));
				CameraController = SafeRequire(ctrl:FindFirstChild("CameraController"));
				MechanicsController = SafeRequire(ctrl:FindFirstChild("MechanicsController"));
			end
			local mods = ps and ps:WaitForChild("Modules", 6);
			local it = mods and mods:WaitForChild("ItemTypes", 6);
			if it then
				GunModule = SafeRequire(it:FindFirstChild("Gun"));
				MeleeModule = SafeRequire(it:FindFirstChild("Melee"));
			end
			local rsMods = ReplicatedStorage:FindFirstChild("Modules");
			if rsMods then
				GameplayUtility = SafeRequire(rsMods:FindFirstChild("GameplayUtility"));
			end
		end);
		pcall(function()
			if (CameraController and CameraController.Update and not CameraController._M4rsHooked) then
				CameraController._M4rsHooked = true;
				local oldCamUpdate = CameraController.Update;
				CameraController.Update = function(self, ...)
					if (Toggles.AntiAimUnderground and Toggles.AntiAimUnderground.Value and undergroundSavedCF and LocalPlayer.Character) then
						local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
						if hrp then
							hrp.CFrame = undergroundSavedCF;
						end
					end
					return oldCamUpdate(self, ...);
				end;
			end
		end);
	end
	task.spawn(LoadRivalsModules);
	Players.PlayerRemoving:Connect(function(player)
		deflecting[player] = nil;
	end);
	local function updateDeflection()
		if (not FighterController or not FighterController.Objects) then
			return;
		end
		for _, fighterObj in pairs(FighterController.Objects) do
			local player = fighterObj.Player;
			if not player then
				continue;
			end
			if (not fighterObj.Entity or not fighterObj.Entity:IsAlive() or fighterObj:Get("IsSpectating")) then
				deflecting[player] = false;
				continue;
			end
			local equipped = fighterObj.EquippedItem;
			local isKatana = equipped and equipped.ViewModel and (equipped.ViewModel.Name == "Katana");
			local isDeflecting = false;
			if isKatana then
				isDeflecting = (equipped._attack_cooldown and (equipped._attack_cooldown > tick())) or false;
			end
			deflecting[player] = isDeflecting;
		end
	end
	local function hasKnifeViewModel(targetPlayer)
		if not targetPlayer then
			return false;
		end
		local viewModels = workspace:FindFirstChild("ViewModels");
		if not viewModels then
			return false;
		end
		local targetName = targetPlayer.Name;
		for _, model in ipairs(viewModels:GetChildren()) do
			if (model:IsA("Model") and string.find(model.Name, targetName, 1, true) and string.find(model.Name, "Knife", 1, true)) then
				return true;
			end
		end
		return false;
	end
	local KatanaUsers = {};
	local function HookCombatModules()
		task.spawn(function()
			for attempt = 1, 20 do
				if not (GunModule and MeleeModule and GameplayUtility) then
					LoadRivalsModules();
					task.wait(0.5);
				else
					break;
				end
			end
			if (GunModule and GunModule.StartShooting and not GunModule._M4rsHooked) then
				GunModule._M4rsHooked = true;
				local oldGunStart = GunModule.StartShooting;
				GunModule.StartShooting = function(self, p1, p2)
					local oldCd;
					if (Toggles.NoCooldown and Toggles.NoCooldown.Value) then
						oldCd = self.Info and self.Info.ShootCooldown;
						if self.Info then
							self.Info.ShootCooldown = 0;
						end
					end
					local res = {oldGunStart(self, p1, p2)};
					if (oldCd and self.Info) then
						self.Info.ShootCooldown = oldCd;
					end
					if (Toggles.NoSpread and Toggles.NoSpread.Value and typeof(res[3]) == "table") then
						res[4] = true;
					end
					return unpack(res);
				end;
				local oldRecoil = GunModule._Recoil;
				if oldRecoil then
					GunModule._Recoil = function(self, mult)
						if (Toggles.NoRecoil and Toggles.NoRecoil.Value) then
							return;
						end
						return oldRecoil(self, mult);
					end;
				end
			end
			if (MeleeModule and MeleeModule.StartShooting and not MeleeModule._M4rsHooked) then
				MeleeModule._M4rsHooked = true;
				local oldMeleeStart = MeleeModule.StartShooting;
				MeleeModule.StartShooting = function(self, p1, p2)
					local oldCd;
					if (Toggles.RapidAttack and Toggles.RapidAttack.Value) then
						oldCd = self.Info and self.Info.AttackCooldown;
						if self.Info then
							self.Info.AttackCooldown = 0;
						end
					end
					local res = {oldMeleeStart(self, p1, p2)};
					if (oldCd and self.Info) then
						self.Info.AttackCooldown = oldCd;
					end
					return unpack(res);
				end;
			end
			if (GameplayUtility and GameplayUtility.GetSpread and not GameplayUtility._M4rsHooked) then
				GameplayUtility._M4rsHooked = true;
				local oldGetSpread = GameplayUtility.GetSpread;
				GameplayUtility.GetSpread = function(...)
					if ((Toggles.NoSpread and Toggles.NoSpread.Value) or (Toggles.MaxAccuracy and Toggles.MaxAccuracy.Value)) then
						return CFrame.new();
					end
					return oldGetSpread(...);
				end;
			end
			pcall(function()
				local ps = LocalPlayer:FindFirstChild("PlayerScripts");
				local mods = ps and ps:FindFirstChild("Modules");
				local items = mods and mods:FindFirstChild("Items");
				local katana = items and items:FindFirstChild("Katana", true);
				if (katana and katana:IsA("ModuleScript")) then
					local kMod = SafeRequire(katana);
					if (kMod and kMod.StartAiming and not kMod._M4rsHooked) then
						kMod._M4rsHooked = true;
						local oldAim = kMod.StartAiming;
						kMod.StartAiming = function(self, force)
							local fighter = self.ClientFighter;
							local plr = fighter and fighter.Player;
							if plr then
								KatanaUsers[plr] = true;
								local dur = (self.Info and self.Info.DeflectDuration) or 0.6;
								task.delay(dur, function()
									KatanaUsers[plr] = nil;
								end);
							end
							return oldAim(self, force);
						end;
					end
				end
			end);
		end);
	end
	HookCombatModules();
	local function IsInMatch()
		if (not localFighter or not localFighter.EquippedItem) then
			pcall(function()
				local ps = LocalPlayer:FindFirstChild("PlayerScripts");
				local ctrl = ps and ps:FindFirstChild("Controllers");
				local fm = ctrl and ctrl:FindFirstChild("FighterController");
				if fm then
					local fc = SafeRequire(fm);
					localFighter = fc and fc.LocalFighter;
				end
			end);
		end
		if localFighter then
			local ok, inDuel = pcall(function()
				return localFighter:Get("IsInDuel");
			end);
			if (ok and (inDuel ~= nil)) then
				return inDuel == true;
			end
		end
		local lp = LocalPlayer;
		if lp then
			for _, attr in ipairs({"IsInDuel","InDuel","InMatch","IsInMatch","InGame","InRound","Fighting"}) do
				local val = lp:GetAttribute(attr);
				if ((val == true) or (val == 1) or (val == "true")) then
					return true;
				end
				if lp.Character then
					local cval = lp.Character:GetAttribute(attr);
					if ((cval == true) or (cval == 1) or (cval == "true")) then
						return true;
					end
				end
			end
			local live = workspace:FindFirstChild("Live");
			if (live and lp.Character and ((lp.Character.Parent == live) or lp.Character:IsDescendantOf(live))) then
				return true;
			end
		end
		return false;
	end
	local function isEnemy(player)
		if (not player or (player == LocalPlayer)) then
			return false;
		end
		if ((Toggles.TeamCheck and not Toggles.TeamCheck.Value) or (getgenv().Config and (getgenv().Config.TeamCheck == false))) then
			return true;
		end
		local duel = SpectateController and SpectateController.CurrentDuelSubject;
		local localDueler = duel and duel:GetDueler(LocalPlayer);
		local localTeam = (localDueler and localDueler:Get("TeamID")) or nil;
		if (localTeam and duel and duel.Duelers) then
			for _, dueler in pairs(duel.Duelers) do
				if (dueler.Player ~= player) then
				else
					local team = dueler:Get("TeamID");
					return team ~= localTeam;
				end
			end
		end
		local pTeam = player:GetAttribute("TeamID");
		local lTeam = LocalPlayer:GetAttribute("TeamID");
		if (pTeam and lTeam) then
			return pTeam ~= lTeam;
		end
		if ((LocalPlayer.Team ~= nil) and (player.Team ~= nil)) then
			return LocalPlayer.Team ~= player.Team;
		end
		return true;
	end
	local function IsTeammate(player)
		return not isEnemy(player);
	end
	local function GetPlayerWeapon(player)
		if not player then
			return "None";
		end
		local vm = workspace:FindFirstChild("ViewModels");
		if vm then
			local pName = player.Name;
			for _, child in ipairs(vm:GetChildren()) do
				local parts = {};
				for part in child.Name:gmatch("[^-]+") do
					table.insert(parts, part:match("^%s*(.-)%s*$"));
				end
				if ((#parts >= 2) and (parts[1] == pName)) then
					return parts[2];
				end
			end
		end
		local char = player.Character;
		if char then
			local tool = char:FindFirstChildOfClass("Tool");
			if tool then
				return tool.Name;
			end
		end
		return "None";
	end
	local function GetMuzzlePosition()
		local vm = workspace:FindFirstChild("ViewModels");
		if vm then
			local fp = vm:FindFirstChild("FirstPerson");
			if fp then
				for _, model in ipairs(fp:GetChildren()) do
					if model:IsA("Model") then
						local muzzle = model:FindFirstChild("Muzzle") or model:FindFirstChild("MuzzleFlash") or model:FindFirstChild("Barrel") or model:FindFirstChild("GunTip") or model:FindFirstChild("Flash") or model:FindFirstChild("Tip");
						if muzzle then
							if muzzle:IsA("Attachment") then
								return muzzle.WorldPosition;
							end
							if muzzle:IsA("BasePart") then
								return muzzle.Position;
							end
						end
						local iv = model:FindFirstChild("ItemVisual");
						local b = iv and iv:FindFirstChild("Body");
						local bp = b and b:FindFirstChild("BodyPrimary");
						local m = bp and bp:FindFirstChild("_muzzle");
						if (m and m:IsA("Attachment")) then
							return m.WorldPosition;
						end
					end
				end
			end
		end
		local cam = workspace.CurrentCamera;
		return (cam and (cam.CFrame.Position + (cam.CFrame.LookVector * 3))) or Vector3.zero;
	end
	local function IsVisible(targetPart, origin)
		local cam = workspace.CurrentCamera;
		local fromPos = origin or (cam and cam.CFrame.Position);
		if (not fromPos or not targetPart) then
			return true;
		end
		local rayParams = RaycastParams.new();
		rayParams.FilterType = Enum.RaycastFilterType.Blacklist;
		rayParams.FilterDescendantsInstances = {LocalPlayer.Character,targetPart.Parent,workspace:FindFirstChild("ViewModels")};
		local result = workspace:Raycast(fromPos, targetPart.Position - fromPos, rayParams);
		return result == nil;
	end
	local function GetCharacterHitPart(char, partName, mousePos)
		if not char then
			return nil;
		end
		local hrp = char:FindFirstChild("HumanoidRootPart");
		if (partName == "Random") then
			local parts = {};
			for _, p in ipairs(char:GetChildren()) do
				if (p:IsA("BasePart") and (p.Name ~= "HumanoidRootPart")) then
					table.insert(parts, p);
				end
			end
			if (#parts > 0) then
				return parts[math.random(1, #parts)];
			end
			return char:FindFirstChild("Head") or hrp;
		elseif (partName == "Closest") then
			local cam = workspace.CurrentCamera;
			local best, bestD = nil, math.huge;
			local mPos = mousePos or UserInputService:GetMouseLocation();
			for _, p in ipairs(char:GetChildren()) do
				if (p:IsA("BasePart") and (p.Name ~= "HumanoidRootPart")) then
					if cam then
						local sPos, onScreen = cam:WorldToViewportPoint(p.Position);
						if onScreen then
							local d = (Vector2.new(sPos.X, sPos.Y) - mPos).Magnitude;
							if (d >= bestD) then
							else
								bestD = d;
								best = p;
							end
						end
					end
				end
			end
			return best or char:FindFirstChild("Head") or hrp;
		elseif (partName == "Torso") then
			return char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("LowerTorso") or hrp;
		elseif ((partName == "UpperTorso") or (partName == "LowerTorso")) then
			return char:FindFirstChild(partName) or char:FindFirstChild("Torso") or hrp;
		elseif (partName == "Head") then
			return char:FindFirstChild("HitboxHead") or char:FindFirstChild("Head") or hrp;
		elseif (partName == "Left Arm") then
			return char:FindFirstChild("Left Arm") or char:FindFirstChild("LeftUpperArm") or char:FindFirstChild("LeftHand") or hrp;
		elseif (partName == "Right Arm") then
			return char:FindFirstChild("Right Arm") or char:FindFirstChild("RightUpperArm") or char:FindFirstChild("RightHand") or hrp;
		elseif (partName == "Left Leg") then
			return char:FindFirstChild("Left Leg") or char:FindFirstChild("LeftUpperLeg") or char:FindFirstChild("LeftFoot") or hrp;
		elseif (partName == "Right Leg") then
			return char:FindFirstChild("Right Leg") or char:FindFirstChild("RightUpperLeg") or char:FindFirstChild("RightFoot") or hrp;
		else
			return char:FindFirstChild(partName) or char:FindFirstChild("Head") or hrp;
		end
	end
	local function GetClosestTarget(fovRadius, hitPartName, checkWall, checkTeam)
		if not IsInMatch() then
			return nil, nil;
		end
		local bestTarget = nil;
		local bestPart = nil;
		local bestScore = math.huge;
		local cam = workspace.CurrentCamera;
		if not cam then
			return nil, nil;
		end
		local mousePos = UserInputService:GetMouseLocation();
		local priority = (Options.TargetPriority and Options.TargetPriority.Value) or "Closest (FOV)";
		local maxFov = fovRadius or 500;
		for _, player in ipairs(Players:GetPlayers()) do
			if ((player ~= LocalPlayer) and not IsTeammate(player)) then
				local char = player.Character;
				if char then
					local hum = char:FindFirstChildOfClass("Humanoid");
					local hrp = char:FindFirstChild("HumanoidRootPart");
					local hasForcefield = char:FindFirstChildOfClass("ForceField") ~= nil;
					local spawnShield = char:FindFirstChild("SpawnShield") or (hrp and hrp:FindFirstChild("Shield"));
					if (hum and (hum.Health > 0) and not hasForcefield and not spawnShield and hrp) then
						local targetPart = GetCharacterHitPart(char, hitPartName, mousePos);
						if targetPart then
							local screenPos, onScreen = cam:WorldToViewportPoint(targetPart.Position);
							if (onScreen and (screenPos.Z > 0)) then
								local fovDist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude;
								if (fovDist > maxFov) then
								elseif (not checkWall or IsVisible(targetPart)) then
									local score = fovDist;
									if (priority == "Lowest HP") then
										score = hum.Health;
									elseif (priority ~= "Distance") then
									else
										score = (targetPart.Position - cam.CFrame.Position).Magnitude;
									end
									if (score >= bestScore) then
									else
										bestScore = score;
										bestTarget = player;
										bestPart = targetPart;
									end
								end
							end
						end
					end
				end
			end
		end
		return bestTarget, bestPart;
	end
	_G.StopBackshoot = function()
	end;
	local SpawnBulletTracer;
	do
		local texture_id = {Line="rbxassetid://13837943016",Laser="rbxassetid://8934336043",Lightning="rbxassetid://7205165972",Heartrate="rbxassetid://8934360341",Chain="rbxassetid://8934346850",Glitch="rbxassetid://8934354397",Swirl="rbxassetid://8934371408",Neon="rbxassetid://8934367352",Plasma="rbxassetid://8934369282",Cross="rbxassetid://8934351661",Dots="rbxassetid://8934353086",Arrows="rbxassetid://8934338426",Wave="rbxassetid://8934372996",Stripes="rbxassetid://8934370332",ZigZag="rbxassetid://8934374355",Barcode="rbxassetid://8934340578",DNA="rbxassetid://8934352516",Hexagon="rbxassetid://8934355288",Pulse="rbxassetid://8934368383",Spiral="rbxassetid://8934369796",Vortex="rbxassetid://8934372337",Circuit="rbxassetid://8934347781",Grid="rbxassetid://8934354832",Matrix="rbxassetid://8934366579",Particles="rbxassetid://8934367862",Sakura="rbxassetid://446111271",Flame="rbxassetid://1327175515",Electric="rbxassetid://7205165972",Stardust="rbxassetid://8934353086",Rays="rbxassetid://8934338426",Rings="rbxassetid://8934369796",Segments="rbxassetid://8934370332",Flow="rbxassetid://8934372996",Binary="rbxassetid://8934366579",Cyber="rbxassetid://8934347781",Nebula="rbxassetid://8934367352",Spectrum="rbxassetid://8934368383",Energy="rbxassetid://8934369282",Constellation="rbxassetid://8934355288",Runes="rbxassetid://8934354397",Vapor="rbxassetid://13837943016",Hyper="rbxassetid://8934360341",Solid=""};
		local active_tracers = 0;
		local MAX_ACTIVE_TRACERS = 48;
		function create_beam(from, to, lerp_override)
			if not (Toggles.TracerEnabled and Toggles.TracerEnabled.Value) then
				return;
			end
			if (active_tracers < MAX_ACTIVE_TRACERS) then
			else
				return;
			end
			active_tracers = active_tracers + 1;
			local total_time = 0;
			local fade_duration = (Options.TracerDuration and Options.TracerDuration.Value) or 2.5;
			local direction = to - from;
			local total_distance = direction.Magnitude;
			local unit = direction.Unit;
			local lerp_speed = lerp_override or (Options.TracerFade and Options.TracerFade.Value) or 0.5;
			if (lerp_speed > 0) then
			else
				lerp_speed = 0.05;
			end
			local colorStart = (Options.TracerColor and Options.TracerColor.Value) or Color3.fromRGB(255, 255, 255);
			local colorEnd = (Options.TracerColorEnd and Options.TracerColorEnd.Value) or colorStart;
			local selectedTex = (Options.TracerStyle and Options.TracerStyle.Value) or "Line";
			local texSpeed = (Options.TracerSpeed and Options.TracerSpeed.Value) or 1;
			local origin_hold = Instance.new("Part");
			origin_hold.Anchored = true;
			origin_hold.CanCollide = false;
			origin_hold.CanTouch = false;
			origin_hold.CanQuery = false;
			origin_hold.Transparency = 1;
			origin_hold.CFrame = CFrame.new(from);
			origin_hold.Parent = workspace;
			local hit_hold = Instance.new("Part");
			hit_hold.Anchored = true;
			hit_hold.CanCollide = false;
			hit_hold.CanTouch = false;
			hit_hold.CanQuery = false;
			hit_hold.Transparency = 1;
			hit_hold.CFrame = CFrame.new(from);
			hit_hold.Parent = workspace;
			local origin_att = Instance.new("Attachment");
			origin_att.Parent = origin_hold;
			local hit_att = Instance.new("Attachment");
			hit_att.Parent = hit_hold;
			local tracer = Instance.new("Beam");
			tracer.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, colorStart),ColorSequenceKeypoint.new(0.5, colorEnd),ColorSequenceKeypoint.new(1, colorStart)});
			tracer.Brightness = 1.5;
			tracer.LightEmission = 1;
			tracer.LightInfluence = 0;
			tracer.TextureSpeed = texSpeed;
			tracer.TextureLength = 3;
			tracer.FaceCamera = true;
			tracer.Texture = texture_id[selectedTex] or "";
			tracer.TextureMode = Enum.TextureMode.Wrap;
			tracer.Attachment0 = origin_att;
			tracer.Attachment1 = hit_att;
			local base_width0 = ((Options.TracerSize and Options.TracerSize.Value) or 1) * 0.1;
			local base_width1 = ((Options.TracerSize1 and Options.TracerSize1.Value) or 1) * 0.1;
			local spring_expand = (Toggles.TracerSpringExpand and Toggles.TracerSpringExpand.Value) or false;
			local spring_speed = (Options.TracerExpandSpeed and Options.TracerExpandSpeed.Value) or 14;
			local spring_damper = (Options.TracerExpandDamper and Options.TracerExpandDamper.Value) or 0.55;
			local spring_pos = (spring_expand and 0) or 1;
			local spring_vel = 0;
			tracer.Width0 = base_width0 * spring_pos;
			tracer.Width1 = base_width1 * spring_pos;
			tracer.Enabled = true;
			tracer.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.1),NumberSequenceKeypoint.new(0.5, 0),NumberSequenceKeypoint.new(1, 0.3)});
			pcall(function()
				if not (Toggles.TracerCurveAround and Toggles.TracerCurveAround.Value) then
					return;
				end
				local params = RaycastParams.new();
				params.FilterType = Enum.RaycastFilterType.Exclude;
				params.FilterDescendantsInstances = {LocalPlayer.Character,origin_hold,hit_hold};
				local blocked = workspace:Raycast(from, to - from, params);
				if not (blocked and ((blocked.Position - from).Magnitude < (total_distance - 2))) then
					return;
				end
				local maxH = (Options.TracerCurveHeight and Options.TracerCurveHeight.Value) or 14;
				local right = unit:Cross(Vector3.yAxis);
				right = ((right.Magnitude > 0.01) and right.Unit) or Vector3.xAxis;
				local upv = right:Cross(unit).Unit;
				if (upv.Y >= 0) then
				else
					upv = -upv;
				end
				local mid = (from + to) * 0.5;
				local function pathClear(apex)
					local a = workspace:Raycast(from, apex - from, params);
					if (a and ((a.Position - from).Magnitude < ((apex - from).Magnitude - 1))) then
						return false;
					end
					local b = workspace:Raycast(apex, to - apex, params);
					if (b and ((b.Position - apex).Magnitude < ((to - apex).Magnitude - 1))) then
						return false;
					end
					return true;
				end
				local dirs = {upv,(upv + (right * 0.6)).Unit,(upv - (right * 0.6)).Unit,right,-right};
				local heights = {(maxH * 0.7),maxH,(maxH * 1.5)};
				local bestDir, bestH;
				for _, d in ipairs(dirs) do
					for _, h in ipairs(heights) do
						if pathClear(mid + (d * h)) then
							bestDir, bestH = d, h;
							break;
						end
					end
					if bestDir then
						break;
					end
				end
				if not bestDir then
					bestDir = upv;
					bestH = math.min(maxH * 1.5, total_distance * 0.4);
				end
				local ref = ((math.abs(bestDir.Y) < 0.99) and Vector3.yAxis) or Vector3.xAxis;
				local u0 = bestDir:Cross(ref).Unit;
				local u1 = -bestDir:Cross(ref).Unit;
				origin_att.CFrame = CFrame.fromMatrix(Vector3.zero, bestDir, u0);
				hit_att.CFrame = CFrame.fromMatrix(Vector3.zero, -bestDir, u1);
				tracer.CurveSize0 = bestH;
				tracer.CurveSize1 = bestH;
			end);
			tracer.Parent = workspace;
			local wallLine;
			if (Toggles.TracerThroughWalls and Toggles.TracerThroughWalls.Value and Drawing and Drawing.new) then
				pcall(function()
					wallLine = Drawing.new("Line");
					wallLine.Thickness = math.max(base_width0 * 20, 1.5);
					wallLine.Color = colorStart;
					wallLine.Transparency = 1;
					wallLine.Visible = false;
				end);
			end
			local elapsed = 0;
			local conn;
			conn = RunService.Heartbeat:Connect(function(dt)
				total_time = total_time + dt;
				elapsed = elapsed + dt;
				local lerp_alpha = elapsed / lerp_speed;
				if (lerp_alpha < 1) then
				else
					lerp_alpha = 1;
				end
				local traveled = total_distance * lerp_alpha;
				if (traveled > total_distance) then
					traveled = total_distance;
				end
				hit_hold.CFrame = CFrame.new(from + (unit * traveled));
				if wallLine then
					local cam = workspace.CurrentCamera;
					local a, onA = cam:WorldToViewportPoint(from);
					local b, onB = cam:WorldToViewportPoint(from + (unit * traveled));
					if ((a.Z > 0) and (b.Z > 0)) then
						wallLine.From = Vector2.new(a.X, a.Y);
						wallLine.To = Vector2.new(b.X, b.Y);
						wallLine.Color = colorStart;
						wallLine.Visible = true;
					else
						wallLine.Visible = false;
					end
				end
				if spring_expand then
					local accel = ((1 - spring_pos) * spring_speed * spring_speed) - (2 * spring_damper * spring_speed * spring_vel);
					spring_vel = spring_vel + (accel * dt);
					spring_pos = spring_pos + (spring_vel * dt);
					tracer.Width0 = base_width0 * spring_pos;
					tracer.Width1 = base_width1 * spring_pos;
				end
				local alpha = math.clamp(total_time / fade_duration, 0, 1);
				tracer.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, math.clamp(0.1 + (alpha * 0.9), 0, 1)),NumberSequenceKeypoint.new(0.5, alpha),NumberSequenceKeypoint.new(1, math.clamp(0.3 + (alpha * 0.7), 0, 1))});
				if wallLine then
					wallLine.Transparency = math.clamp(1 - alpha, 0, 1);
				end
			end);
			task.delay(fade_duration, function()
				if conn then
					conn:Disconnect();
				end
				if wallLine then
					pcall(function()
						wallLine:Remove();
					end);
				end
				pcall(function()
					tracer:Destroy();
				end);
				pcall(function()
					origin_hold:Destroy();
				end);
				pcall(function()
					hit_hold:Destroy();
				end);
				active_tracers = active_tracers - 1;
				if (active_tracers >= 0) then
				else
					active_tracers = 0;
				end
			end);
		end
		SpawnBulletTracer = create_beam;
		Hub.SpawnBulletTracer = create_beam;
	end
	local function getClosestTarget()
		local char = LocalPlayer.Character;
		if not char then
			return nil, nil, nil;
		end
		local myRoot = char:FindFirstChild("HumanoidRootPart");
		if not myRoot then
			return nil, nil, nil;
		end
		local cP, cR, cH;
		local cD = (getgenv().Config and getgenv().Config.MaxDistance) or 500;
		local hitPartName = (Options.HitPartDropdown and Options.HitPartDropdown.Value) or (getgenv().Config and getgenv().Config.HitPart) or "Head";
		local checkWall = Toggles.SilentWallCheck and Toggles.SilentWallCheck.Value and not (Toggles.TargetOn and Toggles.TargetOn.Value);
		for _, p in ipairs(Players:GetPlayers()) do
			if not isEnemy(p) then
				continue;
			end
			local ch = p.Character;
			if not ch then
				continue;
			end
			local r = ch:FindFirstChild("HumanoidRootPart");
			local hitPart = ch:FindFirstChild(hitPartName) or ch:FindFirstChild("Head") or r;
			local hum = ch:FindFirstChildWhichIsA("Humanoid");
			if not (r and hitPart and hum and (hum.Health > 0)) then
				continue;
			end
			if (checkWall and not IsVisible(hitPart, myRoot.Position)) then
				continue;
			end
			local d = (myRoot.Position - r.Position).Magnitude;
			if (d >= cD) then
			else
				cD, cP, cR, cH = d, p, r, hitPart;
			end
		end
		return cP, cR, cH;
	end
	---------------------------------------------------------
	-- HARION VOID SPAM / CSYNC SYSTEM (void spam的void是用他的)
	---------------------------------------------------------
	local function voidRand()
		local n = math.random(-2147483646, 2147483646);
		repeat
			n = math.random(-2147483646, 2147483646);
		until n < -1147483646 or n > 1147483646;
		return n;
	end

	local function voidRandCF()
		return CFrame.new(voidRand(), voidRand(), voidRand()) * CFrame.Angles(math.pi, math.pi, math.pi);
	end

	local voidState = {
		active = false,
		csyncCF = nil,
		csyncLV = nil,
		csyncAV = nil,
		csyncLocalCF = nil,
		csyncLocalLV = nil,
		csyncLocalAV = nil,
		csyncWroteFake = false,
		csyncHbConn = nil,
	};

	local function restoreLocalRoot(root)
		if not root or not voidState.csyncLocalCF then return false end
		local liveVelocity = root.AssemblyLinearVelocity;
		root.CFrame = voidState.csyncLocalCF;
		if voidState.csyncLocalLV then
			root.AssemblyLinearVelocity = Vector3.new(voidState.csyncLocalLV.X, liveVelocity.Y, voidState.csyncLocalLV.Z);
		end
		if voidState.csyncLocalAV then
			root.AssemblyAngularVelocity = voidState.csyncLocalAV;
		end
		return true;
	end

	local function setVoidCsync(cf, lv, av)
		voidState.csyncCF = cf;
		voidState.csyncLV = lv or Vector3.zero;
		voidState.csyncAV = av or Vector3.zero;
	end

	local function enterVoidState()
		setVoidCsync(voidRandCF(), Vector3.zero, Vector3.zero);
	end

	local function startVoidCsync()
		if voidState.csyncHbConn then return end
		voidState.active = true;
		enterVoidState();
		voidState.csyncHbConn = RunService.Heartbeat:Connect(function()
			if not (Toggles.VoidSpam and Toggles.VoidSpam.Value) or not (Toggles.TargetOn and Toggles.TargetOn.Value) then
				return;
			end
			local char = LocalPlayer.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");
			if not root then return end
			if voidState.csyncWroteFake and voidState.csyncLocalCF then
				restoreLocalRoot(root);
			end
			voidState.csyncLocalCF = root.CFrame;
			voidState.csyncLocalLV = root.AssemblyLinearVelocity;
			voidState.csyncLocalAV = root.AssemblyAngularVelocity;
			if voidState.csyncCF then
				root.CFrame = voidState.csyncCF;
				local fakeVelocity = voidState.csyncLV or voidState.csyncLocalLV or root.AssemblyLinearVelocity;
				local localVelocity = voidState.csyncLocalLV or root.AssemblyLinearVelocity;
				root.AssemblyLinearVelocity = Vector3.new(fakeVelocity.X, localVelocity.Y, fakeVelocity.Z);
				root.AssemblyAngularVelocity = voidState.csyncAV or voidState.csyncLocalAV or root.AssemblyAngularVelocity;
				voidState.csyncWroteFake = true;
			else
				voidState.csyncWroteFake = false;
			end
		end);
		pcall(function()
			RunService:BindToRenderStep("M4rs_RagebotVoidCsync", Enum.RenderPriority.Camera.Value - 1, function()
				local char = LocalPlayer.Character;
				local root = char and char:FindFirstChild("HumanoidRootPart");
				if not root or not voidState.csyncLocalCF then return end
				if voidState.csyncWroteFake and restoreLocalRoot(root) then
					voidState.csyncWroteFake = false;
				end
			end);
		end);
	end

	local function stopVoidCsync()
		voidState.active = false;
		if voidState.csyncHbConn then
			voidState.csyncHbConn:Disconnect();
			voidState.csyncHbConn = nil;
		end
		pcall(function()
			RunService:UnbindFromRenderStep("M4rs_RagebotVoidCsync");
		end);
		local char = LocalPlayer.Character;
		local root = char and char:FindFirstChild("HumanoidRootPart");
		if root then
			restoreLocalRoot(root);
		end
		voidState.csyncCF = nil;
		voidState.csyncLocalCF = nil;
		voidState.csyncLocalLV = nil;
		voidState.csyncLocalAV = nil;
		voidState.csyncWroteFake = false;
	end
	_G.__M4rsStopVoidCsync = stopVoidCsync;

	---------------------------------------------------------
	-- HARION SILENT AIM LOGIC (把slient aim的邏輯改成那個txt檔案)
	---------------------------------------------------------
	_G.LionSilentDeflecting = _G.LionSilentDeflecting or {};
	local function installSilentKatanaTracker()
		local ok, res = pcall(function()
			local items = LocalPlayer:FindFirstChild("PlayerScripts");
			items = items and items:FindFirstChild("Modules");
			items = items and items:FindFirstChild("Items");
			local katanaScript = items and items:FindFirstChild("Katana");
			if not katanaScript then return false end
			local okRequire, katana = pcall(require, katanaScript);
			if not okRequire or type(katana) ~= "table" then return false end
			local class = (type(rawget(katana, "ReplicateFromServer")) == "function" and katana) or getmetatable(katana);
			if type(class) ~= "table" or type(rawget(class, "ReplicateFromServer")) ~= "function" then return false end
			if rawget(class, "__M4rsSilentKatanaHook") then return true end
			class.__M4rsSilentKatanaHook = true;
			local oldReplicate = class.ReplicateFromServer;
			class.ReplicateFromServer = function(self, action, ...)
				local actionName = tostring(action):lower();
				if actionName:find("deflect", 1, true) or actionName == "startaiming" or actionName == "startblocking" then
					local fighter = self and (rawget(self, "ClientFighter") or self.ClientFighter);
					local player = fighter and fighter.Player;
					if player and player ~= LocalPlayer then
						local duration = 1;
						pcall(function()
							duration = (self.Info and self.Info.DeflectDuration) or duration;
						end);
						_G.LionSilentDeflecting[player.UserId] = tick() + duration + 0.12;
					end
				end
				return oldReplicate(self, action, ...);
			end;
			return true;
		end);
		return ok and res;
	end
	task.defer(installSilentKatanaTracker);

	local function shouldBlockShotForKatana(targetChar)
		if not targetChar then return false end
		local player = Players:GetPlayerFromCharacter(targetChar);
		local expires = player and _G.LionSilentDeflecting[player.UserId];
		if expires and expires > tick() then
			return true;
		end
		if player and expires then
			_G.LionSilentDeflecting[player.UserId] = nil;
		end
		return false;
	end

	local function isProtectedTarget(targetChar)
		if not targetChar then return true end
		if targetChar:FindFirstChild("InvincibilityParticles", true) then return true end
		local root = targetChar:FindFirstChild("HumanoidRootPart");
		if not root then return true end
		for _, obj in ipairs(root:GetChildren()) do
			if obj:IsA("Attachment") and obj.Name == "Attachment" then
				return true;
			end
		end
		return false;
	end

	local function getTargetWeapon(targetChar)
		local player = Players:GetPlayerFromCharacter(targetChar);
		if not player then return "" end
		for _, object in ipairs(targetChar:GetDescendants()) do
			local lower = object.Name:lower();
			if lower:find("riot", 1, true) or lower:find("shield", 1, true) then
				return "riot shield";
			elseif lower:find("katana", 1, true) then
				return "katana";
			end
		end
		local viewModels = workspace:FindFirstChild("ViewModels");
		if viewModels then
			for _, model in ipairs(viewModels:GetDescendants()) do
				if model:IsA("Model") and model.Name:lower():find(player.Name:lower(), 1, true) then
					local lower = model.Name:lower();
					for _, part in ipairs(model:GetDescendants()) do
						local pname = part.Name:lower();
						if pname:find("riot", 1, true) or pname:find("shield", 1, true) then
							return "riot shield";
						elseif pname:find("katana", 1, true) then
							return "katana";
						end
					end
				end
			end
		end
		return "";
	end

	local function isBlockedByRiotShield(targetChar)
		if getTargetWeapon(targetChar) ~= "riot shield" then return false end
		local targetRoot = targetChar and targetChar:FindFirstChild("HumanoidRootPart");
		local localRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if not targetRoot or not localRoot then return false end
		local offset = localRoot.Position - targetRoot.Position;
		return offset.Magnitude > 0 and targetRoot.CFrame.LookVector:Dot(offset.Unit) > 0;
	end

	local function isFlashed()
		if game:GetService("Lighting"):FindFirstChild("Flashbang") then return true end
		local pg = LocalPlayer:FindFirstChild("PlayerGui");
		return (pg and pg:FindFirstChild("FlashbangGui") ~= nil) or false;
	end

	local function canSeeTarget(targetChar, targetPart)
		local cam = workspace.CurrentCamera;
		if not cam or not targetChar then return false end
		local myPos = cam.CFrame.Position;
		local checkPart = targetPart or targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart");
		if not checkPart then return false end
		local rayParams = RaycastParams.new();
		rayParams.FilterType = Enum.RaycastFilterType.Exclude;
		rayParams.FilterDescendantsInstances = {LocalPlayer.Character, targetChar, cam};
		rayParams.IgnoreWater = true;
		local ray = workspace:Raycast(myPos, checkPart.Position - myPos, rayParams);
		return not ray or ray.Instance:IsDescendantOf(targetChar);
	end

	local function shouldIgnoreTarget(targetChar, targetPart)
		local root = targetChar and targetChar:FindFirstChild("HumanoidRootPart");
		local hum = targetChar and targetChar:FindFirstChildWhichIsA("Humanoid");
		if not root or not hum or hum.Health <= 0 then return true end
		local myChar = LocalPlayer.Character;
		local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart");
		if not myRoot then return true end

		local maxDist = (getgenv().Config and getgenv().Config.MaxDistance) or 500;
		if (root.Position - myRoot.Position).Magnitude > maxDist then return true end

		local checkWall = Toggles.SilentWallCheck and Toggles.SilentWallCheck.Value;
		if checkWall and not canSeeTarget(targetChar, targetPart) then return true end

		if isProtectedTarget(targetChar) then return true end
		if shouldBlockShotForKatana(targetChar) then return true end
		if isBlockedByRiotShield(targetChar) then return true end
		if isFlashed() then return true end
		return false;
	end

	local function getPredictedPosition(targetPart)
		if not targetPart then return Vector3.zero end
		local velocity = targetPart.AssemblyLinearVelocity or targetPart.Velocity or Vector3.zero;
		local lead = math.clamp(velocity.Magnitude / 350, 0, 0.12);
		local pred = targetPart.Position + velocity * lead;
		if math.abs(velocity.Y) > 2 then
			pred = pred + Vector3.new(0, velocity.Y * math.min(lead, 0.05), 0);
		end
		return pred;
	end

	local manipulationOffsets = {
		Vector3.new(0, 12, 0), Vector3.new(0, 16, 0), Vector3.new(0, 20, 0), Vector3.new(0, 24, 0),
		Vector3.new(0, 28, 0), Vector3.new(0, 32, 0), Vector3.new(0, 36, 0), Vector3.new(0, 40, 0)
	};

	local function calculateManipulationPoint(origin, target_pos, target_char)
		local ray_params = RaycastParams.new();
		ray_params.FilterDescendantsInstances = {LocalPlayer.Character, target_char};
		ray_params.FilterType = Enum.RaycastFilterType.Exclude;
		ray_params.IgnoreWater = true;
		if not workspace:Raycast(origin, target_pos - origin, ray_params) then
			return origin;
		end
		for _, offset in ipairs(manipulationOffsets) do
			local scan_pos = origin + offset;
			if not workspace:Raycast(scan_pos, target_pos - scan_pos, ray_params) then
				return scan_pos;
			end
		end
		return nil;
	end

	local function getManipulationShootPosition(targetPart, targetChar)
		local camera = workspace.CurrentCamera;
		local fromPos = (camera and camera.CFrame.Position) or targetPart.Position;
		if not (Toggles.Manipulation and Toggles.Manipulation.Value) then
			return fromPos;
		end
		local manip = calculateManipulationPoint(fromPos, targetPart.Position, targetChar);
		return manip or fromPos;
	end

	local function buildManipulationCameraData(fromPos, targetPart)
		if not targetPart then return nil, nil end
		local aimPosition = getPredictedPosition(targetPart);
		local look = CFrame.new(fromPos, aimPosition);
		local encLook = look;
		local encTarget = look;
		local objSpace = targetPart.CFrame:ToObjectSpace(CFrame.new(aimPosition));
		local encOffset = objSpace;
		if Utility and Utility.EncodeCFrame then
			pcall(function()
				encLook = Utility:EncodeCFrame(look);
				encTarget = Utility:EncodeCFrame(look);
				encOffset = Utility:EncodeCFrame(objSpace);
			end);
		end
		local data = {};
		data[utf8.char(1)] = {
			[utf8.char(0)] = encLook,
			[utf8.char(1)] = encTarget,
			[utf8.char(2)] = targetPart,
			[utf8.char(3)] = encOffset
		};
		data._m4rs_silent = true;
		return data, aimPosition;
	end

	local function getFOVOrigin()
		local camera = workspace.CurrentCamera;
		if not camera then return Vector2.zero end
		if Toggles.SilentFOVFollowMuzzle and Toggles.SilentFOVFollowMuzzle.Value then
			local muz = GetMuzzlePosition();
			if muz then
				local pos, vis = camera:WorldToViewportPoint(muz);
				if vis then
					return Vector2.new(pos.X, pos.Y);
				end
			end
		end
		local vp = camera.ViewportSize;
		return Vector2.new(vp.X / 2, vp.Y / 2);
	end

	local function getSilentTarget()
		local cam = workspace.CurrentCamera;
		if not cam then return nil, nil end
		local origin = getFOVOrigin();
		local maxFov = (Options.FOVRadius and Options.FOVRadius.Value) or 100;
		local hitPartName = (Options.HitPartDropdown and Options.HitPartDropdown.Value) or "Head";
		local headshotChance = (Options.HeadshotChance and Options.HeadshotChance.Value) or 100;
		local priority = (Options.TargetPriority and Options.TargetPriority.Value) or "Closest (FOV)";
		local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");

		local bestChar, bestPart, bestScore = nil, nil, math.huge;

		for _, p in ipairs(Players:GetPlayers()) do
			if p == LocalPlayer or not isEnemy(p) then continue end
			local ch = p.Character;
			if not ch then continue end
			local r = ch:FindFirstChild("HumanoidRootPart");
			local hum = ch:FindFirstChildWhichIsA("Humanoid");
			if not r or not hum or hum.Health <= 0 then continue end

			local part = nil;
			if math.random(1, 100) <= headshotChance then
				part = ch:FindFirstChild("Head") or ch:FindFirstChild(hitPartName) or r;
			else
				part = ch:FindFirstChild(hitPartName) or ch:FindFirstChild("Head") or r;
			end
			if not part then continue end

			if shouldIgnoreTarget(ch, part) then continue end

			local screenPos, onScreen = cam:WorldToViewportPoint(part.Position);
			if not onScreen then continue end

			local dist2D = (Vector2.new(screenPos.X, screenPos.Y) - origin).Magnitude;
			if dist2D > maxFov then continue end

			local score = dist2D;
			if priority == "Closest (Distance)" and myRoot then
				score = (r.Position - myRoot.Position).Magnitude;
			elseif priority == "Lowest HP" then
				score = hum.Health;
			end

			if score < bestScore then
				bestScore = score;
				bestChar = ch;
				bestPart = part;
			end
		end
		return bestChar, bestPart;
	end

	local function handleSilentAimFire(remote, objId, action, cameradata, ...)
		if _G.__M4rsRageFiring then
			return nil;
		end
		if cameradata and type(cameradata) == "table" and cameradata._m4rs_silent then
			return nil;
		end

		local silentOn = Toggles.SilentAim and Toggles.SilentAim.Value;
		if (Options.SilentAimKey and Options.SilentAimKey.Value and (Options.SilentAimKey.Value ~= "None")) then
			if not Options.SilentAimKey:GetState() then
				silentOn = false;
			end
		end
		if not silentOn or not IsInMatch() then
			return nil;
		end

		local actionShooting = "StartShooting";
		if (EnumLibrary and EnumLibrary.ToEnum) then
			pcall(function()
				actionShooting = EnumLibrary:ToEnum("StartShooting");
			end);
		end
		if action ~= actionShooting and action ~= "StartShooting" then
			return nil;
		end

		local hitChance = (Options.HitChance and Options.HitChance.Value) or 100;
		if hitChance < 100 and math.random(1, 100) > hitChance then
			return nil;
		end

		local targetChar, targetPart = getSilentTarget();
		if not targetChar or not targetPart then
			return nil;
		end

		local fromPos = getManipulationShootPosition(targetPart, targetChar);
		local newCameraData, aimedPos = buildManipulationCameraData(fromPos, targetPart);
		if newCameraData then
			local muzzle = GetMuzzlePosition();
			if (SpawnBulletTracer and muzzle and aimedPos) then
				SpawnBulletTracer(muzzle, aimedPos);
			end
			return newCameraData;
		end
		return nil;
	end
	_G.__M4rsSilentAimRedirect = handleSilentAimFire;

	local silentHookInstalled = false;
	local function installSilentAimHook()
		if silentHookInstalled then return end
		pcall(function()
			local remotes = ReplicatedStorage:FindFirstChild("Remotes");
			local rep = remotes and remotes:FindFirstChild("Replication");
			local fighter = rep and rep:FindFirstChild("Fighter");
			local useItemRemote = fighter and fighter:FindFirstChild("UseItem");
			if not useItemRemote then return end

			if hookfunction and newcclosure then
				local oldFireServer = nil;
				oldFireServer = hookfunction(useItemRemote.FireServer, newcclosure(function(self, objId, action, cameradata, ...)
					if (self == useItemRemote) and not (cameradata and type(cameradata) == "table" and cameradata._m4rs_silent) then
						local redirected = handleSilentAimFire(self, objId, action, cameradata, ...);
						if redirected then
							cameradata = redirected;
						end
					end
					return oldFireServer(self, objId, action, cameradata, ...);
				end));
				silentHookInstalled = true;
			end
		end);
	end
	task.defer(installSilentAimHook);

	local function FireSilentAim(targetPart, targetPlr)
	end

	---------------------------------------------------------
	-- RAGEBOT COMBAT EXECUTION (rage是用我的 + void spam)
	---------------------------------------------------------
	local lastMessageFire = 0;
	local function ExecuteMessageCombat(dt)
		local rageOn = Toggles.TargetOn and Toggles.TargetOn.Value;
		if (Options.TargetKey and Options.TargetKey.Value and (Options.TargetKey.Value ~= "None")) then
			if not Options.TargetKey:GetState() then
				rageOn = false;
			end
		end
		if not rageOn then
			if voidState and voidState.active then
				stopVoidCsync();
			end
			return;
		end
		if not IsInMatch() then
			if voidState and voidState.active then
				enterVoidState();
			end
			return;
		end
		updateDeflection();
		local tp, tr, th = getClosestTarget();
		local voidSpamOn = Toggles.VoidSpam and Toggles.VoidSpam.Value;
		if voidSpamOn then
			startVoidCsync();
			if (not tp or not th or not tr or deflecting[tp] or (tp.Character and shouldBlockShotForKatana(tp.Character)) or (tp.Character and isProtectedTarget(tp.Character))) then
				enterVoidState();
				return;
			end
		end
		local desyncCF = nil;
		local rageTeleporting = rageOn and Toggles.RageTeleport and Toggles.RageTeleport.Value;
		local desyncOn = (Toggles.Desync and Toggles.Desync.Value) ~= false;
		if (not rageTeleporting and tr and th and desyncOn and not voidSpamOn) then
			local off = (hasKnifeViewModel(tp) and Vector3.new(0, 6, 0)) or Vector3.new(0, 1, 2);
			local desyncPos = (tr.CFrame * CFrame.new(off)).Position;
			desyncCF = CFrame.lookAt(desyncPos, th.Position);
		end
		if (desyncCF and LocalPlayer.Character and not voidSpamOn) then
			local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
			if myRoot then
				local oCF, oV, oRV = myRoot.CFrame, myRoot.Velocity, myRoot.RotVelocity;
				myRoot.CFrame = desyncCF;
				RunService:BindToRenderStep("__restore", 101, function()
					if myRoot then
						myRoot.CFrame, myRoot.Velocity, myRoot.RotVelocity = oCF, oV, oRV;
					end
					RunService:UnbindFromRenderStep("__restore");
				end);
			end
		end
		if (not tp or not th or not tr) then
			return;
		end
		if deflecting[tp] or (tp.Character and shouldBlockShotForKatana(tp.Character)) or (tp.Character and isProtectedTarget(tp.Character)) then
			if voidSpamOn then
				enterVoidState();
			end
			return;
		end
		if (not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
			return;
		end
		if (not FighterController or not FighterController.LocalFighter) then
			pcall(function()
				local ps = LocalPlayer:FindFirstChild("PlayerScripts");
				local ctrl = ps and ps:FindFirstChild("Controllers");
				local fm = ctrl and ctrl:FindFirstChild("FighterController");
				if fm then
					local fc = SafeRequire(fm);
					if fc then
						FighterController = fc;
						localFighter = fc.LocalFighter;
					end
				end
			end);
			if (not localFighter or not localFighter.EquippedItem) then
				return;
			end
		end
		local item = localFighter and localFighter.EquippedItem;
		if not item then
			return;
		end
		local objId = item:Get("ObjectID");
		if not objId then
			return;
		end
		local curAmmo = item:Get("CurrentAmmo") or item:Get("Ammo") or item:Get("Bullets");
		local maxAmmo = item:Get("MaxAmmo") or item:Get("MaxBullets") or 0;
		if ((curAmmo == 0) and (maxAmmo > 0)) then
			if voidSpamOn then
				enterVoidState();
			end
			pcall(function()
				if item.Reload then
					item:Reload();
				else
					local vim = game:GetService("VirtualInputManager");
					vim:SendKeyEvent(true, Enum.KeyCode.R, false, game);
					task.wait(0.02);
					vim:SendKeyEvent(false, Enum.KeyCode.R, false, game);
				end
			end);
			local doSwap = false;
			if (Options.RageSettings and Options.RageSettings.Value) then
				local rsv = Options.RageSettings.Value;
				if (type(rsv) == "table") then
					doSwap = rsv["swap weapons when no ammo"] == true;
				end
			end
			if doSwap then
				pcall(function()
					local currentSlot = localFighter.EquippedSlot or (item and item:Get("Slot")) or 1;
					local nextSlot = ((currentSlot == 1) and 2) or ((currentSlot == 2) and 3) or 1;
					localFighter:EquipItem(nextSlot);
				end);
			end
			return;
		end
		local fireRate = 0.0001;
		if ((tick() - lastMessageFire) < fireRate) then
			return;
		end
		lastMessageFire = tick();
		local hitChance = (Options.HitChance and Options.HitChance.Value) or 100;
		if ((hitChance < 100) and (math.random(1, 100) > hitChance)) then
			return;
		end

		local shootCF = nil;
		local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
		if (rageTeleporting and myRoot) then
			local dist = (tr.Position - myRoot.Position).Magnitude;
			local maxRageDist = (Options.RageTeleportDistance and Options.RageTeleportDistance.Value) or 200;
			if (dist <= maxRageDist) then
				local jitter = (Options.RageTeleportJitter and Options.RageTeleportJitter.Value) or 10;
				local ang = math.random() * math.pi * 2;
				local rad = math.random() * jitter;
				local feetPos = tr.Position - Vector3.new(0, 3, 0);
				local teleportPos = feetPos + Vector3.new(math.cos(ang) * rad, 0, math.sin(ang) * rad);
				shootCF = CFrame.lookAt(teleportPos, th.Position);
				if not voidSpamOn then
					local oCF, oV, oRV = myRoot.CFrame, myRoot.AssemblyLinearVelocity, myRoot.AssemblyAngularVelocity;
					myRoot.CFrame = shootCF;
					myRoot.AssemblyLinearVelocity = Vector3.zero;
					myRoot.AssemblyAngularVelocity = Vector3.zero;
					RunService:BindToRenderStep("__rageTeleportRestore", 101, function()
						if (myRoot and myRoot.Parent) then
							myRoot.CFrame = oCF;
							myRoot.AssemblyLinearVelocity = oV;
							myRoot.AssemblyAngularVelocity = oRV;
						end
						RunService:UnbindFromRenderStep("__rageTeleportRestore");
					end);
				end
			end
		end

		if voidSpamOn then
			local targetShootCF = shootCF or desyncCF or (myRoot and CFrame.lookAt(tr.Position + Vector3.new(0, 1, 2), th.Position));
			if targetShootCF then
				setVoidCsync(targetShootCF, Vector3.zero, Vector3.zero);
			end
		end

		local originPos = (shootCF and shootCF.Position) or (desyncCF and desyncCF.Position) or tr.Position;
		local aimCF = CFrame.lookAt(originPos, th.Position);
		local targetCF = th.CFrame;
		local sp = 0;
		local rnd = Vector3.zero;
		local aimedPos = th.Position + rnd;
		local objOff = th.CFrame:ToObjectSpace(CFrame.new(aimedPos));
		local encodedAimCF = aimCF;
		local encodedTargetCF = targetCF;
		local encodedOffset = objOff;
		if (Utility and Utility.EncodeCFrame) then
			pcall(function()
				encodedAimCF = Utility:EncodeCFrame(aimCF);
				encodedTargetCF = Utility:EncodeCFrame(targetCF);
				encodedOffset = Utility:EncodeCFrame(objOff);
			end);
		end
		local cameradata = {};
		cameradata[utf8.char(1)] = {[utf8.char(0)]=encodedAimCF,[utf8.char(1)]=encodedTargetCF,[utf8.char(2)]=th,[utf8.char(3)]=encodedOffset};
		local actionEnum = "StartShooting";
		if (EnumLibrary and EnumLibrary.ToEnum) then
			pcall(function()
				actionEnum = EnumLibrary:ToEnum("StartShooting");
			end);
		end
		local attempts = (Options.ShootAttempts and Options.ShootAttempts.Value) or 1;
		_G.__M4rsRageFiring = true;
		for i = 1, attempts do
			pcall(function()
				ReplicatedStorage.Remotes.Replication.Fighter.UseItem:FireServer(objId, actionEnum, cameradata, nil);
			end);
		end
		_G.__M4rsRageFiring = false;

		if voidSpamOn then
			enterVoidState();
		end

		local muzzle = GetMuzzlePosition();
		if (SpawnBulletTracer and muzzle) then
			SpawnBulletTracer(muzzle, aimedPos);
		end
	end
	do
		local hitEffectFloatSpeed = 7;
		local hitEffectAliveTime = 2.8;
		local function scaleHitDuration(seconds)
			local aliveTime = (Options.HitEffectAliveTime and Options.HitEffectAliveTime.Value) or 2.8;
			return seconds * (aliveTime / 2.8);
		end
		local function spawnHitRing(targetPart, color, config)
			if not targetPart then
				return;
			end
			config = config or {};
			local ring = Instance.new("Part");
			ring.Name = config.Name or "M4rsHitRing";
			ring.Shape = Enum.PartType.Cylinder;
			ring.Anchored = true;
			ring.CanCollide = false;
			ring.CanQuery = false;
			ring.CanTouch = false;
			ring.Material = config.Material or Enum.Material.Neon;
			ring.Color = color or Color3.fromRGB(159, 133, 195);
			ring.Transparency = config.StartTransparency or 0.35;
			local startSize = config.StartSize or 0.35;
			ring.Size = Vector3.new(0.05, startSize, startSize);
			ring.CFrame = targetPart.CFrame * CFrame.Angles(0, 0, math.rad(90));
			ring.Parent = workspace.Terrain;
			local endSize = config.EndSize or 5;
			local duration = scaleHitDuration(config.Duration or 0.55);
			TweenService:Create(ring, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size=Vector3.new(0.05, endSize, endSize),Transparency=1}):Play();
			task.delay(duration + 0.1, function()
				if (ring and ring.Parent) then
					ring:Destroy();
				end
			end);
			return ring;
		end
		local function spawnHitFlash(targetPart, color, brightness, range, duration)
			if not targetPart then
				return;
			end
			duration = scaleHitDuration(duration or 0.35);
			local light = Instance.new("PointLight");
			light.Name = "M4rsHitFlash";
			light.Color = color or Color3.fromRGB(255, 255, 255);
			light.Brightness = brightness or 3;
			light.Range = range or 14;
			light.Parent = targetPart;
			TweenService:Create(light, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Brightness=0,Range=0}):Play();
			task.delay(duration + 0.05, function()
				if (light and light.Parent) then
					light:Destroy();
				end
			end);
			return light;
		end
		local function spawnHitParticles(targetPart, color, styleName)
			if not targetPart then
				return;
			end
			local emitter = Instance.new("ParticleEmitter");
			emitter.Name = "M4rsHitParticle";
			emitter.Color = ColorSequence.new(color or Color3.fromRGB(255, 255, 255));
			emitter.Size = NumberSequence.new(0.4, 0);
			emitter.Transparency = NumberSequence.new(0.1, 1);
			emitter.Speed = NumberRange.new(5, 15);
			emitter.SpreadAngle = Vector2.new(180, 180);
			emitter.Lifetime = NumberRange.new(0.4, 0.8);
			emitter.Rate = 0;
			if (styleName == "Blood") then
				emitter.Color = ColorSequence.new(Color3.fromRGB(200, 20, 20));
				emitter.Speed = NumberRange.new(8, 20);
			elseif (styleName == "Fire") then
				emitter.Color = ColorSequence.new(Color3.fromRGB(255, 120, 30));
				emitter.LightEmission = 0.8;
			elseif (styleName == "Ice") then
				emitter.Color = ColorSequence.new(Color3.fromRGB(150, 220, 255));
				emitter.LightEmission = 0.5;
			elseif (styleName == "Lightning") then
				emitter.Color = ColorSequence.new(Color3.fromRGB(200, 240, 255));
				emitter.LightEmission = 1;
			elseif (styleName == "Hearts") then
				emitter.Texture = "rbxassetid://36721240";
				emitter.Color = ColorSequence.new(Color3.fromRGB(255, 100, 150));
			elseif (styleName ~= "Stars") then
			else
				emitter.Texture = "rbxassetid://6822501679";
				emitter.Color = ColorSequence.new(Color3.fromRGB(255, 240, 100));
			end
			emitter.Parent = targetPart;
			emitter:Emit(math.random(10, 25));
			task.delay(1, function()
				if (emitter and emitter.Parent) then
					emitter:Destroy();
				end
			end);
		end
		local function TriggerHitEffects(targetPart)
			if (not (Toggles.HitEffects and Toggles.HitEffects.Value) or not targetPart) then
				return;
			end
			local color = (Options.HitEffectColorPicker and Options.HitEffectColorPicker.Value) or Color3.fromRGB(159, 133, 195);
			local selectedStyles = (Options.HitEffectStyleDropdown and Options.HitEffectStyleDropdown.Value) or {"Particles"};
			local hasStyle = function(name)
				if (type(selectedStyles) == "table") then
					for k, v in pairs(selectedStyles) do
						if ((v == name) or (k == name)) then
							return true;
						end
					end
				elseif (selectedStyles ~= name) then
				else
					return true;
				end
				return false;
			end;
			pcall(function()
				if (hasStyle("Shockwave") or hasStyle("Particles") or hasStyle("Ripple") or hasStyle("Neon")) then
					spawnHitRing(targetPart, color);
				end
				spawnHitFlash(targetPart, color, 2.5, 12, 0.3);
				for _, s in ipairs({"Blood","Fire","Ice","Lightning","Hearts","Stars","Confetti","Sparks","Plasma"}) do
					if hasStyle(s) then
						spawnHitParticles(targetPart, color, s);
					end
				end
			end);
		end
		local fallbackKillSounds = {["sound 1"]="rbxassetid://5043539486",["sound 2"]="rbxassetid://97643101798871",["sound 3"]="rbxassetid://5764885315"};
		local function PlayKillSound()
			if not (Toggles.KillSoundsEnabled and Toggles.KillSoundsEnabled.Value) then
				return;
			end
			local style = (Options.KillSoundStyle and Options.KillSoundStyle.Value) or "sound 1";
			local vol = (Options.KillSoundVolume and Options.KillSoundVolume.Value) or 50;
			local pitch = (Options.KillSoundPitch and Options.KillSoundPitch.Value) or 100;
			pcall(function()
				local sound = Instance.new("Sound");
				sound.SoundId = fallbackKillSounds[style] or fallbackKillSounds["sound 1"];
				sound.Volume = vol / 100;
				sound.PlaybackSpeed = pitch / 100;
				sound.Parent = SoundService;
				sound:Play();
				game:GetService("Debris"):AddItem(sound, 3);
			end);
		end
		local PushHitNotification;
		do
			local hudParent = game:GetService("CoreGui");
			pcall(function()
				if gethui then
					hudParent = gethui();
				elseif (syn and syn.protect_gui) then
					local sg = Instance.new("ScreenGui");
					syn.protect_gui(sg);
					hudParent = game:GetService("CoreGui");
				end
			end);
			if (not hudParent or not pcall(function()
				return hudParent.Name;
			end)) then
				hudParent = LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui", 3) or LocalPlayer:FindFirstChild("PlayerGui");
			end
			local hitNotifGui = hudParent:FindFirstChild("M4rsHitNotifHUD");
			if hitNotifGui then
				hitNotifGui:Destroy();
			end
			hitNotifGui = Instance.new("ScreenGui");
			hitNotifGui.Name = "M4rsHitNotifHUD";
			hitNotifGui.ResetOnSpawn = false;
			hitNotifGui.Parent = hudParent;
			local hitNotifContainer = Instance.new("Frame");
			hitNotifContainer.Name = "NotifContainer";
			hitNotifContainer.Size = UDim2.new(0, 260, 0, 300);
			hitNotifContainer.Position = UDim2.new(0.5, -130, 0.2, 0);
			hitNotifContainer.BackgroundTransparency = 1;
			hitNotifContainer.Parent = hitNotifGui;
			local hitNotifLayout = Instance.new("UIListLayout");
			hitNotifLayout.SortOrder = Enum.SortOrder.LayoutOrder;
			hitNotifLayout.Padding = UDim.new(0, 6);
			hitNotifLayout.Parent = hitNotifContainer;
			local notifPositions = {["Top Left"]=UDim2.new(0.02, 0, 0.05, 0),["Top Center"]=UDim2.new(0.5, -130, 0.05, 0),["Top Right"]=UDim2.new(0.8, 0, 0.05, 0),["Center Left"]=UDim2.new(0.02, 0, 0.45, 0),Center=UDim2.new(0.5, -130, 0.45, 0),["Center Right"]=UDim2.new(0.8, 0, 0.45, 0),["Bottom Left"]=UDim2.new(0.02, 0, 0.75, 0),["Bottom Center"]=UDim2.new(0.5, -130, 0.75, 0),["Bottom Right"]=UDim2.new(0.8, 0, 0.75, 0)};
			local function UpdateHitNotifPos()
				local posName = (Options.HitNotifPosition and Options.HitNotifPosition.Value) or "Center";
				hitNotifContainer.Position = notifPositions[posName] or UDim2.new(0.5, -130, 0.25, 0);
				local gap = (Options.HitNotifStackGap and Options.HitNotifStackGap.Value) or 6;
				hitNotifLayout.Padding = UDim.new(0, gap);
			end
			function PushHitNotification(enemyName, damage, isDead)
				if not (Toggles.HitNotifications and Toggles.HitNotifications.Value) then
					return;
				end
				UpdateHitNotifPos();
				local txtColor = (Options.HitNotificationsColor and Options.HitNotificationsColor.Value) or Color3.fromRGB(240, 240, 245);
				local txtSize = (Options.HitNotifTextSize and Options.HitNotifTextSize.Value) or 13;
				local duration = (Options.HitNotifDuration and Options.HitNotifDuration.Value) or 3;
				local entry = Instance.new("Frame");
				entry.Size = UDim2.new(1, 0, 0, 24);
				entry.BackgroundColor3 = Color3.fromRGB(10, 10, 15);
				entry.BackgroundTransparency = 0.3;
				entry.BorderSizePixel = 0;
				local corner = Instance.new("UICorner", entry);
				corner.CornerRadius = UDim.new(0, 4);
				local stroke = Instance.new("UIStroke", entry);
				stroke.Color = (isDead and Color3.fromRGB(255, 60, 80)) or Library.AccentColor;
				stroke.Thickness = 1;
				stroke.Transparency = 0.4;
				local label = Instance.new("TextLabel", entry);
				label.Size = UDim2.new(1, -12, 1, 0);
				label.Position = UDim2.new(0, 6, 0, 0);
				label.BackgroundTransparency = 1;
				label.Font = Enum.Font.Code;
				label.TextSize = txtSize;
				label.TextColor3 = txtColor;
				label.TextXAlignment = Enum.TextXAlignment.Center;
				if isDead then
					label.Text = string.format("☠ KILLED %s! [-%d HP]", enemyName or "Enemy", damage or 0);
				else
					label.Text = string.format("💥 HIT %s [-%d HP]", enemyName or "Enemy", damage or 0);
				end
				entry.Parent = hitNotifContainer;
				entry.Position = UDim2.new(0, 0, 0, -10);
				TweenService:Create(entry, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position=UDim2.new(0, 0, 0, 0),BackgroundTransparency=0.3}):Play();
				task.delay(duration, function()
					if (entry and entry.Parent) then
						local outTween = TweenService:Create(entry, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency=1});
						TweenService:Create(label, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency=1}):Play();
						TweenService:Create(stroke, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Transparency=1}):Play();
						outTween:Play();
						outTween.Completed:Connect(function()
							entry:Destroy();
						end);
					end
				end);
			end
			Hub.DestroyHitNotification = function()
				if hitNotifGui then
					hitNotifGui:Destroy();
				end
			end;
		end
		local function PlayHitFeedback(damage, enemyName, targetPart, isDead)
			if (Toggles.HitSounds and Toggles.HitSounds.Value) then
				local style = (Options.SoundStyleDropdown and Options.SoundStyleDropdown.Value) or "Rust HS";
				local soundId = hitSoundAssets[style] or hitSoundAssets["Rust HS"];
				local vol = (Options.SoundVolume and Options.SoundVolume.Value) or 50;
				local pitch = (Options.SoundPitch and Options.SoundPitch.Value) or 100;
				pcall(function()
					local s = Instance.new("Sound");
					s.SoundId = soundId;
					s.Volume = vol / 100;
					s.PlaybackSpeed = pitch / 100;
					s.Parent = SoundService;
					s:Play();
					game:GetService("Debris"):AddItem(s, 2);
				end);
			end
			if targetPart then
				TriggerHitEffects(targetPart);
			end
			if isDead then
				PlayKillSound();
			end
			PushHitNotification(enemyName, damage, isDead);
		end
		Hub.LastAttackTick = 0;
		UserInputService.InputBegan:Connect(function(input, gp)
			if (not gp and ((input.UserInputType == Enum.UserInputType.MouseButton1) or (input.UserInputType == Enum.UserInputType.Touch) or (input.KeyCode == Enum.KeyCode.ButtonR2))) then
				Hub.LastAttackTick = tick();
			end
		end);
		Hub.DamageBillboardConnection = workspace.DescendantAdded:Connect(function(obj)
			if (not obj:IsA("BillboardGui") or (obj.Name == "FortniteDamageNumber")) then
				return;
			end
			local lbl = obj:FindFirstChildWhichIsA("TextLabel", true);
			if not lbl then
				return;
			end
			local dmg = tonumber(lbl.Text);
			if (dmg and (dmg > 0) and (dmg <= 350)) then
				if ((tick() - (Hub.LastAttackTick or 0)) > 1.2) then
					return;
				end
				if not IsInMatch() then
					return;
				end
				local checkAdornee = obj.Adornee or (obj.Parent and obj.Parent:IsA("BasePart") and obj.Parent);
				local checkPlayer = checkAdornee and checkAdornee.Parent and Players:GetPlayerFromCharacter(checkAdornee.Parent);
				if (not checkPlayer or not isEnemy(checkPlayer)) then
					return;
				end
				local enemyName = "Target";
				local adornee = obj.Adornee or (obj.Parent and obj.Parent:IsA("BasePart") and obj.Parent);
				local targetPart = (adornee and adornee:IsA("BasePart") and adornee) or nil;
				local worldPos = (targetPart and targetPart.Position) or (obj.Adornee and obj.Adornee.Position) or (obj.Parent and obj.Parent:IsA("BasePart") and obj.Parent.Position);
				local isDead = false;
				if (adornee and adornee.Parent) then
					local p = Players:GetPlayerFromCharacter(adornee.Parent);
					if p then
						enemyName = p.DisplayName or p.Name;
						local hum = adornee.Parent:FindFirstChildOfClass("Humanoid");
						if (hum and (hum.Health <= dmg)) then
							isDead = true;
						end
					end
				end
				PlayHitFeedback(dmg, enemyName, targetPart, isDead);
				if (Hub.SpawnDamageNumber and worldPos) then
					Hub.SpawnDamageNumber(dmg, worldPos);
				end
			end
		end);
	end
	do
		local dmgGui = Instance.new("ScreenGui");
		dmgGui.Name = "M4rs_DamageNumbers";
		dmgGui.ResetOnSpawn = false;
		dmgGui.IgnoreGuiInset = true;
		dmgGui.DisplayOrder = 500;
		pcall(function()
			if gethui then
				dmgGui.Parent = gethui();
			elseif (syn and syn.protect_gui) then
				syn.protect_gui(dmgGui);
				dmgGui.Parent = game:GetService("CoreGui");
			else
				dmgGui.Parent = game:GetService("CoreGui");
			end
		end);
		if not dmgGui.Parent then
			pcall(function()
				dmgGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui");
			end);
		end
		local activeDmgLabels = {};
		Hub.SpawnDamageNumber = function(amount, worldpos)
			if (not (Toggles.DamageNumbersEnable and Toggles.DamageNumbersEnable.Value) or not worldpos) then
				return;
			end
			local cam = workspace.CurrentCamera;
			if not cam then
				return;
			end
			local sp, onscreen = cam:WorldToViewportPoint(worldpos);
			if (not onscreen or (sp.Z <= 0)) then
				return;
			end
			local c1 = (Options.DamageNumbersColor1 and Options.DamageNumbersColor1.Value) or Color3.fromRGB(255, 80, 80);
			local c2 = (Options.DamageNumbersColor2 and Options.DamageNumbersColor2.Value) or Color3.fromRGB(255, 200, 50);
			local mode = (Options.DamageNumbersColorType and Options.DamageNumbersColorType.Value) or "Solid";
			local fSize = (Options.DamageNumbersSize and Options.DamageNumbersSize.Value) or 18;
			local dur = (Options.DamageNumbersDuration and Options.DamageNumbersDuration.Value) or 0.8;
			local rise = (Options.DamageNumbersRise and Options.DamageNumbersRise.Value) or 42;
			local lbl = Instance.new("TextLabel");
			lbl.BackgroundTransparency = 1;
			lbl.Size = UDim2.fromOffset(140, 26);
			lbl.AnchorPoint = Vector2.new(0.5, 0.5);
			lbl.Position = UDim2.fromOffset(sp.X, sp.Y);
			lbl.Font = Enum.Font.GothamBold;
			lbl.TextSize = fSize;
			lbl.Text = "-" .. tostring(math.floor(amount + 0.5));
			lbl.TextStrokeTransparency = 1;
			lbl.TextColor3 = ((mode == "Gradient") and Color3.new(1, 1, 1)) or c1;
			lbl.ZIndex = 10;
			lbl.Parent = dmgGui;
			local stroke = Instance.new("UIStroke");
			stroke.Thickness = 1.5;
			stroke.Color = Color3.fromRGB(0, 0, 0);
			stroke.Transparency = 0.15;
			stroke.LineJoinMode = Enum.LineJoinMode.Round;
			stroke.Parent = lbl;
			local scale = Instance.new("UIScale");
			scale.Scale = 0.5;
			scale.Parent = lbl;
			if (mode ~= "Gradient") then
			else
				local grad = Instance.new("UIGradient");
				grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, c1),ColorSequenceKeypoint.new(1, c2)});
				grad.Rotation = 90;
				grad.Parent = lbl;
			end
			local startX, startY = sp.X, sp.Y;
			local jitter = math.random(-14, 14);
			local start = tick();
			local conn;
			conn = RunService.RenderStepped:Connect(function()
				local t = (tick() - start) / dur;
				if (t >= 1) then
					conn:Disconnect();
					activeDmgLabels[lbl] = nil;
					pcall(function()
						lbl:Destroy();
					end);
					return;
				end
				local ease = 1 - ((1 - t) * (1 - t) * (1 - t));
				if (mode ~= "Rainbow") then
				else
					lbl.TextColor3 = Color3.fromHSV((tick() * 0.6) % 1, 0.75, 1);
				end
				local s;
				if (t < 0.16) then
					s = 0.5 + ((t / 0.16) * 0.62);
				else
					s = 1.12 - (((t - 0.16) / 0.84) * 0.12);
				end
				scale.Scale = s;
				local fade = ((t < 0.55) and 0) or ((t - 0.55) / 0.45);
				lbl.Position = UDim2.fromOffset(startX + (jitter * ease), startY - (rise * ease));
				lbl.TextTransparency = fade;
				stroke.Transparency = 0.15 + (0.85 * fade);
			end);
			activeDmgLabels[lbl] = conn;
		end;
		Hub.DestroyDamageNumbers = function()
			for lbl, conn in pairs(activeDmgLabels) do
				if conn then
					conn:Disconnect();
				end
				pcall(function()
					lbl:Destroy();
				end);
			end
			table.clear(activeDmgLabels);
			if dmgGui then
				pcall(function()
					dmgGui:Destroy();
				end);
			end
		end;
	end
	do
		local deathConns = {};
		Hub.TriggerDeathEffect = function(pos)
			if (not (Toggles.DeathEffectsEnable and Toggles.DeathEffectsEnable.Value) or not pos) then
				return;
			end
			local effType = (Options.DeathEffectsType and Options.DeathEffectsType.Value) or "Explosion";
			local effCol = (Options.DeathEffectsColor and Options.DeathEffectsColor.Value) or Color3.fromRGB(150, 80, 255);
			pcall(function()
				if (effType ~= "Explosion") then
				else
					local exp = Instance.new("Explosion");
					exp.Position = pos;
					exp.BlastRadius = 0;
					exp.BlastPressure = 0;
					exp.DestroyJointRadiusPercent = 0;
					exp.Parent = workspace;
					return;
				end
				local part = Instance.new("Part");
				part.Name = "M4rsDeathEffect";
				part.Anchored = true;
				part.CanCollide = false;
				part.CanQuery = false;
				part.CanTouch = false;
				part.Transparency = 1;
				part.Size = Vector3.new(1, 1, 1);
				part.CFrame = CFrame.new(pos);
				part.Parent = workspace;
				local att = Instance.new("Attachment");
				att.Parent = part;
				local emitter = Instance.new("ParticleEmitter");
				emitter.Color = ColorSequence.new(effCol);
				emitter.Lifetime = NumberRange.new(0.4, 0.9);
				emitter.Speed = NumberRange.new(12, 28);
				emitter.Rate = 0;
				emitter.SpreadAngle = Vector2.new(180, 180);
				emitter.Rotation = NumberRange.new(0, 360);
				emitter.Size = NumberSequence.new(1.6);
				if (effType == "Fire") then
					emitter.Texture = "rbxasset://textures/particles/fire_main.dds";
				elseif (effType == "Sparkles") then
					emitter.Texture = "rbxasset://textures/particles/sparkles_main.dds";
					emitter.LightEmission = 1;
				else
					emitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
					emitter.LightEmission = 1;
				end
				emitter.Parent = att;
				emitter:Emit(45);
				task.delay(1.5, function()
					pcall(function()
						part:Destroy();
					end);
				end);
			end);
		end;
		local function hookDeathForPlayer(plr)
			if not plr then
				return;
			end
			local function onChar(char)
				local hum = char:WaitForChild("Humanoid", 5);
				if not hum then
					return;
				end
				table.insert(deathConns, hum.Died:Connect(function()
					if (Toggles.DeathEffectsEnable and Toggles.DeathEffectsEnable.Value) then
						local root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Head");
						if root then
							Hub.TriggerDeathEffect(root.Position);
						end
					end
				end));
			end
			if plr.Character then
				onChar(plr.Character);
			end
			table.insert(deathConns, plr.CharacterAdded:Connect(onChar));
		end
		for _, p in ipairs(Players:GetPlayers()) do
			hookDeathForPlayer(p);
		end
		table.insert(deathConns, Players.PlayerAdded:Connect(hookDeathForPlayer));
		Hub.DestroyDeathEffects = function()
			for _, conn in ipairs(deathConns) do
				pcall(function()
					conn:Disconnect();
				end);
			end
			table.clear(deathConns);
		end;
	end
	do
		local texture_originals = {};
		local minecraft_textures = {};
		local minecraft_faces = {"Front","Back","Bottom","Top","Right","Left"};
		local minecraft_ids = {[Enum.Material.Wood]="3258599312",[Enum.Material.WoodPlanks]="8676581022",[Enum.Material.Brick]="8558400252",[Enum.Material.Cobblestone]="5003953441",[Enum.Material.Concrete]="7341687607",[Enum.Material.DiamondPlate]="6849247561",[Enum.Material.Fabric]="118776397",[Enum.Material.Granite]="4722586771",[Enum.Material.Grass]="4722588177",[Enum.Material.Ice]="3823766459",[Enum.Material.Marble]="62967586",[Enum.Material.Metal]="62967586",[Enum.Material.Sand]="152572215"};
		local material_lookup = {};
		for _, material in ipairs(Enum.Material:GetEnumItems()) do
			material_lookup[string.lower(material.Name)] = material;
		end
		local function resolve_material(name)
			if not name then
				return nil;
			end
			return material_lookup[string.lower((name:gsub("%s+", "")))];
		end
		local function is_texture_excluded(part)
			if (Toggles.world_textures_apply_vm and Toggles.world_textures_apply_vm.Value) then
				return false;
			end
			local node = part;
			while node and (node ~= workspace) do
				if (node:IsA("Model") and node:FindFirstChildOfClass("Humanoid")) then
					return true;
				end
				node = node.Parent;
			end
			local viewmodels = workspace:FindFirstChild("ViewModels");
			if (viewmodels and part:IsDescendantOf(viewmodels)) then
				return true;
			end
			local cam = workspace.CurrentCamera;
			if (cam and part:IsDescendantOf(cam)) then
				return true;
			end
			return false;
		end
		local function clear_minecraft_texture(part)
			if minecraft_textures[part] then
				for _, tex in ipairs(minecraft_textures[part]) do
					if (tex and tex.Parent) then
						pcall(function()
							tex:Destroy();
						end);
					end
				end
				minecraft_textures[part] = nil;
			end
		end
		local function apply_minecraft_texture(part, texture_id)
			clear_minecraft_texture(part);
			minecraft_textures[part] = {};
			for _, face_name in ipairs(minecraft_faces) do
				local texture = Instance.new("Texture");
				texture.Texture = "rbxassetid://" .. tostring(texture_id);
				texture.Face = Enum.NormalId[face_name];
				texture.Color3 = part.Color;
				texture.Transparency = part.Transparency;
				texture.StudsPerTileU = 3;
				texture.StudsPerTileV = 3;
				texture.Parent = part;
				table.insert(minecraft_textures[part], texture);
			end
		end
		local function apply_texture(part)
			if (not part:IsA("BasePart") or is_texture_excluded(part)) then
				return;
			end
			if not texture_originals[part] then
				texture_originals[part] = {Material=part.Material,Color=part.Color,Transparency=part.Transparency};
			end
			local col = (Options.world_textures_color and Options.world_textures_color.Value) or Color3.fromRGB(244, 244, 244);
			if (Toggles.dark_textures and Toggles.dark_textures.Value) then
				col = Color3.fromRGB(math.floor(col.R * 80), math.floor(col.G * 80), math.floor(col.B * 80));
			end
			part.Color = col;
			if (Toggles.transparent_textures and Toggles.transparent_textures.Value) then
				part.Transparency = (Options.TransparentStrength and Options.TransparentStrength.Value) or 0.6;
			end
			local matStr = (Options.world_textures_material and Options.world_textures_material.Value) or "Brick";
			if (matStr == "Minecraft") then
				local source = texture_originals[part].Material;
				local id = minecraft_ids[source] or "5003953441";
				apply_minecraft_texture(part, id);
			else
				clear_minecraft_texture(part);
				if (Toggles.smooth_textures and Toggles.smooth_textures.Value) then
					part.Material = Enum.Material.SmoothPlastic;
				else
					local mat = resolve_material(matStr);
					if mat then
						part.Material = mat;
					end
				end
			end
		end
		local texture_connection = nil;
		local function enableTextures()
			for _, part in ipairs(workspace:GetDescendants()) do
				if part:IsA("BasePart") then
					apply_texture(part);
				end
			end
			if texture_connection then
				texture_connection:Disconnect();
			end
			texture_connection = workspace.DescendantAdded:Connect(function(part)
				if (Toggles.world_textures_enable and Toggles.world_textures_enable.Value and part:IsA("BasePart")) then
					task.defer(apply_texture, part);
				end
			end);
		end
		local function disableTextures()
			if texture_connection then
				texture_connection:Disconnect();
				texture_connection = nil;
			end
			for part, props in pairs(texture_originals) do
				if (part and part.Parent) then
					pcall(function()
						part.Material = props.Material;
						part.Color = props.Color;
						part.Transparency = props.Transparency;
					end);
				end
			end
			for part, _ in pairs(minecraft_textures) do
				clear_minecraft_texture(part);
			end
			table.clear(texture_originals);
		end
		local lastTexturesEnabled = false;
		local lastTexSig = nil;
		function UpdateTextures()
			local enabled = (Toggles.world_textures_enable and Toggles.world_textures_enable.Value) or false;
			local sig = tostring(enabled) .. "|" .. tostring(Options.world_textures_material and Options.world_textures_material.Value) .. "|" .. tostring(Options.world_textures_color and Options.world_textures_color.Value) .. "|" .. tostring(Toggles.smooth_textures and Toggles.smooth_textures.Value) .. "|" .. tostring(Toggles.dark_textures and Toggles.dark_textures.Value) .. "|" .. tostring(Toggles.transparent_textures and Toggles.transparent_textures.Value) .. "|" .. tostring(Options.TransparentStrength and Options.TransparentStrength.Value);
			if (sig == lastTexSig) then
				return;
			end
			lastTexSig = sig;
			disableTextures();
			lastTexturesEnabled = enabled;
			if enabled then
				enableTextures();
			end
		end
		Hub.UpdateTextures = UpdateTextures;
		Hub.DestroyTextures = disableTextures;
	end
	do
		local function isRivalsGunSound(sound)
			if (not sound or (typeof(sound) ~= "Instance") or not sound:IsA("Sound")) then
				return false;
			end
			local vm = workspace:FindFirstChild("ViewModels");
			if (vm and sound:IsDescendantOf(vm)) then
				return true;
			end
			local cam = workspace.CurrentCamera;
			if (cam and sound:IsDescendantOf(cam)) then
				return true;
			end
			local char = LocalPlayer.Character;
			if (char and sound:IsDescendantOf(char)) then
				local n = sound.Name:lower();
				if (n:find("gun") or n:find("fire") or n:find("shoot") or n:find("weapon") or n:find("muzzle") or n:find("shell") or n:find("reload") or n:find("bolt") or n:find("chamber") or n:find("rifle") or n:find("pistol") or n:find("shotgun") or n:find("bullet")) then
					return true;
				end
			end
			return false;
		end
		local function silenceGunSound(sound)
			if not isRivalsGunSound(sound) then
				return;
			end
			pcall(function()
				sound:Stop();
				sound.Volume = 0;
			end);
		end
		local function bindGunSoundGuard(sound)
			if ((typeof(sound) ~= "Instance") or not sound:IsA("Sound") or sound:GetAttribute("ShootSound")) then
				return;
			end
			if not sound:GetAttribute("GunMuteBound") then
				sound:SetAttribute("GunMuteBound", true);
				sound:GetPropertyChangedSignal("Volume"):Connect(function()
					if (Toggles.DisableGunSounds and Toggles.DisableGunSounds.Value and isRivalsGunSound(sound)) then
						pcall(function()
							sound.Volume = 0;
						end);
					end
				end);
				sound:GetPropertyChangedSignal("Playing"):Connect(function()
					if (sound.Playing and Toggles.DisableGunSounds and Toggles.DisableGunSounds.Value and isRivalsGunSound(sound)) then
						pcall(function()
							sound:Stop();
							sound.Volume = 0;
						end);
					end
				end);
			end
			if (Toggles.DisableGunSounds and Toggles.DisableGunSounds.Value) then
				silenceGunSound(sound);
			end
		end
		local function RefreshGunSoundMute()
			if not (Toggles.DisableGunSounds and Toggles.DisableGunSounds.Value) then
				return;
			end
			local vm = workspace:FindFirstChild("ViewModels");
			if vm then
				for _, d in ipairs(vm:GetDescendants()) do
					if d:IsA("Sound") then
						bindGunSoundGuard(d);
					elseif d:IsA("SoundGroup") then
						d.Volume = 0;
					end
				end
			end
			local cam = workspace.CurrentCamera;
			if cam then
				for _, d in ipairs(cam:GetDescendants()) do
					if d:IsA("Sound") then
						bindGunSoundGuard(d);
					end
				end
			end
		end
		workspace.DescendantAdded:Connect(function(d)
			if (d:IsA("Sound") and Toggles.DisableGunSounds and Toggles.DisableGunSounds.Value) then
				bindGunSoundGuard(d);
			end
		end);
		Toggles.DisableGunSounds:OnChanged(function(v)
			if v then
				RefreshGunSoundMute();
			end
		end);
		_G.RefreshGunSoundMute = RefreshGunSoundMute;
	end
	local UpdateFOVVisuals, DestroyFOVVisuals;
	do
		local fovGui = Instance.new("ScreenGui");
		fovGui.Name = "M4rs_FOV";
		fovGui.DisplayOrder = 999990;
		fovGui.ResetOnSpawn = false;
		fovGui.IgnoreGuiInset = true;
		fovGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		pcall(function()
			if gethui then
				fovGui.Parent = gethui();
			elseif (syn and syn.protect_gui) then
				syn.protect_gui(fovGui);
				fovGui.Parent = game:GetService("CoreGui");
			else
				fovGui.Parent = game:GetService("CoreGui");
			end
		end);
		local silentFovFrame = Instance.new("Frame");
		silentFovFrame.Name = "SilentFovFrame";
		silentFovFrame.AnchorPoint = Vector2.new(0.5, 0.5);
		silentFovFrame.BorderSizePixel = 0;
		silentFovFrame.BackgroundTransparency = 1;
		silentFovFrame.Visible = false;
		silentFovFrame.Parent = fovGui;
		local silentFovCorner = Instance.new("UICorner");
		silentFovCorner.CornerRadius = UDim.new(1, 0);
		silentFovCorner.Parent = silentFovFrame;
		local silentFovFillGrad = Instance.new("UIGradient");
		silentFovFillGrad.Parent = silentFovFrame;
		local silentFovStroke = Instance.new("UIStroke");
		silentFovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		silentFovStroke.Thickness = 1.5;
		silentFovStroke.Parent = silentFovFrame;
		local silentFovStrokeGrad = Instance.new("UIGradient");
		silentFovStrokeGrad.Parent = silentFovStroke;
		local aimbotFovFrame = Instance.new("Frame");
		aimbotFovFrame.Name = "AimbotFovFrame";
		aimbotFovFrame.AnchorPoint = Vector2.new(0.5, 0.5);
		aimbotFovFrame.BorderSizePixel = 0;
		aimbotFovFrame.BackgroundTransparency = 1;
		aimbotFovFrame.Visible = false;
		aimbotFovFrame.Parent = fovGui;
		local aimbotFovCorner = Instance.new("UICorner");
		aimbotFovCorner.CornerRadius = UDim.new(1, 0);
		aimbotFovCorner.Parent = aimbotFovFrame;
		local aimbotFovFillGrad = Instance.new("UIGradient");
		aimbotFovFillGrad.Parent = aimbotFovFrame;
		local aimbotFovStroke = Instance.new("UIStroke");
		aimbotFovStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		aimbotFovStroke.Thickness = 1.5;
		aimbotFovStroke.Parent = aimbotFovFrame;
		local aimbotFovStrokeGrad = Instance.new("UIGradient");
		aimbotFovStrokeGrad.Parent = aimbotFovStroke;
		local silentFovCircle = Drawing.new("Circle");
		silentFovCircle.Filled = false;
		silentFovCircle.Thickness = 1.5;
		silentFovCircle.Visible = false;
		local silentFovFillCircle = Drawing.new("Circle");
		silentFovFillCircle.Filled = true;
		silentFovFillCircle.Thickness = 0;
		silentFovFillCircle.Visible = false;
		local aimbotFovCircle = Drawing.new("Circle");
		aimbotFovCircle.Filled = false;
		aimbotFovCircle.Thickness = 1.5;
		aimbotFovCircle.Visible = false;
		local aimbotFovFillCircle = Drawing.new("Circle");
		aimbotFovFillCircle.Filled = true;
		aimbotFovFillCircle.Thickness = 0;
		aimbotFovFillCircle.Visible = false;
		function UpdateFOVVisuals(dt)
			local mouseLoc = UserInputService:GetMouseLocation();
			local cam = workspace.CurrentCamera;
			local curTime = tick();
			local showSilent = Toggles.ShowFOV and Toggles.ShowFOV.Value;
			if showSilent then
				local radius = (Options.FOVRadius and Options.FOVRadius.Value) or 100;
				local centerPos = mouseLoc;
				if (Toggles.SilentFOVFollowMuzzle and Toggles.SilentFOVFollowMuzzle.Value and cam) then
					local muz = GetMuzzlePosition();
					local sPos, onScreen = cam:WorldToViewportPoint(muz);
					if onScreen then
						centerPos = Vector2.new(sPos.X, sPos.Y);
					end
				end
				silentFovFrame.Visible = true;
				silentFovFrame.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y);
				silentFovFrame.Size = UDim2.new(0, radius * 2, 0, radius * 2);
				local outThick = (Options.SilentFOVOutlineThickness and Options.SilentFOVOutlineThickness.Value) or 1.5;
				local outTrans = (Options.SilentFOVOutlineTransparency and Options.SilentFOVOutlineTransparency.Value) or 0;
				local outCol1 = (Options.FOVOutlineColor1 and Options.FOVOutlineColor1.Value) or Color3.fromRGB(255, 255, 255);
				local outCol2 = (Options.FOVOutlineColor2 and Options.FOVOutlineColor2.Value) or Color3.fromRGB(255, 255, 255);
				local outBaseRot = (Options.SilentFOVOutlineRotation and Options.SilentFOVOutlineRotation.Value) or 0;
				local spinOn = Toggles.SilentFOVSpin and Toggles.SilentFOVSpin.Value;
				local spinSpd = (Options.SilentFOVSpinSpd and Options.SilentFOVSpinSpd.Value) or 1;
				local spinDeg = (spinOn and ((curTime * spinSpd * 60) % 360)) or 0;
				silentFovStroke.Thickness = outThick;
				silentFovStroke.Transparency = outTrans;
				silentFovStrokeGrad.Color = ColorSequence.new(outCol1, outCol2);
				silentFovStrokeGrad.Rotation = (outBaseRot + spinDeg) % 360;
				local filled = Toggles.SilentFOVFilled and Toggles.SilentFOVFilled.Value;
				if filled then
					local fCol1 = (Options.SilentFOVFillColor1 and Options.SilentFOVFillColor1.Value) or Color3.fromRGB(255, 255, 255);
					local fCol2 = (Options.SilentFOVFillColor2 and Options.SilentFOVFillColor2.Value) or Color3.fromRGB(0, 0, 0);
					local fTrans = (Options.SilentFOVFillTransparency and Options.SilentFOVFillTransparency.Value) or 0.7;
					local fBaseRot = (Options.SilentFOVFillRotation and Options.SilentFOVFillRotation.Value) or 0;
					local fAnimOn = Toggles.SilentFOVFillAnimated and Toggles.SilentFOVFillAnimated.Value;
					local fAnimSpd = (Options.SilentFOVFillSpeed and Options.SilentFOVFillSpeed.Value) or 1;
					local fAnimDeg = (fAnimOn and ((curTime * fAnimSpd * 60) % 360)) or 0;
					silentFovFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					silentFovFrame.BackgroundTransparency = 0;
					silentFovFillGrad.Color = ColorSequence.new(fCol1, fCol2);
					silentFovFillGrad.Transparency = NumberSequence.new(fTrans);
					silentFovFillGrad.Rotation = (fBaseRot + fAnimDeg + spinDeg) % 360;
					silentFovFillCircle.Visible = true;
					silentFovFillCircle.Radius = radius;
					silentFovFillCircle.Position = centerPos;
					silentFovFillCircle.Color = fCol1;
					silentFovFillCircle.Transparency = 1 - fTrans;
				else
					silentFovFrame.BackgroundTransparency = 1;
					silentFovFillCircle.Visible = false;
				end
				silentFovCircle.Visible = true;
				silentFovCircle.Radius = radius;
				silentFovCircle.Position = centerPos;
				silentFovCircle.Color = outCol1;
				silentFovCircle.Thickness = outThick;
				silentFovCircle.Transparency = 1 - outTrans;
			else
				silentFovFrame.Visible = false;
				silentFovCircle.Visible = false;
				silentFovFillCircle.Visible = false;
			end
			local showAimbot = Toggles.ShowAimbotFOV and Toggles.ShowAimbotFOV.Value;
			if showAimbot then
				local radius = (Options.AimbotFOV and Options.AimbotFOV.Value) or 500;
				local centerPos = mouseLoc;
				if (Toggles.AimbotFOVFollowMuzzle and Toggles.AimbotFOVFollowMuzzle.Value and cam) then
					local muz = GetMuzzlePosition();
					local sPos, onScreen = cam:WorldToViewportPoint(muz);
					if onScreen then
						centerPos = Vector2.new(sPos.X, sPos.Y);
					end
				end
				aimbotFovFrame.Visible = true;
				aimbotFovFrame.Position = UDim2.new(0, centerPos.X, 0, centerPos.Y);
				aimbotFovFrame.Size = UDim2.new(0, radius * 2, 0, radius * 2);
				local outThick = (Options.AimbotFOVOutlineThickness and Options.AimbotFOVOutlineThickness.Value) or 1.5;
				local outTrans = (Options.AimbotFOVOutlineTransparency and Options.AimbotFOVOutlineTransparency.Value) or 0;
				local outCol1 = (Options.AimbotFOVOutlineColor1 and Options.AimbotFOVOutlineColor1.Value) or Color3.fromRGB(255, 255, 255);
				local outCol2 = (Options.AimbotFOVOutlineColor2 and Options.AimbotFOVOutlineColor2.Value) or Color3.fromRGB(255, 255, 255);
				local outBaseRot = (Options.AimbotFOVOutlineRotation and Options.AimbotFOVOutlineRotation.Value) or 0;
				local spinOn = Toggles.AimbotFOVSpin and Toggles.AimbotFOVSpin.Value;
				local spinSpd = (Options.AimbotFOVSpinSpd and Options.AimbotFOVSpinSpd.Value) or 1;
				local spinDeg = (spinOn and ((curTime * spinSpd * 60) % 360)) or 0;
				aimbotFovStroke.Thickness = outThick;
				aimbotFovStroke.Transparency = outTrans;
				aimbotFovStrokeGrad.Color = ColorSequence.new(outCol1, outCol2);
				aimbotFovStrokeGrad.Rotation = (outBaseRot + spinDeg) % 360;
				local filled = Toggles.AimbotFOVFilled and Toggles.AimbotFOVFilled.Value;
				if filled then
					local fCol1 = (Options.AimbotFOVFillColor1 and Options.AimbotFOVFillColor1.Value) or Color3.fromRGB(255, 255, 255);
					local fCol2 = (Options.AimbotFOVFillColor2 and Options.AimbotFOVFillColor2.Value) or Color3.fromRGB(0, 0, 0);
					local fTrans = (Options.AimbotFOVFillTransparency and Options.AimbotFOVFillTransparency.Value) or 0.7;
					local fBaseRot = (Options.AimbotFOVFillRotation and Options.AimbotFOVFillRotation.Value) or 0;
					local fAnimOn = Toggles.AimbotFOVFillAnimated and Toggles.AimbotFOVFillAnimated.Value;
					local fAnimSpd = (Options.AimbotFOVFillSpeed and Options.AimbotFOVFillSpeed.Value) or 1;
					local fAnimDeg = (fAnimOn and ((curTime * fAnimSpd * 60) % 360)) or 0;
					aimbotFovFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
					aimbotFovFrame.BackgroundTransparency = 0;
					aimbotFovFillGrad.Color = ColorSequence.new(fCol1, fCol2);
					aimbotFovFillGrad.Transparency = NumberSequence.new(fTrans);
					aimbotFovFillGrad.Rotation = (fBaseRot + fAnimDeg + spinDeg) % 360;
					aimbotFovFillCircle.Visible = true;
					aimbotFovFillCircle.Radius = radius;
					aimbotFovFillCircle.Position = centerPos;
					aimbotFovFillCircle.Color = fCol1;
					aimbotFovFillCircle.Transparency = 1 - fTrans;
				else
					aimbotFovFrame.BackgroundTransparency = 1;
					aimbotFovFillCircle.Visible = false;
				end
				aimbotFovCircle.Visible = true;
				aimbotFovCircle.Radius = radius;
				aimbotFovCircle.Position = centerPos;
				aimbotFovCircle.Color = outCol1;
				aimbotFovCircle.Thickness = outThick;
				aimbotFovCircle.Transparency = 1 - outTrans;
			else
				aimbotFovFrame.Visible = false;
				aimbotFovCircle.Visible = false;
				aimbotFovFillCircle.Visible = false;
			end
		end
		function DestroyFOVVisuals()
			pcall(function()
				if fovGui then
					fovGui:Destroy();
				end
				silentFovCircle:Remove();
				if silentFovFillCircle then
					silentFovFillCircle:Remove();
				end
				aimbotFovCircle:Remove();
				if aimbotFovFillCircle then
					aimbotFovFillCircle:Remove();
				end
			end);
		end
	end
	local ESP_Holders = {};
	local r15BonePairs = {{"Head","UpperTorso"},{"UpperTorso","LowerTorso"},{"UpperTorso","LeftUpperArm"},{"LeftUpperArm","LeftLowerArm"},{"LeftLowerArm","LeftHand"},{"UpperTorso","RightUpperArm"},{"RightUpperArm","RightLowerArm"},{"RightLowerArm","RightHand"},{"LowerTorso","LeftUpperLeg"},{"LeftUpperLeg","LeftLowerLeg"},{"LeftLowerLeg","LeftFoot"},{"LowerTorso","RightUpperLeg"},{"RightUpperLeg","RightLowerLeg"},{"RightLowerLeg","RightFoot"}};
	local r6BonePairs = {{"Head","Torso"},{"Torso","Left Arm"},{"Torso","Right Arm"},{"Torso","Left Leg"},{"Torso","Right Leg"}};
	local espgui = Instance.new("ScreenGui");
	espgui.Name = "M4rs_ESP";
	espgui.DisplayOrder = 999999;
	espgui.ResetOnSpawn = false;
	espgui.IgnoreGuiInset = true;
	espgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
	pcall(function()
		if gethui then
			espgui.Parent = gethui();
		elseif (syn and syn.protect_gui) then
			syn.protect_gui(espgui);
			espgui.Parent = game:GetService("CoreGui");
		else
			espgui.Parent = game:GetService("CoreGui");
		end
	end);
	local function CreateEspHolder(player)
		if ESP_Holders[player] then
			return;
		end
		local h = {BoxOutline=Drawing.new("Square"),Box=Drawing.new("Square"),BoxInline=Drawing.new("Square"),HealthOutline=Drawing.new("Square"),HealthFill=Drawing.new("Square"),Name=Drawing.new("Text"),Distance=Drawing.new("Text"),Tool=Drawing.new("Text"),Tracer=Drawing.new("Line"),Skeleton={},Highlight=nil,Filled=nil,FilledGradient=nil,Glow=nil,GlowGradient=nil};
		h.BoxOutline.Filled = false;
		h.BoxOutline.Thickness = 1;
		h.BoxOutline.Color = Color3.fromRGB(0, 0, 0);
		h.BoxOutline.Visible = false;
		h.Box.Filled = false;
		h.Box.Thickness = 1.5;
		h.Box.Color = Color3.fromRGB(255, 255, 255);
		h.Box.Visible = false;
		h.BoxInline.Filled = false;
		h.BoxInline.Thickness = 1;
		h.BoxInline.Color = Color3.fromRGB(0, 0, 0);
		h.BoxInline.Visible = false;
		h.HealthOutline.Filled = true;
		h.HealthOutline.Color = Color3.fromRGB(0, 0, 0);
		h.HealthOutline.Visible = false;
		h.HealthFill.Filled = true;
		h.HealthFill.Color = Color3.fromRGB(45, 255, 120);
		h.HealthFill.Visible = false;
		h.Name.Size = 13;
		h.Name.Center = true;
		h.Name.Outline = true;
		h.Name.OutlineColor = Color3.fromRGB(0, 0, 0);
		h.Name.Color = Color3.fromRGB(255, 255, 255);
		h.Name.Visible = false;
		h.Distance.Size = 11;
		h.Distance.Center = true;
		h.Distance.Outline = true;
		h.Distance.OutlineColor = Color3.fromRGB(0, 0, 0);
		h.Distance.Color = Color3.fromRGB(220, 220, 230);
		h.Distance.Visible = false;
		h.Tool.Size = 11;
		h.Tool.Center = true;
		h.Tool.Outline = true;
		h.Tool.OutlineColor = Color3.fromRGB(0, 0, 0);
		h.Tool.Color = Color3.fromRGB(200, 220, 255);
		h.Tool.Visible = false;
		h.Tracer.Thickness = 1;
		h.Tracer.Color = Color3.fromRGB(255, 255, 255);
		h.Tracer.Visible = false;
		for i = 1, 14 do
			local l = Drawing.new("Line");
			l.Thickness = 1.2;
			l.Color = Color3.fromRGB(255, 255, 255);
			l.Visible = false;
			table.insert(h.Skeleton, l);
		end
		pcall(function()
			local filled = Instance.new("Frame");
			filled.Name = "EspFill_" .. player.Name;
			filled.BackgroundColor3 = Color3.new(1, 1, 1);
			filled.BackgroundTransparency = 0.7;
			filled.BorderSizePixel = 0;
			filled.Visible = false;
			filled.ZIndex = 2;
			filled.Parent = espgui;
			local filled_gradient = Instance.new("UIGradient");
			filled_gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
			filled_gradient.Rotation = 0;
			filled_gradient.Parent = filled;
			local glow = Instance.new("ImageLabel");
			glow.Name = "EspGlow_" .. player.Name;
			glow.Image = "rbxassetid://110204605000367";
			glow.ScaleType = Enum.ScaleType.Slice;
			glow.SliceCenter = Rect.new(Vector2.new(21, 21), Vector2.new(79, 79));
			glow.ImageTransparency = 0.8;
			glow.BackgroundTransparency = 1;
			glow.BorderSizePixel = 0;
			glow.ZIndex = 1;
			glow.Visible = false;
			glow.Parent = espgui;
			local glow_gradient = Instance.new("UIGradient");
			glow_gradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255));
			glow_gradient.Rotation = 0;
			glow_gradient.Parent = glow;
			h.Filled = filled;
			h.FilledGradient = filled_gradient;
			h.Glow = glow;
			h.GlowGradient = glow_gradient;
		end);
		ESP_Holders[player] = h;
	end
	local function RemoveEspHolder(player)
		local h = ESP_Holders[player];
		if not h then
			return;
		end
		pcall(function()
			h.BoxOutline:Remove();
			h.Box:Remove();
			h.BoxInline:Remove();
			h.HealthOutline:Remove();
			h.HealthFill:Remove();
			h.Name:Remove();
			h.Distance:Remove();
			h.Tool:Remove();
			h.Tracer:Remove();
			for _, l in ipairs(h.Skeleton) do
				l:Remove();
			end
			if h.Highlight then
				h.Highlight:Destroy();
			end
			if h.Filled then
				h.Filled:Destroy();
			end
			if h.Glow then
				h.Glow:Destroy();
			end
		end);
		ESP_Holders[player] = nil;
	end
	local function HideEspHolder(h)
		h.BoxOutline.Visible = false;
		h.Box.Visible = false;
		h.BoxInline.Visible = false;
		h.HealthOutline.Visible = false;
		h.HealthFill.Visible = false;
		h.Name.Visible = false;
		h.Distance.Visible = false;
		h.Tool.Visible = false;
		h.Tracer.Visible = false;
		for _, l in ipairs(h.Skeleton) do
			l.Visible = false;
		end
		if h.Highlight then
			h.Highlight.Enabled = false;
		end
		if h.Filled then
			h.Filled.Visible = false;
		end
		if h.Glow then
			h.Glow.Visible = false;
		end
	end
	local function UpdateAllEsp()
		local masterOn = Toggles.box_enabled and Toggles.box_enabled.Value;
		local inMatch = IsInMatch();
		local cam = workspace.CurrentCamera;
		if not cam then
			return;
		end
		if (not masterOn or not inMatch) then
			for _, h in pairs(ESP_Holders) do
				HideEspHolder(h);
			end
			return;
		end
		for player, h in pairs(ESP_Holders) do
			if not player.Parent then
				HideEspHolder(h);
			else
				local isTeam = IsTeammate(player);
				local char = player.Character;
				local hum = char and char:FindFirstChildOfClass("Humanoid");
				local hrp = char and char:FindFirstChild("HumanoidRootPart");
				local head = char and char:FindFirstChild("Head");
				if (isTeam or not hum or (hum.Health <= 0) or not hrp or not head) then
					HideEspHolder(h);
				else
					local headPos = head.Position + Vector3.new(0, 0.6, 0);
					local feetPos = hrp.Position - Vector3.new(0, 3, 0);
					local topSP, topOk = cam:WorldToViewportPoint(headPos);
					local botSP, botOk = cam:WorldToViewportPoint(feetPos);
					if (topOk and botOk and (topSP.Z > 0) and (botSP.Z > 0)) then
						local boxHeight = math.abs(botSP.Y - topSP.Y);
						local boxWidth = math.max(boxHeight * 0.55, 6);
						local boxX = math.floor(topSP.X - (boxWidth / 2));
						local boxY = math.floor(math.min(topSP.Y, botSP.Y));
						local isVisible = false;
						if (Toggles.esp_visible_check and Toggles.esp_visible_check.Value) then
							local origin = cam.CFrame.Position;
							local target = head.Position;
							local rayParams = RaycastParams.new();
							rayParams.FilterType = Enum.RaycastFilterType.Exclude;
							rayParams.FilterDescendantsInstances = {LocalPlayer.Character,cam};
							local rayResult = workspace:Raycast(origin, target - origin, rayParams);
							if (rayResult and rayResult.Instance and rayResult.Instance:IsDescendantOf(char)) then
								isVisible = true;
							elseif not rayResult then
								isVisible = true;
							end
						end
						if not h.LastHealth then
							h.LastHealth = hum.Health;
						end
						if (hum.Health >= h.LastHealth) then
						else
							h.HitFlashTime = tick();
						end
						h.LastHealth = hum.Health;
						local isHitFlashing = Toggles.esp_hit_flash and Toggles.esp_hit_flash.Value and ((tick() - (h.HitFlashTime or 0)) < 0.16);
						local flowOffset = 0;
						if (Toggles.esp_text_flow and Toggles.esp_text_flow.Value) then
							flowOffset = math.sin((tick() * 4) + (player.UserId % 10)) * 3;
						end
						if (Toggles.box_enabled2 and Toggles.box_enabled2.Value) then
							local col1 = (Options.box_outline_color and Options.box_outline_color.Value) or Color3.fromRGB(255, 255, 255);
							local col2 = (Options.box_outline_color2 and Options.box_outline_color2.Value) or col1;
							local boxCol = col1:Lerp(col2, (math.sin(tick() * 3) + 1) / 2);
							if (Toggles.esp_visible_check and Toggles.esp_visible_check.Value) then
								local visCol = (Options.esp_visible_color and Options.esp_visible_color.Value) or Color3.fromRGB(0, 255, 120);
								local occCol = (Options.esp_occluded_color and Options.esp_occluded_color.Value) or Color3.fromRGB(255, 50, 50);
								boxCol = (isVisible and visCol) or occCol;
							end
							if isHitFlashing then
								boxCol = Color3.fromRGB(255, 255, 255);
							end
							h.BoxOutline.Visible = true;
							h.BoxOutline.Position = Vector2.new(boxX - 1, boxY - 1);
							h.BoxOutline.Size = Vector2.new(boxWidth + 2, boxHeight + 2);
							h.Box.Visible = true;
							h.Box.Position = Vector2.new(boxX, boxY);
							h.Box.Size = Vector2.new(boxWidth, boxHeight);
							h.Box.Color = boxCol;
							h.BoxInline.Visible = true;
							h.BoxInline.Position = Vector2.new(boxX + 1, boxY + 1);
							h.BoxInline.Size = Vector2.new(math.max(boxWidth - 2, 2), math.max(boxHeight - 2, 2));
						else
							h.BoxOutline.Visible = false;
							h.Box.Visible = false;
							h.BoxInline.Visible = false;
						end
						if (Toggles.box_filled and Toggles.box_filled.Value and h.Filled and h.FilledGradient) then
							local cStart = (Options.box_filled_color_start and Options.box_filled_color_start.Value) or Color3.fromRGB(255, 255, 255);
							local cEnd = (Options.box_filled_color_end and Options.box_filled_color_end.Value) or Color3.fromRGB(255, 255, 255);
							local trans = (Options.box_filled_transparency and Options.box_filled_transparency.Value) or 0.7;
							local rot = (Options.box_filled_rotation and Options.box_filled_rotation.Value) or 0;
							local spd = (Options.box_filled_speed and Options.box_filled_speed.Value) or 1;
							local anim = Toggles.box_filled_animated and Toggles.box_filled_animated.Value;
							h.Filled.Visible = true;
							h.Filled.BackgroundTransparency = trans;
							h.Filled.Position = UDim2.fromOffset(boxX, boxY);
							h.Filled.Size = UDim2.fromOffset(boxWidth, boxHeight);
							h.FilledGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, cStart),ColorSequenceKeypoint.new(1, cEnd)});
							if anim then
								h.FilledGradient.Rotation = (math.sin(tick() * spd) * 90) + rot;
							else
								h.FilledGradient.Rotation = rot;
							end
						elseif h.Filled then
							h.Filled.Visible = false;
						end
						if (Toggles.box_glow and Toggles.box_glow.Value and Toggles.box_enabled2 and Toggles.box_enabled2.Value and h.Glow and h.GlowGradient) then
							local gStart = (Options.box_glow_color_start and Options.box_glow_color_start.Value) or Color3.fromRGB(255, 255, 255);
							local gEnd = (Options.box_glow_color_end and Options.box_glow_color_end.Value) or Color3.fromRGB(255, 255, 255);
							local gTrans = (Options.box_glow_transparency and Options.box_glow_transparency.Value) or 0.8;
							local gRot = (Options.box_glow_rotation and Options.box_glow_rotation.Value) or 0;
							h.Glow.Visible = true;
							h.Glow.ImageTransparency = gTrans;
							h.Glow.Position = UDim2.fromOffset(boxX - 21, boxY - 21);
							h.Glow.Size = UDim2.fromOffset(boxWidth + 42, boxHeight + 42);
							h.GlowGradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, gStart),ColorSequenceKeypoint.new(1, gEnd)});
							h.GlowGradient.Rotation = gRot;
						elseif h.Glow then
							h.Glow.Visible = false;
						end
						if (Toggles.healthbar and Toggles.healthbar.Value) then
							local maxHp = math.max(hum.MaxHealth, 1);
							local curHp = math.clamp(hum.Health, 0, maxHp);
							local hpPct = curHp / maxHp;
							local barHeight = math.floor(boxHeight * hpPct);
							h.HealthOutline.Visible = true;
							h.HealthOutline.Position = Vector2.new(boxX - 6, boxY - 1);
							h.HealthOutline.Size = Vector2.new(4, boxHeight + 2);
							h.HealthFill.Visible = true;
							h.HealthFill.Position = Vector2.new(boxX - 5, boxY + (boxHeight - barHeight));
							h.HealthFill.Size = Vector2.new(2, barHeight);
							local cHigh = (Options.ColorPicker121212 and Options.ColorPicker121212.Value) or Color3.fromRGB(45, 255, 120);
							local cMid = (Options.ColorPicker21 and Options.ColorPicker21.Value) or Color3.fromRGB(255, 220, 50);
							local cLow = (Options.ColorPicker45 and Options.ColorPicker45.Value) or Color3.fromRGB(255, 50, 60);
							if (hpPct > 0.5) then
								h.HealthFill.Color = cMid:Lerp(cHigh, (hpPct - 0.5) * 2);
							else
								h.HealthFill.Color = cLow:Lerp(cMid, hpPct * 2);
							end
						else
							h.HealthOutline.Visible = false;
							h.HealthFill.Visible = false;
						end
						if (Toggles.textesp and Toggles.textesp.Value) then
							local col1 = (Options.name_color and Options.name_color.Value) or Color3.fromRGB(255, 255, 255);
							local col2 = (Options.name_color2 and Options.name_color2.Value) or col1;
							h.Name.Visible = true;
							h.Name.Text = player.DisplayName or player.Name;
							h.Name.Color = col1:Lerp(col2, (math.sin(tick() * 2) + 1) / 2);
							h.Name.Position = Vector2.new(boxX + (boxWidth / 2) + flowOffset, boxY - 16);
							h.Name.Size = (Options.textesp_namesize and Options.textesp_namesize.Value) or 12;
						else
							h.Name.Visible = false;
						end
						local textOffset = 2;
						if (Toggles.textesp_distance and Toggles.textesp_distance.Value) then
							local col1 = (Options.distance_color and Options.distance_color.Value) or Color3.fromRGB(220, 220, 230);
							local col2 = (Options.distance_color2 and Options.distance_color2.Value) or col1;
							local dist = (hrp.Position - cam.CFrame.Position).Magnitude;
							h.Distance.Visible = true;
							h.Distance.Text = string.format("%d m", math.floor(dist * 0.28));
							h.Distance.Color = col1:Lerp(col2, (math.sin(tick() * 2) + 1) / 2);
							h.Distance.Position = Vector2.new(boxX + (boxWidth / 2) + flowOffset, boxY + boxHeight + textOffset);
							h.Distance.Size = (Options.textesp_distancesize and Options.textesp_distancesize.Value) or 11;
							textOffset = textOffset + 14;
						else
							h.Distance.Visible = false;
						end
						if (Toggles.textesp_tools and Toggles.textesp_tools.Value) then
							local col1 = (Options.tool_color and Options.tool_color.Value) or Color3.fromRGB(200, 220, 255);
							local col2 = (Options.tool_color2 and Options.tool_color2.Value) or col1;
							local weapName = GetPlayerWeapon(player);
							h.Tool.Visible = true;
							h.Tool.Text = weapName;
							h.Tool.Color = col1:Lerp(col2, (math.sin(tick() * 2) + 1) / 2);
							h.Tool.Position = Vector2.new(boxX + (boxWidth / 2) + flowOffset, boxY + boxHeight + textOffset);
							h.Tool.Size = (Options.textesp_toolssize and Options.textesp_toolssize.Value) or 11;
						else
							h.Tool.Visible = false;
						end
						if (Toggles.tracers and Toggles.tracers.Value) then
							local col1 = (Options.tracers_color and Options.tracers_color.Value) or Color3.fromRGB(255, 255, 255);
							local col2 = (Options.tracers_color2 and Options.tracers_color2.Value) or col1;
							h.Tracer.Visible = true;
							h.Tracer.From = Vector2.new(cam.ViewportSize.X / 2, cam.ViewportSize.Y);
							h.Tracer.To = Vector2.new(boxX + (boxWidth / 2), boxY + boxHeight);
							h.Tracer.Color = col1:Lerp(col2, 0.5);
							h.Tracer.Thickness = (Options.tracers_thickness and Options.tracers_thickness.Value) or 1;
						else
							h.Tracer.Visible = false;
						end
						if (Toggles.skeleton and Toggles.skeleton.Value) then
							local col1 = (Options.skeleton_color and Options.skeleton_color.Value) or Color3.fromRGB(255, 255, 255);
							local col2 = (Options.skeleton_color2 and Options.skeleton_color2.Value) or col1;
							local skelThick = (Options.skeleton_thickness and Options.skeleton_thickness.Value) or 1.2;
							local bones = ((hum.RigType == Enum.HumanoidRigType.R15) and r15BonePairs) or r6BonePairs;
							for i = 1, #h.Skeleton do
								local pair = bones[i];
								local line = h.Skeleton[i];
								if pair then
									local p1 = char:FindFirstChild(pair[1]);
									local p2 = char:FindFirstChild(pair[2]);
									if (p1 and p2 and p1:IsA("BasePart") and p2:IsA("BasePart")) then
										local sp1, ok1 = cam:WorldToViewportPoint(p1.Position);
										local sp2, ok2 = cam:WorldToViewportPoint(p2.Position);
										if (ok1 and ok2 and (sp1.Z > 0) and (sp2.Z > 0)) then
											line.Visible = true;
											line.From = Vector2.new(sp1.X, sp1.Y);
											line.To = Vector2.new(sp2.X, sp2.Y);
											line.Color = col1:Lerp(col2, i / #h.Skeleton);
											line.Thickness = skelThick;
										else
											line.Visible = false;
										end
									else
										line.Visible = false;
									end
								else
									line.Visible = false;
								end
							end
						else
							for _, l in ipairs(h.Skeleton) do
								l.Visible = false;
							end
						end
						if (Toggles.chams and Toggles.chams.Value) then
							if (not h.Highlight or (h.Highlight.Parent ~= char)) then
								pcall(function()
									local oldHl = char:FindFirstChild("M4rsCham");
									if oldHl then
										oldHl:Destroy();
									end
									local hl = Instance.new("Highlight");
									hl.Name = "M4rsCham";
									hl.Adornee = char;
									hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
									hl.Parent = char;
									h.Highlight = hl;
								end);
							end
							if h.Highlight then
								local fillCol = (Options.chams_color and Options.chams_color.Value) or Color3.fromRGB(255, 255, 255);
								local outCol = (Options.chams_color2 and Options.chams_color2.Value) or Color3.fromRGB(255, 255, 255);
								local trans = (Options.chams_transparency and Options.chams_transparency.Value) or 0.3;
								h.Highlight.Enabled = true;
								h.Highlight.FillColor = fillCol;
								h.Highlight.OutlineColor = outCol;
								h.Highlight.FillTransparency = trans;
								h.Highlight.OutlineTransparency = 0;
							end
						elseif h.Highlight then
							h.Highlight.Enabled = false;
						end
					else
						HideEspHolder(h);
					end
				end
			end
		end
	end
	for _, p in ipairs(Players:GetPlayers()) do
		if (p == LocalPlayer) then
		else
			CreateEspHolder(p);
		end
	end
	Players.PlayerAdded:Connect(function(p)
		if (p ~= LocalPlayer) then
			CreateEspHolder(p);
		end
	end);
	Players.PlayerRemoving:Connect(RemoveEspHolder);
	do
		local utilGui = Instance.new("ScreenGui");
		utilGui.Name = "M4rs_UtilityESP";
		utilGui.ResetOnSpawn = false;
		utilGui.IgnoreGuiInset = true;
		utilGui.DisplayOrder = 450;
		pcall(function()
			if gethui then
				utilGui.Parent = gethui();
			elseif (syn and syn.protect_gui) then
				syn.protect_gui(utilGui);
				utilGui.Parent = game:GetService("CoreGui");
			else
				utilGui.Parent = game:GetService("CoreGui");
			end
		end);
		if not utilGui.Parent then
			pcall(function()
				utilGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui");
			end);
		end
		local utilItemThumbs = {grenade="rbxassetid://18698144948",flashbang="rbxassetid://18698145214",molotov="rbxassetid://18698145532",["smoke grenade"]="rbxassetid://18698145781",satchel="rbxassetid://18698145920",["subspace tripmine"]="rbxassetid://18698146115",warpstone="rbxassetid://18698146312"};
		local utilTrackers = {};
		local function removeUtilTracker(obj)
			if utilTrackers[obj] then
				pcall(function()
					if utilTrackers[obj].icon then
						utilTrackers[obj].icon:Destroy();
					end
					if utilTrackers[obj].name then
						utilTrackers[obj].name:Destroy();
					end
					if utilTrackers[obj].dist then
						utilTrackers[obj].dist:Destroy();
					end
				end);
				utilTrackers[obj] = nil;
			end
		end
		workspace.ChildRemoved:Connect(removeUtilTracker);
		local function matchUtilityType(objName)
			local n = objName:lower();
			if n:find("tripmine") then
				return "subspace tripmine";
			end
			if n:find("flashbang") then
				return "flashbang";
			end
			if n:find("molotov") then
				return "molotov";
			end
			if n:find("smoke") then
				return "smoke grenade";
			end
			if n:find("satchel") then
				return "satchel";
			end
			if n:find("warpstone") then
				return "warpstone";
			end
			if n:find("grenade") then
				return "grenade";
			end
			return nil;
		end
		Hub.UpdateUtilityEsp = function()
			if (not (Toggles.utilenable and Toggles.utilenable.Value) or not IsInMatch()) then
				for _, trk in pairs(utilTrackers) do
					if trk.icon then
						trk.icon.Visible = false;
					end
					if trk.name then
						trk.name.Visible = false;
					end
					if trk.dist then
						trk.dist.Visible = false;
					end
				end
				return;
			end
			local cam = workspace.CurrentCamera;
			if not cam then
				return;
			end
			local activeSet = (Options.utilitems and Options.utilitems.Value) or {};
			local showDist = Toggles.utildistance and Toggles.utildistance.Value;
			local showImg = Toggles.utilimages and Toggles.utilimages.Value;
			local col1 = (Options.utilcolor and Options.utilcolor.Value) or Color3.fromRGB(255, 255, 255);
			local seen = {};
			for _, obj in ipairs(workspace:GetChildren()) do
				local utype = matchUtilityType(obj.Name);
				if (utype and ((next(activeSet) == nil) or (activeSet[utype] == true))) then
					local root = (obj:IsA("BasePart") and obj) or (obj:IsA("Model") and (obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")));
					if root then
						seen[obj] = true;
						local trk = utilTrackers[obj];
						if not trk then
							local iconLabel = Instance.new("ImageLabel");
							iconLabel.BackgroundTransparency = 1;
							iconLabel.Size = UDim2.fromOffset(40, 40);
							iconLabel.Visible = false;
							iconLabel.Parent = utilGui;
							local nameLabel = Instance.new("TextLabel");
							nameLabel.BackgroundTransparency = 1;
							nameLabel.TextStrokeTransparency = 0;
							nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
							nameLabel.Font = Enum.Font.GothamBold;
							nameLabel.TextSize = 13;
							nameLabel.TextXAlignment = Enum.TextXAlignment.Center;
							nameLabel.Size = UDim2.fromOffset(120, 16);
							nameLabel.Visible = false;
							nameLabel.Parent = utilGui;
							local distLabel = Instance.new("TextLabel");
							distLabel.BackgroundTransparency = 1;
							distLabel.TextStrokeTransparency = 0;
							distLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
							distLabel.Font = Enum.Font.GothamMedium;
							distLabel.TextSize = 11;
							distLabel.TextXAlignment = Enum.TextXAlignment.Center;
							distLabel.Size = UDim2.fromOffset(120, 14);
							distLabel.Visible = false;
							distLabel.Parent = utilGui;
							utilTrackers[obj] = {icon=iconLabel,name=nameLabel,dist=distLabel,utype=utype};
							trk = utilTrackers[obj];
						end
						local pos, onScreen = cam:WorldToViewportPoint(root.Position);
						if (onScreen and (pos.Z > 0)) then
							local distance = math.floor((cam.CFrame.Position - root.Position).Magnitude * 0.28);
							if showImg then
								trk.icon.Visible = true;
								trk.icon.Image = utilItemThumbs[utype] or "";
								trk.icon.Position = UDim2.fromOffset(pos.X - 20, pos.Y - 45);
							else
								trk.icon.Visible = false;
							end
							trk.name.Visible = true;
							trk.name.TextColor3 = col1;
							trk.name.Position = UDim2.fromOffset(pos.X - 60, pos.Y - 6);
							trk.name.Text = obj.Name;
							if showDist then
								trk.dist.Visible = true;
								trk.dist.TextColor3 = Color3.fromRGB(200, 200, 200);
								trk.dist.Position = UDim2.fromOffset(pos.X - 60, pos.Y + 10);
								trk.dist.Text = string.format("%dm", distance);
							else
								trk.dist.Visible = false;
							end
						else
							trk.icon.Visible = false;
							trk.name.Visible = false;
							trk.dist.Visible = false;
						end
					end
				end
			end
			for obj, _ in pairs(utilTrackers) do
				if not seen[obj] then
					removeUtilTracker(obj);
				end
			end
		end;
		Hub.DestroyUtilityEsp = function()
			for obj, _ in pairs(utilTrackers) do
				removeUtilTracker(obj);
			end
			if utilGui then
				pcall(function()
					utilGui:Destroy();
				end);
			end
		end;
	end
	do
		local NO_ANIM_PATTERNS = {Idle={"idle","stand"},Reloading={"reload","mag","clip"},Sprinting={"sprint","run"},Crouching={"crouch","slide"},Shooting={"shoot","fire"},Aiming={"aim","ads"}};
		local function shouldBlockViewModelTrack(track)
			if not (Toggles.NoAnimations and Toggles.NoAnimations.Value) then
				return false;
			end
			local blocked = (Options.NoAnimationsList and Options.NoAnimationsList.Value) or {};
			local name = "";
			if track.Animation then
				name = (tostring(track.Animation.Name) .. " " .. tostring(track.Animation.AnimationId)):lower();
			else
				name = tostring(track.Name):lower();
			end
			for category, enabled in pairs(blocked) do
				if enabled then
					local patterns = NO_ANIM_PATTERNS[category];
					if patterns then
						for _, pat in ipairs(patterns) do
							if name:find(pat, 1, true) then
								return true;
							end
						end
					end
				end
			end
			return false;
		end
		local function stopBlockedViewModelTrack(track)
			if shouldBlockViewModelTrack(track) then
				pcall(function()
					track:Stop(0);
				end);
			end
		end
		local noAnimConns = {};
		local function scanAndHookAnimators()
			if not (Toggles.NoAnimations and Toggles.NoAnimations.Value) then
				return;
			end
			local vm = workspace:FindFirstChild("ViewModels");
			local fp = vm and vm:FindFirstChild("FirstPerson");
			if not fp then
				return;
			end
			for _, desc in ipairs(fp:GetDescendants()) do
				if (desc:IsA("Animator") and not desc:GetAttribute("NoAnimBound")) then
					desc:SetAttribute("NoAnimBound", true);
					local p = desc.Parent;
					if (p and p:IsA("Humanoid")) then
						table.insert(noAnimConns, p.AnimationPlayed:Connect(function(track)
							if (Toggles.NoAnimations and Toggles.NoAnimations.Value) then
								task.defer(function()
									stopBlockedViewModelTrack(track);
								end);
							end
						end));
					end
					for _, track in ipairs(desc:GetPlayingAnimationTracks()) do
						stopBlockedViewModelTrack(track);
					end
				end
			end
		end
		_G.StopNoAnim = function()
			for _, conn in ipairs(noAnimConns) do
				pcall(function()
					conn:Disconnect();
				end);
			end
			table.clear(noAnimConns);
		end;
		Hub.UpdateViewmodelMods = function()
			local vm = workspace:FindFirstChild("ViewModels");
			local fp = vm and vm:FindFirstChild("FirstPerson");
			if not fp then
				return;
			end
			local cam = workspace.CurrentCamera;
			if not cam then
				return;
			end
			if (Toggles.EnableViewport and Toggles.EnableViewport.Value) then
				local ox = (Options.OffsetX and Options.OffsetX.Value) or 0;
				local oy = (Options.OffsetY and Options.OffsetY.Value) or 0;
				local oz = (Options.OffsetZ and Options.OffsetZ.Value) or 0;
				local offsetCF = cam.CFrame * CFrame.new(ox, oy, oz);
				for _, model in ipairs(fp:GetChildren()) do
					if (model:IsA("Model") and model.PrimaryPart) then
						model:SetPrimaryPartCFrame(offsetCF);
					end
				end
			end
			if (Toggles.NoAnimations and Toggles.NoAnimations.Value) then
				scanAndHookAnimators();
			end
			do
				local vm_arm_keywords = {"arm","hand","sleeve","elbow","wrist","shoulder","finger","thumb","glove"};
				local function vm_is_arm(part)
					local name = string.lower(part.Name);
					for i = 1, #vm_arm_keywords do
						if string.find(name, vm_arm_keywords[i], 1, true) then
							return true;
						end
					end
					local ancestor = part.Parent;
					while ancestor and (ancestor ~= fp) and (ancestor ~= workspace) do
						local aname = string.lower(ancestor.Name);
						if (string.find(aname, "arm", 1, true) or string.find(aname, "rig", 1, true)) then
							return true;
						end
						ancestor = ancestor.Parent;
					end
					return false;
				end
				local gunChamOn = Toggles.GunChams and Toggles.GunChams.Value;
				local armChamOn = Toggles.ArmChams and Toggles.ArmChams.Value;
				local disableArms = (Toggles.DisableArms and Toggles.DisableArms.Value) or (Toggles.InvisibleArms and Toggles.InvisibleArms.Value);
				if (gunChamOn or armChamOn or disableArms) then
					local gunMat = (Options.GunMaterial and Enum.Material[Options.GunMaterial.Value]) or Enum.Material.Neon;
					local armMat = (Options.ArmMaterial and Enum.Material[Options.ArmMaterial.Value]) or Enum.Material.ForceField;
					local gunCol = (Options.GunColor1 and Options.GunColor1.Value) or Color3.fromRGB(255, 255, 255);
					local armCol = (Options.ArmColor1 and Options.ArmColor1.Value) or Color3.fromRGB(255, 255, 255);
					local gunTrans = (Options.GunChamTransparency and Options.GunChamTransparency.Value) or 0;
					local armTrans = (Options.ArmChamTransparency and Options.ArmChamTransparency.Value) or 0;
					for _, part in ipairs(fp:GetDescendants()) do
						if (part:IsA("BasePart") and (part.Size.Magnitude < 40)) then
							local isArm = vm_is_arm(part);
							if isArm then
								if disableArms then
									part.LocalTransparencyModifier = 1;
									part.Transparency = 1;
								elseif armChamOn then
									part.Material = armMat;
									part.Color = armCol;
									part.Transparency = armTrans;
									part.LocalTransparencyModifier = 0;
								end
							elseif gunChamOn then
								part.Material = gunMat;
								part.Color = gunCol;
								part.Transparency = gunTrans;
								part.LocalTransparencyModifier = 0;
							end
						end
					end
				end
				local myChar = LocalPlayer.Character;
				if myChar then
					if (Toggles.DisableClothes and Toggles.DisableClothes.Value) then
						for _, inst in ipairs(myChar:GetDescendants()) do
							if (inst:IsA("Shirt") and (inst.ShirtTemplate ~= "")) then
								inst.ShirtTemplate = "";
							elseif (inst:IsA("Pants") and (inst.PantsTemplate ~= "")) then
								inst.PantsTemplate = "";
							elseif (inst:IsA("ShirtGraphic") and (inst.Graphic ~= "")) then
								inst.Graphic = "";
							end
						end
					end
					if (Toggles.BodyCustomEnable and Toggles.BodyCustomEnable.Value) then
						local bCol = (Options.BodyCustomColor and Options.BodyCustomColor.Value) or Color3.fromRGB(255, 255, 255);
						local bMat = (Options.BodyCustomMaterial and Enum.Material[Options.BodyCustomMaterial.Value]) or Enum.Material.ForceField;
						local bTrans = (Options.BodyCustomTrans and Options.BodyCustomTrans.Value) or 0;
						for _, part in ipairs(myChar:GetChildren()) do
							if (part:IsA("BasePart") and (part.Name ~= "HumanoidRootPart")) then
								part.Material = bMat;
								part.Color = bCol;
								part.Transparency = bTrans;
							end
						end
					end
				end
				local gunHl = Toggles.GunHighlight and Toggles.GunHighlight.Value;
				local armHl = Toggles.ArmHighlight and Toggles.ArmHighlight.Value;
				local gunOl = Toggles.GunOutline and Toggles.GunOutline.Value;
				local armOl = Toggles.ArmOutline and Toggles.ArmOutline.Value;
				for _, model in ipairs(fp:GetChildren()) do
					if model:IsA("Model") then
						local isArm = vm_is_arm(model);
						if isArm then
							local hl = model:FindFirstChild("_M4rsArmHighlight");
							if (armHl and not disableArms) then
								if not hl then
									hl = Instance.new("Highlight");
									hl.Name = "_M4rsArmHighlight";
									hl.Adornee = model;
									hl.Parent = model;
								end
								hl.FillColor = (Options.ArmHighlightTop and Options.ArmHighlightTop.Value) or Color3.fromRGB(255, 255, 255);
								hl.OutlineColor = (Options.ArmHighlightBottom and Options.ArmHighlightBottom.Value) or Color3.fromRGB(200, 200, 255);
								hl.FillTransparency = (Options.ArmHighlightFillTransparency and Options.ArmHighlightFillTransparency.Value) or 0;
								hl.OutlineTransparency = (Options.ArmHighlightOutlineTransparency and Options.ArmHighlightOutlineTransparency.Value) or 0;
							elseif hl then
								hl:Destroy();
							end
							local ol = model:FindFirstChild("_M4rsArmOutline");
							if (armOl and not armHl and not disableArms) then
								if not ol then
									ol = Instance.new("Highlight");
									ol.Name = "_M4rsArmOutline";
									ol.Adornee = model;
									ol.FillTransparency = 1;
									ol.OutlineTransparency = 0;
									ol.Parent = model;
								end
								ol.OutlineColor = (Options.ArmOutlineColor1 and Options.ArmOutlineColor1.Value) or Color3.fromRGB(255, 255, 255);
							elseif ol then
								ol:Destroy();
							end
						else
							local hl = model:FindFirstChild("_M4rsGunHighlight");
							if gunHl then
								if not hl then
									hl = Instance.new("Highlight");
									hl.Name = "_M4rsGunHighlight";
									hl.Adornee = model;
									hl.Parent = model;
								end
								hl.FillColor = (Options.GunHighlightTop and Options.GunHighlightTop.Value) or Color3.fromRGB(255, 255, 255);
								hl.OutlineColor = (Options.GunHighlightBottom and Options.GunHighlightBottom.Value) or Color3.fromRGB(200, 200, 255);
								hl.FillTransparency = (Options.GunHighlightFillTransparency and Options.GunHighlightFillTransparency.Value) or 0;
								hl.OutlineTransparency = (Options.GunHighlightOutlineTransparency and Options.GunHighlightOutlineTransparency.Value) or 0;
							elseif hl then
								hl:Destroy();
							end
							local ol = model:FindFirstChild("_M4rsGunOutline");
							if (gunOl and not gunHl) then
								if not ol then
									ol = Instance.new("Highlight");
									ol.Name = "_M4rsGunOutline";
									ol.Adornee = model;
									ol.FillTransparency = 1;
									ol.OutlineTransparency = 0;
									ol.Parent = model;
								end
								ol.OutlineColor = (Options.GunOutlineColor1 and Options.GunOutlineColor1.Value) or Color3.fromRGB(255, 255, 255);
							elseif ol then
								ol:Destroy();
							end
						end
					end
				end
			end
		end;
		Hub.CleanMuzzleFlash = function()
			if not (Toggles.NoMuzzleFlash and Toggles.NoMuzzleFlash.Value) then
				return;
			end
			local vm = workspace:FindFirstChild("ViewModels");
			local fp = vm and vm:FindFirstChild("FirstPerson");
			if not fp then
				return;
			end
			for _, model in ipairs(fp:GetChildren()) do
				if model:IsA("Model") then
					local iv = model:FindFirstChild("ItemVisual");
					local body = iv and iv:FindFirstChild("Body");
					local bp = body and body:FindFirstChild("BodyPrimary");
					local muzzle = bp and bp:FindFirstChild("_muzzle");
					if muzzle then
						local light = muzzle:FindFirstChildWhichIsA("Light");
						if light then
							light:Destroy();
						end
						for _, c in ipairs(muzzle:GetChildren()) do
							if c:IsA("ParticleEmitter") then
								c.Enabled = false;
							end
						end
					end
				end
			end
		end;
	end
	do
		Misc.antiFlashConn1 = nil;
		Misc.antiFlashConn2 = nil;
		Misc.autoBanTask = nil;
		Misc.autoQueueTask = nil;
		Misc.inReloadVoid = false;
		Misc.savedReloadCF = nil;
		local function PatchFlashbang()
			pcall(function()
				local mods = ReplicatedStorage:FindFirstChild("Modules");
				local itemLib = mods and mods:FindFirstChild("ItemLibrary");
				if itemLib then
					local lib = SafeRequire(itemLib);
					if (lib and lib.Items and lib.Items.Flashbang) then
						lib.Items.Flashbang.BlindDuration = 0;
						if lib.Items.Flashbang.Info then
							lib.Items.Flashbang.Info.BlindDuration = 0;
						end
					end
				end
			end);
			if (Toggles.AntiFlashbang and Toggles.AntiFlashbang.Value) then
				pcall(function()
					for _, v in ipairs(workspace:GetChildren()) do
						if (v.Name ~= "FlashbangEffect") then
						else
							v:Destroy();
						end
					end
					local pg = LocalPlayer:FindFirstChild("PlayerGui");
					if pg then
						for _, v in ipairs(pg:GetChildren()) do
							if (v.Name ~= "FlashbangGui") then
							else
								v:Destroy();
							end
						end
					end
				end);
				if not Misc.antiFlashConn1 then
					Misc.antiFlashConn1 = workspace.ChildAdded:Connect(function(v)
						if (Toggles.AntiFlashbang and Toggles.AntiFlashbang.Value and (v.Name == "FlashbangEffect")) then
							task.defer(function()
								pcall(function()
									v:Destroy();
								end);
							end);
						end
					end);
				end
				if not Misc.antiFlashConn2 then
					local pg = LocalPlayer:FindFirstChild("PlayerGui");
					if pg then
						Misc.antiFlashConn2 = pg.ChildAdded:Connect(function(v)
							if (Toggles.AntiFlashbang and Toggles.AntiFlashbang.Value and (v.Name == "FlashbangGui")) then
								task.defer(function()
									pcall(function()
										v:Destroy();
									end);
								end);
							end
						end);
					end
				end
			else
				if Misc.antiFlashConn1 then
					Misc.antiFlashConn1:Disconnect();
					Misc.antiFlashConn1 = nil;
				end
				if Misc.antiFlashConn2 then
					Misc.antiFlashConn2:Disconnect();
					Misc.antiFlashConn2 = nil;
				end
			end
		end
		Misc.PatchFlashbang = PatchFlashbang;
		local lastTripmineCheck = 0;
		local function CheckAntiTripmine()
			if not (Toggles.AntiTrip and Toggles.AntiTrip.Value) then
				return;
			end
			if ((tick() - lastTripmineCheck) >= 0.15) then
			else
				return;
			end
			lastTripmineCheck = tick();
			local char = LocalPlayer.Character;
			local hrp = char and char:FindFirstChild("HumanoidRootPart");
			if (not hrp or not firetouchinterest) then
				return;
			end
			local maxDist = (Options.AntiTripDist and Options.AntiTripDist.Value) or 35;
			pcall(function()
				for _, s in ipairs(workspace:GetChildren()) do
					if ((s.Name == "SubspaceTripmineHitbox") or s.Name:find("Tripmine")) then
						local hb = s:FindFirstChild("Hitbox") or (s:IsA("BasePart") and s);
						if (hb and hb:IsA("BasePart") and ((hb.Position - hrp.Position).Magnitude < maxDist)) then
							firetouchinterest(hrp, hb, 1);
							task.defer(function()
								pcall(function()
									firetouchinterest(hrp, hb, 0);
								end);
							end);
						end
					end
				end
			end);
		end
		Misc.CheckAntiTripmine = CheckAntiTripmine;
		local deviceCodes = {Mobile="Touch",Console="Gamepad",VR="VR",PC="MouseKeyboard"};
		local function ApplyDeviceSpoof()
			if not (Toggles.device_spoof and Toggles.device_spoof.Value) then
				return;
			end
			pcall(function()
				local dev = (Options.device_type and Options.device_type.Value) or "Console";
				local code = deviceCodes[dev] or "Gamepad";
				ReplicatedStorage.Remotes.Replication.Fighter.SetControls:FireServer(code);
			end);
		end
		Misc.ApplyDeviceSpoof = ApplyDeviceSpoof;
		local staffRoles = {"mod","staff","contributor","admin","owner","builder","developer"};
		local function CheckStaff(player)
			if ((player == LocalPlayer) or (game.CreatorType ~= Enum.CreatorType.Group)) then
				return false;
			end
			local ok, role = pcall(function()
				return player:GetRoleInGroup(game.CreatorId);
			end);
			if (ok and role and (type(role) == "string")) then
				local lower = role:lower();
				for _, s in ipairs(staffRoles) do
					if lower:find(s) then
						return true, role;
					end
				end
			end
			return false;
		end
		local function ScanExistingStaff()
			if not (Toggles.moddetector and Toggles.moddetector.Value) then
				return;
			end
			for _, plr in ipairs(Players:GetPlayers()) do
				if (plr == LocalPlayer) then
				else
					local isStaff, role = CheckStaff(plr);
					if isStaff then
						PlayUiSound(6895079853);
						Library:Notify("[ALERT] Staff in server: " .. plr.Name .. " (" .. tostring(role) .. ")!", 8);
					end
				end
			end
		end
		Misc.ScanExistingStaff = ScanExistingStaff;
		Players.PlayerAdded:Connect(function(plr)
			if (Toggles.moddetector and Toggles.moddetector.Value) then
				task.wait(1);
				local isStaff, role = CheckStaff(plr);
				if isStaff then
					PlayUiSound(6895079853);
					Library:Notify("[ALERT] Staff member detected: " .. plr.Name .. " (" .. tostring(role) .. ")!", 8);
				end
			end
		end);
		local function UpdateAutoBan()
			if Misc.autoBanTask then
				task.cancel(Misc.autoBanTask);
				Misc.autoBanTask = nil;
			end
			if (Toggles.AutoBanQueueEnable and Toggles.AutoBanQueueEnable.Value) then
				Misc.autoBanTask = task.spawn(function()
					local voteRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Duels"):WaitForChild("Vote");
					while Toggles.AutoBanQueueEnable and Toggles.AutoBanQueueEnable.Value do
						local w1 = Options.first and Options.first.Value;
						local w2 = Options.second and Options.second.Value;
						if (w1 and (w1 ~= "")) then
							pcall(function()
								voteRemote:FireServer(w1);
							end);
							task.wait(0.5);
						end
						if (w2 and (w2 ~= "")) then
							pcall(function()
								voteRemote:FireServer(w2);
							end);
							task.wait(0.5);
						end
						task.wait(2.5);
					end
				end);
			end
		end
		Misc.UpdateAutoBan = UpdateAutoBan;
		local function fire_gui_button(btn)
			local fired = false;
			if firesignal then
				for _, sname in ipairs({"MouseButton1Click","MouseButton1Down","Activated"}) do
					local ok, sig = pcall(function()
						return btn[sname];
					end);
					if (ok and sig) then
						if pcall(firesignal, sig) then
							fired = true;
						end
					end
				end
			end
			if (not fired and getconnections) then
				for _, sname in ipairs({"MouseButton1Click","MouseButton1Down","Activated"}) do
					local ok, sig = pcall(function()
						return btn[sname];
					end);
					if (ok and sig) then
						local good, cons = pcall(getconnections, sig);
						if (good and cons) then
							for _, con in ipairs(cons) do
								pcall(function()
									if con.Fire then
										con:Fire();
									elseif con.Function then
										con.Function();
									end
								end);
								fired = true;
							end
						end
					end
				end
			end
			return fired;
		end
		local function button_is_shown(gui)
			local cur = gui;
			while cur do
				if cur:IsA("ScreenGui") then
					return cur.Enabled == true;
				end
				if (cur:IsA("GuiObject") and not cur.Visible) then
					return false;
				end
				cur = cur.Parent;
			end
			return false;
		end
		local leave_words = {leave=true,["leave match"]=true,["leave duel"]=true,["leave game"]=true,["back to lobby"]=true,["return to lobby"]=true,lobby=true,exit=true};
		local function try_auto_leave()
			local pg = LocalPlayer:FindFirstChildOfClass("PlayerGui");
			if not pg then
				return false;
			end
			for _, d in ipairs(pg:GetDescendants()) do
				if d:IsA("TextButton") then
					local t = string.lower((d.Text or ""):gsub("^%s*(.-)%s*$", "%1"));
					if (leave_words[t] and button_is_shown(d)) then
						if fire_gui_button(d) then
							return true;
						end
					end
				end
			end
			return false;
		end
		local lastQueueRemoteTime = 0;
		local function UpdateAutoQueue()
			if Misc.autoQueueTask then
				task.cancel(Misc.autoQueueTask);
				Misc.autoQueueTask = nil;
			end
			if (Toggles.queueenabled and Toggles.queueenabled.Value) then
				Misc.autoQueueTask = task.spawn(function()
					local joinRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Matchmaking"):WaitForChild("JoinQueue");
					while Toggles.queueenabled and Toggles.queueenabled.Value do
						local delayTime = (Options.queue_delay and Options.queue_delay.Value) or 3;
						local fighter = FighterController and FighterController.LocalFighter;
						local currently_in_match = false;
						pcall(function()
							currently_in_match = (fighter ~= nil) and (fighter:Get("IsInDuel") == true);
						end);
						if currently_in_match then
						else
							local pressed_leave = false;
							if (Toggles.autoleave and Toggles.autoleave.Value) then
								pcall(function()
									pressed_leave = try_auto_leave();
								end);
							end
							if (not pressed_leave and ((tick() - lastQueueRemoteTime) > delayTime)) then
								lastQueueRemoteTime = tick();
								local mode = (Options.queuemode and Options.queuemode.Value) or "1v1";
								local ranked = Toggles.ranked and Toggles.ranked.Value;
								pcall(function()
									if ranked then
										joinRemote:InvokeServer(mode, true);
									else
										joinRemote:InvokeServer(mode);
									end
								end);
							end
						end
						task.wait(1);
					end
				end);
			end
		end
		Misc.UpdateAutoQueue = UpdateAutoQueue;
		local function TriggerFastRespawn()
			pcall(function()
				if ReplicatedStorage:FindFirstChild("Remotes") then
					if (ReplicatedStorage.Remotes:FindFirstChild("Duels") and ReplicatedStorage.Remotes.Duels:FindFirstChild("RespawnNow")) then
						ReplicatedStorage.Remotes.Duels.RespawnNow:FireServer();
					elseif ReplicatedStorage.Remotes:FindFirstChild("Respawn") then
						ReplicatedStorage.Remotes.Respawn:FireServer();
					end
				end
			end);
		end
		Misc.TriggerFastRespawn = TriggerFastRespawn;
		LocalPlayer.CharacterAdded:Connect(function(char)
			task.wait(0.3);
			local hum = char:WaitForChild("Humanoid", 5);
			if hum then
				hum.Died:Connect(function()
					if (Toggles.AutoRespawn and Toggles.AutoRespawn.Value) then
						task.wait(0.1);
						TriggerFastRespawn();
					end
				end);
			end
		end);
		local function CheckFastRespawn()
			if not (Toggles.AutoRespawn and Toggles.AutoRespawn.Value) then
				return;
			end
			local char = LocalPlayer.Character;
			local hum = char and char:FindFirstChildOfClass("Humanoid");
			if (hum and (hum.Health <= 0)) then
				TriggerFastRespawn();
			end
		end
		Misc.CheckFastRespawn = CheckFastRespawn;
		local lastMedkitUse = 0;
		local function UseMedkit()
			if ((tick() - lastMedkitUse) >= 3) then
			else
				return;
			end
			local char = LocalPlayer.Character;
			local hum = char and char:FindFirstChildOfClass("Humanoid");
			if (not hum or (hum.Health <= 0)) then
				return;
			end
			lastMedkitUse = tick();
			task.spawn(function()
				pcall(function()
					local vim = game:GetService("VirtualInputManager");
					if (FighterController and FighterController.LocalFighter and FighterController.LocalFighter.EquipItem) then
						FighterController.LocalFighter:EquipItem(4);
					else
						vim:SendKeyEvent(true, Enum.KeyCode.Four, false, game);
						task.wait(0.04);
						vim:SendKeyEvent(false, Enum.KeyCode.Four, false, game);
					end
					task.wait(0.08);
					if (FighterController and FighterController.LocalFighter and FighterController.LocalFighter.Input) then
						setthreadidentity(2);
						FighterController.LocalFighter:Input("StartShooting");
						task.wait(0.06);
						FighterController.LocalFighter:Input("EndShooting");
						setthreadidentity(7);
					elseif mouse1click then
						mouse1click();
					elseif (mouse1press and mouse1release) then
						mouse1press();
						task.wait(0.03);
						mouse1release();
					end
					task.wait(0.15);
					if (FighterController and FighterController.LocalFighter and FighterController.LocalFighter.EquipItem) then
						FighterController.LocalFighter:EquipItem(1);
					else
						vim:SendKeyEvent(true, Enum.KeyCode.One, false, game);
						task.wait(0.04);
						vim:SendKeyEvent(false, Enum.KeyCode.One, false, game);
					end
					Library:Notify("[Auto-Heal] Medkit used successfully!", 2);
				end);
			end);
		end
		Misc.UseMedkit = UseMedkit;
		local function CheckAutoMedkit()
			if not (Toggles.AutoMedkit and Toggles.AutoMedkit.Value) then
				return;
			end
			local char = LocalPlayer.Character;
			local hum = char and char:FindFirstChildOfClass("Humanoid");
			if (hum and (hum.Health > 0) and (hum.MaxHealth > 0)) then
				local thresh = (Options.AutoMedkitHP and Options.AutoMedkitHP.Value) or 40;
				local pct = (hum.Health / hum.MaxHealth) * 100;
				if (pct > thresh) then
				else
					UseMedkit();
				end
			end
		end
		Misc.CheckAutoMedkit = CheckAutoMedkit;
		local function isPlayerReloading()
			if (not FighterController or not FighterController.LocalFighter) then
				return false;
			end
			local ok, res = pcall(function()
				local item = FighterController.LocalFighter.EquippedItem;
				if not item then
					return false;
				end
				if (item._reload_end and (item._reload_end > tick())) then
					return true;
				end
				if (item._reloading ~= true) then
				else
					return true;
				end
				if (item.Get and (item:Get("Reloading") == true)) then
					return true;
				end
				return false;
			end);
			return (ok and res) or false;
		end
		local function CheckVoidSpamReload()
			if not (Toggles.VoidSpamReload and Toggles.VoidSpamReload.Value) then
				if (Misc.inReloadVoid and Misc.savedReloadCF) then
					local char = LocalPlayer.Character;
					local hrp = char and char:FindFirstChild("HumanoidRootPart");
					if hrp then
						pcall(function()
							hrp.CFrame = Misc.savedReloadCF;
						end);
					end
					Misc.inReloadVoid = false;
					Misc.savedReloadCF = nil;
				end
				return;
			end
			local char = LocalPlayer.Character;
			local hrp = char and char:FindFirstChild("HumanoidRootPart");
			if not hrp then
				return;
			end
			local reloading = isPlayerReloading();
			local voidY = (Options.VoidSpamDepth and Options.VoidSpamDepth.Value) or -5000;
			if (reloading and not Misc.inReloadVoid) then
				Misc.savedReloadCF = hrp.CFrame;
				Misc.inReloadVoid = true;
				pcall(function()
					hrp.CFrame = CFrame.new(hrp.Position.X, voidY, hrp.Position.Z);
				end);
			elseif (not reloading and Misc.inReloadVoid) then
				Misc.inReloadVoid = false;
				if Misc.savedReloadCF then
					pcall(function()
						hrp.CFrame = Misc.savedReloadCF;
					end);
					Misc.savedReloadCF = nil;
				end
			end
		end
		Misc.CheckVoidSpamReload = CheckVoidSpamReload;
		local lastVoteMapTime = 0;
		local function UpdateAutoVoteMap()
			if not (Toggles.AutoVoteMap and Toggles.AutoVoteMap.Value) then
				return;
			end
			if ((tick() - lastVoteMapTime) < 1.5) then
				return;
			end
			local map = Options.AutoVoteMapSelect and Options.AutoVoteMapSelect.Value;
			if (not map or (map == "")) then
				return;
			end
			lastVoteMapTime = tick();
			pcall(function()
				if (ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Duels") and ReplicatedStorage.Remotes.Duels:FindFirstChild("Vote")) then
					ReplicatedStorage.Remotes.Duels.Vote:FireServer(map);
				end
			end);
		end
		Misc.UpdateAutoVoteMap = UpdateAutoVoteMap;
		local pickWeaponsRemote = nil;
		local lastPickWeaponsTime = 0;
		local function CheckAutoLoadout()
			if not (Toggles.AutoLoadout and Toggles.AutoLoadout.Value) then
				return;
			end
			if ((tick() - lastPickWeaponsTime) >= 0.6) then
			else
				return;
			end
			local fighter = FighterController and FighterController.LocalFighter;
			if not fighter then
				return;
			end
			local canPick = false;
			pcall(function()
				canPick = fighter:Get("CanPickWeapons") == true;
			end);
			if not canPick then
				return;
			end
			lastPickWeaponsTime = tick();
			pcall(function()
				if not pickWeaponsRemote then
					pickWeaponsRemote = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Replication"):WaitForChild("Fighter"):WaitForChild("PickWeapons");
				end
				local p = Options.AutoLoadoutPrimary and Options.AutoLoadoutPrimary.Value;
				local s = Options.AutoLoadoutSecondary and Options.AutoLoadoutSecondary.Value;
				local m = Options.AutoLoadoutMelee and Options.AutoLoadoutMelee.Value;
				local u = Options.AutoLoadoutUtility and Options.AutoLoadoutUtility.Value;
				if (p and s and m and u) then
					pickWeaponsRemote:FireServer({[1]=p,[2]=s,[3]=m,[4]=u});
				end
			end);
		end
		Misc.CheckAutoLoadout = CheckAutoLoadout;
		local lastGrabDropsTime = 0;
		local function CheckGrabDrops()
			if not (Toggles.GrabDrops and Toggles.GrabDrops.Value) then
				return;
			end
			if ((tick() - lastGrabDropsTime) >= 0.1) then
			else
				return;
			end
			lastGrabDropsTime = tick();
			local char = LocalPlayer.Character;
			local hrp = char and char:FindFirstChild("HumanoidRootPart");
			if (not hrp or not firetouchinterest) then
				return;
			end
			pcall(function()
				for _, v in ipairs(workspace:GetChildren()) do
					if ((v.Name == "_drop") and v:IsA("BasePart")) then
						firetouchinterest(hrp, v, 0);
						firetouchinterest(hrp, v, 1);
					end
				end
			end);
		end
		Misc.CheckGrabDrops = CheckGrabDrops;
		local lastSoundSpamTime = 0;
		local function CheckSoundSpammer()
			if not (Toggles.SoundSpammer and Toggles.SoundSpammer.Value) then
				return;
			end
			local interval = (Options.SoundSpammerDelay and Options.SoundSpammerDelay.Value) or 0.1;
			if ((tick() - lastSoundSpamTime) >= interval) then
			else
				return;
			end
			lastSoundSpamTime = tick();
			pcall(function()
				if (MechanicsController and MechanicsController.PlayMechanicsSound) then
					local stype = (Options.SoundSpammerType and Options.SoundSpammerType.Value) or "DoubleJump";
					MechanicsController:PlayMechanicsSound(stype);
				end
			end);
		end
		Misc.CheckSoundSpammer = CheckSoundSpammer;
		local RANK_ICONS = {Bronze="rbxassetid://111599878354131",Silver="rbxassetid://82834564754747",Gold="rbxassetid://80716950169934",Diamond="rbxassetid://131795064007344",Onyx="rbxassetid://114166096331502",Nemesis="rbxassetid://133903971285645",["Arch Nemesis"]="rbxassetid://134520747948636"};
		local origAttributes = {level=LocalPlayer:GetAttribute("Level"),streak=LocalPlayer:GetAttribute("StatisticDuelsWinStreak"),playerstatus=LocalPlayer:GetAttribute("PlayerStatus"),elo=LocalPlayer:GetAttribute("DisplayELO"),userId=LocalPlayer.UserId,name=LocalPlayer.Name,displayName=LocalPlayer.DisplayName};
		Misc.origAttributes = origAttributes;
		local function FormatCommas(n)
			local s = tostring(n);
			while true do
				local r;
				s, r = string.gsub(s, "^(-?%d+)(%d%d%d)", "%1,%2");
				if (r ~= 0) then
				else
					break;
				end
			end
			return s;
		end
		local function UpdateAttributeSpoofs()
			pcall(function()
				if (Toggles.LevelSpoof and Toggles.LevelSpoof.Value) then
					local lvl = tonumber(Options.LevelSpoofVal and Options.LevelSpoofVal.Value) or 100;
					LocalPlayer:SetAttribute("Level", lvl);
				end
				if (Toggles.StreakSpoof and Toggles.StreakSpoof.Value) then
					local stk = tonumber(Options.StreakSpoofVal and Options.StreakSpoofVal.Value) or 99;
					LocalPlayer:SetAttribute("StatisticDuelsWinStreak", stk);
				end
				if (Toggles.StatusSpoof and Toggles.StatusSpoof.Value) then
					local st = (Options.StatusSpoofVal and Options.StatusSpoofVal.Value) or "Online";
					LocalPlayer:SetAttribute("PlayerStatus", st);
				end
				if (Toggles.ELOSpoof and Toggles.ELOSpoof.Value) then
					local elo = tonumber(Options.ELOSpoofVal and Options.ELOSpoofVal.Value) or 60000;
					LocalPlayer:SetAttribute("DisplayELO", elo);
				end
			end);
		end
		Misc.UpdateAttributeSpoofs = UpdateAttributeSpoofs;
		local spoofHeld = setmetatable({}, {__mode="k"});
		local function LockLabelText(label, value)
			if (not label or not label:IsA("TextLabel")) then
				return;
			end
			if (label.Text == value) then
			else
				label.Text = value;
			end
			if spoofHeld[label] then
				return;
			end
			spoofHeld[label] = true;
			label:GetPropertyChangedSignal("Text"):Connect(function()
				if ((Toggles.RankSpoof and Toggles.RankSpoof.Value) or (Toggles.ELOSpoof and Toggles.ELOSpoof.Value)) then
					if (label.Text == value) then
					else
						label.Text = value;
					end
				end
			end);
		end
		local function LockImageValue(img, value)
			if (not img or not (img:IsA("ImageLabel") or img:IsA("ImageButton"))) then
				return;
			end
			if (img.Image ~= value) then
				img.Image = value;
			end
			if spoofHeld[img] then
				return;
			end
			spoofHeld[img] = true;
			img:GetPropertyChangedSignal("Image"):Connect(function()
				if (Toggles.RankSpoof and Toggles.RankSpoof.Value) then
					if (img.Image == value) then
					else
						img.Image = value;
					end
				end
			end);
		end
		local function ScanGuiSpoofs()
			if not ((Toggles.RankSpoof and Toggles.RankSpoof.Value) or (Toggles.ELOSpoof and Toggles.ELOSpoof.Value)) then
				return;
			end
			local pg = LocalPlayer:FindFirstChild("PlayerGui");
			if not pg then
				return;
			end
			local mainGui = pg:FindFirstChild("MainGui");
			local rankOn = Toggles.RankSpoof and Toggles.RankSpoof.Value;
			local eloOn = Toggles.ELOSpoof and Toggles.ELOSpoof.Value;
			local rankText = (Options.RankSpoofVal and Options.RankSpoofVal.Value) or "Arch Nemesis";
			local rankIcon = (rankOn and (RANK_ICONS[rankText] or "")) or "";
			local eloVal = (Options.ELOSpoofVal and Options.ELOSpoofVal.Value) or "60000";
			local eloText = (eloOn and FormatCommas(eloVal)) or nil;
			local roots = {mainGui,pg:FindFirstChild("PlayerList")};
			for _, root in ipairs(roots) do
				if root then
					for _, d in ipairs(root:GetDescendants()) do
						if d:IsA("TextLabel") then
							if ((d.Name == "CurrentELO") and eloText and d:FindFirstAncestor("ELOBar")) then
								LockLabelText(d, eloText);
							elseif (((d.Name == "LeftRank") or (d.Name == "RightRank")) and rankOn and (rankText ~= "") and d:FindFirstAncestor("ELOBar")) then
								LockLabelText(d, rankText);
							end
						end
					end
				end
			end
			if (rankOn and (rankIcon ~= "")) then
				local list = pg:FindFirstChild("PlayerList") or (mainGui and mainGui:FindFirstChild("PlayerList"));
				if list then
					for _, slot in ipairs(list:GetDescendants()) do
						if (slot.Name ~= "PlayerListSlot") then
						else
							local myName = LocalPlayer.Name;
							local myDisp = LocalPlayer.DisplayName;
							local isMine = false;
							for _, t in ipairs(slot:GetDescendants()) do
								if (t:IsA("TextLabel") and ((t.Text == myName) or (t.Text == myDisp) or (t.Text == ("@" .. myName)))) then
									isMine = true;
									break;
								end
							end
							if isMine then
								local stat = slot:FindFirstChild("Leaderstat");
								local container = stat and stat:FindFirstChild("RankContainer");
								if container then
									for _, ic in ipairs(container:GetDescendants()) do
										if ((ic.Name == "Icon") and (ic:IsA("ImageLabel") or ic:IsA("ImageButton"))) then
											LockImageValue(ic, rankIcon);
										end
									end
								end
							end
						end
					end
				end
			end
		end
		task.spawn(function()
			while true do
				pcall(ScanGuiSpoofs);
				task.wait(0.4);
			end
		end);
		local userCache = {};
		local function FetchRobloxUserData(username)
			if (not username or (username == "")) then
				return nil;
			end
			if userCache[username] then
				return userCache[username];
			end
			local id = nil;
			pcall(function()
				id = Players:GetUserIdFromNameAsync(username);
			end);
			if not id then
				return nil;
			end
			local data = {id=id,name=username,displayName=username};
			pcall(function()
				local raw = game:HttpGet("https://users.roblox.com/v1/users/" .. tostring(id), true);
				local dec = HttpService:JSONDecode(raw);
				if ((type(dec) == "table") and dec.id) then
					data = {id=dec.id,name=dec.name,displayName=dec.displayName};
				end
			end);
			userCache[username] = data;
			return data;
		end
		local function ApplyPlayerAppearance(targetPlayer, victimId)
			local char = targetPlayer.Character;
			if not char then
				return;
			end
			local hum = char:FindFirstChildOfClass("Humanoid");
			if not hum then
				return;
			end
			local ok, appearance = pcall(function()
				return Players:GetCharacterAppearanceAsync(victimId);
			end);
			if (not ok or not appearance) then
				return;
			end
			for _, v in ipairs(char:GetChildren()) do
				if (v:IsA("Accessory") or v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") or v:IsA("CharacterMesh") or v:IsA("ShirtGraphic")) then
					v:Destroy();
				end
			end
			for _, v in ipairs(appearance:GetChildren()) do
				if (v:IsA("Shirt") or v:IsA("Pants") or v:IsA("BodyColors") or v:IsA("CharacterMesh")) then
					v.Parent = char;
				elseif v:IsA("Accessory") then
					pcall(function()
						hum:AddAccessory(v);
					end);
				end
			end
			pcall(function()
				appearance:Destroy();
			end);
			local head = char:FindFirstChild("Head");
			if head then
				pcall(function()
					local json = game:HttpGet("https://avatar.roblox.com/v1/users/" .. tostring(victimId) .. "/avatar", true);
					local info = HttpService:JSONDecode(json);
					local faceId = nil;
					for _, asset in ipairs(info.assets or {}) do
						if (asset.assetType and (asset.assetType.id == 18)) then
							faceId = asset.id;
							break;
						end
					end
					if faceId then
						local objs = game:GetObjects("rbxassetid://" .. tostring(faceId));
						local tex = nil;
						for _, obj in ipairs(objs) do
							if obj:IsA("Decal") then
								tex = obj.Texture;
								break;
							end
							for _, ch in ipairs(obj:GetDescendants()) do
								if ch:IsA("Decal") then
									tex = ch.Texture;
									break;
								end
							end
							if tex then
								break;
							end
						end
						if tex then
							local f = head:FindFirstChild("face") or head:FindFirstChildOfClass("Decal");
							if f then
								f.Texture = tex;
							end
						end
					end
				end);
			end
		end
		local function ApplyFullProfileSpoof()
			local username = Options.ProfileSpoofUsername and Options.ProfileSpoofUsername.Value;
			if (not username or (username == "")) then
				Library:Notify("Please enter a valid Roblox username to clone!", 3);
				return;
			end
			local data = FetchRobloxUserData(username);
			if not data then
				Library:Notify("Failed to fetch user data for: " .. tostring(username), 3);
				return;
			end
			pcall(function()
				LocalPlayer.Name = data.name;
				LocalPlayer.UserId = data.id;
				LocalPlayer.CharacterAppearanceId = data.id;
				LocalPlayer.DisplayName = data.displayName;
				if LocalPlayer.Character then
					LocalPlayer.Character.Name = data.name;
					local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
					if hum then
						hum.DisplayName = data.displayName;
					end
				end
			end);
			ApplyPlayerAppearance(LocalPlayer, data.id);
			Library:Notify("Successfully cloned identity & appearance: " .. data.displayName .. " (@" .. data.name .. ")!", 4);
		end
		Misc.ApplyFullProfileSpoof = ApplyFullProfileSpoof;
		local function RestoreOriginalProfile()
			pcall(function()
				if Misc.origAttributes.name then
					LocalPlayer.Name = Misc.origAttributes.name;
				end
				if Misc.origAttributes.userId then
					LocalPlayer.UserId = Misc.origAttributes.userId;
				end
				if Misc.origAttributes.userId then
					LocalPlayer.CharacterAppearanceId = Misc.origAttributes.userId;
				end
				if Misc.origAttributes.displayName then
					LocalPlayer.DisplayName = Misc.origAttributes.displayName;
				end
				if Misc.origAttributes.level then
					LocalPlayer:SetAttribute("Level", Misc.origAttributes.level);
				end
				if Misc.origAttributes.streak then
					LocalPlayer:SetAttribute("StatisticDuelsWinStreak", Misc.origAttributes.streak);
				end
				if Misc.origAttributes.elo then
					LocalPlayer:SetAttribute("DisplayELO", Misc.origAttributes.elo);
				end
				if Misc.origAttributes.playerstatus then
					LocalPlayer:SetAttribute("PlayerStatus", Misc.origAttributes.playerstatus);
				end
				if LocalPlayer.Character then
					LocalPlayer.Character.Name = Misc.origAttributes.name or LocalPlayer.Name;
					local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid");
					if hum then
						hum.DisplayName = Misc.origAttributes.displayName or LocalPlayer.DisplayName;
					end
				end
			end);
			if Misc.origAttributes.userId then
				ApplyPlayerAppearance(LocalPlayer, Misc.origAttributes.userId);
			end
			Library:Notify("Original profile and appearance restored!", 3);
		end
		Misc.RestoreOriginalProfile = RestoreOriginalProfile;
		local function UnlockAllCosmeticsClient()
			pcall(function()
				local itemLib = ReplicatedStorage:FindFirstChild("Modules") and ReplicatedStorage.Modules:FindFirstChild("ItemLibrary");
				if itemLib then
					local lib = SafeRequire(itemLib);
					if (lib and lib.Items) then
						for _, item in pairs(lib.Items) do
							if ((type(item) == "table") and item.Skins) then
								for _, s in pairs(item.Skins) do
									if (type(s) ~= "table") then
									else
										s.Unlocked = true;
									end
								end
							end
						end
					end
				end
				Library:Notify("Client-side cosmetics & skins unlocked!", 3);
			end);
		end
		Misc.UnlockAllCosmeticsClient = UnlockAllCosmeticsClient;
	end
	local origColors = {};
	local smoothHidden = {};
	local texState = {smooth=false,dark=false,conn=nil,lastScan=0};
	local function applyDarkSmoothTo(v)
		if (texState.smooth and (v:IsA("Texture") or v:IsA("Decal"))) then
			if smoothHidden[v] == nil then
				smoothHidden[v] = v.Transparency;
				v.Transparency = 1;
			end
		end
		if (texState.dark and v:IsA("BasePart") and not (v.Parent and v.Parent:FindFirstChildOfClass("Humanoid"))) then
			if not origColors[v] then
				origColors[v] = v.Color;
				v.Color = Color3.new(v.Color.R * 0.4, v.Color.G * 0.4, v.Color.B * 0.4);
			end
		end
	end
	local function UpdateTextures()
		local smooth = (Toggles.smooth_textures and Toggles.smooth_textures.Value) or false;
		local dark = (Toggles.dark_textures and Toggles.dark_textures.Value) or false;
		if (smooth == texState.smooth and dark == texState.dark) then
			return;
		end
		texState.smooth, texState.dark = smooth, dark;
		if not smooth then
			for v, tr in pairs(smoothHidden) do
				if (v and v.Parent) then v.Transparency = tr; end
			end
			table.clear(smoothHidden);
		end
		if not dark then
			for part, col in pairs(origColors) do
				if (part and part.Parent) then part.Color = col; end
			end
			table.clear(origColors);
		end
		if (smooth or dark) then
			task.spawn(function()
				local n = 0;
				for _, v in ipairs(workspace:GetDescendants()) do
					pcall(applyDarkSmoothTo, v);
					n = n + 1;
					if (n % 400 == 0) then task.wait(); end
				end
			end);
			if not texState.conn then
				texState.conn = workspace.DescendantAdded:Connect(function(v)
					if (texState.smooth or texState.dark) then
						task.defer(function() pcall(applyDarkSmoothTo, v); end);
					end
				end);
			end
		elseif texState.conn then
			texState.conn:Disconnect();
			texState.conn = nil;
		end
	end
	pcall(function()
		local vu = game:GetService("VirtualUser");
		LocalPlayer.Idled:Connect(function()
			if (Toggles.AntiAFK and Toggles.AntiAFK.Value) then
				pcall(function()
					vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
					task.wait(0.5);
					vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
					Library:Notify("[Anti-AFK] Idle kick intercepted!", 2);
				end);
			end
		end);
	end);
	UserInputService.JumpRequest:Connect(function()
		if (Toggles.InfiniteJump and Toggles.InfiniteJump.Value) then
			local char = LocalPlayer.Character;
			local hum = char and char:FindFirstChildOfClass("Humanoid");
			if hum then
				hum:ChangeState(Enum.HumanoidStateType.Jumping);
				if (Options.JumpPowerSlider and Options.JumpPowerSlider.Value) then
					hum.JumpPower = Options.JumpPowerSlider.Value;
				end
			end
		end
	end);
	local NoclipConnection = RunService.Stepped:Connect(function()
		if (Toggles.noclip and Toggles.noclip.Value) then
			local char = LocalPlayer.Character;
			if char then
				for _, part in ipairs(char:GetDescendants()) do
					if (part:IsA("BasePart") and part.CanCollide) then
						part.CanCollide = false;
					end
				end
			end
		end
	end);
	local lastSafeCFrame = nil;
	local HeartbeatConnection = RunService.Heartbeat:Connect(function(dt)
		local char = LocalPlayer.Character;
		if not char then
			return;
		end
		local hum = char:FindFirstChildOfClass("Humanoid");
		local root = char:FindFirstChild("HumanoidRootPart");
		if (not hum or not root) then
			return;
		end
		updateDeflection();
		if (Toggles.AntiAimUnderground and Toggles.AntiAimUnderground.Value and IsInMatch()) then
			local rayParams = RaycastParams.new();
			rayParams.FilterType = Enum.RaycastFilterType.Exclude;
			rayParams.FilterDescendantsInstances = {char,workspace:FindFirstChild("ViewModels")};
			local rayResult = workspace:Raycast(root.Position, Vector3.new(0, -500, 0), rayParams);
			if rayResult then
				local oldCF = root.CFrame;
				local oldVel = root.Velocity;
				local oldRotVel = root.RotVelocity;
				undergroundSavedCF = oldCF;
				root.CFrame = CFrame.new(root.Position.X, rayResult.Position.Y - 2, root.Position.Z) * (oldCF - oldCF.Position);
				pcall(function()
					RunService:UnbindFromRenderStep("__restore_underground");
				end);
				RunService:BindToRenderStep("__restore_underground", 101, function()
					if root then
						root.CFrame = oldCF;
						root.Velocity = oldVel;
						root.RotVelocity = oldRotVel;
					end
					RunService:UnbindFromRenderStep("__restore_underground");
				end);
			end
		else
			undergroundSavedCF = nil;
		end
		if ExecuteMessageCombat then
			ExecuteMessageCombat(dt);
		end
		if (Toggles.cframespf_enabled and Toggles.cframespf_enabled.Value and not (Toggles.cframefly_enabled and Toggles.cframefly_enabled.Value)) then
			if (hum.MoveDirection.Magnitude <= 0) then
			else
				local speed = (Options.spdd_value and Options.spdd_value.Value) or 32;
				root.Velocity = Vector3.new(hum.MoveDirection.X * speed, root.Velocity.Y, hum.MoveDirection.Z * speed);
			end
		end
		if (Toggles.slide_boost and Toggles.slide_boost.Value and MechanicsController) then
			pcall(function()
				local boost = (Options.slide_speed and Options.slide_speed.Value) or 300;
				local sv = MechanicsController._sliding_velocity;
				if (sv and sv.Parent) then
					local cur = sv.Velocity;
					local dir = (cur.Magnitude > 0.1) and cur.Unit or Vector3.new(root.CFrame.LookVector.X, 0, root.CFrame.LookVector.Z).Unit;
					sv.Velocity = dir * boost;
				end
			end);
		end
		if Misc.CheckAntiTripmine then
			Misc.CheckAntiTripmine();
		end
		if Misc.CheckAutoMedkit then
			Misc.CheckAutoMedkit();
		end
		if (Options.QuickMedkitKey and Options.QuickMedkitKey:GetState() and Misc.UseMedkit) then
			Misc.UseMedkit();
		end
		if Misc.CheckFastRespawn then
			Misc.CheckFastRespawn();
		end
		if Misc.CheckVoidSpamReload then
			Misc.CheckVoidSpamReload();
		end
		if Misc.UpdateAutoVoteMap then
			Misc.UpdateAutoVoteMap();
		end
		if Misc.CheckAutoLoadout then
			Misc.CheckAutoLoadout();
		end
		if Misc.CheckGrabDrops then
			Misc.CheckGrabDrops();
		end
		if Misc.CheckSoundSpammer then
			Misc.CheckSoundSpammer();
		end
		if Misc.UpdateAttributeSpoofs then
			Misc.UpdateAttributeSpoofs();
		end
	end);
	do
		local rageTargetChar = nil;
		local rageTargetPart = nil;
		local rageTargetPlayer = nil;
		local rageImmune = false;
		local ragePredictionVel = Vector3.zero;
		local rageLastPos = nil;
		local rageLastPosTime = 0;
		local voidSpamPhase = "shoot";
		local lastVoidSpamSwitch = tick();
		local lastRageFire = 0;
		local rageVisLine = Drawing.new("Line");
		rageVisLine.Visible = false;
		rageVisLine.Thickness = 1.5;
		rageVisLine.Color = Color3.fromRGB(0, 186, 255);
		local rageVisOutline = Drawing.new("Line");
		rageVisOutline.Visible = false;
		rageVisOutline.Thickness = 3;
		rageVisOutline.Color = Color3.fromRGB(0, 0, 0);
		local rageStatusLabel = Drawing.new("Text");
		rageStatusLabel.Visible = false;
		rageStatusLabel.Size = 13;
		rageStatusLabel.Center = true;
		rageStatusLabel.Outline = true;
		rageStatusLabel.OutlineColor = Color3.fromRGB(0, 0, 0);
		rageStatusLabel.Font = 2;
		rageStatusLabel.Color = Color3.fromRGB(255, 255, 255);
		local function IsRageSettingEnabled(settingName)
			if (Options.RageSettings and Options.RageSettings.Value) then
				local v = Options.RageSettings.Value;
				if (type(v) ~= "table") then
				else
					return v[settingName] == true;
				end
			end
			return false;
		end
		local function GetRagePredictedPos(targetPart, origin)
			if not targetPart then
				return Vector3.zero;
			end
			local basePos = targetPart.Position;
			if not IsRageSettingEnabled("prediction") then
				return basePos;
			end
			local dist = (basePos - origin).Magnitude;
			local ping = 0;
			pcall(function()
				ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue() / 1000;
			end);
			local travelTime = dist / 3000;
			local mult = (Options.PredictMul and Options.PredictMul.Value) or 1.2;
			local totalTime = (travelTime + ping) * mult;
			return basePos + (ragePredictionVel * totalTime);
		end
		local function GetRageHitPart(char, partChoice)
			if not char then
				return nil;
			end
			if (partChoice == "Closest") then
				local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
				if not myRoot then
					return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart");
				end
				local closestPart, closestDist = nil, math.huge;
				for _, part in ipairs(char:GetChildren()) do
					if part:IsA("BasePart") then
						local d = (part.Position - myRoot.Position).Magnitude;
						if (d >= closestDist) then
						else
							closestDist = d;
							closestPart = part;
						end
					end
				end
				return closestPart or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart");
			elseif (partChoice == "Random") then
				local candidates = {};
				for _, name in ipairs({"Head","HumanoidRootPart","UpperTorso","Torso","LowerTorso"}) do
					local p = char:FindFirstChild(name);
					if p then
						table.insert(candidates, p);
					end
				end
				if (#candidates <= 0) then
				else
					return candidates[math.random(1, #candidates)];
				end
				return char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart");
			else
				return char:FindFirstChild(partChoice) or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart");
			end
		end
		local function GetRageTarget(maxDist, partChoice)
			if not IsInMatch() then
				return nil, nil;
			end
			local myChar = LocalPlayer.Character;
			local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart");
			local myPos = (myRoot and myRoot.Position) or (workspace.CurrentCamera and workspace.CurrentCamera.CFrame.Position);
			if not myPos then
				return nil, nil;
			end
			local bestTarget = nil;
			local bestPart = nil;
			local bestScore = math.huge;
			local mousePos = UserInputService:GetMouseLocation();
			local cam = workspace.CurrentCamera;
			for _, player in ipairs(Players:GetPlayers()) do
				if ((player ~= LocalPlayer) and not IsTeammate(player)) then
					local char = player.Character;
					local hum = char and char:FindFirstChildOfClass("Humanoid");
					local hrp = char and char:FindFirstChild("HumanoidRootPart");
					local isImmune = hrp and (hrp:FindFirstChild("Attachment") ~= nil);
					if (hum and (hum.Health > 0) and not isImmune and hrp) then
						local dist3D = (hrp.Position - myPos).Magnitude;
						if (dist3D > (maxDist or 3500)) then
						else
							local score = dist3D;
							if cam then
								local sPos, onScreen = cam:WorldToViewportPoint(hrp.Position);
								if (onScreen and (sPos.Z > 0)) then
									score = (Vector2.new(sPos.X, sPos.Y) - mousePos).Magnitude;
								else
									score = dist3D + 2000;
								end
							end
							if (score >= bestScore) then
							else
								local part = GetRageHitPart(char, partChoice);
								if part then
									bestScore = score;
									bestTarget = player;
									bestPart = part;
								end
							end
						end
					end
				end
			end
			return bestTarget, bestPart;
		end
		local function FireRagebot(targetPart, targetPlr)
		end
		local voidSpamSavedCFrame = nil;
		local lastRageSwapTime = 0;
		Hub.UpdateRagebot = function(dt)
			local rageEnabled = Toggles.TargetOn and Toggles.TargetOn.Value;
			if (Options.TargetKey and Options.TargetKey.Value and (Options.TargetKey.Value ~= "None")) then
				if not Options.TargetKey:GetState() then
					rageEnabled = false;
				end
			end
			if (not rageEnabled or not IsInMatch()) then
				if (voidSpamSavedCFrame and LocalPlayer.Character) then
					local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					if myRoot then
						pcall(function()
							myRoot.CFrame = voidSpamSavedCFrame;
						end);
					end
					voidSpamSavedCFrame = nil;
				end
				rageTargetChar = nil;
				rageTargetPart = nil;
				rageTargetPlayer = nil;
				rageVisLine.Visible = false;
				rageVisOutline.Visible = false;
				rageStatusLabel.Visible = false;
				return;
			end
			local swapWhenNoAmmo = IsRageSettingEnabled("swap weapons when no ammo");
			if (localFighter and Options.PreferredWeapon) then
				local pref = tostring(Options.PreferredWeapon.Value):lower();
				local slotMap = {primary=1,secondary=2,melee=3};
				local desiredSlot = slotMap[pref] or 1;
				pcall(function()
					if localFighter.EquipItem then
						local currentSlot = localFighter.EquippedSlot or (localFighter.EquippedItem and localFighter.EquippedItem:Get("Slot"));
						if not swapWhenNoAmmo then
							if (currentSlot == desiredSlot) then
							else
								localFighter:EquipItem(desiredSlot);
							end
						elseif not currentSlot then
							localFighter:EquipItem(desiredSlot);
						elseif localFighter.EquippedItem then
							local curAmmo = localFighter.EquippedItem:Get("CurrentAmmo") or localFighter.EquippedItem:Get("Ammo") or localFighter.EquippedItem:Get("Bullets");
							local maxAmmo = localFighter.EquippedItem:Get("MaxAmmo") or localFighter.EquippedItem:Get("MaxBullets") or 0;
							if ((curAmmo == 0) and (maxAmmo > 0) and ((tick() - lastRageSwapTime) > 0.4)) then
								lastRageSwapTime = tick();
								local nextSlot = ((currentSlot == 1) and 2) or ((currentSlot == 2) and 3) or 1;
								localFighter:EquipItem(nextSlot);
							end
						end
					end
				end);
			end
			local partChoice = (Options.TargetPart and Options.TargetPart.Value) or "Head";
			local foundPlr, foundPart = GetRageTarget(3500, partChoice);
			if (foundPlr and foundPart and foundPlr.Character) then
				rageTargetPlayer = foundPlr;
				rageTargetChar = foundPlr.Character;
				rageTargetPart = foundPart;
				local hrp = rageTargetChar:FindFirstChild("HumanoidRootPart");
				rageImmune = hrp and (hrp:FindFirstChild("Attachment") ~= nil);
				if hrp then
					local now = tick();
					local dtPos = now - rageLastPosTime;
					if ((dtPos > 0) and (dtPos < 0.1)) then
						if rageLastPos then
							local instantVel = (hrp.Position - rageLastPos) / dtPos;
							ragePredictionVel = ragePredictionVel:Lerp(instantVel, 0.6);
						end
						rageLastPos = hrp.Position;
						rageLastPosTime = now;
					elseif (dtPos < 0.1) then
					else
						rageLastPos = hrp.Position;
						rageLastPosTime = now;
						ragePredictionVel = Vector3.zero;
					end
				end
				if (Toggles.VoidSpam and Toggles.VoidSpam.Value and not rageImmune) then
					local shootTime = (Options.VoidShootTime and Options.VoidShootTime.Value) or 0.1;
					local hideTime = (Options.VoidHideTime and Options.VoidHideTime.Value) or 0.25;
					local elapsed = tick() - lastVoidSpamSwitch;
					if ((voidSpamPhase == "shoot") and (elapsed >= shootTime)) then
						voidSpamPhase = "hide";
						lastVoidSpamSwitch = tick();
					elseif ((voidSpamPhase == "hide") and (elapsed >= hideTime)) then
						voidSpamPhase = "shoot";
						lastVoidSpamSwitch = tick();
					end
					local myChar = LocalPlayer.Character;
					local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart");
					if myRoot then
						if (voidSpamPhase == "hide") then
							if not voidSpamSavedCFrame then
								voidSpamSavedCFrame = myRoot.CFrame;
							end
							pcall(function()
								myRoot.CFrame = CFrame.new(math.random(-8000, 8000), -999999999, math.random(-8000, 8000));
							end);
							return;
						elseif voidSpamSavedCFrame then
							pcall(function()
								myRoot.CFrame = voidSpamSavedCFrame;
							end);
							voidSpamSavedCFrame = nil;
						end
					end
				elseif (voidSpamSavedCFrame and LocalPlayer.Character) then
					local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart");
					if myRoot then
						pcall(function()
							myRoot.CFrame = voidSpamSavedCFrame;
						end);
					end
					voidSpamSavedCFrame = nil;
				end
				if (Toggles.VisEnabled and Toggles.VisEnabled.Value and Toggles.VisTracerEnabled and Toggles.VisTracerEnabled.Value) then
					local cam = workspace.CurrentCamera;
					local startPos2D = nil;
					local startMode = (Options.VisTracerStart and Options.VisTracerStart.Value) or "cursor";
					if (startMode == "muzzle") then
						local muz = GetMuzzlePosition();
						local sPos, onScreen = cam:WorldToViewportPoint(muz);
						if onScreen then
							startPos2D = Vector2.new(sPos.X, sPos.Y);
						end
					else
						startPos2D = UserInputService:GetMouseLocation();
					end
					local targetScreenPos, targetOnScreen = cam:WorldToViewportPoint(GetRagePredictedPos(rageTargetPart, cam.CFrame.Position));
					if (startPos2D and targetOnScreen) then
						local endPos2D = Vector2.new(targetScreenPos.X, targetScreenPos.Y);
						local col = (Options.VisTracerColor and Options.VisTracerColor.Value) or Color3.fromRGB(0, 186, 255);
						local thick = (Options.VisTracerThickness and Options.VisTracerThickness.Value) or 1;
						local showOutline = Toggles.VisTracerOutline and Toggles.VisTracerOutline.Value;
						if showOutline then
							rageVisOutline.Visible = true;
							rageVisOutline.From = startPos2D;
							rageVisOutline.To = endPos2D;
							rageVisOutline.Thickness = thick + 1.5;
						else
							rageVisOutline.Visible = false;
						end
						rageVisLine.Visible = true;
						rageVisLine.From = startPos2D;
						rageVisLine.To = endPos2D;
						rageVisLine.Color = col;
						rageVisLine.Thickness = thick;
					else
						rageVisLine.Visible = false;
						rageVisOutline.Visible = false;
					end
				else
					rageVisLine.Visible = false;
					rageVisOutline.Visible = false;
				end
				if (Toggles.RageStatus and Toggles.RageStatus.Value) then
					local isReloading = false;
					if (localFighter and localFighter.EquippedItem) then
						pcall(function()
							local item = localFighter.EquippedItem;
							for _, key in ipairs({"Reloading","IsReloading","IsReload"}) do
								local val = item:Get(key);
								if ((val == true) or (val == 1) or (val == "true")) then
									isReloading = true;
									break;
								end
							end
						end);
					end
					if (Toggles.RageStatusReloadHide and Toggles.RageStatusReloadHide.Value and isReloading) then
						rageStatusLabel.Visible = false;
					else
						local cam = workspace.CurrentCamera;
						local mode = (Options.RageStatusMode and Options.RageStatusMode.Value) or "static";
						local sX = (Options.RageStatusStaticX and Options.RageStatusStaticX.Value) or 0;
						local sY = (Options.RageStatusStaticY and Options.RageStatusStaticY.Value) or 40;
						local basePos = nil;
						if (mode == "muzzle") then
							local muz = GetMuzzlePosition();
							local sPos, onScreen = cam:WorldToViewportPoint(muz);
							if onScreen then
								basePos = Vector2.new(sPos.X + sX, sPos.Y + sY);
							end
						else
							basePos = Vector2.new((cam.ViewportSize.X / 2) + sX, (cam.ViewportSize.Y / 2) + sY);
						end
						if basePos then
							rageStatusLabel.Visible = true;
							rageStatusLabel.Position = basePos;
							rageStatusLabel.Color = (Options.RageStatusColor and Options.RageStatusColor.Value) or Color3.fromRGB(235, 235, 235);
							local immStr = (rageImmune and " [IMMUNE]") or "";
							local ammoStr = "";
							if (Toggles.RageStatusAmmo and Toggles.RageStatusAmmo.Value and localFighter and localFighter.EquippedItem) then
								local item = localFighter.EquippedItem;
								local cur = item:Get("CurrentAmmo") or item:Get("Ammo") or item:Get("Bullets");
								local maxA = item:Get("MaxAmmo") or item:Get("MaxBullets");
								if (cur and maxA) then
									ammoStr = string.format(" [%d/%d]", cur, maxA);
								end
							end
							rageStatusLabel.Text = string.format("RAGE: %s%s%s", rageTargetPlayer.DisplayName or rageTargetPlayer.Name, immStr, ammoStr);
						else
							rageStatusLabel.Visible = false;
						end
					end
				else
					rageStatusLabel.Visible = false;
				end
			else
				rageTargetPlayer = nil;
				rageTargetChar = nil;
				rageTargetPart = nil;
				rageVisLine.Visible = false;
				rageVisOutline.Visible = false;
				rageStatusLabel.Visible = false;
			end
		end;
		Hub.DestroyRagebot = function()
			pcall(function()
				if rageVisLine then
					rageVisLine:Remove();
				end
				if rageVisOutline then
					rageVisOutline:Remove();
				end
				if rageStatusLabel then
					rageStatusLabel:Remove();
				end
			end);
		end;
	end
	do
		local antiAimFrameCounter = 0;
		local function CalculateAntiAimAngles(dt)
			local yaw = 0;
			local pitch = 0;
			local roll = 0;
			local curTime = tick();
			local yawType = (Options.AntiAimYaw and Options.AntiAimYaw.Value) or "none";
			local pitchType = (Options.AntiAimPitch and Options.AntiAimPitch.Value) or "none";
			local angleType = (Options.AntiAimAngle and Options.AntiAimAngle.Value) or "none";
			local minAngle = (Options.minangleslider and Options.minangleslider.Value) or 30;
			local maxAngle = (Options.maxangleslider and Options.maxangleslider.Value) or 60;
			local minSpeed = (Options.speedslider and Options.speedslider.Value) or 10;
			local maxSpeed = (Options.angleslider and Options.angleslider.Value) or 20;
			local isRandom = Toggles.randomangle and Toggles.randomangle.Value;
			if (yawType == "jitter") then
				local minRad = math.rad(minAngle);
				local maxRad = math.rad(maxAngle);
				if isRandom then
					yaw = -maxRad + (math.random() * maxRad * 2);
				else
					yaw = ((math.random() > 0.5) and minRad) or -minRad;
				end
			elseif (yawType == "spinbot") then
				local spd = (minSpeed + (math.random() * math.max(0, maxSpeed - minSpeed))) / 10;
				yaw = (curTime * spd) % (2 * math.pi);
			elseif (yawType ~= "random") then
			else
				yaw = math.rad(-maxAngle + (math.random() * maxAngle * 2));
			end
			if (Options.AntiAimInvertKey and Options.AntiAimInvertKey:GetState()) then
				yaw = yaw + math.pi;
			end
			if (pitchType == "jitter") then
				local minRad = math.rad(minAngle);
				local maxRad = math.rad(maxAngle);
				if isRandom then
					pitch = -maxRad + (math.random() * maxRad * 2);
				else
					pitch = ((math.random() > 0.5) and minRad) or -minRad;
				end
			elseif (pitchType == "spinbot") then
				pitch = math.sin(curTime * (maxSpeed / 10)) * math.rad(maxAngle);
			elseif (pitchType ~= "random") then
			else
				pitch = math.rad(-85 + (math.random() * 170));
			end
			if (angleType == "tilt 45") then
				roll = math.rad(45);
			elseif (angleType == "tilt 90") then
				roll = math.rad(90);
			elseif (angleType == "upside down") then
				roll = math.rad(180);
			elseif (angleType ~= "custom") then
			else
				local customAngle = (Options.AntiAimCustomAngle and Options.AntiAimCustomAngle.Value) or 0;
				roll = math.rad(customAngle);
			end
			return pitch, yaw, roll;
		end
		local undergroundSavedPos = nil;
		Hub.UpdateAntiAim = function(dt)
			if (not (Toggles.AntiAimEnable and Toggles.AntiAimEnable.Value) or not IsInMatch()) then
				undergroundSavedPos = nil;
				return;
			end
			local char = LocalPlayer.Character;
			local hrp = char and char:FindFirstChild("HumanoidRootPart");
			if not hrp then
				return;
			end
			antiAimFrameCounter = antiAimFrameCounter + 1;
			local p, y, r = CalculateAntiAimAngles(dt);
			if ((p ~= 0) or (y ~= 0) or (r ~= 0)) then
				hrp.CFrame = hrp.CFrame * CFrame.Angles(p, y, r);
			end
		end;
	end
	do
		local lastFakeStatCheck = 0;
		local nameSpoofBadges = {premium=utf8.char(57345),verified=utf8.char(57344)};
		local function GetSpoofedName()
			local raw = (Options.NameSpoofValue and Options.NameSpoofValue.Value) or "m4rs";
			local clean = raw:gsub(utf8.char(57344), ""):gsub(utf8.char(57345), "");
			local pBadge = (Toggles.NameSpoofPremium and Toggles.NameSpoofPremium.Value and nameSpoofBadges.premium) or "";
			local vBadge = (Toggles.NameSpoofVerified and Toggles.NameSpoofVerified.Value and nameSpoofBadges.verified) or "";
			return clean .. pBadge .. vBadge;
		end
		Hub.ApplySkinChanger = function()
			if not (Toggles.SkinChangerEnabled and Toggles.SkinChangerEnabled.Value) then
				return;
			end
			local char = LocalPlayer.Character;
			if not char then
				return;
			end
			local rawId = (Options.SkinChangerValue and Options.SkinChangerValue.Value) or "1";
			local targetUserId = tonumber(rawId);
			if not targetUserId then
				return;
			end
			pcall(function()
				local model = Players:CreateHumanoidModelFromUserId(targetUserId);
				if not model then
					return;
				end
				for _, obj in ipairs(char:GetChildren()) do
					if (obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("ShirtGraphic")) then
						obj:Destroy();
					end
				end
				local head = char:FindFirstChild("Head");
				if head then
					local face = head:FindFirstChildOfClass("Decal");
					if face then
						face:Destroy();
					end
				end
				for _, obj in ipairs(model:GetChildren()) do
					if (obj:IsA("Accessory") or obj:IsA("Shirt") or obj:IsA("Pants") or obj:IsA("BodyColors") or obj:IsA("CharacterMesh") or obj:IsA("ShirtGraphic")) then
						obj:Clone().Parent = char;
					elseif (obj.Name ~= "Head") then
					else
						local targetFace = obj:FindFirstChildOfClass("Decal");
						if (targetFace and head) then
							targetFace:Clone().Parent = head;
						end
					end
				end
				model:Destroy();
			end);
		end;
		local function HookNameSpoofDescendant(descendant)
			if not (Toggles.NameSpoofEnabled and Toggles.NameSpoofEnabled.Value) then
				return;
			end
			if not (descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox")) then
				return;
			end
			if not descendant.Text then
				return;
			end
			local myName = LocalPlayer.Name;
			if descendant.Text:find(myName, 1, true) then
				local spoof = GetSpoofedName();
				pcall(function()
					descendant.Text = descendant.Text:gsub(myName, spoof);
				end);
			end
		end
		LocalPlayer.PlayerGui.DescendantAdded:Connect(HookNameSpoofDescendant);
		Hub.UpdateFakeStatsLoop = function()
			if ((tick() - lastFakeStatCheck) >= 0.4) then
			else
				return;
			end
			lastFakeStatCheck = tick();
			if (Toggles.LevelSpoof and Toggles.LevelSpoof.Value) then
				local val = tonumber(Options.LevelValue and Options.LevelValue.Value) or 9999;
				LocalPlayer:SetAttribute("Level", val);
			end
			if (Toggles.WinStreakSpoof and Toggles.WinStreakSpoof.Value) then
				local val = tonumber(Options.WinStreakValue and Options.WinStreakValue.Value) or 9999;
				pcall(function()
					local ls = LocalPlayer:FindFirstChild("Leaderstats") or LocalPlayer:FindFirstChild("leaderstats");
					if ls then
						local ws = ls:FindFirstChild("Win Streak") or ls:FindFirstChild("Streak");
						if ws then
							ws.Value = val;
						end
					end
				end);
			end
			if (Toggles.NameSpoofEnabled and Toggles.NameSpoofEnabled.Value) then
				local char = LocalPlayer.Character;
				local hum = char and char:FindFirstChildOfClass("Humanoid");
				if hum then
					local spoof = GetSpoofedName();
					if (hum.DisplayName == spoof) then
					else
						hum.DisplayName = spoof;
					end
				end
			end
			local pGui = LocalPlayer:FindFirstChild("PlayerGui");
			if pGui then
				for _, lbl in ipairs(pGui:GetDescendants()) do
					if (lbl:IsA("TextLabel") and (lbl.Name == "Title")) then
						local pName = (lbl.Parent and lbl.Parent.Name) or "";
						if ((pName == "ServerRegion") and Toggles.RegionSpoofEnabled and Toggles.RegionSpoofEnabled.Value) then
							lbl.Text = (Options.RegionSpoofValue and Options.RegionSpoofValue.Value) or "m4rs";
						elseif (pName:lower():find("fps") and Toggles.FPSSpoofEnabled and Toggles.FPSSpoofEnabled.Value) then
							local base = tonumber(Options.FPSSpoofValue and Options.FPSSpoofValue.Value) or 144;
							if (Toggles.FPSSpoofFraud and Toggles.FPSSpoofFraud.Value) then
								base = base + math.random(-3, 3);
							end
							lbl.Text = tostring(base) .. " FPS";
						elseif ((pName:lower():find("ping") or pName:lower():find("ms")) and Toggles.MSSpoofEnabled and Toggles.MSSpoofEnabled.Value) then
							local base = tonumber(Options.MSSpoofValue and Options.MSSpoofValue.Value) or 15;
							if (Toggles.MSSpoofFraud and Toggles.MSSpoofFraud.Value) then
								base = math.max(1, base + math.random(-2, 4));
							end
							lbl.Text = tostring(base) .. " ms";
						end
					end
				end
			end
		end;
	end
	do
		local unlockAllInitialized = false;
		local cosmeticGui = nil;
		local cosmeticFrame = nil;
		Misc.UnlockAllCosmeticsClient = function()
			pcall(function()
				local ps = LocalPlayer:FindFirstChild("PlayerScripts");
				local ctrl = ps and ps:FindFirstChild("Controllers");
				local dataMod = ctrl and ctrl:FindFirstChild("PlayerDataController");
				if not dataMod then
					return;
				end
				local data_ctrl = SafeRequire(dataMod);
				if (not data_ctrl or not data_ctrl.Get) then
					return;
				end
				local rep = game:GetService("ReplicatedStorage");
				local mods = rep:FindFirstChild("Modules");
				local cosLibMod = mods and mods:FindFirstChild("CosmeticLibrary");
				local cosLib = cosLibMod and SafeRequire(cosLibMod);
				if not _G.OriginalPlayerDataGet then
					_G.OriginalPlayerDataGet = data_ctrl.Get;
					data_ctrl.Get = function(self, key)
						local original = _G.OriginalPlayerDataGet(self, key);
						if (key ~= "CosmeticInventory") then
						else
							local inv = (original and table.clone(original)) or {};
							if (cosLib and cosLib.Cosmetics) then
								for cname, cdata in pairs(cosLib.Cosmetics) do
									if ((inv[cname] == nil) and not cname:find("MISSING_")) then
										inv[cname] = true;
									end
								end
							end
							return inv;
						end
						return original;
					end;
				end
				Library:Notify("Unlocked all client cosmetics & skins in locker!", 4);
			end);
		end;
		Hub.OpenCosmeticChanger = function()
			pcall(function()
				if not unlockAllInitialized then
					Misc.UnlockAllCosmeticsClient();
					unlockAllInitialized = true;
				end
				if cosmeticFrame then
					cosmeticFrame.Visible = not cosmeticFrame.Visible;
					return;
				end
				cosmeticGui = Instance.new("ScreenGui");
				cosmeticGui.Name = "M4rs_CosmeticChanger";
				cosmeticGui.ResetOnSpawn = false;
				cosmeticGui.DisplayOrder = 9999;
				pcall(function()
					if gethui then
						cosmeticGui.Parent = gethui();
					elseif (syn and syn.protect_gui) then
						syn.protect_gui(cosmeticGui);
						cosmeticGui.Parent = game:GetService("CoreGui");
					else
						cosmeticGui.Parent = game:GetService("CoreGui");
					end
				end);
				if not cosmeticGui.Parent then
					pcall(function()
						cosmeticGui.Parent = LocalPlayer:FindFirstChildOfClass("PlayerGui");
					end);
				end
				cosmeticFrame = Instance.new("Frame");
				cosmeticFrame.Size = UDim2.fromOffset(480, 360);
				cosmeticFrame.Position = UDim2.new(0.5, -240, 0.5, -180);
				cosmeticFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 22);
				cosmeticFrame.BorderSizePixel = 0;
				cosmeticFrame.Active = true;
				cosmeticFrame.Draggable = true;
				cosmeticFrame.Parent = cosmeticGui;
				local frameCorner = Instance.new("UICorner", cosmeticFrame);
				frameCorner.CornerRadius = UDim.new(0, 6);
				local frameStroke = Instance.new("UIStroke", cosmeticFrame);
				frameStroke.Color = Color3.fromRGB(50, 50, 65);
				frameStroke.Thickness = 1.5;
				local title = Instance.new("TextLabel", cosmeticFrame);
				title.Size = UDim2.new(1, -40, 0, 32);
				title.Position = UDim2.fromOffset(12, 0);
				title.BackgroundTransparency = 1;
				title.Text = "m4rs | Cosmetic & Weapon Skin Changer";
				title.TextColor3 = Color3.fromRGB(240, 240, 240);
				title.Font = Enum.Font.GothamBold;
				title.TextSize = 14;
				title.TextXAlignment = Enum.TextXAlignment.Left;
				local closeBtn = Instance.new("TextButton", cosmeticFrame);
				closeBtn.Size = UDim2.fromOffset(24, 24);
				closeBtn.Position = UDim2.new(1, -30, 0, 4);
				closeBtn.BackgroundTransparency = 1;
				closeBtn.Text = "X";
				closeBtn.TextColor3 = Color3.fromRGB(200, 70, 70);
				closeBtn.Font = Enum.Font.GothamBold;
				closeBtn.TextSize = 14;
				closeBtn.MouseButton1Click:Connect(function()
					cosmeticFrame.Visible = false;
				end);
				local scroll = Instance.new("ScrollingFrame", cosmeticFrame);
				scroll.Size = UDim2.new(1, -24, 1, -50);
				scroll.Position = UDim2.fromOffset(12, 38);
				scroll.BackgroundTransparency = 1;
				scroll.ScrollBarThickness = 4;
				scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y;
				scroll.CanvasSize = UDim2.new(0, 0, 0, 0);
				local grid = Instance.new("UIGridLayout", scroll);
				grid.CellSize = UDim2.fromOffset(105, 95);
				grid.CellPadding = UDim2.fromOffset(8, 8);
				local rep = game:GetService("ReplicatedStorage");
				local mods = rep:FindFirstChild("Modules");
				local cosLibMod = mods and mods:FindFirstChild("CosmeticLibrary");
				local cosLib = cosLibMod and SafeRequire(cosLibMod);
				if (cosLib and cosLib.Cosmetics) then
					local count = 0;
					for cname, cdata in pairs(cosLib.Cosmetics) do
						if (count < 60) then
						else
							break;
						end
						if (not cname:find("MISSING_") and (cdata.Type == "Skin")) then
							count = count + 1;
							local card = Instance.new("TextButton", scroll);
							card.BackgroundColor3 = Color3.fromRGB(28, 28, 35);
							card.BorderSizePixel = 0;
							card.Text = "";
							local cCorner = Instance.new("UICorner", card);
							cCorner.CornerRadius = UDim.new(0, 4);
							local icon = Instance.new("ImageLabel", card);
							icon.Size = UDim2.new(1, -8, 0, 60);
							icon.Position = UDim2.fromOffset(4, 4);
							icon.BackgroundTransparency = 1;
							icon.Image = cdata.ImageHighResolution or cdata.Image or "";
							local lbl = Instance.new("TextLabel", card);
							lbl.Size = UDim2.new(1, -4, 0, 24);
							lbl.Position = UDim2.new(0, 2, 1, -26);
							lbl.BackgroundTransparency = 1;
							lbl.Text = cname;
							lbl.TextColor3 = Color3.fromRGB(220, 220, 220);
							lbl.Font = Enum.Font.GothamMedium;
							lbl.TextSize = 10;
							lbl.TextTruncate = Enum.TextTruncate.AtEnd;
							card.MouseButton1Click:Connect(function()
								Library:Notify("Applied Skin: " .. cname, 3);
								PlayUiSound(6895079853);
							end);
						end
					end
				end
			end);
		end;
	end
	do
		local SlfMtrlOriginals = {};
		local SlfMtrlPhase = 0;
		local function SlfMtrlBlend(t, c1, c2, c3)
			if (t >= 0.5) then
			else
				return c1:Lerp(c2, t * 2);
			end
			return c2:Lerp(c3, (t - 0.5) * 2);
		end
		Hub.UpdateSlfMtrl = function(dt)
			if not (Toggles.SlfMtrlEnable and Toggles.SlfMtrlEnable.Value) then
				if (next(SlfMtrlOriginals) == nil) then
				else
					for part, data in pairs(SlfMtrlOriginals) do
						if (part and part.Parent) then
							part.Material = data.Material;
							part.Color = data.Color;
							part.Transparency = data.Transparency;
						end
					end
					table.clear(SlfMtrlOriginals);
				end
				return;
			end
			local char = LocalPlayer.Character;
			if not char then
				return;
			end
			local c1 = (Options.SlfMtrlColor1 and Options.SlfMtrlColor1.Value) or Color3.fromRGB(255, 255, 255);
			local c2 = (Options.SlfMtrlColor2 and Options.SlfMtrlColor2.Value) or Color3.fromRGB(255, 255, 255);
			local c3 = (Options.SlfMtrlColor3 and Options.SlfMtrlColor3.Value) or Color3.fromRGB(255, 255, 255);
			local matName = (Options.SlfMtrlMaterial and Options.SlfMtrlMaterial.Value) or "Neon";
			local matEnum = Enum.Material[matName] or Enum.Material.Neon;
			local trans = (Options.SlfMtrlTransparency and Options.SlfMtrlTransparency.Value) or 0.1;
			local pSpeed = (Options.SlfMtrlPulseSpeed and Options.SlfMtrlPulseSpeed.Value) or 3;
			SlfMtrlPhase = SlfMtrlPhase + (dt * pSpeed);
			local t = (math.sin(SlfMtrlPhase) + 1) * 0.5;
			local pulseCol = SlfMtrlBlend(t, c1, c2, c3);
			for _, part in ipairs(char:GetChildren()) do
				if (part:IsA("BasePart") and (part.Name ~= "HumanoidRootPart")) then
					if not SlfMtrlOriginals[part] then
						SlfMtrlOriginals[part] = {Material=part.Material,Color=part.Color,Transparency=part.Transparency};
					end
					part.Material = matEnum;
					part.Color = pulseCol;
					part.Transparency = trans;
				end
			end
		end;
		local animActiveTrack = nil;
		local animLastJitter = tick();
		local animJitterState = false;
		local function PlaySelectedAnimation(animIdStr)
			local char = LocalPlayer.Character;
			local hum = char and char:FindFirstChildOfClass("Humanoid");
			if not hum then
				return;
			end
			local animator = hum:FindFirstChildOfClass("Animator") or hum;
			local cleanId = tostring(animIdStr or ""):gsub("%D", "");
			if (cleanId == "") then
				return;
			end
			pcall(function()
				if animActiveTrack then
					animActiveTrack:Stop();
					animActiveTrack:Destroy();
					animActiveTrack = nil;
				end
				local animObj = Instance.new("Animation");
				animObj.AnimationId = "rbxassetid://" .. cleanId;
				animActiveTrack = animator:LoadAnimation(animObj);
				animObj:Destroy();
				animActiveTrack.Looped = (Toggles.AnimLoop and Toggles.AnimLoop.Value) or true;
				animActiveTrack:Play(0.05, 1, 1);
				local spd = (Options.AnimSpeed and Options.AnimSpeed.Value) or 1;
				animActiveTrack:AdjustSpeed(spd);
			end);
		end
		Hub.StopAllAnimations = function()
			pcall(function()
				if animActiveTrack then
					animActiveTrack:Stop();
					animActiveTrack:Destroy();
					animActiveTrack = nil;
				end
				local char = LocalPlayer.Character;
				local hum = char and char:FindFirstChildOfClass("Humanoid");
				local animator = hum and hum:FindFirstChildOfClass("Animator");
				if animator then
					for _, tr in ipairs(animator:GetPlayingAnimationTracks()) do
						tr:Stop();
					end
				end
			end);
		end;
		Hub.UpdateAnimLoop = function()
			if not (Toggles.AnimEnabled and Toggles.AnimEnabled.Value) then
				if animActiveTrack then
					Hub.StopAllAnimations();
				end
				return;
			end
			if (Toggles.AnimJitter and Toggles.AnimJitter.Value) then
				local interval = (Options.JitterSpeed and Options.JitterSpeed.Value) or 0.1;
				if ((tick() - animLastJitter) < interval) then
				else
					animLastJitter = tick();
					animJitterState = not animJitterState;
					local targetId = (animJitterState and Options.AnimJitterID and Options.AnimJitterID.Value) or (Options.AnimForceID and Options.AnimForceID.Value);
					PlaySelectedAnimation(targetId);
				end
			elseif (not animActiveTrack or not animActiveTrack.IsPlaying) then
				local primaryId = (Options.AnimForceID and Options.AnimForceID.Value) or "96579993895076";
				PlaySelectedAnimation(primaryId);
			end
		end;
	end
	do
		local customSkyboxInstance = nil;
		local customAtmosphereInstance = nil;
		local currentAmbientSound = nil;
		local weatherPart = nil;
		local weatherEmitter = nil;
		do
			local openSourceSkyboxData = {SpongeBob={SkyboxBk="http://www.roblox.com/asset/?id=15962101128",SkyboxDn="http://www.roblox.com/asset/?id=15970246218",SkyboxFt="http://www.roblox.com/asset/?id=15962101128",SkyboxLf="http://www.roblox.com/asset/?id=15962101128",SkyboxRt="http://www.roblox.com/asset/?id=15962101128",SkyboxUp="http://www.roblox.com/asset/?id=15962901054"},["Deep Space"]={SkyboxBk="http://www.roblox.com/asset/?id=159248188",SkyboxDn="http://www.roblox.com/asset/?id=159248183",SkyboxFt="http://www.roblox.com/asset/?id=159248187",SkyboxLf="http://www.roblox.com/asset/?id=159248173",SkyboxRt="http://www.roblox.com/asset/?id=159248192",SkyboxUp="http://www.roblox.com/asset/?id=159248176"},["Crazy Hello City"]={SkyboxBk="http://www.roblox.com/asset/?id=5487778646",SkyboxDn="http://www.roblox.com/asset/?id=5487764867",SkyboxFt="http://www.roblox.com/asset/?id=5487778646",SkyboxLf="http://www.roblox.com/asset/?id=5487778646",SkyboxRt="http://www.roblox.com/asset/?id=5487778646",SkyboxUp="http://www.roblox.com/asset/?id=5487762943"},["One Piece"]={SkyboxBk="http://www.roblox.com/asset/?id=158516797",SkyboxDn="http://www.roblox.com/asset/?id=158516788",SkyboxFt="http://www.roblox.com/asset/?id=158516797",SkyboxLf="http://www.roblox.com/asset/?id=158516797",SkyboxRt="http://www.roblox.com/asset/?id=158516797",SkyboxUp="http://www.roblox.com/asset/?id=158516792"},Matcha={SkyboxBk="http://www.roblox.com/asset/?id=151165214",SkyboxDn="http://www.roblox.com/asset/?id=151165197",SkyboxFt="http://www.roblox.com/asset/?id=151165224",SkyboxLf="http://www.roblox.com/asset/?id=151165191",SkyboxRt="http://www.roblox.com/asset/?id=151165206",SkyboxUp="http://www.roblox.com/asset/?id=151165227"},["Abyssal Blues"]={SkyboxBk="http://www.roblox.com/asset/?id=16269815885",SkyboxDn="http://www.roblox.com/asset/?id=16269839652",SkyboxFt="http://www.roblox.com/asset/?id=16269798011",SkyboxLf="http://www.roblox.com/asset/?id=16269813852",SkyboxRt="http://www.roblox.com/asset/?id=16269814948",SkyboxUp="http://www.roblox.com/asset/?id=16269829700"},["Pink Sky"]={SkyboxBk="http://www.roblox.com/asset/?id=271042516",SkyboxDn="http://www.roblox.com/asset/?id=271077243",SkyboxFt="http://www.roblox.com/asset/?id=271042556",SkyboxLf="http://www.roblox.com/asset/?id=271042310",SkyboxRt="http://www.roblox.com/asset/?id=271042467",SkyboxUp="http://www.roblox.com/asset/?id=271077958"},["Green Sky"]={SkyboxBk="rbxassetid://921882045",SkyboxDn="rbxassetid://921881907",SkyboxFt="rbxassetid://921882121",SkyboxLf="rbxassetid://921881811",SkyboxRt="rbxassetid://921881989",SkyboxUp="rbxassetid://921882259"},["Purple Nebula"]={SkyboxBk="http://www.roblox.com/asset/?id=159454299",SkyboxDn="http://www.roblox.com/asset/?id=159454296",SkyboxFt="http://www.roblox.com/asset/?id=159454299",SkyboxLf="http://www.roblox.com/asset/?id=159454299",SkyboxRt="http://www.roblox.com/asset/?id=159454299",SkyboxUp="http://www.roblox.com/asset/?id=159454288"},Vaporwave={SkyboxBk="http://www.roblox.com/asset/?id=1417494030",SkyboxDn="http://www.roblox.com/asset/?id=1417494146",SkyboxFt="http://www.roblox.com/asset/?id=1417494030",SkyboxLf="http://www.roblox.com/asset/?id=1417494030",SkyboxRt="http://www.roblox.com/asset/?id=1417494030",SkyboxUp="http://www.roblox.com/asset/?id=1417494643"},Redshift={SkyboxBk="http://www.roblox.com/asset/?id=2670643365",SkyboxDn="http://www.roblox.com/asset/?id=2670643365",SkyboxFt="http://www.roblox.com/asset/?id=2670643365",SkyboxLf="http://www.roblox.com/asset/?id=2670643365",SkyboxRt="http://www.roblox.com/asset/?id=2670643365",SkyboxUp="http://www.roblox.com/asset/?id=2670643365"},Minecraft={SkyboxBk="rbxassetid://1876545003",SkyboxDn="rbxassetid://1876544331",SkyboxFt="rbxassetid://1876542941",SkyboxLf="rbxassetid://1876543392",SkyboxRt="rbxassetid://1876543764",SkyboxUp="rbxassetid://1876544642"},PurpleDay={SkyboxBk="rbxassetid://296908715",SkyboxDn="rbxassetid://296908724",SkyboxFt="rbxassetid://296908740",SkyboxLf="rbxassetid://296908755",SkyboxRt="rbxassetid://296908764",SkyboxUp="rbxassetid://296908769"},RedNight={SkyboxBk="rbxassetid://401664839",SkyboxDn="rbxassetid://401664862",SkyboxFt="rbxassetid://401664960",SkyboxLf="rbxassetid://401664881",SkyboxRt="rbxassetid://401664901",SkyboxUp="rbxassetid://401664936"},Trollge={SkyboxBk="rbxassetid://6155393905",SkyboxDn="rbxassetid://6155393905",SkyboxFt="rbxassetid://6155393905",SkyboxLf="rbxassetid://6155393905",SkyboxRt="rbxassetid://6155393905",SkyboxUp="rbxassetid://6155393905"},Night={SkyboxBk="rbxassetid://48020371",SkyboxDn="rbxassetid://48020144",SkyboxFt="rbxassetid://48020234",SkyboxLf="rbxassetid://48020211",SkyboxRt="rbxassetid://48020254",SkyboxUp="rbxassetid://48020383"},Space={SkyboxBk="rbxassetid://149397692",SkyboxDn="rbxassetid://149397686",SkyboxFt="rbxassetid://149397697",SkyboxLf="rbxassetid://149397684",SkyboxRt="rbxassetid://149397688",SkyboxUp="rbxassetid://149397702"},Default={SkyboxBk="rbxassetid://6444884337",SkyboxDn="rbxassetid://6444884785",SkyboxFt="rbxassetid://6444884337",SkyboxLf="rbxassetid://6444884337",SkyboxRt="rbxassetid://6444884337",SkyboxUp="rbxassetid://6412503613"},VibeMorning={SkyboxBk="rbxassetid://1417494030",SkyboxDn="rbxassetid://1417494146",SkyboxFt="rbxassetid://1417494253",SkyboxLf="rbxassetid://1417494402",SkyboxRt="rbxassetid://1417494499",SkyboxUp="rbxassetid://1417494643"},VibeNight={SkyboxBk="rbxassetid://5084575798",SkyboxDn="rbxassetid://5084575916",SkyboxFt="rbxassetid://5103949679",SkyboxLf="rbxassetid://5103948542",SkyboxRt="rbxassetid://5103948784",SkyboxUp="rbxassetid://5084576400"},PurpleSplash={SkyboxBk="rbxassetid://8539982183",SkyboxDn="rbxassetid://8539981943",SkyboxFt="rbxassetid://8539981721",SkyboxLf="rbxassetid://8539981424",SkyboxRt="rbxassetid://8539980766",SkyboxUp="rbxassetid://8539981085"},GreenSpace={SkyboxBk="rbxassetid://159248188",SkyboxDn="rbxassetid://159248183",SkyboxFt="rbxassetid://159248187",SkyboxLf="rbxassetid://159248173",SkyboxRt="rbxassetid://159248192",SkyboxUp="rbxassetid://159248176"},Snowy={SkyboxBk="rbxassetid://155657655",SkyboxDn="rbxassetid://155674246",SkyboxFt="rbxassetid://155657609",SkyboxLf="rbxassetid://155657671",SkyboxRt="rbxassetid://155657619",SkyboxUp="rbxassetid://155674931"},Spongebob={SkyboxBk="rbxassetid://10287764626",SkyboxDn="rbxassetid://10287766382",SkyboxFt="rbxassetid://10287764626",SkyboxLf="rbxassetid://10287763421",SkyboxRt="rbxassetid://10287764626",SkyboxUp="rbxassetid://10287767597"},PinkDay={SkyboxBk="rbxassetid://271042516",SkyboxDn="rbxassetid://271077243",SkyboxFt="rbxassetid://271042556",SkyboxLf="rbxassetid://271042310",SkyboxRt="rbxassetid://271042467",SkyboxUp="rbxassetid://271077958"},AlienRed={SkyboxBk="rbxassetid://1012890",SkyboxDn="rbxassetid://1012891",SkyboxFt="rbxassetid://1012887",SkyboxLf="rbxassetid://1012889",SkyboxRt="rbxassetid://1012888",SkyboxUp="rbxassetid://1014449"},WallsOfAutumn={SkyboxBk="rbxassetid://7123244709",SkyboxDn="rbxassetid://7123246497",SkyboxFt="rbxassetid://7123255895",SkyboxLf="rbxassetid://7123257992",SkyboxRt="rbxassetid://7123279103",SkyboxUp="rbxassetid://7123281828"},ColdWinterness={SkyboxBk="rbxassetid://7123754562",SkyboxDn="rbxassetid://7123756028",SkyboxFt="rbxassetid://7123757422",SkyboxLf="rbxassetid://7123758897",SkyboxRt="rbxassetid://7123760563",SkyboxUp="rbxassetid://7123762364"},Oblivion={SkyboxBk="rbxassetid://7123654189",SkyboxDn="rbxassetid://7123657455",SkyboxFt="rbxassetid://7123662047",SkyboxLf="rbxassetid://7123664533",SkyboxRt="rbxassetid://7123666598",SkyboxUp="rbxassetid://7123668994"},ClassicSky={SkyboxBk="rbxassetid://672345740",SkyboxDn="rbxassetid://672345828",SkyboxFt="rbxassetid://672345879",SkyboxLf="rbxassetid://672345927",SkyboxRt="rbxassetid://672346006",SkyboxUp="rbxassetid://672346072"},PurpleNight={SkyboxBk="rbxassetid://5084575798",SkyboxDn="rbxassetid://5084575916",SkyboxFt="rbxassetid://5103949679",SkyboxLf="rbxassetid://5103948542",SkyboxRt="rbxassetid://5103948784",SkyboxUp="rbxassetid://5084576400"},PurpleDayClear={SkyboxBk="rbxassetid://6847607535",SkyboxDn="rbxassetid://6847607977",SkyboxFt="rbxassetid://6847608302",SkyboxLf="rbxassetid://6847608608",SkyboxRt="rbxassetid://6847608986",SkyboxUp="rbxassetid://6847609323"},YellowDay={SkyboxBk="rbxassetid://2651432901",SkyboxDn="rbxassetid://2651434974",SkyboxFt="rbxassetid://2651435990",SkyboxLf="rbxassetid://2651436494",SkyboxRt="rbxassetid://2651436979",SkyboxUp="rbxassetid://2651437350"},MinecraftSky={SkyboxBk="rbxassetid://8735166756",SkyboxDn="rbxassetid://8735166707",SkyboxFt="rbxassetid://8735231668",SkyboxLf="rbxassetid://8735166755",SkyboxRt="rbxassetid://8735166751",SkyboxUp="rbxassetid://8735166729"},Sunset={SkyboxBk="rbxassetid://150939022",SkyboxDn="rbxassetid://150939038",SkyboxFt="rbxassetid://150939047",SkyboxLf="rbxassetid://150939056",SkyboxRt="rbxassetid://150939063",SkyboxUp="rbxassetid://150939082"},CartoonSky={SkyboxBk="rbxassetid://6778646360",SkyboxDn="rbxassetid://6778658683",SkyboxFt="rbxassetid://6778648039",SkyboxLf="rbxassetid://6778649136",SkyboxRt="rbxassetid://6778650519",SkyboxUp="rbxassetid://6778658364"},Anime={SkyboxBk="rbxassetid://7643700666",SkyboxDn="rbxassetid://7643743687",SkyboxFt="rbxassetid://7644304186",SkyboxLf="rbxassetid://7644288724",SkyboxRt="rbxassetid://7643700819",SkyboxUp="rbxassetid://7643757404"},HellSky={SkyboxBk="rbxassetid://437430787",SkyboxDn="rbxassetid://437430804",SkyboxFt="rbxassetid://437430543",SkyboxLf="rbxassetid://437430732",SkyboxRt="rbxassetid://437430747",SkyboxUp="rbxassetid://437430771"},StarryNight={SkyboxBk="rbxassetid://8291078911",SkyboxDn="rbxassetid://8291077403",SkyboxFt="rbxassetid://8291081613",SkyboxLf="rbxassetid://8291074004",SkyboxRt="rbxassetid://8291080353",SkyboxUp="rbxassetid://8291075054"},Omori={SkyboxBk="rbxassetid://8767416629",SkyboxDn="rbxassetid://8767416629",SkyboxFt="rbxassetid://8767416629",SkyboxLf="rbxassetid://8767416629",SkyboxRt="rbxassetid://8767416629",SkyboxUp="rbxassetid://8767416629"},c00lkidd={SkyboxBk="rbxassetid://433381097",SkyboxDn="rbxassetid://433381097",SkyboxFt="rbxassetid://433381097",SkyboxLf="rbxassetid://433381097",SkyboxRt="rbxassetid://433381097",SkyboxUp="rbxassetid://433381097"},ClearDay={SkyboxBk="rbxassetid://591058823",SkyboxDn="rbxassetid://591059876",SkyboxFt="rbxassetid://591058104",SkyboxLf="rbxassetid://591057861",SkyboxRt="rbxassetid://591057625",SkyboxUp="rbxassetid://591059642"},Mountains={SkyboxBk="http://www.roblox.com/asset/?id=324014980",SkyboxDn="http://www.roblox.com/asset/?id=324015477",SkyboxFt="http://www.roblox.com/asset/?id=324014995",SkyboxLf="http://www.roblox.com/asset/?id=324014679",SkyboxRt="http://www.roblox.com/asset/?id=324015013",SkyboxUp="http://www.roblox.com/asset/?id=324015409"},Forest={SkyboxBk="http://www.roblox.com/asset/?id=70945545",SkyboxDn="http://www.roblox.com/asset/?id=70945449",SkyboxFt="http://www.roblox.com/asset/?id=70945487",SkyboxLf="http://www.roblox.com/asset/?id=70945523",SkyboxRt="http://www.roblox.com/asset/?id=70945508",SkyboxUp="http://www.roblox.com/asset/?id=70945531"},LargeForest={SkyboxBk="rbxassetid://17428978603",SkyboxDn="rbxassetid://17428977445",SkyboxFt="rbxassetid://17428977114",SkyboxLf="rbxassetid://17428978399",SkyboxRt="rbxassetid://17428976828",SkyboxUp="rbxassetid://17428976669"},Crimson={SkyboxBk="rbxassetid://15832429892",SkyboxDn="rbxassetid://15832430998",SkyboxFt="rbxassetid://15832430210",SkyboxLf="rbxassetid://15832430671",SkyboxRt="rbxassetid://15832431198",SkyboxUp="rbxassetid://15832429401"},PumpkinHill={SkyboxBk="rbxassetid://11202510597",SkyboxDn="rbxassetid://11202510255",SkyboxFt="rbxassetid://11202509993",SkyboxLf="rbxassetid://11202510806",SkyboxRt="rbxassetid://11202511066",SkyboxUp="rbxassetid://11202509704"},AnimeIsland={SkyboxBk="http://www.roblox.com/asset/?id=14753804949",SkyboxDn="http://www.roblox.com/asset/?id=14753795573",SkyboxFt="http://www.roblox.com/asset/?id=14753807625",SkyboxLf="http://www.roblox.com/asset/?id=14753797417",SkyboxRt="http://www.roblox.com/asset/?id=14753799966",SkyboxUp="http://www.roblox.com/asset/?id=14753810287"},SnowyMountains={SkyboxBk="http://www.roblox.com/asset/?id=368385273",SkyboxDn="http://www.roblox.com/asset/?id=48015300",SkyboxFt="http://www.roblox.com/asset/?id=368388290",SkyboxLf="http://www.roblox.com/asset/?id=368390615",SkyboxRt="http://www.roblox.com/asset/?id=368385190",SkyboxUp="http://www.roblox.com/asset/?id=48015387"},Desert={SkyboxBk="rbxassetid://161319957",SkyboxDn="rbxassetid://161319965",SkyboxFt="rbxassetid://161319970",SkyboxLf="rbxassetid://161319983",SkyboxRt="rbxassetid://161319989",SkyboxUp="rbxassetid://161319996"},Cloudy={SkyboxBk="http://www.roblox.com/asset/?id=225469345",SkyboxDn="http://www.roblox.com/asset/?id=225469349",SkyboxFt="http://www.roblox.com/asset/?id=225469359",SkyboxLf="http://www.roblox.com/asset/?id=225469364",SkyboxRt="http://www.roblox.com/asset/?id=225469372",SkyboxUp="http://www.roblox.com/asset/?id=225469380"},Island={SkyboxBk="http://www.roblox.com/asset/?id=319343577",SkyboxDn="http://www.roblox.com/asset/?id=319343653",SkyboxFt="http://www.roblox.com/asset/?id=319343666",SkyboxLf="http://www.roblox.com/asset/?id=319343686",SkyboxRt="http://www.roblox.com/asset/?id=319343631",SkyboxUp="http://www.roblox.com/asset/?id=319343614"},OrangeFog={SkyboxBk="http://www.roblox.com/asset/?id=458016711",SkyboxDn="http://www.roblox.com/asset/?id=458016826",SkyboxFt="http://www.roblox.com/asset/?id=458016532",SkyboxLf="http://www.roblox.com/asset/?id=458016655",SkyboxRt="http://www.roblox.com/asset/?id=458016782",SkyboxUp="http://www.roblox.com/asset/?id=458016792"},FadeNight={SkyboxBk="http://www.roblox.com/asset/?id=16888843486",SkyboxDn="http://www.roblox.com/asset/?id=16888845693",SkyboxFt="http://www.roblox.com/asset/?id=16888848245",SkyboxLf="http://www.roblox.com/asset/?id=16888850949",SkyboxRt="http://www.roblox.com/asset/?id=16888854243",SkyboxUp="http://www.roblox.com/asset/?id=16888857144"},Office={SkyboxBk="rbxassetid://658623433",SkyboxDn="rbxassetid://316342560",SkyboxFt="rbxassetid://658625205",SkyboxLf="rbxassetid://658627155",SkyboxRt="rbxassetid://658628504",SkyboxUp="rbxassetid://658632701"},Spongebob2={SkyboxBk="rbxassetid://12049872454",SkyboxDn="rbxassetid://12049872284",SkyboxFt="rbxassetid://12049872181",SkyboxLf="rbxassetid://12049872074",SkyboxRt="rbxassetid://12049871884",SkyboxUp="rbxassetid://12049871774"},PurpleFog={SkyboxBk="http://www.roblox.com/asset/?id=17279854976",SkyboxDn="http://www.roblox.com/asset/?id=17279856318",SkyboxFt="http://www.roblox.com/asset/?id=17279858447",SkyboxLf="http://www.roblox.com/asset/?id=17279860360",SkyboxRt="http://www.roblox.com/asset/?id=17279862234",SkyboxUp="http://www.roblox.com/asset/?id=17279864507"},EarthSpace={SkyboxBk="rbxassetid://15753305495",SkyboxDn="rbxassetid://15753362674",SkyboxFt="rbxassetid://15753305823",SkyboxLf="rbxassetid://15753310707",SkyboxRt="rbxassetid://15753304774",SkyboxUp="rbxassetid://15753304473"},GreenCloudy={SkyboxBk="rbxassetid://921882045",SkyboxDn="rbxassetid://921881907",SkyboxFt="rbxassetid://921882121",SkyboxLf="rbxassetid://921881811",SkyboxRt="rbxassetid://921881989",SkyboxUp="rbxassetid://921882259"},SummerDay={SkyboxBk="http://www.roblox.com/asset/?version=1&id=135483466",SkyboxDn="http://www.roblox.com/asset/?version=1&id=135483484",SkyboxFt="http://www.roblox.com/asset/?version=1&id=135483461",SkyboxLf="http://www.roblox.com/asset/?version=1&id=135483495",SkyboxRt="http://www.roblox.com/asset/?version=1&id=135483499",SkyboxUp="http://www.roblox.com/asset/?version=1&id=135483475"},SnowyPlains={SkyboxBk="http://www.roblox.com/asset/?id=155657655",SkyboxDn="http://www.roblox.com/asset/?id=155674246",SkyboxFt="http://www.roblox.com/asset/?id=155657609",SkyboxLf="http://www.roblox.com/asset/?id=155657671",SkyboxRt="http://www.roblox.com/asset/?id=155657619",SkyboxUp="http://www.roblox.com/asset/?id=155674931"},Underwater={SkyboxBk="http://www.roblox.com/asset/?id=227635868",SkyboxDn="http://www.roblox.com/asset/?id=227635921",SkyboxFt="http://www.roblox.com/asset/?id=227635954",SkyboxLf="http://www.roblox.com/asset/?id=227635974",SkyboxRt="http://www.roblox.com/asset/?id=227635990",SkyboxUp="http://www.roblox.com/asset/?id=227636031"},BlueAbyss={SkyboxBk="rbxassetid://16269815885",SkyboxDn="rbxassetid://16269839652",SkyboxFt="rbxassetid://16269798011",SkyboxLf="rbxassetid://16269813852",SkyboxRt="rbxassetid://16269814948",SkyboxUp="rbxassetid://16269829700"},Poison={SkyboxBk="rbxassetid://1370716695",SkyboxDn="rbxassetid://1370716766",SkyboxFt="rbxassetid://1370716833",SkyboxLf="rbxassetid://1370716898",SkyboxRt="rbxassetid://1370716955",SkyboxUp="rbxassetid://1370717024"},BlueSpace={SkyboxBk="rbxassetid://1127563035",SkyboxDn="rbxassetid://1127563006",SkyboxFt="rbxassetid://1127563026",SkyboxLf="rbxassetid://1127563216",SkyboxRt="rbxassetid://1127563115",SkyboxUp="rbxassetid://1127562999"},AnimeMountains={SkyboxBk="http://www.roblox.com/asset/?id=12849370744",SkyboxDn="http://www.roblox.com/asset/?id=12849378890",SkyboxFt="http://www.roblox.com/asset/?id=12849390276",SkyboxLf="http://www.roblox.com/asset/?id=12849405549",SkyboxRt="http://www.roblox.com/asset/?id=12849398428",SkyboxUp="http://www.roblox.com/asset/?id=12849426002"},PinkGradient={SkyboxBk="http://www.roblox.com/asset/?id=5371541816",SkyboxDn="http://www.roblox.com/asset/?id=5371541154",SkyboxFt="http://www.roblox.com/asset/?id=5371541816",SkyboxLf="http://www.roblox.com/asset/?id=5371541816",SkyboxRt="http://www.roblox.com/asset/?id=5371541816",SkyboxUp="http://www.roblox.com/asset/?id=5371540604"},YellowGradient={SkyboxBk="http://www.roblox.com/asset/?id=159005370",SkyboxDn="rbxassetid://858422412",SkyboxFt="http://www.roblox.com/asset/?id=159005370",SkyboxLf="http://www.roblox.com/asset/?id=159005370",SkyboxRt="http://www.roblox.com/asset/?id=159005370",SkyboxUp="http://www.roblox.com/asset/?id=159006363"},BlueGradient={SkyboxBk="http://www.roblox.com/asset/?id=4628466090",SkyboxDn="http://www.roblox.com/asset/?id=4628471901",SkyboxFt="http://www.roblox.com/asset/?id=4628466090",SkyboxLf="http://www.roblox.com/asset/?id=4628466090",SkyboxRt="http://www.roblox.com/asset/?id=4628466090",SkyboxUp="http://www.roblox.com/asset/?id=4628472152"},GreenNebula={SkyboxBk="http://www.roblox.com/asset/?id=47974894",SkyboxDn="http://www.roblox.com/asset/?id=47974690",SkyboxFt="http://www.roblox.com/asset/?id=47974821",SkyboxLf="http://www.roblox.com/asset/?id=47974776",SkyboxRt="http://www.roblox.com/asset/?id=47974859",SkyboxUp="http://www.roblox.com/asset/?id=47974909"},OrangeGradient={SkyboxBk="rbxassetid://6902754982",SkyboxDn="rbxassetid://6902795826",SkyboxFt="rbxassetid://6902754982",SkyboxLf="rbxassetid://6902754982",SkyboxRt="rbxassetid://6902754982",SkyboxUp="rbxassetid://6902796078"},GreenAurora={SkyboxBk="http://www.roblox.com/asset/?id=16563478983",SkyboxDn="http://www.roblox.com/asset/?id=16563481302",SkyboxFt="http://www.roblox.com/asset/?id=16563484084",SkyboxLf="http://www.roblox.com/asset/?id=16563485362",SkyboxRt="http://www.roblox.com/asset/?id=16563487078",SkyboxUp="http://www.roblox.com/asset/?id=16563489821"},Blank={SkyboxBk="http://www.roblox.com/asset/?ID=1361097",SkyboxDn="http://www.roblox.com/asset/?ID=1361097",SkyboxFt="http://www.roblox.com/asset/?ID=1361097",SkyboxLf="http://www.roblox.com/asset/?ID=1361097",SkyboxRt="http://www.roblox.com/asset/?ID=1361097",SkyboxUp="http://www.roblox.com/asset/?ID=1361097"},Clouds={SkyboxBk="rbxassetid://570557514",SkyboxDn="rbxassetid://570557775",SkyboxFt="rbxassetid://570557559",SkyboxLf="rbxassetid://570557620",SkyboxRt="rbxassetid://570557672",SkyboxUp="rbxassetid://570557727"},["Cloudy Skies"]={SkyboxBk="rbxassetid://151165214",SkyboxDn="rbxassetid://151165197",SkyboxFt="rbxassetid://151165224",SkyboxLf="rbxassetid://151165191",SkyboxRt="rbxassetid://151165206",SkyboxUp="rbxassetid://151165227"},["Elegant Morning"]={SkyboxBk="rbxassetid://153767241",SkyboxDn="rbxassetid://153767216",SkyboxFt="rbxassetid://153767266",SkyboxLf="rbxassetid://153767200",SkyboxRt="rbxassetid://153767231",SkyboxUp="rbxassetid://153767288"},["Fade Blue"]={SkyboxBk="rbxassetid://153695414",SkyboxDn="rbxassetid://153695352",SkyboxFt="rbxassetid://153695452",SkyboxLf="rbxassetid://153695320",SkyboxRt="rbxassetid://153695383",SkyboxUp="rbxassetid://153695471"},Neptune={SkyboxBk="rbxassetid://218955819",SkyboxDn="rbxassetid://218953419",SkyboxFt="rbxassetid://218954524",SkyboxLf="rbxassetid://218958493",SkyboxRt="rbxassetid://218957134",SkyboxUp="rbxassetid://218950090"},["Night Sky"]={SkyboxBk="rbxassetid://12064107",SkyboxDn="rbxassetid://12064152",SkyboxFt="rbxassetid://12064121",SkyboxLf="rbxassetid://12063984",SkyboxRt="rbxassetid://12064115",SkyboxUp="rbxassetid://12064131"},["Purple And Blue"]={SkyboxBk="rbxassetid://149397692",SkyboxDn="rbxassetid://149397686",SkyboxFt="rbxassetid://149397697",SkyboxLf="rbxassetid://149397684",SkyboxRt="rbxassetid://149397688",SkyboxUp="rbxassetid://149397702"},["Purple Clouds"]={SkyboxBk="rbxassetid://151165214",SkyboxDn="rbxassetid://151165197",SkyboxFt="rbxassetid://151165224",SkyboxLf="rbxassetid://151165191",SkyboxRt="rbxassetid://151165206",SkyboxUp="rbxassetid://151165227"},["Purple Galaxy"]={SkyboxBk="http://www.roblox.com/Asset/?ID=14543264135",SkyboxDn="http://www.roblox.com/asset/?ID=14543358958",SkyboxFt="http://www.roblox.com/asset/?ID=14543257810",SkyboxLf="http://www.roblox.com/asset/?ID=14543275895",SkyboxRt="http://www.roblox.com/asset/?ID=14543280890",SkyboxUp="http://www.roblox.com/asset/?ID=14543371676"},["Red Night Sky"]={SkyboxBk="http://www.roblox.com/Asset/?ID=401664839",SkyboxDn="http://www.roblox.com/asset/?ID=401664862",SkyboxFt="http://www.roblox.com/asset/?ID=401664960",SkyboxLf="http://www.roblox.com/asset/?ID=401664881",SkyboxRt="http://www.roblox.com/asset/?ID=401664901",SkyboxUp="http://www.roblox.com/asset/?ID=401664936"},["Setting Sun"]={SkyboxBk="rbxassetid://626460377",SkyboxDn="rbxassetid://626460216",SkyboxFt="rbxassetid://626460513",SkyboxLf="rbxassetid://626473032",SkyboxRt="rbxassetid://626458639",SkyboxUp="rbxassetid://626460625"},Twighlight={SkyboxBk="rbxassetid://264908339",SkyboxDn="rbxassetid://264907909",SkyboxFt="rbxassetid://264909420",SkyboxLf="rbxassetid://264909758",SkyboxRt="rbxassetid://264908886",SkyboxUp="rbxassetid://264907379"},["Vivid Skies"]={SkyboxBk="rbxassetid://271042516",SkyboxDn="rbxassetid://271077243",SkyboxFt="rbxassetid://271042556",SkyboxLf="rbxassetid://271042310",SkyboxRt="rbxassetid://271042467",SkyboxUp="rbxassetid://271077958"},["Elisium Sky"]={SkyboxBk="rbxassetid://1898724755",SkyboxDn="rbxassetid://1898727189",SkyboxFt="rbxassetid://1898722814",SkyboxLf="rbxassetid://1898729298",SkyboxRt="rbxassetid://1898741025",SkyboxUp="rbxassetid://1898736761"}};
			local customSkyboxInstance = nil;
			local origSkyboxOrientation = nil;
			local rotatorTick = 0;
			Hub.UpdateSkybox = function()
				if (Toggles.skybox_master and Toggles.skybox_master.Value) then
					local sName = (Options.skybox_selection and Options.skybox_selection.Value) or "Default";
					local tex = openSourceSkyboxData[sName] or Skyboxes[sName] or openSourceSkyboxData['Default'] or Skyboxes['Default'];
					if (not customSkyboxInstance or not customSkyboxInstance.Parent) then
						customSkyboxInstance = Instance.new("Sky");
						customSkyboxInstance.Name = "M4rsCustomSkybox";
						customSkyboxInstance.Parent = Lighting;
					end
					if tex then
						customSkyboxInstance.SkyboxBk = tex.SkyboxBk or "";
						customSkyboxInstance.SkyboxDn = tex.SkyboxDn or "";
						customSkyboxInstance.SkyboxFt = tex.SkyboxFt or "";
						customSkyboxInstance.SkyboxLf = tex.SkyboxLf or "";
						customSkyboxInstance.SkyboxRt = tex.SkyboxRt or "";
						customSkyboxInstance.SkyboxUp = tex.SkyboxUp or "";
					end
					local dis = (Options.disable_elements and Options.disable_elements.Value) or {};
					local hasDis = function(el)
						if (type(dis) ~= "table") then
						else
							for _, v in pairs(dis) do
								if (v ~= el) then
								else
									return true;
								end
							end
						end
						return false;
					end;
					if hasDis("Sun") then
						customSkyboxInstance.SunTextureId = "";
						customSkyboxInstance.SunAngularSize = 0;
					end
					if hasDis("Moon") then
						customSkyboxInstance.MoonTextureId = "";
						customSkyboxInstance.MoonAngularSize = 0;
					end
					if hasDis("Stars") then
						customSkyboxInstance.StarCount = 0;
					end
				elseif customSkyboxInstance then
					customSkyboxInstance:Destroy();
					customSkyboxInstance = nil;
				end
			end;
			RunService.Heartbeat:Connect(function(dt)
				local sky = customSkyboxInstance or Lighting:FindFirstChildOfClass("Sky");
				if (Toggles.skybox_rotate and Toggles.skybox_rotate.Value and sky) then
					if not origSkyboxOrientation then
						pcall(function()
							origSkyboxOrientation = sky.SkyboxOrientation;
						end);
					end
					local speed = (Options.skybox_rotate_speed and Options.skybox_rotate_speed.Value) or 2;
					rotatorTick = rotatorTick + (dt * speed * 0.5);
					local method = (Options.skybox_rotate_method and Options.skybox_rotate_method.Value) or "Spin";
					local angle = 0;
					if (method == "Spin") then
						angle = (rotatorTick * 20) % 360;
					elseif (method == "Wave") then
						angle = math.sin(rotatorTick) * 180;
					elseif (method ~= "Alternate") then
					else
						angle = math.abs(((rotatorTick * 40) % 720) - 360) - 180;
					end
					local dir = (Options.skybox_rotate_direction and Options.skybox_rotate_direction.Value) or "Horizontal";
					local rotV3 = Vector3.zero;
					if (dir == "Horizontal") then
						rotV3 = Vector3.new(0, angle, 0);
					elseif (dir == "Vertical") then
						rotV3 = Vector3.new(angle, 0, 0);
					elseif (dir ~= "Diagonal") then
					else
						rotV3 = Vector3.new(angle, angle, angle);
					end
					local ok = pcall(function()
						sky.SkyboxOrientation = rotV3;
					end);
					if (not ok and (dir == "Horizontal")) then
						pcall(function()
							Lighting.GeographicLatitude = angle;
						end);
					end
				elseif (not (Toggles.skybox_rotate and Toggles.skybox_rotate.Value) and sky and origSkyboxOrientation) then
					pcall(function()
						sky.SkyboxOrientation = origSkyboxOrientation;
					end);
					origSkyboxOrientation = nil;
					rotatorTick = 0;
				end
			end);
		end
		Hub.UpdateAtmosphere = function()
			if (Toggles.atmosphere_master and Toggles.atmosphere_master.Value) then
				if (not customAtmosphereInstance or not customAtmosphereInstance.Parent) then
					customAtmosphereInstance = Instance.new("Atmosphere");
					customAtmosphereInstance.Name = "M4rsCustomAtmosphere";
					customAtmosphereInstance.Parent = Lighting;
				end
				customAtmosphereInstance.Color = (Options.atmosphere_color and Options.atmosphere_color.Value) or Color3.fromRGB(140, 160, 190);
				customAtmosphereInstance.Decay = (Options.atmosphere_decay and Options.atmosphere_decay.Value) or Color3.fromRGB(90, 110, 140);
				customAtmosphereInstance.Density = (Options.atmosphere_density and Options.atmosphere_density.Value) or 0.5;
				customAtmosphereInstance.Haze = (Options.atmosphere_haze and Options.atmosphere_haze.Value) or 1;
				customAtmosphereInstance.Glare = (Options.atmosphere_glare and Options.atmosphere_glare.Value) or 0.6;
				customAtmosphereInstance.Offset = (Options.atmosphere_offset and Options.atmosphere_offset.Value) or 0.25;
			elseif customAtmosphereInstance then
				customAtmosphereInstance:Destroy();
				customAtmosphereInstance = nil;
			end
			if (Toggles.atmosphere_sound_toggle and Toggles.atmosphere_sound_toggle.Value) then
				local soundName = (Options.atmosphere_ambient_sound and Options.atmosphere_ambient_sound.Value) or "None";
				local soundId = ambientSounds[soundName];
				if soundId then
					if (not currentAmbientSound or (currentAmbientSound.SoundId ~= ("rbxassetid://" .. tostring(soundId)))) then
						if currentAmbientSound then
							currentAmbientSound:Destroy();
						end
						currentAmbientSound = Instance.new("Sound");
						currentAmbientSound.Name = "M4rsAmbientSound";
						currentAmbientSound.SoundId = "rbxassetid://" .. tostring(soundId);
						currentAmbientSound.Looped = true;
						currentAmbientSound.Parent = SoundService;
						currentAmbientSound:Play();
					end
					local vol = (Options.atmosphere_sound_volume and Options.atmosphere_sound_volume.Value) or 0.6;
					currentAmbientSound.Volume = vol;
				elseif currentAmbientSound then
					currentAmbientSound:Destroy();
					currentAmbientSound = nil;
				end
			elseif currentAmbientSound then
				currentAmbientSound:Destroy();
				currentAmbientSound = nil;
			end
		end;
		Hub.UpdateWeather = function()
			if (Toggles.weather_master_enable and Toggles.weather_master_enable.Value) then
				local cam = workspace.CurrentCamera;
				if not cam then
					return;
				end
				if (not weatherPart or not weatherPart.Parent) then
					weatherPart = Instance.new("Part");
					weatherPart.Name = "M4rsWeatherContainer";
					weatherPart.Size = Vector3.new(60, 1, 60);
					weatherPart.CanCollide = false;
					weatherPart.Massless = true;
					weatherPart.CastShadow = false;
					weatherPart.Transparency = 1;
					weatherPart.Anchored = true;
					weatherPart.Parent = workspace;
					weatherEmitter = Instance.new("ParticleEmitter");
					weatherEmitter.Name = "WeatherFX";
					weatherEmitter.EmissionDirection = Enum.NormalId.Bottom;
					weatherEmitter.Orientation = Enum.ParticleOrientation.FacingCamera;
					weatherEmitter.Parent = weatherPart;
				end
				weatherPart.CFrame = CFrame.new(cam.CFrame.Position + Vector3.new(0, 22, 0));
				local col = (Options.weather_color and Options.weather_color.Value) or Color3.fromRGB(255, 255, 255);
				local rate = (Options.weather_rate and Options.weather_rate.Value) or 100;
				local spdMin = (Options.weather_speed_min and Options.weather_speed_min.Value) or 40;
				local spdMax = (Options.weather_speed_max and Options.weather_speed_max.Value) or 60;
				local szMin = (Options.weather_size_min and Options.weather_size_min.Value) or 0.33;
				local szMax = (Options.weather_size_max and Options.weather_size_max.Value) or 0.4;
				local opMin = ((Options.weather_opacity_min and Options.weather_opacity_min.Value) or 50) / 100;
				local opMax = ((Options.weather_opacity_max and Options.weather_opacity_max.Value) or 0) / 100;
				local spread = (Options.weather_spread and Options.weather_spread.Value) or 0;
				local bright = ((Options.weather_brightness and Options.weather_brightness.Value) or 100) / 100;
				local emission = ((Options.weather_emission and Options.weather_emission.Value) or 50) / 100;
				local szScale = (Options.weather_sizescale and Options.weather_sizescale.Value) or 1;
				weatherEmitter.Color = ColorSequence.new(col);
				weatherEmitter.Rate = rate * 8;
				weatherEmitter.Speed = NumberRange.new(spdMin, spdMax);
				weatherEmitter.Size = NumberSequence.new(szMin * szScale, szMax * szScale);
				weatherEmitter.Transparency = NumberSequence.new(opMax, opMin);
				weatherEmitter.SpreadAngle = Vector2.new(spread, spread);
				weatherEmitter.Brightness = bright;
				weatherEmitter.LightEmission = emission;
				weatherEmitter.Lifetime = NumberRange.new(2, 3);
			elseif weatherPart then
				weatherPart:Destroy();
				weatherPart = nil;
				weatherEmitter = nil;
			end
		end;
		local dofInstance = nil;
		local sunRaysInstance = nil;
		local bloomInstance = nil;
		local ccInstance = nil;
		Hub.UpdateShaders = function()
			if (Toggles.depth_of_field_enable and Toggles.depth_of_field_enable.Value) then
				if (not dofInstance or not dofInstance.Parent) then
					dofInstance = Instance.new("DepthOfFieldEffect");
					dofInstance.Name = "M4rsDOF";
					dofInstance.NearIntensity = 0.15;
					dofInstance.FarIntensity = 0.15;
					dofInstance.InFocusRadius = 10;
					dofInstance.Parent = Lighting;
				end
				dofInstance.FocusDistance = (Options.dof_focus_dist and Options.dof_focus_dist.Value) or 20;
			elseif dofInstance then
				dofInstance:Destroy();
				dofInstance = nil;
			end
			if (Toggles.sunrays_enable and Toggles.sunrays_enable.Value) then
				if (not sunRaysInstance or not sunRaysInstance.Parent) then
					sunRaysInstance = Instance.new("SunRaysEffect");
					sunRaysInstance.Name = "M4rsSunRays";
					sunRaysInstance.Spread = 1;
					sunRaysInstance.Parent = Lighting;
				end
				sunRaysInstance.Intensity = (Options.sunrays_intensity and Options.sunrays_intensity.Value) or 0.25;
			elseif sunRaysInstance then
				sunRaysInstance:Destroy();
				sunRaysInstance = nil;
			end
			if (Toggles.lighting_color_correction and Toggles.lighting_color_correction.Value) then
				if (not ccInstance or not ccInstance.Parent) then
					ccInstance = Instance.new("ColorCorrectionEffect");
					ccInstance.Name = "M4rsColorCorrection";
					ccInstance.Parent = Lighting;
				end
				ccInstance.Contrast = ((Options.lighting_cc_contrast and Options.lighting_cc_contrast.Value) or 0) / 10;
				ccInstance.Saturation = ((Options.lighting_cc_saturation and Options.lighting_cc_saturation.Value) or 0) / 10;
				ccInstance.Brightness = ((Options.lighting_cc_brightness and Options.lighting_cc_brightness.Value) or 0) / 10;
			elseif ccInstance then
				ccInstance:Destroy();
				ccInstance = nil;
			end
			if (Toggles.lighting_bloom_modifier and Toggles.lighting_bloom_modifier.Value) then
				if (not bloomInstance or not bloomInstance.Parent) then
					bloomInstance = Instance.new("BloomEffect");
					bloomInstance.Name = "M4rsBloom";
					bloomInstance.Parent = Lighting;
				end
				bloomInstance.Intensity = (Options.lighting_bloom_multiplier and Options.lighting_bloom_multiplier.Value) or 0.3;
				bloomInstance.Size = ((Options.lighting_bloom_size and Options.lighting_bloom_size.Value) or 4) * 4;
				bloomInstance.Threshold = (Options.lighting_bloom_threshold and Options.lighting_bloom_threshold.Value) or 0.7;
			elseif bloomInstance then
				bloomInstance:Destroy();
				bloomInstance = nil;
			end
		end;
		local motionBlurEffect = Instance.new("BlurEffect");
		motionBlurEffect.Name = "M4rsMotionBlur";
		motionBlurEffect.Size = 0;
		motionBlurEffect.Parent = workspace.CurrentCamera;
		local lastCamLook = (workspace.CurrentCamera and workspace.CurrentCamera.CFrame.LookVector) or Vector3.zero;
		Hub.UpdateMotionBlur = function(dt)
			local cam = workspace.CurrentCamera;
			if not cam then
				return;
			end
			motionBlurEffect.Parent = cam;
			if (Toggles.motion_blur_enable and Toggles.motion_blur_enable.Value) then
				local intensity = (Options.motion_blur_intensity and Options.motion_blur_intensity.Value) or 3;
				local delta = (cam.CFrame.LookVector - lastCamLook).Magnitude;
				motionBlurEffect.Size = math.clamp(delta * intensity * 5, 0, 32);
			else
				motionBlurEffect.Size = 0;
			end
			lastCamLook = cam.CFrame.LookVector;
		end;
		Hub.DestroyWorldVisualEffects = function()
			pcall(function()
				if customSkyboxInstance then
					customSkyboxInstance:Destroy();
					customSkyboxInstance = nil;
				end
				if customAtmosphereInstance then
					customAtmosphereInstance:Destroy();
					customAtmosphereInstance = nil;
				end
				if currentAmbientSound then
					currentAmbientSound:Destroy();
					currentAmbientSound = nil;
				end
				if weatherPart then
					weatherPart:Destroy();
					weatherPart = nil;
					weatherEmitter = nil;
				end
				if dofInstance then
					dofInstance:Destroy();
					dofInstance = nil;
				end
				if sunRaysInstance then
					sunRaysInstance:Destroy();
					sunRaysInstance = nil;
				end
				if bloomInstance then
					bloomInstance:Destroy();
					bloomInstance = nil;
				end
				if ccInstance then
					ccInstance:Destroy();
					ccInstance = nil;
				end
				if motionBlurEffect then
					motionBlurEffect:Destroy();
				end
			end);
		end;
		Hub.UpdateAspectRatio = function()
			if (Toggles.aspect_ratio_master and Toggles.aspect_ratio_master.Value) then
				local cam = workspace.CurrentCamera;
				if not cam then
					return;
				end
				local rx = (Options.aspect_ratio_x and Options.aspect_ratio_x.Value) or 13;
				local ry = (Options.aspect_ratio_y and Options.aspect_ratio_y.Value) or 10;
				local ratio = rx / ry;
				local cf = cam.CFrame;
				cam.CFrame = CFrame.fromMatrix(cf.Position, cf.RightVector, cf.UpVector * ratio, -cf.LookVector);
			end
		end;
		local lightingOriginal = {};
		local lightingRules = {
			{key="Ambient", tog="lighting_ambient", get=function() return Options.lighting_ambient_color and Options.lighting_ambient_color.Value end},
			{key="OutdoorAmbient", tog="lighting_outdoorambient", get=function() return Options.lighting_outdoorambient_color and Options.lighting_outdoorambient_color.Value end},
			{key="ColorShift_Top", tog="lighting_colorshifttop", get=function() return Options.lighting_colorshifttop_color and Options.lighting_colorshifttop_color.Value end},
			{key="ColorShift_Bottom", tog="lighting_colorshiftbottom", get=function() return Options.lighting_colorshiftbottom_color and Options.lighting_colorshiftbottom_color.Value end},
			{key="ClockTime", tog="lighting_clocktime", get=function() return Options.lighting_clocktime_value and Options.lighting_clocktime_value.Value end},
			{key="GeographicLatitude", tog="lighting_latitude", get=function() return Options.lighting_latitude_value and Options.lighting_latitude_value.Value end},
			{key="ShadowSoftness", tog="lighting_shadowsoftness", get=function() return Options.lighting_shadowsoftness_value and Options.lighting_shadowsoftness_value.Value end},
			{key="EnvironmentDiffuseScale", tog="lighting_diffuse", get=function() return Options.lighting_diffuse_value and Options.lighting_diffuse_value.Value end},
			{key="EnvironmentSpecularScale", tog="lighting_specular", get=function() return Options.lighting_specular_value and Options.lighting_specular_value.Value end},
			{key="FogColor", tog="lighting_fog", get=function() return Options.lighting_fog_color and Options.lighting_fog_color.Value end},
			{key="FogStart", tog="lighting_fog", get=function() return Options.lighting_fogstart and Options.lighting_fogstart.Value end},
			{key="FogEnd", tog="lighting_fog", get=function() return Options.lighting_fogend and Options.lighting_fogend.Value end},
		};
		Hub.UpdateCustomLighting = function()
			local master = Toggles.lighting_master and Toggles.lighting_master.Value;
			for _, rule in ipairs(lightingRules) do
				pcall(function()
					local t = Toggles[rule.tog];
					local active = master and t and t.Value;
					if active then
						local v = rule.get();
						if v == nil then return end
						if lightingOriginal[rule.key] == nil then
							lightingOriginal[rule.key] = Lighting[rule.key];
						end
						Lighting[rule.key] = v;
					elseif lightingOriginal[rule.key] ~= nil then
						Lighting[rule.key] = lightingOriginal[rule.key];
						lightingOriginal[rule.key] = nil;
					end
				end);
			end
			-- sun color is not a Lighting property in all games: tint via ColorCorrection-free fallback
			pcall(function()
				local active = master and Toggles.lighting_suncolor and Toggles.lighting_suncolor.Value;
				local sky = Lighting:FindFirstChildOfClass("Atmosphere");
				if (active and sky and Options.lighting_suncolor_color) then
					if lightingOriginal.__AtmoColor == nil then lightingOriginal.__AtmoColor = sky.Color end
					sky.Color = Options.lighting_suncolor_color.Value;
				elseif (sky and lightingOriginal.__AtmoColor ~= nil) then
					sky.Color = lightingOriginal.__AtmoColor;
					lightingOriginal.__AtmoColor = nil;
				end
			end);
			pcall(function()
				local gs = Toggles.lighting_globalshadows;
				if (master and gs) then
					if lightingOriginal.__GS == nil then lightingOriginal.__GS = Lighting.GlobalShadows end
					Lighting.GlobalShadows = gs.Value;
				elseif lightingOriginal.__GS ~= nil then
					Lighting.GlobalShadows = lightingOriginal.__GS;
					lightingOriginal.__GS = nil;
				end
			end);
		end;
	end
	do
		local ch_lines = {};
		local ch_outlines = {};
		for i = 1, 4 do
			local outl = Drawing.new("Line");
			outl.Visible = false;
			outl.Color = Color3.fromRGB(0, 0, 0);
			outl.Thickness = 3;
			table.insert(ch_outlines, outl);
			local inl = Drawing.new("Line");
			inl.Visible = false;
			inl.Thickness = 1.5;
			table.insert(ch_lines, inl);
		end
		local ch_ring_outline = Drawing.new("Circle");
		ch_ring_outline.Filled = false;
		ch_ring_outline.NumSides = 48;
		ch_ring_outline.Thickness = 3;
		ch_ring_outline.Color = Color3.fromRGB(0, 0, 0);
		ch_ring_outline.Visible = false;
		local ch_ring = Drawing.new("Circle");
		ch_ring.Filled = false;
		ch_ring.NumSides = 48;
		ch_ring.Thickness = 1.5;
		ch_ring.Visible = false;
		local ch_dot_outline = Drawing.new("Circle");
		ch_dot_outline.Filled = true;
		ch_dot_outline.NumSides = 24;
		ch_dot_outline.Radius = 3;
		ch_dot_outline.Color = Color3.fromRGB(0, 0, 0);
		ch_dot_outline.Visible = false;
		local ch_dot = Drawing.new("Circle");
		ch_dot.Filled = true;
		ch_dot.NumSides = 24;
		ch_dot.Radius = 2;
		ch_dot.Visible = false;
		local ch_text = Drawing.new("Text");
		ch_text.Visible = false;
		ch_text.Size = 13;
		ch_text.Center = true;
		ch_text.Outline = true;
		ch_text.Color = Color3.fromRGB(240, 240, 245);
		local ch_clock = 0;
		local ch_spin = 0;
		local function hide_crosshair()
			for i = 1, 4 do
				ch_lines[i].Visible = false;
				ch_outlines[i].Visible = false;
			end
			ch_ring.Visible = false;
			ch_ring_outline.Visible = false;
			ch_dot.Visible = false;
			ch_dot_outline.Visible = false;
			ch_text.Visible = false;
		end
		local function get_local_speed()
			local char = LocalPlayer.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");
			if not root then
				return 0;
			end
			local vel = root.AssemblyLinearVelocity or root.Velocity;
			return Vector2.new(vel.X, vel.Z).Magnitude;
		end
		Hub.UpdateCrosshair = function(dt)
			if not (Toggles.crosshaireeee and Toggles.crosshaireeee.Value) then
				hide_crosshair();
				return;
			end
			local cam = workspace.CurrentCamera;
			if not cam then
				return;
			end
			ch_clock = ch_clock + (dt or 0.016);
			local style = (Options.CrosshairStyle and Options.CrosshairStyle.Value) or "cross";
			local length = (Options.CrosshairLength and Options.CrosshairLength.Value) or 12;
			local gap = (Options.CrosshairGap and Options.CrosshairGap.Value) or 5;
			local thick = (Options.CrosshairThickness and Options.CrosshairThickness.Value) or 1.5;
			local col = (Options.CrosshairColor and Options.CrosshairColor.Value) or Color3.fromRGB(0, 200, 255);
			if (Toggles.CrosshairRotating and Toggles.CrosshairRotating.Value) then
				local spd = (Options.CrosshairRotateSpeed and Options.CrosshairRotateSpeed.Value) or 60;
				ch_spin = (ch_spin + (spd * (dt or 0.016))) % 360;
			else
				ch_spin = 0;
			end
			if (Toggles.CrosshairSpread and Toggles.CrosshairSpread.Value) then
				local spd = get_local_speed();
				gap = gap + math.clamp(spd * 0.25, 0, 45);
			end
			local animMode = (Options.CrosshairAnimMode and Options.CrosshairAnimMode.Value) or "none";
			if (animMode == "breathe") then
				local wave = (math.sin(ch_clock * 3) + 1) * 0.5;
				gap = gap + (wave * length * 0.5);
			elseif (animMode ~= "pulse") then
			else
				local wave = (math.sin(ch_clock * 5) + 1) * 0.5;
				length = length * (0.6 + (wave * 0.5));
			end
			local anchor = cam.ViewportSize / 2;
			local followMode = (Options.crosshairmode and Options.crosshairmode.Value) or "static";
			if (followMode == "follow muzzle") then
				local muz = GetMuzzlePosition and GetMuzzlePosition();
				if muz then
					local sPos, onScreen = cam:WorldToViewportPoint(muz);
					if onScreen then
						anchor = Vector2.new(sPos.X, sPos.Y);
					end
				end
			elseif ((followMode == "follow target") or (Toggles.CrosshairFollowTarget and Toggles.CrosshairFollowTarget.Value)) then
				local targetPlr, _ = GetClosestTarget and GetClosestTarget(300, "Head", false, false);
				if (targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("Head")) then
					local sPos, onScreen = cam:WorldToViewportPoint(targetPlr.Character.Head.Position);
					if onScreen then
						anchor = Vector2.new(sPos.X, sPos.Y);
					end
				end
			end
			local totalRad = math.rad(((Options.GradientRotation and Options.GradientRotation.Value) or 0) + ch_spin);
			local cosv, sinv = math.cos(totalRad), math.sin(totalRad);
			if (style == "circle") then
				for i = 1, 4 do
					ch_lines[i].Visible = false;
					ch_outlines[i].Visible = false;
				end
				ch_dot.Visible = false;
				ch_dot_outline.Visible = false;
				ch_ring_outline.Position = anchor;
				ch_ring_outline.Radius = length;
				ch_ring_outline.Thickness = thick + 2;
				ch_ring_outline.Visible = true;
				ch_ring.Position = anchor;
				ch_ring.Radius = length;
				ch_ring.Thickness = thick;
				ch_ring.Color = col;
				ch_ring.Visible = true;
			elseif (style == "dot") then
				for i = 1, 4 do
					ch_lines[i].Visible = false;
					ch_outlines[i].Visible = false;
				end
				ch_ring.Visible = false;
				ch_ring_outline.Visible = false;
				ch_dot_outline.Position = anchor;
				ch_dot_outline.Radius = thick + 2;
				ch_dot_outline.Visible = true;
				ch_dot.Position = anchor;
				ch_dot.Radius = thick;
				ch_dot.Color = col;
				ch_dot.Visible = true;
			else
				ch_ring.Visible = false;
				ch_ring_outline.Visible = false;
				ch_dot.Visible = false;
				ch_dot_outline.Visible = false;
				local arms = {{Vector2.new(0, -gap),Vector2.new(0, -gap - length)},{Vector2.new(0, gap),Vector2.new(0, gap + length)},{Vector2.new(-gap, 0),Vector2.new(-gap - length, 0)},{Vector2.new(gap, 0),Vector2.new(gap + length, 0)}};
				if (style == "t") then
					arms[1] = nil;
				elseif (style ~= "x") then
				else
					local d = 0.7071;
					arms = {{(Vector2.new(-d, -d) * gap),(Vector2.new(-d, -d) * (gap + length))},{(Vector2.new(d, d) * gap),(Vector2.new(d, d) * (gap + length))},{(Vector2.new(-d, d) * gap),(Vector2.new(-d, d) * (gap + length))},{(Vector2.new(d, -d) * gap),(Vector2.new(d, -d) * (gap + length))}};
				end
				local showLines = not (Toggles.showlines and not Toggles.showlines.Value);
				for i = 1, 4 do
					local arm = arms[i];
					local l = ch_lines[i];
					local o = ch_outlines[i];
					if (arm and showLines) then
						local f, t = arm[1], arm[2];
						local fr = Vector2.new((f.X * cosv) - (f.Y * sinv), (f.X * sinv) + (f.Y * cosv));
						local tr = Vector2.new((t.X * cosv) - (t.Y * sinv), (t.X * sinv) + (t.Y * cosv));
						local from = anchor + fr;
						local to = anchor + tr;
						o.Thickness = thick + 2;
						o.From = from;
						o.To = to;
						o.Visible = true;
						l.Thickness = thick;
						l.Color = col;
						l.From = from;
						l.To = to;
						l.Visible = true;
					else
						l.Visible = false;
						o.Visible = false;
					end
				end
			end
			local showAmmo = Toggles.showammo and Toggles.showammo.Value;
			local showText = Toggles.CrosshairTargetText and Toggles.CrosshairTargetText.Value;
			if ((showAmmo or showText) and localFighter and localFighter.EquippedItem) then
				local item = localFighter.EquippedItem;
				local cur = item:Get("CurrentAmmo") or item:Get("Ammo") or 0;
				local maxA = item:Get("MaxAmmo") or item:Get("MaxBullets") or 0;
				ch_text.Visible = true;
				ch_text.Position = Vector2.new(anchor.X, anchor.Y + gap + length + 8);
				ch_text.Text = string.format("%d / %d", cur, maxA);
			else
				ch_text.Visible = false;
			end
		end;
		Hub.DestroyCrosshair = function()
			pcall(function()
				for i = 1, 4 do
					ch_lines[i]:Remove();
					ch_outlines[i]:Remove();
				end
				ch_ring:Remove();
				ch_ring_outline:Remove();
				ch_dot:Remove();
				ch_dot_outline:Remove();
				ch_text:Remove();
			end);
		end;
	end
	local lastSilentFire = 0;
	local lastTriggerTick = 0;
	local FrameTimer = tick();
	local FrameCounter = 0;
	local FPS = 60;
	local RenderConnection = RunService.RenderStepped:Connect(function(dt)
		FrameCounter = FrameCounter + 1;
		if ((tick() - FrameTimer) < 1) then
		else
			FPS = FrameCounter;
			FrameTimer = tick();
			FrameCounter = 0;
		end
		if (Toggles.cframefly_enabled and Toggles.cframefly_enabled.Value) then
			local char = LocalPlayer.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");
			if root then
				local speed = (Options.cframefly_speed and Options.cframefly_speed.Value) or 50;
				local cam = workspace.CurrentCamera;
				local moveDir = Vector3.zero;
				if UserInputService:IsKeyDown(Enum.KeyCode.W) then
					moveDir = moveDir + cam.CFrame.LookVector;
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.S) then
					moveDir = moveDir - cam.CFrame.LookVector;
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.A) then
					moveDir = moveDir - cam.CFrame.RightVector;
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.D) then
					moveDir = moveDir + cam.CFrame.RightVector;
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
					moveDir = moveDir + Vector3.new(0, 1, 0);
				end
				if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
					moveDir = moveDir - Vector3.new(0, 1, 0);
				end
				if (moveDir.Magnitude > 0) then
					root.Velocity = Vector3.zero;
					root.CFrame = root.CFrame + (moveDir.Unit * speed * 0.016);
				else
					root.Velocity = Vector3.zero;
				end
			end
		end
		if (Toggles.CustomFOV and Toggles.CustomFOV.Value) then
			workspace.CurrentCamera.FieldOfView = (Options.CustomFOVValue and Options.CustomFOVValue.Value) or 90;
		end
		if (Toggles.ThirdPerson and Toggles.ThirdPerson.Value) then
			local dist = (Options.ThirdPersonDist and Options.ThirdPersonDist.Value) or 12;
			LocalPlayer.CameraMaxZoomDistance = dist;
			LocalPlayer.CameraMinZoomDistance = dist;
		else
			LocalPlayer.CameraMinZoomDistance = 0.5;
			LocalPlayer.CameraMaxZoomDistance = 128;
		end
		if (Toggles.RainbowCrosshair and Toggles.RainbowCrosshair.Value and Options.CrosshairColor) then
			local hue = (tick() * 0.25) % 1;
			Options.CrosshairColor:SetValueRGB(Color3.fromHSV(hue, 0.9, 1));
		end
		UpdateFOVVisuals(dt);
		if (Toggles.AimbotToggle and Toggles.AimbotToggle.Value) then
			local aimbotKeyActive = true;
			if (Options.AimbotKey and Options.AimbotKey.Value and (Options.AimbotKey.Value ~= "None")) then
				aimbotKeyActive = Options.AimbotKey:GetState();
			end
			if aimbotKeyActive then
				local fov = (Options.AimbotFOV and Options.AimbotFOV.Value) or 500;
				local hitPart = (Options.AimbotHitPart and Options.AimbotHitPart.Value) or "Head";
				local smoothness = (Options.AimbotSmoothness and Options.AimbotSmoothness.Value) or 100;
				local checkWall = Toggles.AimbotWallCheck and Toggles.AimbotWallCheck.Value;
				local targetPlr, targetPart = GetClosestTarget(fov, hitPart, checkWall, true);
				if (targetPlr and targetPart) then
					local cam = workspace.CurrentCamera;
					if cam then
						local targetPos = targetPart.Position;
						local screenPos, onScreen = cam:WorldToViewportPoint(targetPos);
						if (onScreen and (screenPos.Z > 0)) then
							local mousePos = UserInputService:GetMouseLocation();
							local deltaX = screenPos.X - mousePos.X;
							local deltaY = screenPos.Y - mousePos.Y;
							local moveMouse = mousemoverel or (Input and Input.MouseMoveRel) or mouse_moverel;
							if moveMouse then
								if (smoothness >= 100) then
									moveMouse(deltaX, deltaY);
								else
									local factor = math.clamp(smoothness / 100, 0.01, 1);
									moveMouse(deltaX * factor, deltaY * factor);
								end
							else
								local curCF = cam.CFrame;
								local targetCF = CFrame.new(curCF.Position, targetPos);
								if (smoothness >= 100) then
									cam.CFrame = targetCF;
								else
									local alpha = math.clamp(smoothness / 100, 0.05, 1);
									cam.CFrame = curCF:Lerp(targetCF, alpha);
								end
							end
						end
					end
				end
			end
		end
		if (Toggles.TriggerbotEnabled and Toggles.TriggerbotEnabled.Value and IsInMatch()) then
			local canFire = true;
			if (Options.TriggerbotKey and Options.TriggerbotKey.Value and (Options.TriggerbotKey.Value ~= "None")) then
				canFire = Options.TriggerbotKey:GetState();
			end
			if (canFire and ((tick() - lastTriggerTick) >= 0.12)) then
				local mouse = LocalPlayer:GetMouse();
				local targetPart = mouse.Target;
				if (targetPart and targetPart.Parent) then
					local model = targetPart.Parent;
					if (not model:FindFirstChildOfClass("Humanoid") and model.Parent) then
						model = model.Parent;
					end
					local hum = model:FindFirstChildOfClass("Humanoid");
					local targetPlr = Players:GetPlayerFromCharacter(model);
					if (hum and (hum.Health > 0) and targetPlr and (targetPlr ~= LocalPlayer) and not IsTeammate(targetPlr)) then
						local isHead = not (Toggles.TriggerHeadOnly and Toggles.TriggerHeadOnly.Value) or (targetPart.Name == "Head");
						if isHead then
							lastTriggerTick = tick();
							local delayMs = (Options.TriggerDelay and Options.TriggerDelay.Value) or 0;
							task.spawn(function()
								if (delayMs <= 0) then
								else
									task.wait(delayMs / 1000);
								end
								if mouse1click then
									mouse1click();
								elseif (mouse1press and mouse1release) then
									mouse1press();
									task.wait(0.02);
									mouse1release();
								end
							end);
						end
					end
				end
			end
		end
		if Hub.UpdateRagebot then
			Hub.UpdateRagebot(dt);
		end
		if Hub.UpdateAntiAim then
			Hub.UpdateAntiAim(dt);
		end
		if Hub.UpdateFakeStatsLoop then
			Hub.UpdateFakeStatsLoop();
		end
		if Hub.UpdateSlfMtrl then
			Hub.UpdateSlfMtrl(dt);
		end
		if Hub.UpdateAnimLoop then
			Hub.UpdateAnimLoop();
		end
		if Hub.UpdateSkybox then
			Hub.UpdateSkybox();
		end
		if Hub.UpdateAtmosphere then
			Hub.UpdateAtmosphere();
		end
		if Hub.UpdateWeather then
			Hub.UpdateWeather();
		end
		if Hub.UpdateShaders then
			Hub.UpdateShaders();
		end
		if Hub.UpdateMotionBlur then
			Hub.UpdateMotionBlur(dt);
		end
		if Hub.UpdateAspectRatio then
			Hub.UpdateAspectRatio();
		end
		if Hub.UpdateCustomLighting then
			Hub.UpdateCustomLighting();
		end
		if Hub.UpdateCrosshair then
			Hub.UpdateCrosshair(dt);
		end
		UpdateAllEsp();
		if Hub.UpdateUtilityEsp then
			Hub.UpdateUtilityEsp();
		end
		if Hub.UpdateViewmodelMods then
			Hub.UpdateViewmodelMods();
		end
		if Hub.CleanMuzzleFlash then
			Hub.CleanMuzzleFlash();
		end
		UpdateTextures();
		if Hub.UpdateTextures then
			Hub.UpdateTextures();
		end
		if (Toggles.AntiFlashbang and Toggles.AntiFlashbang.Value) then
			PatchFlashbang();
		end
		local ping = 0;
		pcall(function()
			ping = math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue());
		end);
		local curTime = os.date("%H:%M:%S");
		local username = LocalPlayer.DisplayName or LocalPlayer.Name or "User";
		Library:SetWatermark(("M4rs.win | Rivals | %s | %s fps | %s ms | %s"):format(username, math.floor(FPS), ping, curTime));
		if (Toggles.TargetHUDToggle and Toggles.TargetHUDToggle.Value and IsInMatch()) then
			TargetHUD.Stroke.Color = Library.AccentColor;
			local mouse = LocalPlayer:GetMouse();
			local hover = mouse.Target;
			local targetPlr = nil;
			local targetHum = nil;
			if (hover and hover.Parent) then
				local model = hover.Parent;
				if (not model:FindFirstChildOfClass("Humanoid") and model.Parent) then
					model = model.Parent;
				end
				targetHum = model:FindFirstChildOfClass("Humanoid");
				targetPlr = Players:GetPlayerFromCharacter(model);
			end
			if not targetPlr then
				targetPlr, _ = GetClosestTarget(250, "Head", false, false);
				if (targetPlr and targetPlr.Character) then
					targetHum = targetPlr.Character:FindFirstChildOfClass("Humanoid");
				end
			end
			if (targetPlr and targetHum and (targetHum.Health > 0) and (targetPlr ~= LocalPlayer)) then
				TargetHUD.Frame.Visible = true;
				TargetHUD.Name.Text = "Target: " .. (targetPlr.DisplayName or targetPlr.Name);
				local dist = 0;
				pcall(function()
					dist = math.floor((workspace.CurrentCamera.CFrame.Position - targetPlr.Character.HumanoidRootPart.Position).Magnitude * 0.28);
				end);
				TargetHUD.Dist.Text = tostring(dist) .. "m";
				local maxHp = ((targetHum.MaxHealth > 0) and targetHum.MaxHealth) or 100;
				local curHp = math.clamp(targetHum.Health, 0, maxHp);
				local pct = curHp / maxHp;
				TargetHUD.HealthBarFill.Size = UDim2.new(pct, 0, 1, 0);
				if (pct > 0.5) then
					TargetHUD.HealthBarFill.BackgroundColor3 = Color3.fromRGB(45, 255, 120);
				elseif (pct > 0.25) then
					TargetHUD.HealthBarFill.BackgroundColor3 = Color3.fromRGB(255, 200, 50);
				else
					TargetHUD.HealthBarFill.BackgroundColor3 = Color3.fromRGB(255, 50, 70);
				end
				TargetHUD.HealthText.Text = string.format("%d / %d HP (%d%%)", math.floor(curHp), math.floor(maxHp), math.floor(pct * 100));
			else
				TargetHUD.Frame.Visible = false;
			end
		else
			TargetHUD.Frame.Visible = false;
		end
	end);
	Library:OnUnload(function()
		if RenderConnection then
			RenderConnection:Disconnect();
		end
		if HeartbeatConnection then
			HeartbeatConnection:Disconnect();
		end
		if NoclipConnection then
			NoclipConnection:Disconnect();
		end
		if Hub.DamageBillboardConnection then
			Hub.DamageBillboardConnection:Disconnect();
		end
		if SlingshotConnection then
			SlingshotConnection:Disconnect();
		end
		if Misc.autoBanTask then
			task.cancel(Misc.autoBanTask);
		end
		if Misc.autoQueueTask then
			task.cancel(Misc.autoQueueTask);
		end
		if Misc.antiFlashConn1 then
			Misc.antiFlashConn1:Disconnect();
		end
		if Misc.antiFlashConn2 then
			Misc.antiFlashConn2:Disconnect();
		end
		if (Misc.inReloadVoid and Misc.savedReloadCF) then
			pcall(function()
				LocalPlayer.Character.HumanoidRootPart.CFrame = Misc.savedReloadCF;
			end);
		end
		if Misc.RestoreOriginalProfile then
			pcall(Misc.RestoreOriginalProfile);
		end
		pcall(function()
			DestroyFOVVisuals();
			if Hub.DestroyRagebot then
				Hub.DestroyRagebot();
			end
			if Hub.DestroyCrosshair then
				Hub.DestroyCrosshair();
			end
			for p, _ in pairs(ESP_Holders) do
				RemoveEspHolder(p);
			end
			if Hub.DestroyUtilityEsp then
				Hub.DestroyUtilityEsp();
			end
			if Hub.DestroyDamageNumbers then
				Hub.DestroyDamageNumbers();
			end
			if Hub.DestroyDeathEffects then
				Hub.DestroyDeathEffects();
			end
			if Hub.DestroyTextures then
				Hub.DestroyTextures();
			end
			for _, t in ipairs(activeBulletTracers) do
				if t.beam then
					t.beam:Destroy();
				end
				if t.a0 then
					t.a0:Destroy();
				end
				if t.a1 then
					t.a1:Destroy();
				end
			end
		end);
		pcall(function()
			if Hub.DestroyWorldVisualEffects then
				Hub.DestroyWorldVisualEffects();
			end
			if Hub.DestroyHitNotification then
				Hub.DestroyHitNotification();
			end
			if Hub.StopAllAnimations then
				Hub.StopAllAnimations();
			end
			if _G.StopBackshoot then
				_G.StopBackshoot();
			end
			if _G.StopNoAnim then
				_G.StopNoAnim();
			end
			local vm = workspace:FindFirstChild("ViewModels");
			local fp = vm and vm:FindFirstChild("FirstPerson");
			if fp then
				for _, m in ipairs(fp:GetChildren()) do
					if m:IsA("Model") then
						for _, h in ipairs(m:GetChildren()) do
							if h.Name:find("_M4rs") then
								h:Destroy();
							end
						end
					end
				end
			end
		end);
		if TargetHUD.Gui then
			TargetHUD.Gui:Destroy();
		end
		Library.Unloaded = true;
	end);
	Toggles.AutoBanQueueEnable:OnChanged(function()
		if Misc.UpdateAutoBan then
			Misc.UpdateAutoBan();
		end
	end);
	Toggles.queueenabled:OnChanged(function()
		if Misc.UpdateAutoQueue then
			Misc.UpdateAutoQueue();
		end
	end);
	Toggles.device_spoof:OnChanged(function()
		if Misc.ApplyDeviceSpoof then
			Misc.ApplyDeviceSpoof();
		end
	end);
	Options.device_type:OnChanged(function()
		if Misc.ApplyDeviceSpoof then
			Misc.ApplyDeviceSpoof();
		end
	end);
	Toggles.AntiFlashbang:OnChanged(function()
		if Misc.PatchFlashbang then
			Misc.PatchFlashbang();
		end
	end);
	Toggles.moddetector:OnChanged(function()
		if (Toggles.moddetector.Value and Misc.ScanExistingStaff) then
			Misc.ScanExistingStaff();
		end
	end);
	Toggles.StreakSpoof:OnChanged(function()
		if (not Toggles.StreakSpoof.Value and Misc.origAttributes and Misc.origAttributes.streak) then
			pcall(function()
				LocalPlayer:SetAttribute("StatisticDuelsWinStreak", Misc.origAttributes.streak);
			end);
		end
	end);
	Toggles.LevelSpoof:OnChanged(function()
		if (not Toggles.LevelSpoof.Value and Misc.origAttributes and Misc.origAttributes.level) then
			pcall(function()
				LocalPlayer:SetAttribute("Level", Misc.origAttributes.level);
			end);
		end
	end);
	Toggles.ELOSpoof:OnChanged(function()
		if (not Toggles.ELOSpoof.Value and Misc.origAttributes and Misc.origAttributes.elo) then
			pcall(function()
				LocalPlayer:SetAttribute("DisplayELO", Misc.origAttributes.elo);
			end);
		end
	end);
	Toggles.StatusSpoof:OnChanged(function()
		if (not Toggles.StatusSpoof.Value and Misc.origAttributes and Misc.origAttributes.playerstatus) then
			pcall(function()
				LocalPlayer:SetAttribute("PlayerStatus", Misc.origAttributes.playerstatus);
			end);
		end
	end);
	if Options.search1 then
		Options.search1:OnChanged(function(query)
			local filtered = {};
			local q = (query or ""):lower();
			for _, w in ipairs(weaponList) do
				if ((q == "") or w:lower():find(q, 1, true)) then
					table.insert(filtered, w);
				end
			end
			Options.first:SetValues(((#filtered > 0) and filtered) or weaponList);
		end);
	end
	if Options.search2 then
		Options.search2:OnChanged(function(query)
			local filtered = {};
			local q = (query or ""):lower();
			for _, w in ipairs(weaponList) do
				if ((q == "") or w:lower():find(q, 1, true)) then
					table.insert(filtered, w);
				end
			end
			Options.second:SetValues(((#filtered > 0) and filtered) or weaponList);
		end);
	end
	Toggles.handcaps:OnChanged(function()
		pcall(function()
			local ps = LocalPlayer:FindFirstChild("PlayerScripts");
			local ctrl = ps and ps:FindFirstChild("Controllers");
			local debugMod = ctrl and ctrl:FindFirstChild("DebugController");
			if debugMod then
				local DebugController = SafeRequire(debugMod);
				if (DebugController and DebugController.SetHandicapsEnabled) then
					DebugController:SetHandicapsEnabled(Toggles.handcaps.Value);
				end
			end
		end);
	end);
	Toggles.SkinChangerEnabled:OnChanged(function()
		if Hub.ApplySkinChanger then
			Hub.ApplySkinChanger();
		end
	end);
	Options.SkinChangerValue:OnChanged(function()
		if Hub.ApplySkinChanger then
			Hub.ApplySkinChanger();
		end
	end);
	Options.AnimPresetSelector:OnChanged(function(val)
		local id = animPresets[val];
		if (id and Options.AnimForceID) then
			Options.AnimForceID:SetValue(id);
		end
	end);
	Options.AnimJitterSelector:OnChanged(function(val)
		local id = animPresets[val];
		if (id and Options.AnimJitterID) then
			Options.AnimJitterID:SetValue(id);
		end
	end);
	if DismissLoader then
		DismissLoader();
	end
	task.wait(0.1);
	if not Library.MenuOpen then
		pcall(function()
			Library:Toggle();
		end);
	end
	Library:Notify("m4rs | Rivals Loaded Successfully!", 5);
	PlayUiSound(6895079853);
end
