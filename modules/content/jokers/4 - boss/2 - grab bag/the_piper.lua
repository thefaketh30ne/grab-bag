SMODS.Joker{
    key = "piper",
    loc_txt = {
		name = 'The Piper',
		text = {
			"After hand scores, {C:green}#1# in #2# chance{} to",
            "{C:attention}destroy{} the {C:attention}leftmost{} card and",
            "give a {C:attention}third{} of its base {C:chips}Chips{} as {C:money}Money{}"
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 5, y = 2 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { odds = 2 } },
    loc_vars = function(self, info_queue, card)
		local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return { vars = { new_numerator, new_denominator } }
	end,
    calculate = function(self, card, context)
        if context.before
        and context.scoring_hand[1]
        and not context.blueprint
        and SMODS.pseudorandom_probability(card, 'gb_piper', 1, card.ability.extra.odds) then
            context.scoring_hand[1].ability.piper_destroy = true
        end
        if context.destroy_card and 
        context.destroy_card.ability.piper_destroy == true 
        and not context.blueprint then
            if not SMODS.has_no_rank(context.destroy_card)
            and context.destroy_card.base.nominal
            and context.destroy_card.base.nominal > 0 then
                context.destroy_card.getting_sliced = true
                return {
                    remove = true,
                    dollars = math.floor(context.destroy_card.base.nominal / 3)
                }
            end
            return {
                remove = true
            }
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_gb_piper")
    end
}