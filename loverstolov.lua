script_name('Jimmy Cabrera script')
script_author('From Jimmy Cabrera')
script_description('This is my table for Arthur')

require "lib.moonloader"
local sampev = require "lib.samp.events"
local imgui_lib = require 'imgui'
local imgui = require('imgui')
local game_keys = require 'lib.game.keys'
local ffi = require("ffi")
local encoding = require('encoding')
local key = require 'vkeys'
local dlstatus = require('moonloader').download_status

ffi.cdef[[
bool SetCursorPos(int X, int Y);
]]

local activVoice = 0
local AnswerReport = 0
local AnswerTextInReport = 0
local ActivTimerAnswer = 0
local OpenReport = 0
local font_flag = require('moonloader').font_flag
local my_font = renderCreateFont('Verdana', 14, font_flag.BOLD + font_flag.SHADOW)
local my_font1 = renderCreateFont('Verdana', 20, font_flag.BOLD + font_flag.SHADOW)
local clik = false
local poluchknopka1 = false
local poluchknopka2 = false
local OldAnswer = 0
local pricemetr = imgui.ImBuffer(256)
local pricemetr1 = imgui.ImBuffer(256)
local activAnswer = 1
local OldAnswerKol = 0
local schetchik = 0
local money = 0
local TextScript = 0
local maincoord = 0
local menuActive = imgui.ImBool(false)
local activTimerS = 0
local activateHP = 0
local min_money_kick = 100000000
local activGame = 0
local exit_game = 0
local u8 = encoding.UTF8
encoding.default = 'CP1251'
local activTable = 0
local inicfg = require("inicfg")
local lob = imgui.ImBool(false)
local activClicker = false
local status = 0
local zaderzhkachecka = imgui.ImBuffer(256)
local krichalka = imgui.ImBuffer(256)
local mon = 0
local tretokno = imgui.ImBool()
local info_skript = imgui.ImBool(true)
local info_klac = imgui.ImBool(false)
local activVoice = false
local info_cursor = imgui.ImBool(false)
local anti_flud = imgui.ImBool(true)
local activTimerS = 0
local update_state = false
local info_screen = imgui.ImBool(true)
local status_krichalka = imgui.ImBool(false)
local info_script = '{7FFF00}�������'
local info_clicker = '{FF0000}��������'
local ActivateScript = 0
local stol = false
local knopka1 = ''
local knopka2 = ''
local emulate_F5 = false

local script_vers = 1.16
local script_vers_text = "1.16"
local update_url = "https://raw.githubusercontent.com/DedisonVan/ParsingPython/main/update.ini" -- ��� ���� ���� ������
local update_path = getWorkingDirectory() .. "/update.ini" -- � ��� ���� ������

local script_url = "https://raw.githubusercontent.com/DedisonVan/ParsingPython/main/loverstolov.lua" -- ��� ���� ������
local script_path = thisScript().path

local directIni = 'loverstolov.ini' --�������� ����� � ����� moonloader/config
local ini = inicfg.load(inicfg.load({ --���������� ini
    settings = {    
    }
}, directIni))
local ffi = require "ffi"
ffi.cdef[[
     void keybd_event(int keycode, int scancode, int flags, int extra);
]]

encoding.default = 'CP1251'; u8 = encoding.UTF8 

local activateMathematic = 0

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand('lover', cmd_tk)
	sampRegisterChatCommand("min", TableMin)
	sampRegisterChatCommand("cur", cursor)
	sampRegisterChatCommand("stol", function() stol = not stol
		if stol then
			sampAddChatMessage('VKL', -1)
			sampSendClickTextdraw(1681)
		else
			sampAddChatMessage('��������', -1)
		end
	 end)
	sampRegisterChatCommand("bug", bug)
	sampRegisterChatCommand("max", TableMax)
	createDirectory('moonloader/config')
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if updateIni then
				if tonumber(updateIni.info.vers) > script_vers then
					update_state = true
				end
				os.remove(update_path)
			end
		end
	end)
	if not doesFileExist("moonloader/config/loverstolov.ini") then 
		if settings == nil then
			ini.settings.zaderzhkachecka=1900
			ini.settings.pricemetr=1
			ini.settings.pricemetr1=2
			ini.settings.kknopka2='B'
			ini.settings.kknopka1='G'
			ini.settings.knopka2=66
			ini.settings.knopka1=71
			ini.settings.krichalka=tostring(u8('99.999-100.000. ������� �� ������, ����� �� ������!!'))
			inicfg.save(ini, "loverstolov.ini")
			zaderzhkachecka.v = tostring(ini.settings.zaderzhkachecka)
			pricemetr.v = tostring(ini.settings.pricemetr)
			pricemetr1.v = tostring(ini.settings.pricemetr1)
			knopka1 = tostring(ini.settings.kknopka1)
			knopka2 = tostring(ini.settings.kknopka2)
			krichalka.v = tostring(ini.settings.krichalka)
		end
	else
		zaderzhkachecka.v = tostring(ini.settings.zaderzhkachecka)
		knopka1 = tostring(ini.settings.kknopka1)
		knopka2 = tostring(ini.settings.kknopka2)
		pricemetr.v = tostring(ini.settings.pricemetr)
		pricemetr1.v = tostring(ini.settings.pricemetr1)
		krichalka.v = u8(tostring(u8:decode(ini.settings.krichalka)))
	end
	sampRegisterChatCommand("wait", waiters)
	sampRegisterChatCommand("dio", MoneyKick)
	sampRegisterChatCommand("ons", function() info_skript.v = not info_skript.v
		if info_skript.v then
			info_script = '{7FFF00}�������'
		else
			info_script = '{FF0000}��������'
		end
	 end)
	 sampRegisterChatCommand("clicker", function() info_klac.v = not info_klac.v
		if info_klac.v then
			info_clicker = '{7FFF00}�������'
		else
			info_clicker = '{FF0000}��������'
		end
	 end)
	while true do
		wait(0)
		if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage("������ �������!", -1)
                    thisScript():reload()
                end
            end)
            break
        end
		if isKeyDown(VK_F8) and info_screen.v then
			info_screen.v = false
			wait(1000)
			info_screen.v = true
		end
		if status_krichalka.v then
			if activTimerS == 0 then
				lua_thread.create(function()
					activTimerS = 1
					local timers = math.random(30000,60000)
					wait(timers)
					if(status_krichalka.v) then
						sampSendChat('/s ' .. tostring(u8:decode(ini.settings.krichalka)))
						activTimerS = 0                                              
					end
				end)
			end	
		end
		if isKeyDown(ini.settings.knopka1) and isKeyJustPressed(ini.settings.knopka2) then
            menuActive.v = not menuActive.v
            imgui.Process = menuActive.v
        end
		if menuActive.v == false then
            imgui.Process = false
        end
		money = getPlayerMoney()
		sampTextdrawIsExists(1681)
		if sampTextdrawIsExists(2057) then
			sampTextdrawIsExists(1681)
			--sampSendDialogResponse(874, 0, -1, 3)
		end
		  if info_klac.v then
			wait(20)
			if sampTextdrawIsExists(1684) then
				random = math.random(zaderzhkachecka.v, zaderzhkachecka.v+1000)
				wait(zaderzhkachecka.v)
				sampSendClickTextdraw(1684)
			end
		end
	end
end

function cursor()
	emulate_F5 = not emulate_F5
	if emulate_F5 then
		EmulateKey(VK_F5, true)
		sampSetCursorMode(CMODE_LOCKCAM)
		sampToggleCursor(false)
		info_cursor.v = true
		freezeCharPosition(PLAYER_PED, true)
		freezeCharPosition(PLAYER_PED, false)
		setPlayerControl(PLAYER_HANDLE, true)
		restoreCameraJumpcut()
		clearCharTasksImmediately(PLAYER_PED)
	else
		EmulateKey(VK_F5, false)
		info_cursor.v = false
	end
end

function sampev.onShowTextDraw(id, data) --� id ��������� id ����������
    print('����� ���������� '..id..': '..data.text, -1)
    posX, posY = sampTextdrawGetPos(id)  -- 0C5B
    if posX == 100 and posY == 100 then sampAddChatMessage('��������� ���������� '..id..': X=100, Y=100', -1) end --���� ��������� ���������� �� ��� X � ��� Y == 100, �� � ��� ����� �������� ���������
end

function sampev.onServerMessage(color, text)
	if anti_flud.v then
		if text:find('�� ������ ������ ������') and text:find('100000') then
			return false
		end
		if text:find('�������:') or text:find('��������:') then
			return false
		end
	end
end

function EmulateKey(key, isDown)
    if not isDown then
        ffi.C.keybd_event(key, 0, 2, 0)
    else
        ffi.C.keybd_event(key, 0, 0, 0)
    end
end

function sampev.onRequestClassResponse(canSpawn, team, skin, _unused, positon, rotation, weapons, ammo)
	print(canSpawn, team, skin, _unused, positon, rotation, weapons, ammo)
end

function bug()
	sampSendDialogResponse(874, 1, -1, 1)
	freezeCharPosition(PLAYER_PED, true)
	freezeCharPosition(PLAYER_PED, false)
	setPlayerControl(PLAYER_HANDLE, true)
	restoreCameraJumpcut()
	clearCharTasksImmediately(PLAYER_PED)
end

function cmd_tk(arg)
    menuActive.v = not menuActive.v
    imgui.Process = menuActive.v
end

function onD3DPresent()
    if isSampfuncsLoaded() and isSampLoaded() then
		if info_screen.v then
		local resX, resY = getScreenResolution()
			renderFontDrawText(my_font1, '{FF8C00} �����: {FFFF00}' .. money .. '$', resX - 420, (resY - 850) + 7, 0xFF00FF00)
			renderFontDrawText(my_font, '{FF8C00} �����: ' .. info_script, resX - 320, (resY - 250) + 7, 0xFF00FF00)
			renderFontDrawText(my_font, '{FF8C00} ������: ' .. info_clicker, resX - 320, (resY - 220) + 7, 0xFF00FF00)
			renderFontDrawText(my_font, '{FF8C00} ���. ������: {FFFF00}' .. pricemetr.v .. '$', resX - 320, (resY - 190) + 7, 0xFF00FF00)
			renderFontDrawText(my_font, '{FF8C00} ����. ������: {FFFF00}' .. pricemetr1.v .. '$', resX - 320, (resY - 160) + 7, 0xFF00FF00)
			renderFontDrawText(my_font, '{FF8C00} �������� �����: {FFFF00}' .. zaderzhkachecka.v, resX - 320, (resY - 130) + 7, 0xFF00FF00)
		end
	end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
	if info_skript.v then
		if id == 872 then
			sampSendDialogResponse(872, 1, -1, -1)
			return false
		end
		if id == 873 then
			sampSendDialogResponse(873, 1, -1, pricemetr.v)
			return false
		end
		if id == 874 then
			sampSendDialogResponse(874, 1, -1, pricemetr1.v)
			-- info_klac.v = true
			-- activClicker = true
			-- info_clicker = '{7FFF00}�������'
			-- status_krichalka.v = true
			sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {7FFF00}���� ����������� ������ � ��������",  -1)
			if stol then
				return true
			else
				return false
			end
		end
	end
end

function imgui.OnDrawFrame()
	local xw, yw = getScreenResolution()
	imgui.SetNextWindowPos(imgui.ImVec2(xw / 2, yw / 2), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowSize(imgui.ImVec2(425, 225), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'����� ������', menuActive, imgui.WindowFlags.NoResize)
	if imgui.Checkbox(u8'�����', info_skript) then
		if info_skript.v then
			info_script = '{7FFF00}�������'
		else
			info_script = '{FF0000}��������'
		end
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}��������� ������ ��� ����� ������ \n�������: {ffa500}/ons")
	imgui.SetCursorPosY(50)
	if imgui.Checkbox(u8'������', info_klac) then
		if info_klac.v then
			activClicker = true
			info_clicker = '{7FFF00}�������'
		else
			activClicker = false
			info_clicker = '{FF0000}��������'
		end
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}����� ������������� ����� �� ������� \n{FFFFFF}�������� ������ ����������� ���� \n�������: {ffa500}/clicker")
	imgui.SetCursorPosY(25)
	imgui.SetCursorPosX(100)
	if imgui.Checkbox(u8'����������', info_screen) then
		if info_screen.v then
			ini.settings.info_screen = true
			inicfg.save(ini, "loverstolov.ini")
		else
			ini.settings.info_screen = false
			inicfg.save(ini, "loverstolov.ini")
		end
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}���������� �� ������")
	imgui.SetCursorPosY(50)
	imgui.SetCursorPosX(100)
	if imgui.Checkbox(u8'��������', status_krichalka) then
		--
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}����������� ��� ���� ����� /s ���\n{FFFFFF}��������� ����������� ����")
	imgui.SetCursorPosY(25)
	imgui.SetCursorPosX(225)
	if imgui.Checkbox(u8'���� �� �����', info_cursor) then
		cursor()
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}����������� ���� �� �����, ������ � ������ ���������. \n�������: {ffa500}/cur")
	imgui.SetCursorPosY(50)
	imgui.SetCursorPosX(225)
	if imgui.Checkbox(u8'����-����', anti_flud) then
		ini.settings.anti_flud = anti_flud.v
		inicfg.save(ini, "loverstolov.ini")
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}������� ���� � ������ ����� /s. \n{FFFFFF}������� ���� ����� ������� � 100.000$. \n�������: {ffa500}/clicker")
	imgui.SetCursorPosY(85)
	imgui.Separator()
	imgui.Text(u8'��������: ')
	imgui.SetCursorPosY(86)
	imgui.SetCursorPosX(100)
	imgui.PushItemWidth(100)
	if imgui.InputText(u8'##2', zaderzhkachecka, imgui.InputTextFlags.CharsDecimal, imgui.InputTextFlags.CharsNoBlank) then
		ini.settings.zaderzhkachecka=zaderzhkachecka.v
		inicfg.save(ini, "loverstolov.ini")
	end
	imgui.Tooltip("{ffa500}(?) ���������:\n{FFFFFF}������������� �������� ��� �������. \n{FFFFFF}��� ��������������� �����, �������� � ������ ������ ������. \n�������: {ffa500}/clicker")
	imgui.PushItemWidth(100)
	imgui.SetCursorPosY(116)
	imgui.Text(u8'���. ������: ')
	imgui.SetCursorPosX(100)
	imgui.SetCursorPosY(115)
	if imgui.InputText(u8'##3', pricemetr, imgui.InputTextFlags.CharsDecimal, imgui.InputTextFlags.CharsNoBlank) then
		if pricemetr.v then
			if tonumber(pricemetr.v) > 0 and tonumber(pricemetr.v) <= 99999 then
				ini.settings.pricemetr = pricemetr.v
				inicfg.save(ini, "loverstolov.ini")
			elseif tonumber(pricemetr.v) >= 99999 then
				pricemetr.v = tostring(99999)
				ini.settings.pricemetr1 = pricemetr1.v
				inicfg.save(ini, "loverstolov.ini")
			elseif tonumber(pricemetr.v) < 0 then
				pricemetr.v = tostring(1) 
				ini.settings.pricemetr1 = pricemetr1.v
				inicfg.save(ini, "loverstolov.ini")
			end
		end
	end
	imgui.PushItemWidth(100)
	imgui.SetCursorPosY(146)
	imgui.Text(u8'����. ������: ')
	imgui.SetCursorPosX(100)
	imgui.SetCursorPosY(145)
	if imgui.InputText(u8'##4', pricemetr1, imgui.InputTextFlags.CharsDecimal, imgui.InputTextFlags.CharsNoBlank) then
		if pricemetr1.v then
			if tonumber(pricemetr1.v) > 1 and tonumber(pricemetr1.v) <= 100000 then
				ini.settings.pricemetr1 = pricemetr1.v
				inicfg.save(ini, "loverstolov.ini")
			elseif tonumber(pricemetr1.v) >= 100000 then
				pricemetr1.v = tostring(100000)
				ini.settings.pricemetr1 = pricemetr1.v
				inicfg.save(ini, "loverstolov.ini")
			elseif tonumber(pricemetr1.v) < 1 then
				pricemetr1.v = tostring(2) 
				ini.settings.pricemetr1 = pricemetr1.v
				inicfg.save(ini, "loverstolov.ini")
			end
		end
	end
	imgui.SetCursorPosX(210)
	imgui.SetCursorPosY(148)
	imgui.Text(u8'��������� ����:')
	imgui.SetCursorPosX(350)
	imgui.SetCursorPosY(143)
	imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
	if imgui.Button(knopka1, imgui.ImVec2(25, 25), imgui.StyleVar.ButtonTextAlign) then
		knopka1 = 'No'
		poluchknopka1 = true
	end
	imgui.PopStyleVar(1)
	if poluchknopka1 then
		knopka1 = getDownKeysText()
		if knopka1 == 'No' then
			poluchknopka1 = true
		else
			ini.settings.knopka1 = getDownKeys(knopka1)
			ini.settings.kknopka1 = knopka1
			inicfg.save(ini, directIni)
			poluchknopka1 = false
		end
	end
	imgui.SetCursorPosY(143)
	imgui.SetCursorPosX(320)
-- ���
	imgui.PushStyleVar(imgui.StyleVar.ButtonTextAlign , imgui.ImVec2(0.5, 0.5))
	if imgui.Button(knopka2, imgui.ImVec2(25, 25)) then
		knopka2 = 'No'
		poluchknopka2 = true
	end
	imgui.PopStyleVar(1)
	if poluchknopka2 then
		knopka2 = getDownKeysText()
		if knopka2 == 'No' then
			poluchknopka2 = true
		else
			ini.settings.knopka2 = getDownKeys(knopka2)
			ini.settings.kknopka2 = knopka2
			inicfg.save(ini, directIni)
			poluchknopka2 = false
		end
	end
	imgui.PushItemWidth(300)
	imgui.SetCursorPosY(176)
	imgui.Text(u8'��������: ')
	imgui.SetCursorPosX(100)
	imgui.SetCursorPosY(175)
	if imgui.InputText(u8'##5', krichalka) then
		ini.settings.krichalka = krichalka.v
		inicfg.save(ini, "loverstolov.ini")
	end
	imgui.SetCursorPosX(3)
	imgui.SetCursorPosY(210)
	imgui.TextColoredRGB('{C0C0C0}Yurii Krestovskiy � Aleksey Krestovskiy')
	imgui.End()
	end

function imgui.Tooltip(text)
	if imgui.IsItemHovered() then
		print(text)
		imgui.BeginTooltip()
		imgui.TextColoredRGB(text)
		imgui.EndTooltip()
	end
end

-- � ����� ����� ����
function imgui.TextColoredRGB(text)
    local style = imgui.GetStyle()
    local colors = style.Colors
    local ImVec4 = imgui.ImVec4

    local explode_argb = function(argb)
        local a = bit.band(bit.rshift(argb, 24), 0xFF)
        local r = bit.band(bit.rshift(argb, 16), 0xFF)
        local g = bit.band(bit.rshift(argb, 8), 0xFF)
        local b = bit.band(argb, 0xFF)
        return a, r, g, b
    end

    local getcolor = function(color)
        if color:sub(1, 6):upper() == 'SSSSSS' then
            local r, g, b = colors[1].x, colors[1].y, colors[1].z
            local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
            return ImVec4(r, g, b, a / 255)
        end
        local color = type(color) == 'string' and tonumber(color, 16) or color
        if type(color) ~= 'number' then return end
        local r, g, b, a = explode_argb(color)
        return imgui.ImColor(r, g, b, a):GetVec4()
    end

    local render_text = function(text_)
        for w in text_:gmatch('[^\r\n]+') do
            local text, colors_, m = {}, {}, 1
            w = w:gsub('{(......)}', '{%1FF}')
            while w:find('{........}') do
                local n, k = w:find('{........}')
                local color = getcolor(w:sub(n + 1, k - 1))
                if color then
                    text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                    colors_[#colors_ + 1] = color
                    m = n
                end
                w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
            end
            if text[0] then
                for i = 0, #text do
                    imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                    imgui.SameLine(nil, 0)
                end
                imgui.NewLine()
            else imgui.Text(u8(w)) end
        end
    end

    render_text(text)
end

function waiters(arg)
	zaderzhkachecka.v = tonumber(arg)
	sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}�������� ����� �����������: {ff00ff}" .. zaderzhkachecka.v,  -1)
end

function TableMin(arg)
	if arg then
		if tonumber(arg) > 0 and tonumber(arg) <= 99999 then
			pricemetr.v = tostring(arg)
			ini.settings.pricemetr = pricemetr.v
			inicfg.save(ini, "loverstolov.ini")
			sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}����������� ������ �����������: {ff00ff}" .. pricemetr.v,  -1)
		else
			sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}�������� ����������� ������ {FF0000}[Error]",  -1)
		end
	else
		sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}�������� ����������� ������ {FF0000}[Error]",  -1)
	end
end

function TableMax(arg)
	if tonumber(arg) then
		if tonumber(arg) > 1 and tonumber(arg) <= 100000 then
			pricemetr1.v = tostring(arg)
			ini.settings.pricemetr1 = pricemetr1.v
			inicfg.save(ini, "loverstolov.ini")
			sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}������������ ������ �����������: {ff00ff}" .. pricemetr1.v, -1)
		else
			sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}�������� ������������ ������ {FF0000}[Error]",  -1)
		end
	else
		sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FFFFFF}�������� ������������ ������ {FF0000}[Error]",  -1)
	end
end

function MoneyKick(arg)
	min_money_kick = tonumber(arg) 
	sampAddChatMessage("{FFFFFF}���� ������ �����������.: " .. min_money_kick)
end
function OnScript(arg)
	if ActivateScript == 0 then
		sampAddChatMessage("{FFFFFF}{FF8C00}[{FF6347}����� ������{FF8C00}]: {7FFF00}������ ������� {ff00ff}", -1);
	end
	if ActivateScript == 1 then
		ActivateScript = 0;
		sampAddChatMessage("{FF8C00}[{FF6347}����� ������{FF8C00}]: {FF0000}������ �������� {ff00ff}", -1);
	end
end
function OffScript(arg)
	if ActivateScript == 1 then
		sampAddChatMessage("{FFFFFF}������ ��� ��������");
	end
	if ActivateScript == 0 then
		ActivateScript = 1;
		sampAddChatMessage("{FFFFFF}�� �������� ������");
	end
end

function imgui.Hint(str_id, hint, delay)
    local hovered = imgui.IsItemHovered()
    local animTime = 0.2
    local delay = delay or 0.00
    local show = true

    if not allHints then allHints = {} end
    if not allHints[str_id] then
        allHints[str_id] = {
            status = false,
            timer = 0
        }
    end

    if hovered then
        for k, v in pairs(allHints) do
            if k ~= str_id and os.clock() - v.timer <= animTime  then
                show = false
            end
        end
    end

    if show and allHints[str_id].status ~= hovered then
        allHints[str_id].status = hovered
        allHints[str_id].timer = os.clock() + delay
    end

    if show then
        local between = os.clock() - allHints[str_id].timer
        if between <= animTime then
            local s = function(f)
                return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
            end
            local alpha = hovered and s(between / animTime) or s(1.00 - between / animTime)
            imgui.PushStyleVarFloat(imgui.StyleVar.Alpha, alpha)
            imgui.SetTooltip(hint)
            imgui.PopStyleVar()
        elseif hovered then
            imgui.SetTooltip(hint)
        end
    end
end

function getDownKeys()
    local curkeys = ""
    local bool = false
    for k, v in pairs(key) do
        if isKeyDown(v) and (v == VK_MENU or v == VK_CONTROL or v == VK_SHIFT or v == VK_LMENU or v == VK_RMENU or v == VK_RCONTROL or v == VK_LCONTROL or v == VK_LSHIFT or v == VK_RSHIFT) then
            if v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT then
                curkeys = v
            end
        end
    end
    for k, v in pairs(key) do
        if isKeyDown(v) and (v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT and v ~= VK_LMENU and v ~= VK_RMENU and v ~= VK_RCONTROL and v ~= VK_LCONTROL and v ~= VK_LSHIFT and v ~= VK_RSHIFT) then
            if tostring(curkeys):len() == 0 then
                curkeys = v
            else
                curkeys = curkeys .. " " .. v
            end
            bool = true
        end
    end
    return curkeys, bool
end

function getDownKeysText()
    tKeys = string.split(getDownKeys(), " ")
    if #tKeys ~= 0 then
        for i = 1, #tKeys do
            if i == 1 then
                str = key.id_to_name(tonumber(tKeys[i]))
            end
        end
        return str
    else
        return "No"
    end
end

function string.split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end


function strToIdKeys(str)
    tKeys = string.split(str, "+")
    if #tKeys ~= 0 then
        for i = 1, #tKeys do
            if i == 1 then
                str = key.name_to_id(tKeys[i], false)
            else
                str = str .. " " .. key.name_to_id(tKeys[i], false)
            end
        end
        return tostring(str)
    else
        return "(("
    end
end

function isKeysDown(keylist, pressed)
    local tKeys = string.split(keylist, " ")
    if pressed == nil then
        pressed = false
    end
    if tKeys[1] == nil then
        return false
    end
    local bool = false
    local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[2])
    local modified = tonumber(tKeys[1])
    if #tKeys < 2 then
        if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) and not isKeyDown(VK_RSHIFT) and not isKeyDown(VK_LCONTROL) and not isKeyDown(VK_RCONTROL) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    else
        if isKeyDown(modified) and not wasKeyReleased(modified) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    end
    if nextLockKey == keylist then
        if pressed and not wasKeyReleased(key) then
            bool = false
        else
            bool = false
            nextLockKey = ""
        end
    end
    return bool
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    local style = imgui_lib.GetStyle()
    local colors = style.Colors
    local clr = imgui_lib.Col
    local ImVec4 = imgui_lib.ImVec4

    style.WindowRounding = 2
    style.WindowTitleAlign = imgui_lib.ImVec2(0.5, 0.5)
    style.ChildWindowRounding = 4.0
    style.FrameRounding = 3
    style.ItemSpacing = imgui_lib.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0
    style.WindowPadding = imgui_lib.ImVec2(4.0, 4.0)
    style.FramePadding = imgui_lib.ImVec2(3.5, 3.5)
    style.ButtonTextAlign = imgui_lib.ImVec2(0.0, 0.5)

    colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
    colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.TitleBg] = ImVec4(0.76, 0.31, 0.00, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
    colors[clr.TitleBgActive] = ImVec4(0.80, 0.33, 0.00, 1.00)
    colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
    colors[clr.CheckMark] = ImVec4(1.00, 0.42, 0.00, 0.53)
    colors[clr.SliderGrab] = ImVec4(1.00, 0.42, 0.00, 0.53)
    colors[clr.SliderGrabActive] = ImVec4(1.00, 0.42, 0.00, 1.00)
    colors[clr.Button] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

apply_custom_style()