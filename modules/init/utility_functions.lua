function gb_is_blind_defeated(blind_key)
    if G.GAME.GB_DEFEATED_BLINDS and G.GAME.GB_DEFEATED_BLINDS[blind_key] then
        return true
    else
        return false
    end
end

function gb_get_boss_joker_cost()
    return math.min(math.max(G.GAME.round_resets.blind_ante, 4), 10) or 4
end

function gb_count_suits(card_table)
    local suits = {}
    for _, card in ipairs(card_table) do
        if card.base.suit
        and not suits[card.base.suit]
        and not SMODS.has_no_suit(card)
        and not SMODS.has_any_suit(card) then
            suits[card.base.suit] = true
        end
    end
    local suit_count = 0
    for _, _ in pairs(suits) do
        suit_count = suit_count + 1
    end
    return suit_count
end