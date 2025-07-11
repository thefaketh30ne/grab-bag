SMODS.Joker{
    key = "spirit",
    loc_txt = {
		name = 'The Spirit',
		text = {
			"When hand is played, {C:attention}flips{} all",
            "{C:attention}face-up{} {C:spades}Spades{} and {C:clubs}Clubs{} held in hand",
            "Cards flipped by this Joker",
            "{C:attention}permanently{} gain {C:chips}+#1#{} Chips",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 3, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { chips = 20 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    calculate = function(self, card, context)
        if context.before then
            for _, playing_card in ipairs(G.hand.cards) do
                if (playing_card:is_suit("Spades")
                or playing_card:is_suit("Clubs"))
                and not context.blueprint
                and playing_card.facing == "front" then
                    playing_card.ability.perma_bonus = (playing_card.ability.perma_bonus or 0) + card.ability.extra.chips
                    playing_card:flip()
                    SMODS.calculate_effect( {
                        message = localize('k_upgrade_ex'),
                        message_card = playing_card,
                        colour = G.C.CHIPS
                    }, card)
                end
            end
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_spirit")
    end
}