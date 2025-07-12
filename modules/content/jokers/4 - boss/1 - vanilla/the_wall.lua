SMODS.Joker{
    key = "wall",
    loc_txt = {
		name = 'The Wall',
		text = {
			"{C:red}X#1#{C:attention} Boss Blind{} size",
            "{C:attention}+#2#{} hand size",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 2, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { boss_blind_size = 2, hand_size = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.boss_blind_size, card.ability.extra.hand_size } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.boss_blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            play_sound("cancel")
            card:juice_up()
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_wall")
    end
}