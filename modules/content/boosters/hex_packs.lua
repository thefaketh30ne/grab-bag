
SMODS.Booster {
    key = "hex_small_1",
    loc_txt = {
        name = "Hex Pack",
        group_name = "Hex Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Hex{} cards to",
            "use immediately"
        }
    },
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("9493aa")} } }
    end,
    cost = 5,
    atlas = "gb_Boosters",
    weight = 1.0,
    pos = { x = 0, y = 1 },
    draw_hand = true,
    kind = "Hex",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Hex", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("9493aa"))
        ease_background_colour({ new_colour = HEX('4f5767'), special_colour = HEX("9493aa"), contrast = 2 })
    end
}

SMODS.Booster {
    key = "hex_small_2",
    loc_txt = {
        name = "Hex Pack",
        group_name = "Hex Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Hex{} cards to",
            "use immediately"
        }
    },
    config = { extra = 2, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("9493aa")} } }
    end,
    cost = 5,
    atlas = "gb_Boosters",
    weight = 1.0,
    pos = { x = 1, y = 1 },
    draw_hand = true,
    kind = "Hex",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Hex", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("9493aa"))
        ease_background_colour({ new_colour = HEX('4f5767'), special_colour = HEX("9493aa"), contrast = 2 })
    end
}

SMODS.Booster {
    key = "hex_jumbo",
    loc_txt = {
        name = "Jumbo Hex Pack",
        group_name = "Hex Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Hex{} cards to",
            "use immediately"
        }
    },
    config = { extra = 4, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("9493aa")} } }
    end,
    cost = 7,
    atlas = "gb_Boosters",
    weight = 0.3,
    pos = { x = 2, y = 1 },
    draw_hand = true,
    kind = "Hex",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Hex", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("9493aa"))
        ease_background_colour({ new_colour = HEX('4f5767'), special_colour = HEX("9493aa"), contrast = 2 })
    end
}

SMODS.Booster {
    key = "hex_mega",
    loc_txt = {
        name = "Mega Hex Pack",
        group_name = "Hex Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Hex{} cards to",
            "use immediately"
        }
    },
    config = { extra = 4, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("9493aa")} } }
    end,
    cost = 10,
    atlas = "gb_Boosters",
    weight = 0.1,
    pos = { x = 3, y = 1 },
    draw_hand = true,
    kind = "Hex",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Hex", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("9493aa"))
        ease_background_colour({ new_colour = HEX('4f5767'), special_colour = HEX("9493aa"), contrast = 2 })
    end
}