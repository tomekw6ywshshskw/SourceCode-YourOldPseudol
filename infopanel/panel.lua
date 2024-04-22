local InfoPanel = {}
local settings = {
  title = "Co znajdziemy na serwerze?",
  description = [[ swirki bajerki ]],
}

function InfoPanel:init()
  self.scr = Vector2(guiGetScreenSize())
  self.w = 800
  self.h = 600
  self.x = self.scr.x/2-self.w/2
  self.y = self.scr.y/2-self.h/2
  self.open = false
  
  self.func = {}
  self.func.render = function() self:draw() end
  self.func.key = function(...) self:onKey(...) end
  
  addEventHandler("onClientKey",root,self.func.key)
  return true
end

function InfoPanel:draw()
  dxDrawRectangle(self.x,self.y,self.w,self.h,tocolor(0,0,0,150))
  dxDrawText(settings.title,self.x,self.y,self.x+self.w,self.y+self.h,white,1,"default","center","top")
  dxDrawText(settings.description,self.x,self.y,self.x+self.w,self.y+self.h,white,1,"default","center","center")
end

function InfoPanel:onKey(...)
  local button = arg[1]
  local state = arg[2]
  if button ~= "f1" then return end
  if not state then return end
  
  self.open = not self.open
  if self.open then
    addEventHandler("onClientRender",root,self.func.render)
  else
    removeEventHandler("onClientRender",root,self.func.render)
  end
end

InfoPanel:init()
