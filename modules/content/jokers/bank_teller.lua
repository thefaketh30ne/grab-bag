SMODS.Joker{
    key = 'bank_teller',
    loc_txt = {
        name = 'Bank Teller',
        text = {
            "Earn {C:money}$#1#{} at end of round",
            "Payout decreases by {C:money}$#2#{} for every",
            "card purchased in the shop"
        }
    },
    config = { extra = { dollars = 10, dollars_mod = 1 } },
    rarity = 2,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = false,
    atlas = 'Jokers',
    pos = { x = 5, y = 0 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars_mod } }
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card ~= card then
			card.ability.extra.dollars = card.ability.extra.dollars - card.ability.extra.dollars_mod
            if card.ability.extra.dollars <= 0 then
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
                    message = 'Bankrupt!'
                }
            else
                return {
                    message = 'Downgraded!',
                    colour = G.C.MONEY
                }
            end
        end
    end
}