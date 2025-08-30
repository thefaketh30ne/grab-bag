SMODS.Joker {
	key = 'fault_line',
	loc_txt = {
		name = 'Fault Line',
		text = {
            "{X:mult,C:white}X#1#{} Mult if played hand",
            "contains a {C:attention}Stone{} card",
            "{C:attention}Stone{} cards have a",
            "{C:green}#2# in #3#{} chance to be",
            "{C:attention}destroyed{} after scoring"
		}
	},
	config = { extra = { xmult = 3, odds = 2 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 2, y = 6 },
	cost = 6,
	blueprint_compat = true,
    enhancement_gate = "m_stone",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { card.ability.extra.xmult, new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
	    if context.joker_main then
            for _, playing_card in ipairs(context.scoring_hand) do
                if SMODS.has_enhancement(playing_card, "m_stone") then
                    return {
                        xmult = card.ability.extra.xmult
                    }
                end
            end
        end
        if context.destroy_card
        and context.cardarea == G.play
        and SMODS.has_enhancement(context.destroy_card, "m_stone")
        and SMODS.pseudorandom_probability(card, 'gb_fault_line', 1, card.ability.extra.odds) then
            return {
                remove = true
            }
        end
    end
}