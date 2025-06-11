SMODS.Joker {
	key = 'wax_joker',
	loc_txt = {
		name = 'Wax Joker',
		text = {
            "Earn {C:money}$#1#{} when a card",
            "with any {C:attention}Seal{} scores",
		}
	},
	config = { extra = { dollars = 2 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 0, y = 3 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            context.other_card.seal then
            return {
                dollars = card.ability.extra.dollars
			}
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card.seal then
                return true
            end
        end
        return false
    end
}