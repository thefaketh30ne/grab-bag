SMODS.Joker{
    key = "Triforce",
    loc_txt = {
        name = 'Triforce',
		text = {
            "{X:mult,C:white}X#1#{} Mult if played hand",
            "is a {C:attention}Three of a Kind",
            "with {C:attention}#2#{} different suits"
		}
    },
    config = { extra = { xmult = 3, suits = 3 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 6, y = 5 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.suits } }
    end,
    calculate = function(self, card, context)
        if context.joker_main 
        and context.scoring_name == "Three of a Kind"
        and gb_count_suits(context.scoring_hand) == card.ability.extra.suits then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end
}