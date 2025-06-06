SMODS.Joker {
    key = 'candle',
    loc_txt = {
        name = 'Candle',
        text = {
            "For the next {C:attention}#1#{} rounds, the first",
            "scoring card of the round",
            "gains a random {C:attention}Seal{}",
        }
    },
    config = { extra = { rounds_left = 5 } },
    rarity = 2,
    cost = 6,
    blueprint_compat = false,
    
    atlas = 'gb_Jokers',
    pos = { x = 6, y = 4 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.rounds_left } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and not context.blueprint then
            context.scoring_hand[1]:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'gb_candle' }))
            context.scoring_hand[1]:juice_up()
            card.ability.extra.rounds_left = card.ability.extra.rounds_left - 1
            if card.ability.extra.rounds_left > 0 then
                return {
                    message = card.ability.extra.rounds_left .. '',
                    colour = G.C.FILTER
                }
            else
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
                    message = 'Melted!',
                    colour = G.C.FILTER
                }
            end
        end
    end
}