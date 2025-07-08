function gb_is_blind_defeated(blind_key)
    if G.GAME.GB_DEFEATED_BLINDS[blind_key] then
        return true
    else
        return false
    end
end

function gb_get_boss_joker_cost()
    return math.min(math.max(G.GAME.round_resets.blind_ante, 4), 10) or 4
end