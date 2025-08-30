SMODS.Consumable {
    key = "blasphemy",
    set = "Hex",
    loc_txt = {
        name = 'Blasphemy',
        text = {
            "Selected cards",
            "gain a random {C:attention}Seal",
            "and become {C:attention}Inflexible",
        },
    },
    config = { extra = { hex_to_apply = "inflexible" } },
    atlas = 'gb_HexCards',
    pos = { x = 7, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = GB.hex_tooltip(card.ability.extra.hex_to_apply)
    end,
    use = function(self, card, area, copier)
        for _, playing_card in ipairs(G.hand.highlighted) do
            playing_card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'gb_candle' }))
            GB.set_hex(playing_card, "inflexible")
            playing_card:juice_up()
        end
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0
    end
}

