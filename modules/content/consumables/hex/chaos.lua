SMODS.Consumable {
    key = "chaos",
    set = "Hex",
    loc_txt = {
        name = 'Chaos',
        text = { {
            "Selected cards gain",
            "a random {C:attention}Hex Enhancement{}",
        },
        {
            "An equal number of cards",
            "in {C:attention}full deck{} gain",
            "a random {C:attention}Curse"
        } }
    },
    atlas = 'gb_HexCards',
    pos = { x = 5, y = 0 },
    use = function(self, card, area, copier)
        local enhancement_keys = {
            "ripple",
            "rotten",
            "macabre",
            "chained",
            "ashen",
            "alloyed"
        }
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
                    local chosen_enhancement = pseudorandom_element(enhancement_keys, pseudoseed("gb_chaos"))
                    chosen_enhancement = "m_gb_" .. chosen_enhancement
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS[chosen_enhancement])
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
                for i = 1, #G.hand.highlighted do
                    gb_apply_hex(
                        G.playing_cards,
                        pseudorandom_element(GB.HEX_KEYS, "gb_chaos_hexes"),
                        1
                    )
                end
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