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

function gb_is_score_on_fire()
    return to_big(G.GAME.blind.chips) <= to_big(hand_chips) * to_big(mult)
end

function gb_is_suit_in_deck(suit_key)
    if G.playing_cards then
        for _, card in ipairs(G.playing_cards) do
            if card.base.suit == suit_key then
                return true
            end
        end
    end
    return false
end

function gb_partial_balance(init_chips, init_mult, value)
    if value <= 0 or value > 1 then
        return nil
    end
    mult = mod_mult(math.ceil((init_mult + init_chips * value) / (1 + value)))
    hand_chips = mod_chips(math.ceil((init_chips + init_mult * value) / (1 + value)))
    update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
    G.E_MANAGER:add_event(Event({
        func = function()
            play_sound('gong', 0.94, 0.3)
            play_sound('gong', 0.94*1.5, 0.2)
            play_sound('tarot1', 1.5)
            return true
        end
     }))
end

function gb_find_eligible_shatters()
    local eligible_jokers = {}
    for _, joker in ipairs(G.jokers.cards) do
        if GB_SHATTERED_TABLE[joker.config.center.key] then
            eligible_jokers[#eligible_jokers + 1] = joker.config.center.key
        end
    end
    return eligible_jokers
end

function gb_apply_hex(card_table, hex_key, cards_to_hex)
    local unhexed_cards = {}
    for _, playing_card in ipairs(card_table) do
        table.insert(unhexed_cards, playing_card)
    end
    if #unhexed_cards > 0 then
        for i = 1, cards_to_hex do
            local hex_index = pseudorandom("gb_hex", 1, #unhexed_cards)
            card_to_hex = unhexed_cards[hex_index]
            table.remove(unhexed_cards, hex_index)
            GB.set_hex(card_to_hex, hex_key)
        end
    end
end

function gb_tally_enhancements(cards, enhancement_key)
    local tally = 0
    for _, playing_card in ipairs(cards) do
        if SMODS.has_enhancement(playing_card, enhancement_key) then
            tally = tally + 1
        end
    end
    return tally
end

function gb_contains_enhancement(cards, enhancement_key)
    for _, playing_card in ipairs(cards) do
        if SMODS.has_enhancement(playing_card, enhancement_key) then
            return true
        end
    end
    return false
end