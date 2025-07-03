SMODS.Booster {
    key = "ephemeral_small_1",
    loc_txt = {
        name = "Ephemeral Pack",
        group_name = "Ephemeral Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Ephemeral{} cards to",
            "be used immediately"
        }
    },
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("8ea4b3")} } }
    end,
    cost = 4,
    atlas = "gb_Boosters",
    weight = 1.5,
    pos = { x = 0, y = 0 },
    draw_hand = false,
    select_card = "consumeables",
    kind = "Ephemeral",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Ephemeral", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("8ea4b3"))
        ease_background_colour({ new_colour = HEX('59778c'), special_colour = HEX("8ea4b3"), contrast = 2 })
    end
}

SMODS.Booster {
    key = "ephemeral_small_2",
    loc_txt = {
        name = "Ephemeral Pack",
        group_name = "Ephemeral Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Ephemeral{} cards to",
            "be used immediately"
        }
    },
    config = { extra = 3, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("8ea4b3")} } }
    end,
    cost = 4,
    atlas = "gb_Boosters",
    weight = 1.5,
    pos = { x = 1, y = 0 },
    draw_hand = false,
    select_card = "consumeables",
    kind = "Ephemeral",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Ephemeral", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("8ea4b3"))
        ease_background_colour({ new_colour = HEX('59778c'), special_colour = HEX("8ea4b3"), contrast = 2 })
    end
}

SMODS.Booster {
    key = "ephemeral_jumbo",
    loc_txt = {
        name = "Jumbo Ephemeral Pack",
        group_name = "Ephemeral Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Ephemeral{} cards to",
            "be used immediately"
        }
    },
    config = { extra = 5, choose = 1 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("8ea4b3")} } }
    end,
    cost = 6,
    atlas = "gb_Boosters",
    weight = 0.5,
    pos = { x = 2, y = 0 },
    draw_hand = false,
    select_card = "consumeables",
    kind = "Ephemeral",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Ephemeral", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("8ea4b3"))
        ease_background_colour({ new_colour = HEX('59778c'), special_colour = HEX("8ea4b3"), contrast = 2 })
    end
}

SMODS.Booster {
    key = "ephemeral_mega",
    loc_txt = {
        name = "Mega Ephemeral Pack",
        group_name = "Ephemeral Pack",
        text = {
            "Choose {C:attention}#1#{} of up to",
            "{C:attention}#2# {V:1}Ephemeral{} cards to",
            "be used immediately"
        }
    },
    config = { extra = 5, choose = 2 },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra, colours = {HEX("8ea4b3")} } }
    end,
    cost = 8,
    atlas = "gb_Boosters",
    weight = 0.2,
    pos = { x = 3, y = 0 },
    draw_hand = false,
    select_card = "consumeables",
    kind = "Ephemeral",
    create_card = function(self, card, i)
        return SMODS.create_card({set = "Ephemeral", skip_materialize = true, area = G.pack_cards})
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("8ea4b3"))
        ease_background_colour({ new_colour = HEX('59778c'), special_colour = HEX("8ea4b3"), contrast = 2 })
    end
}