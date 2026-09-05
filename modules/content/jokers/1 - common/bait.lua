SMODS.Joker{
    key = 'bait',
    loc_txt = {
        name = 'Bait',
        text = {
            "{C:mult}+#1#{} Mult",
            "{C:green}#2# in #3#{} chance at",
            "end of round to",
            "{C:attention}reel something in{}",
        }
    },
    config = { extra = { odds = 6, mult = 8 } },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = false,
    atlas = 'gb_Jokers',
    pos = { x = 7, y = 4 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { card.ability.extra.mult, new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            } 
        end
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if SMODS.pseudorandom_probability(card, 'gb_bait', 1, card.ability.extra.odds) then
                SMODS.add_card{
                    set = 'Joker',
                    key = "j_gb_hadal_zone",
                    edition = (card.edition and card.edition.key) or nil
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