SMODS.Joker {
	key = 'o5_keycard',
	loc_txt = {
		name = 'O5 Keycard',
		text = {
			"{C:attention}5{}s give {C:money}$#1#{} when scored",
            "{C:red}Cannot{} play {C:attention}2{}s, {C:attention}3{}s or {C:attention}4{}s",
		}
	},
	rarity = 2,
	atlas = 'Jokers',
    config = { extra = { dollars = 5 } },
	pos = { x = 6, y = 9 },
	cost = 7,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and context.other_card:get_id() == 5 then
            return {
                dollars = card.ability.extra.dollars
            }
        end
        if context.debuff_hand then
            for _, playing_card in ipairs(context.full_hand) do
                if playing_card:get_id() >= 2
                and playing_card:get_id() <= 4 then
                    return {
                    debuff = true,
                    debuff_text = "Cannot play 2s, 3s or 4s"
                    }
                end
            end
        end
    end
}