SMODS.Joker {
    key = 'golden_cookie',
    loc_txt = {
        name = 'Golden Cookie',
        text = {
            "{X:mult,C:white}X#1#{} Mult,",
            "decreases by {X:mult,C:white}X#2#{} Mult",
            "at end of round",
        }
    },
    config = { extra = { xmult = 7, xmult_mod = 1 } },
    rarity = 3,
    atlas = 'gb_Jokers',
    pos = { x = 0, y = 4 },
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult,
            }
        end
        if context.after and not context.blueprint then
            card.ability.extra.xmult = card.ability.extra.xmult - card.ability.extra.xmult_mod
            if card.ability.extra.xmult <= 1 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Eaten!',
                    colour = G.C.FILTER
                }
            else           
                return {
                    message = 'Downgraded!',
                    colour = G.C.FILTER
                }
            end
        end
    end
}