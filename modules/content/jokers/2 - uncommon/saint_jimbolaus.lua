SMODS.Joker {
    key = "saint_jimbolaus",
    loc_txt = {
		name = 'Saint Jimbolaus',
		text = {
			"After {C:attention}#1#{} played hands,",
            "create a {C:dark_edition}Negative Perishable",
            "{C:common}Common{} Joker",
            "{C:inactive}({C:attention}#2#{C:inactive}/#1#)"
		}
	},
    blueprint_compat = true,
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    pos = { x = 9, y = 8 },
    config = { extra = { counter = 0, threshold = 12 } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "Perishable", set = 'Other' }
        return { vars = { card.ability.extra.threshold, card.ability.extra.counter } }
    end,
    calculate = function(self, card, context)
        if context.press_play then
            card.ability.extra.counter = card.ability.extra.counter + 1
            if card.ability.extra.counter == card.ability.extra.threshold then
                card.ability.extra.counter = 0
                SMODS.add_card{
                    set = "Joker",
                    rarity = "Common",
                    edition = 'e_negative',
                    key_append = 'gb_saint_jimbolaus',
                    stickers = {"perishable"}
                }
                return {
                    message = "Ho Ho Ho!"
                }
            end
        end
        if context.after then
            message = card.ability.extra.counter .. "/" .. card.ability.extra.threshold
        end
    end
}
