SMODS.Enhancement {
    key = 'hunger',
    loc_txt = {
		name = 'Hunger Card',
		text = {
			"If scoring, {C:attention}destroys{} another",
            "random played card and",
            "gains {C:attention}a tenth{} of its",
            "base {C:chips}Chips{} as {X:mult,C:white}XMult{}",
		}
	},
    atlas = 'gb_Enhancements',
    pos = { x = 7, y = 0 },
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            local valid_cards = {}
            for _, playing_card in ipairs(context.full_hand) do
                if not SMODS.has_no_rank(playing_card)
                and not SMODS.has_enhancement(playing_card, 'm_gb_hunger')
                and not playing_card.ability.gb_hunger_destroy
                and not playing_card ~= card then
                    valid_cards[#valid_cards + 1] = playing_card
                end
            end
            if next(valid_cards) then
                local chosen_card = pseudorandom_element(valid_cards, pseudoseed("gb_hunger") + card.sort_id)
                chosen_card.ability.gb_hunger_destroy = card.sort_id
            end
        end
        if context.destroy_card and context.destroy_card.ability.gb_hunger_destroy == card.sort_id then
            context.destroy_card.ability.gb_hunger_destroy = nil
            card.ability.perma_x_mult = (card.ability.perma_x_mult or 0) + context.destroy_card.base.nominal * 0.1
            return {
                remove = true,
                message = localize("k_upgrade_ex"),
                colour = G.C.MULT
            }
        end
    end,
    in_pool = function(self, args)
        return false
    end
}