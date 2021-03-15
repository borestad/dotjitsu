-- HANDLE SCROLLING WITH MOUSE BUTTON PRESSED
local scrollMouseButton = 2
local deferred = false

overrideOtherMouseDown = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDown }, function(e)
    -- print("down")
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if scrollMouseButton == pressedMouseButton
        then
            deferred = true
            return true
        end
end)

overrideOtherMouseUp = hs.eventtap.new({ hs.eventtap.event.types.otherMouseUp }, function(e)
    -- print("up")
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    if scrollMouseButton == pressedMouseButton
        then
            if (deferred) then
                overrideOtherMouseDown:stop()
                overrideOtherMouseUp:stop()
                hs.eventtap.otherClick(e:location(), pressedMouseButton)
                overrideOtherMouseDown:start()
                overrideOtherMouseUp:start()
                return true
            end
            return false
        end
        return false
end)

local oldmousepos = {}
local scrollmult = -4   -- negative multiplier makes mouse work like traditional scrollwheel

dragOtherToScroll = hs.eventtap.new({ hs.eventtap.event.types.otherMouseDragged }, function(e)
    local pressedMouseButton = e:getProperty(hs.eventtap.event.properties['mouseEventButtonNumber'])
    -- print ("pressed mouse " .. pressedMouseButton)
    if scrollMouseButton == pressedMouseButton
        then
            -- print("scroll");
            deferred = false
            oldmousepos = hs.mouse.getAbsolutePosition()
            local dx = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaX'])
            local dy = e:getProperty(hs.eventtap.event.properties['mouseEventDeltaY'])
            local scroll = hs.eventtap.event.newScrollEvent({-dx * scrollmult, dy * scrollmult},{},'pixel')
            -- put the mouse back
            hs.mouse.absolutePosition(oldmousepos)
            return true, {scroll}
        else
            return false, {}
        end
end)

overrideOtherMouseDown:start()
overrideOtherMouseUp:start()
dragOtherToScroll:start()
