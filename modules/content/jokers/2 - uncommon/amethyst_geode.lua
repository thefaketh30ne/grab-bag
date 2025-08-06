SMODS.Joker {
	key = 'amethyst_geode',
	loc_txt = {
		name = 'Amethyst Geode',
		text = {
            "Played cards with",
            "{C:gb_eyes}Eyes{} suit retrigger",
            "{C:attention}#1#{} time when scored",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 1, y = 6 },
	cost = 6,
	blueprint_compat = true,
    config = { extra = { retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retriggers } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and
            context.other_card:is_suit("gb_Eyes") then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_suit_in_deck(suit_key)
    end
}
