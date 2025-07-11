SMODS.Joker{
    key = "weave",
    loc_txt = {
		name = 'The Weave',
		text = {
			"Cards give {C:money}$#1#{} when scored",
            "if played hand contains",
            "{C:attention}#2# or fewer{} cards",

		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 6, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { dollars = 2, cards_played = 3 } },
    loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars, card.ability.extra.cards_played } }
	end,
    calculate = function(self, card, context)
        if context.individual 
        and #context.full_hand <= card.ability.extra.dollars.cards_played 
        and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars
            }
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_weave")
    end
}