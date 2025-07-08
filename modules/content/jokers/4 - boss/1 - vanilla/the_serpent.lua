SMODS.Joker{
    key = "serpent",
    loc_txt = {
		name = 'The Serpent',
		text = {
            "{C:attention}+#1#{} hand size",
            "Always draw {C:attention}#2#{} cards",
            "after {C:blue}Play{} or {C:red}Discard{}"
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 5, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { hand_size = 2, cards_to_draw = 3 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hand_size, card.ability.extra.cards_to_draw } }
    end,
    calculate = function(self, card, context)
        if context.drawing_cards 
        and (G.GAME.current_round.hands_played ~= 0
        or G.GAME.current_round.discards_used ~= 0)
        and not context.blueprint then
            return {
                cards_to_draw = card.ability.extra.cards_to_draw
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_serpent")
    end
}        