-- The parent frame to add textures and fontstrings to
local frame = CreateFrame("Frame", nil, UIParent)
    frame:SetWidth(425)
    frame:SetHeight(425)
    frame:SetPoint("CENTER", UIParent, "CENTER")
    
    -- The body texture of BagBuddy
    frame.texture  = frame:CreateTexture();
    frame.texture:SetAllPoint(frame);
    frame.texture:SetTexture(255,255,0);
    
    -- The portrait texture of BagBuddy
    frame.icon = frame:CreateTexture("BagBuddy_Icon", "BACKGROUND")
    frame.icon:SetWidth(60)
    frame.icon:SetHeight(60)
    frame.icon:SetPoint("TOPLEFT", 7, -6)
    frame.icon:SetTexture("Interface\\Icons\\INV_Misc_EngGizmos_17")
    SetPortraitToTexture(frame.icon, "Interface\\Icons\\INV_Misc_EngGizmos_17")
    
    -- The title fontstring of BagBuddy
    --frame.title = frame:CreateFontString("BagBuddy_Title", "OVERLAY", "GameFontNormal")
    --frame.title:SetPoint("TOP", 0, -18)
    --frame.title:SetText("BagBuddy")
    
    -- The button that allows BagBuddy to be hidden
    frame.close = CreateFrame("Button", "BagBuddy_Close", frame, "UIPanelCloseButton")
    frame.close:SetPoint("TOPRIGHT", -22, -8)
	
	function BagBuddy_OnLoad(self)
 
    end
 
    function BagBuddy_MakeMovable(self, motion)
        self:EnableMouse(true)
        self:SetMovable(true)
        self:SetClampedToScreen(true)
        self:RegisterForDrag("LeftButton")
        self:SetScript("OnDragStart", self.StartMoving)
        self:SetScript("OnDragStop", self.StopMovingOrSizing)
    end
 
    BagBuddy_MakeMovable(frame)