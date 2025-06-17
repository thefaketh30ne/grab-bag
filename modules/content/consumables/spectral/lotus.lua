SMODS.Consumable {
    key = 'lotus',
    loc_txt = {
        name = "Lotus",
        text = {
            "Add an {V:1}Infinite Seal{}",
            "to {C:attention}1{} selected",
            "card in your hand",
        },
    },
    set = 'Spectral',
    atlas = 'gb_Consumables',
    pos = { x = 0, y = 1 },
    config = { extra = { seal = 'gb_infinite' }, max_highlighted = 1 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted, colours = { HEX("A1A5A6") } } }
    end,
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}