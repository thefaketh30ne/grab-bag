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
        and not context.blueprint then
            table.insert(card.ability.extra.saved_cards, context.other_card)
            if #card.ability.extra.saved_cards > card.ability.extra.cards_to_save then
                table.remove(card.ability.extra.saved_cards, 1)
            end
        end
        if context.selling_self and not context.blueprint then
            local copied_cards = {}
            for _, saved_card in ipairs(card.ability.extra.saved_cards) do
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copy_card = copy_card(saved_card, nil, nil, G.playing_card)
                copy_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy_card)
                G.deck:emplace(copy_card)
                table.insert(copied_cards, copy_card)
            end
            return {
                message = "Copied " .. #copied_cards .. " Cards!",
                colour = G.C.FILTER,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            if #copied_cards > 0 then
                                SMODS.calculate_context({ playing_card_added = true, cards = copied_cards })
                            end
                            return true
                        end
                    }))
                end
            }
        end
    end
}