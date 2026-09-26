SMODS.Joker {
    key = 'metro_lines',
	loc_txt = {
		name = 'Metro Lines',
		text = {
            "Any {C:attention}#1#{} cards with",
            "different ranks are",
            "considered a {C:attention}Straight"
		}
	},
	blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 2, y = 2 },
    rarity = "gb_shattered",
    config = { extra = { card_amount = 5, active = false } },
    cost = 10,
    loc_vars = function(self, info_queue, card)
        card.ability.extra.card_amount = SMODS.four_fingers()
        return { vars = { card.ability.extra.card_amount } }
	end,
    calculate = function(self, card, context)
        if context.evaluate_poker_hand then
            card.ability.extra.card_amount = SMODS.four_fingers()
            local ranks = {}
            for _, playing_card in ipairs(context.full_hand) do
                ranks[#ranks + 1] = playing_card:get_id()
            end
            local duplicate = false
            -- exhausts all possible pairs in ranks
            for a_index = 1, #ranks - 1 do
                for b_index = a_index + 1, #ranks do
                    if ranks[a_index] == ranks[b_index]
                    and a_index ~= b_index then
                        duplicate = true
                        break
                    end
                end
            end
            if duplicate == false
            and #context.full_hand >= SMODS.four_fingers("straight") then
                card.ability.extra.active = true
                return {
                    replace_scoring_name = "Straight"
                }
            else
                card.ability.extra.active = false
            end
        end
        if context.modify_scoring_hand and card.ability.extra.active then
            return {
                add_to_hand = true
            }
        end
    end
}