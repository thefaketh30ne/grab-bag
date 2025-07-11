SMODS.Joker{
    key = "psychic",
    loc_txt = {
		name = 'The Psychic',
		text = {
			"The {C:attention}fifth{} scoring card has a",
            "{C:green}#1# in #2# chance{} to convert into",
            "the {C:attention}first{} scoring card"
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 0, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { 
            G.GAME.probabilities.normal or 1,
            card.ability.extra.odds
        } }
    end,

    calculate = function(self, card, context)
        if context.before
        and context.scoring_hand[5]
        and not context.blueprint
        and SMODS.pseudorandom_probability(card, 'gb_psychic', G.GAME.probabilities.normal, card.ability.extra.odds) then
            copy_card(context.scoring_hand[1], context.scoring_hand[5])
            context.scoring_hand[5]:juice_up()
            return {
                message = "Converted!",
                colour = G.C.FILTER
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_psychic")
    end
}