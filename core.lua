local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function ChatNotification(id)
	local allowSpell = {20066, 5782, 118, 853, 5484, 6789, 31661, 710, 135893};	
	
	if not has_value(allowSpell, id) then
		return
	end
	
	local spellName,  rank, icon, castTime, minRange, maxRange  = GetSpellInfo(id);
	-- local itemIcon = GetItemIcon(icon)	
	
	-- print (icon);
	-- print("|T"..icon..":0|t");
	-- print()
	
	local playerName = UnitName("player");
	local targetName = UnitName("target");
	local localizedClass, englishClass, classIndex = UnitClass("target");		
		
	local message = spellName .. ' ' .. string.upper(localizedClass).."  " .. targetName;
	C_ChatInfo.SendAddonMessage("kloxer", icon..'^'..targetName..'^'..localizedClass, "RAID");
	SendChatMessage(spellName .. " на " .. targetName .. ' ' .. localizedClass, "PARTY", "COMMON");
end

function init()	
	if C_ChatInfo then
		C_ChatInfo.RegisterAddonMessagePrefix("kloxer")
	else
		RegisterAddonMessagePrefix("kloxer")
	end
end
 
 function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end

local function displayupdate(message)
	local obj = mysplit(message, '^');
	local icon, targetName, targetClass = obj[1], obj[2], obj[3];
	
	PlaySoundFile(567397)

	local f1 = CreateFrame("Frame", nil, UIParent)
	f1:SetWidth(1) 
	f1:SetHeight(1) 
	f1.icon = f1:CreateTexture("BagBuddy_Icon", "BACKGROUND")
	f1.icon:SetWidth(48)
	f1.icon:SetHeight(48)
	f1.icon:SetPoint("BOTTOM", 0, 10)
	f1:SetPoint("CENTER", 0, 50)
	f1.text = f1:CreateFontString(nil, "OVERLAY", "GameFontHighlight") 
	f1.text:SetFont(615958, 18, "OUTLINE")
	f1.text:SetPoint("CENTER")
	
	local ag = f1:CreateAnimationGroup()    
	local a1 = ag:CreateAnimation("Translation")
	a1:SetOffset(0, 800)    
	a1:SetDuration(5)
	a1:SetSmoothing("OUT")

	f1.text:SetText('\124cFF00FF00'..targetName .. '\124r ' .. targetClass)
	f1.icon:SetTexture(icon)
    f1:Show() 
	ag:Play()
	C_Timer.After(4, 
		function()
			f1:Hide();
		end
	)
end

function hide()
	f1:Hide() 
end
 
local myFrame = CreateFrame("Frame");
local myCurrentCast;
myFrame:RegisterEvent("UNIT_SPELLCAST_SENT");
myFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
myFrame:RegisterEvent("CHAT_MSG_ADDON");
myFrame:RegisterEvent("ADDON_LOADED");
myFrame:SetScript("OnEvent",
    function(self, event, arg1, arg2, arg3, arg4)		
		 if (event == "ADDON_LOADED") then			
			init();
        elseif (event == "UNIT_SPELLCAST_SENT" and arg1 == "player") then     			
            myCurrentCast = arg3;
        elseif (event == "UNIT_SPELLCAST_SUCCEEDED" and arg2 == myCurrentCast) then
			myCurrentCast = nil;
			ChatNotification(arg3);		
		elseif (event == "CHAT_MSG_ADDON" and arg1 == "kloxer") then		
			displayupdate(arg2);	
        end
    end
);


  