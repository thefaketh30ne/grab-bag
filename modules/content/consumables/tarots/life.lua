SMODS.Consumable {
    key = 'life',
    set = 'Tarot',
    atlas = "Consumables",
    pos = { x = 2, y = 0 },
    config = { max_highlighted = 1, mod_conv = 'm_gb_wooden' },
    loc_txt = {
        name = "Life",
        text = {
            "Enhances {C:attention}#1#{}",
            "selected cards to",
            "{C:attention}#2#s",
        },
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
    end
}