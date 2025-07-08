SMODS.Joker{
    key = "goad",
    loc_txt = {
		name = 'The Goad',
		text = {
            "{C:spades}Spade{} cards give",
            "{C:mult}+#1#{} Mult when scored",
            "{V:1}#2#{} cards are {C:attention}debuffed",
            "{C:inactive}(Changes at end of round)",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 0, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { mult = 10 } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.gb_goad_card or {}).suit or 'Hearts'
        return { vars = { 
            card.ability.extra.mult,
            localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] }
        } }
    end,
    calculate = function(self, card, context)
        if context.individual
        and not context.other_card.debuff
        and context.other_card:is_suit("Spades") then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.debuff_card 
        and context.debuff_card.area ~= G.jokers 
        and context.other_card:is_suit(G.GAME.current_round.gb_goad_card.suit) then
            return {
                debuff = true
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_goad")
    end
}

function reset_gb_goad_card()
    G.GAME.current_round.gb_goad_card = { suit = 'Hearts' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card)
        and not playing_card:is_suit("Spades") then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local chosen_card = pseudorandom_element(valid_cards,
        'gb_goad' .. G.GAME.round_resets.ante)
    if chosen_card then
        G.GAME.current_round.gb_goad_card.suit = chosen_card.base.suit
    end
end
