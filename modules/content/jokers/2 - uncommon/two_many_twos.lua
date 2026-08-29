SMODS.Joker {
    key = 'two_many_twos',
	loc_txt = {
		name = 'Two Many Twos',
		text = {
			"Every {C:attention}#3#{}nd scored {C:attention}2{}",
            "gives {X:mult,C:white}X#1#{} Mult",
            "{C:inactive}({C:attention}#2#{C:inactive}/#3#)"
		}
	},
    config = { extra = { x_mult = 2, counter = 0, threshold = 2 } },
    rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 7 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.counter, card.ability.extra.threshold } }
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and context.other_card:get_id() == 2 then
            card.ability.extra.counter = card.ability.extra.counter + 1
            if card.ability.extra.counter >= 2 then
                card.ability.extra.counter = 0
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end
}