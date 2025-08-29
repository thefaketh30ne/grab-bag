SMODS.Consumable {
    key = "superstition",
    set = "Hex",
    loc_txt = {
        name = 'Superstition',
        text = {
            "For each selected card,",
            "{C:green}#1# in #2# chance{} to",
            "level up {C:attention}most played poker hand{}",
            "An equal number of cards",
            "in {C:attention}full deck{} become {C:attention}Obsessive"
        }
    },
    config = { extra = { odds = 2, hex_to_apply = "obsessive" } },
    atlas = 'gb_HexCards',
    pos = { x = 8, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = GB.hex_tooltip(card.ability.extra.hex_to_apply)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
		return { vars = { new_numerator, new_denominator } }
    end,
    use = function(self, card, area, copier)
        local most_played_hand, play_tally = nil, 0
        local levels = 0
        for i = 1, #G.hand.highlighted do
            if SMODS.pseudorandom_probability(card, 'gb_superstition', 1, card.ability.extra.odds) then
                levels = levels + 1
            end
        end
        for _, handname in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > play_tally then
                most_played_hand = handname
                play_tally = G.GAME.hands[handname].played
            end
        end
        if most_played_hand and levels > 0 then
            SMODS.smart_level_up_hand(card, most_played_hand, false, levels)
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                gb_apply_hex(G.playing_cards, card.ability.extra.hex_to_apply, #G.hand.highlighted)
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0
    end
}

