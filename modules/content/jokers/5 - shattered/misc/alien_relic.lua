SMODS.Joker {
    key = "alien_relic",
    loc_txt = {
		name = 'Alien Relic',
		text = {
			{"Played {V:1}#4#{} give",
            "{X:mult,C:white}X#1#{} Mult when played"},
            {"Played {C:attention}#3#s{} give",
            "{X:mult,C:white}X#2#{} Mult when played"}
		}
	},
    blueprint_compat = true,
	atlas = 'gb_ShatteredJokers',
	pos = { x = 4, y = 2 },
    rarity = "gb_shattered",
    cost = 10,
    config = { extra = { suit_xmult = 1.5, rank_xmult = 1.75 } },
    loc_vars = function(self, info_queue, card)
        local idol_card = G.GAME.current_round.idol_card or { rank = 'Ace', suit = 'Spades' }
        return { vars = { card.ability.extra.suit_xmult, card.ability.extra.rank_xmult, localize(idol_card.rank, 'ranks'), localize(idol_card.suit, 'suits_plural'), colours = { G.C.SUITS[idol_card.suit] } } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            local current_x_mult = 1
            if context.other_card:get_id() == G.GAME.current_round.idol_card.id then
                current_x_mult = current_x_mult * card.ability.extra.rank_xmult
            end
            if context.other_card:is_suit(G.GAME.current_round.idol_card.suit) then
                current_x_mult = current_x_mult * card.ability.extra.suit_xmult
            end
            return {
                xmult = current_x_mult
            }
        end
    end
}