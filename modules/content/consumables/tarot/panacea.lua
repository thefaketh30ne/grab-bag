SMODS.Consumable {
    key = 'panacea',
    set = 'Tarot',
    atlas = "gb_Consumables",
    pos = { x = 3, y = 0 },
    config = { max_highlighted = 2, mod_conv = 'm_gb_honey' },
    loc_txt = {
        name = "The Panacea",
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