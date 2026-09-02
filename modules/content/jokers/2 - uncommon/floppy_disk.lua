SMODS.Joker {
	key = 'floppy_disk',
	loc_txt = {
		name = 'Floppy Disk',
		text = {
            "Sell this Joker to {C:attention}duplicate{}",
            "the last {C:attention}#1#{} played cards and",
            "add them to deck"
		}
	},
	rarity = 2,
	atlas = 'Jokers',
    config = { extra = { saved_cards = {}, cards_to_save = 3 } },
    pixel_size = { h = 72 },
	pos = { x = 3, y = 7 },
	cost = 6,
	blueprint_compat = false,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards_to_save } }
    end,
    calculate = function(self, card, context)
        if context.individual
        and context.cardarea == G.play
        and not context.repetition
        and not context.blueprint then
            table.insert(card.ability.extra.saved_cards, context.other_card)
            if #card.ability.extra.saved_cards > card.ability.extra.cards_to_save then
                table.remove(card.ability.extra.saved_cards, 1)
            end
        end
        if context.selling_self and not context.blueprint then
            local copied_cards = {}
            for _, saved_card in ipairs(card.ability.extra.saved_cards) do
                SMODS.copy_card(saved_card, nil, nil, nil, nil, G.deck)
            end
            return {
                message = "Copied " .. #copied_cards .. " Cards!",
                colour = G.C.FILTER
            }
        end
    end
}