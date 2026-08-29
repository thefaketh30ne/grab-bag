SMODS.Joker {
    key = 'exclusion_principle',
	loc_txt = {
		name = 'Exclusion Principle',
		text = {
            "{X:mult,C:white}X#1#{} Mult if no two",
            "played cards have the",
            "same {C:attention}rank{} and {C:attention}base suit"
		}
	},
    config = { extra = { x_mult = 2 } },
    rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 1, y = 9 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local suits_and_ranks = {}
            for _, playing_card in ipairs(context.full_hand) do
                suits_and_ranks[#suits_and_ranks + 1] = { playing_card:get_id(), playing_card.base.suit }
            end
            local duplicate = false
            -- exhausts all possible pairs in suits_and_ranks
            for a_index = 1, #suits_and_ranks - 1 do
                for b_index = a_index + 1, #suits_and_ranks do
                    if suits_and_ranks[a_index][1] == suits_and_ranks[b_index][1]
                    and suits_and_ranks[a_index][2] == suits_and_ranks[b_index][2]
                    and a_index ~= b_index then
                        duplicate = true
                    end
                end
            end
            if duplicate == false then
                return {
                    xmult = card.ability.extra.x_mult
                }
            end
        end
    end
}