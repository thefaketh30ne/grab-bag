SMODS.Joker {
	key = 'black_book',
	loc_txt = {
		name = 'Black Book',
		text = {
            "{C:mult}+#1#{} Mult if there are",
			"no {C:attention}#2#s{} held in hand"
		}
	},
	config = { extra = { mult = 12 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 5, y = 8 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize((G.GAME.current_round.gb_black_book_card or {}).rank or 'Ace', 'ranks') } }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			for _, playing_card in ipairs(G.hand.cards) do
            	if playing_card:get_id() == G.GAME.current_round.gb_black_book_card.id then
					return
				end
			end
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

function reset_gb_black_book_rank()
    G.GAME.current_round.gb_gb_black_book_card = { rank = 'Ace' }
    local valid_black_book_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_black_book_cards[#valid_black_book_cards + 1] = playing_card
        end
    end
    local black_book_card = pseudorandom_element(valid_black_book_cards, 'gb_black_book' .. G.GAME.round_resets.ante)
    if black_book_card then
        G.GAME.current_round.gb_black_book_card.rank = black_book_card.base.value
        G.GAME.current_round.gb_black_book_card.id = black_book_card.base.id
    end
end