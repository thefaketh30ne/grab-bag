SMODS.Joker {
    key = "rainbow_road",
    loc_txt = {
		name = 'Rainbow Road',
		text = {
			"{C:attention}Wild Cards{} have a",
            "{C:green}#1# in #2# chance{} to {C:attention}level up",
            "played {C:attention}poker hand{} when played"
		}
	},
    blueprint_compat = true,
    atlas = 'Jokers',
    rarity = 3,
    cost = 7,
    pos = { x = 7, y = 9 },
    config = { extra = { odds = 4 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'gb_rainbow_road')
        return { vars = { numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.before then
            for _, playing_card in ipairs(context.full_hand) do
                if SMODS.has_enhancement(playing_card, "m_wild") then
                    if SMODS.pseudorandom_probability(card, 'gb_rainbow_road', 1, card.ability.extra.odds) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:juice_up()
                                return true
                            end
                        }))
                        return {
                            level_up = true,
                            message = localize('k_level_up_ex')
                        }
                    end
                end
            end
        end
    end
}
