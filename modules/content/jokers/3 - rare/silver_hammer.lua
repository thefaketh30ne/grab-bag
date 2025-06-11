SMODS.Joker {
	key = 'silver_hammer',
	loc_txt = {
		name = 'Silver Hammer',
		text = {
            "{C:attention}Enhanced Cards{} give {X:mult,C:white}X#1#{} Mult",
            "when scored and have a",
            "{C:green}#3# in #2# chance{} to be {C:attention}destroyed",
		}
	},
	config = { extra = { xmult = 2, odds = 3 } },
	rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 1, y = 0 },
	cost = 8,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.odds, G.GAME.probabilities.normal } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            next(SMODS.get_enhancements(context.other_card)) then
            return {
                xmult = card.ability.extra.xmult
			}
        end
        if context.destroy_card then
			for _, playing_card in ipairs(context.scoring_hand) do
				if pseudorandom('gb_silver_hammer') < G.GAME.probabilities.normal / card.ability.extra.odds and
                context.destroy_card == playing_card and
                next(SMODS.get_enhancements(playing_card)) then
				    return { remove = true }
				end
			end
		end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if next(SMODS.get_enhancements(playing_card)) then
                return true
            end
        end
        return false
    end,
}