SMODS.Consumable {
    key = "conceit",
    set = "Hex",
    loc_txt = {
        name = 'Conceit',
        text = {
            "Selected cards",
            "become {C:attention}#1#{} cards",
            "An equal number of cards",
            "in {C:attention}full deck{} become {C:attention}#2#"
        }
    },
    config = {extra = { mod_conv = 'm_gb_ripple', hex_to_apply = "egoistic"}},
    atlas = 'gb_HexCards',
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.config.extra.mod_conv]
        info_queue[#info_queue + 1] = GB.hex_tooltip(card.config.extra.hex_to_apply)
        return { vars = { 
            localize { type = 'name_text', set = 'Enhanced', key = card.config.extra.mod_conv },
            localize { type = 'name_text', set = 'Hex', key = "gb_" .. card.config.extra.hex_to_apply .. "_hex" },
        } }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[card.config.extra.mod_conv])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        gb_apply_hex(G.deck.cards, card.config.extra.hex_to_apply, #G.hand.highlighted)
        delay(0.5)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0
    end
}
