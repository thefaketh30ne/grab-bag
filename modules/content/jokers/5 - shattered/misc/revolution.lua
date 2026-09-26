SMODS.Joker {
    key = 'revolution',
	loc_txt = {
		name = 'Revolution',
		text = {
            "The lowest ranked card",
            "{C:attention}held in hand{} gives {C:attention}half",
            "its base {C:chips}Chips{} as {X:mult,C:white}XMult{}"
		}
	},
	blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 6, y = 1 },
    rarity = "gb_shattered",
    cost = 10,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round then
            local nominal, id = 15, 15
            local raised_card = nil
            for i = 1, #G.hand.cards do
                if id >= G.hand.cards[i].base.id and not SMODS.has_no_rank(G.hand.cards[i]) then
                    nominal = G.hand.cards[i].base.nominal
                    id = G.hand.cards[i].base.id
                    raised_card = G.hand.cards[i]
                end
            end
            if raised_card == context.other_card then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED
                    }
                else
                    return {
                        xmult = 0.5 * nominal
                    }
                end
            end
        end
    end
}