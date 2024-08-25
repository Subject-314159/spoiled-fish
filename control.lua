local DIARRHEA_DURATION = 30 * 60 -- 30sec
local TURD_COOLDOWN = 2 * 60 -- 2sec

local function check_player_global(player_index)
    if not global.players then
        global.players = {}
    end
    if not global.players[player_index] then
        global.players[player_index] = {
            diarrhea_expire = 0,
            next_turd_cooldown = 0
        }
    end
end

script.on_event(defines.events.on_player_used_capsule, function(e)
    check_player_global(e.player_index)

    if e.item.name == "spoiled-fish" then
        local p = global.players[e.player_index]
        p.diarrhea_expire = game.ticks_played + DIARRHEA_DURATION
        game.print("Ewww... " .. game.get_player(e.player_index).name .. " ate a spoiled fish!")
    end
end)

script.on_event(defines.events.on_player_changed_position, function(e)
    check_player_global(e.player_index)

    -- Check if player recently ate spoiled fish and thus has diarrhea
    local p = global.players[e.player_index]
    if not p or game.ticks_played > p.diarrhea_expire or game.ticks_played < p.next_turd_cooldown then
        -- Do not proceed if there is no player, the game tick is past the expiration of diarrhea, or the game tick is before the cooldown for the next turd
        return
    end

    -- Add diarrhea corpse effect under player trail
    local player = game.get_player(e.player_index) -- get the player that moved
    if not player then
        return
    end
    if player.character then
        if math.random(1, 100) < 30 then -- 30% chance per move
            -- create the turd where they're standing
            local pos = {
                x = player.position.x + (math.random(-50, 50) / 100),
                y = player.position.y + (math.random(-50, 50) / 100)
            }
            player.surface.create_entity {
                name = "turd",
                position = pos,
                force = "neutral"
            }
            -- Play the fart sound
            player.play_sound({
                path = "fart"
            })
            p.next_turd_cooldown = game.ticks_played + TURD_COOLDOWN
        end
    end
end)
