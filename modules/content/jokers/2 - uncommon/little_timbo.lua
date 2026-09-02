SMODS.Joker{
    key = "little_timbo",
    loc_txt = {
        name = 'Little Timbo',
		text = {
			"{C:attention}#1#X{} Blind size",
            "{C:red}#2#{} Joker slot",
		}
    },
    config = { extra = { x_blind_size = 0.5, joker_slot = -1 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 2, y = 0 },
	cost = 6,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_blind_size, card.ability.extra.joker_slot } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            return {
                xblindsize = card.ability.extra.x_blind_size
            }
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slot
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slot
    end
}