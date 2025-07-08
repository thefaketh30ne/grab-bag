SMODS.Joker{
    key = "window",
    loc_txt = {
		name = 'The Window',
		text = {
            "{C:diamonds}Heart{} cards retrigger {C:attention}#1#{} time",
            "{V:1}#2#{} cards are {C:attention}debuffed",
            "{C:inactive}(Changes at end of round)",
		}
	},
    blueprint_compat = false,
	atlas = 'gb_BossJokers',
	pos = { x = 3, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.gb_window_card or {}).suit or 'Spades'
        return { vars = { 
            card.ability.extra.retriggers,
            localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] }
        } }
    end,
    calculate = function(self, card, context)
        if context.repetition
        and not context.other_card.debuff
        and context.other_card:is_suit("Diamonds") then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
            return {
                repetitons = card.ability.extra.retriggers,
            }
        end
        if context.debuff_card 
        and context.debuff_card.area ~= G.jokers
        and context.other_card:is_suit(G.GAME.current_round.gb_window_card.suit) then
            return {
                debuff = true
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_window")
    end
}

function reset_gb_window_card()
    G.GAME.current_round.gb_window_card = { suit = 'Spades' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card)
        and not playing_card:is_suit("Spades") then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local chosen_card = pseudorandom_element(valid_cards,
        'gb_window' .. G.GAME.round_resets.ante)
    if chosen_card then
        G.GAME.current_round.gb_window_card.suit = chosen_card.base.suit
    end
end