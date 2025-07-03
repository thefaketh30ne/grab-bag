SMODS.Joker {
    key = 'lure',
    loc_txt = {
        name = 'Lure',
        text = {
            "{X:mult,C:white}X#1#{} Mult",
            "{C:green}#2# in #3#{} chance at end of round to",
            "{C:attention}reel something in{}",
        }
    },
    config = { extra = { xmult = 1.5, odds = 6 } },
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 0, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom('gb_lure') < G.GAME.probabilities.normal / card.ability.extra.odds then
                SMODS.add_card{
                    set = 'Joker',
                    key = "j_gb_lovecraftian_horror",
                    no_edition = true
                }
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
                    message = 'Caught!',
                    colour = G.C.FILTER
                }
            end
        end
    end,
}