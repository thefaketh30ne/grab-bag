SMODS.Consumable {
    key = "superstition",
    set = "Hex",
    loc_txt = {
        name = 'Superstition',
        text = { {
            "For each selected card,",
            "level up {C:attention}most played poker hand{}",
        },
        {
            "An equal number of cards",
            "in {C:attention}full deck{} become {C:attention}Obsessive"
        } }
    },
    config = { extra = { hex_to_apply = "obsessive" } },
    atlas = 'gb_HexCards',
    pos = { x = 8, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = GB.hex_tooltip(card.ability.extra.hex_to_apply)
    end,
    use = function(self, card, area, copier)
        local most_played_hand, play_tally = nil, 0
        for _, handname in ipairs(G.handlist) do
            if SMODS.is_poker_hand_visible(handname) and G.GAME.hands[handname].played > play_tally then
                most_played_hand = handname
                play_tally = G.GAME.hands[handname].played
            end
        end
        if most_played_hand then
            SMODS.smart_level_up_hand(card, most_played_hand, false, #G.hand.highlighted)
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

