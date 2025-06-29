SMODS.Joker{
    key = "little_timbo",
    loc_txt = {
        name = 'Little Timbo',
		text = {
			"{C:attention}#1#X{} Blind size",
            "{C:red}#2#{} Joker slot",
		}
    },
    config = { extra = { blind_size = 0.5, joker_slot = -1 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 2, y = 0 },
	cost = 6,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.blind_size, card.ability.extra.joker_slot } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            play_sound("cancel")
            card:juice_up()
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + card.ability.extra.joker_slot
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - card.ability.extra.joker_slot
    end
}