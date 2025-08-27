
SMODS.Consumable {
    key = "conceit",
    set = "Hex",
    loc_txt = {
        name = 'Conceit',
        text = {
            "Selected cards",
            "become {C:attention}Ripple{} cards",
            "An equal number of cards",
            "in {C:attention}full deck{} become {C:attention}Egoistic"
        }
    },
    config = { mod_conv = 'm_gb_ripple' },
    atlas = 'gb_HexCards',
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, card)
    end,
    use = function(self, card, area, copier)
        gb_apply_hex(G.deck.cards, "s_gb_egoistic", #G.hand.highlighted)
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted > 0
    end
}
