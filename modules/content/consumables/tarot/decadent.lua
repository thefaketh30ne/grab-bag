SMODS.Consumable {
    key = 'decadent',
    set = 'Tarot',
    atlas = "gb_Consumables",
    pos = { x = 2, y = 2 },
    config = { max_highlighted = 1, mod_conv = 'm_gb_cake' },
    loc_txt = {
        name = "The Decadent",
        text = {
            "Enhances {C:attention}#1#{}",
            "selected card to a",
            "{C:attention}#2#",
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}