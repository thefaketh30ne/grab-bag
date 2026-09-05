SMODS.Consumable {
    key = "hunger",
    set = "Hex",
    loc_txt = {
        name = 'Hunger',
        text = {
            "Create {C:attention}Ravenous{} copies",
            "of all selected cards"
        },
    },
    config = { extra = { hex_to_apply = "ravenous" } },
    atlas = 'gb_HexCards',
    pos = { x = 1, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = GB.hex_tooltip(card.ability.extra.hex_to_apply)
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            func = function()
                local first_dissolve = nil
                local new_cards = {}
                for i = 1, #G.hand.highlighted do
                    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                    local copy_card = copy_card(G.hand.highlighted[i], nil, nil, G.playing_card)
                    copy_card:add_to_deck()
                    GB.set_hex(copy_card, card.ability.extra.hex_to_apply)
                    G.deck.config.card_limit = G.deck.config.card_limit + 1
                    table.insert(G.playing_cards, copy_card)
                    G.hand:emplace(copy_card)
                    copy_card:start_materialize(nil, first_dissolve)
                    first_dissolve = true
                    new_cards[#new_cards + 1] = copy_card
                end
                SMODS.calculate_context({ playing_card_added = true, cards = new_cards })
                return true
            end
        }))
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0
    end
}