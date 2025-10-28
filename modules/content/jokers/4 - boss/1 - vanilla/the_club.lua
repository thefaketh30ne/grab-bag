SMODS.Joker{
    key = "club",
    loc_txt = {
		name = 'The Club',
		text = {
            "{C:clubs}Club{} cards give",
            "{C:money}$#1#{} when scored",
            "{V:1}#2#{} cards are {C:attention}debuffed",
            "{C:inactive}(Changes at end of round)",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 2, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { dollars = 2, debuffed_suit = "Hearts" } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.gb_club_card or {}).suit or 'Spades'
        return { vars = { 
            card.ability.extra.dollars,
            localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] }
        } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            card.ability.extra.debuffed_suit = G.GAME.current_round.gb_club_card.suit
        end
        if context.individual
        and context.other_card:is_suit("Clubs")
        and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.dollars,
                message_card = context.other_card
            }
        end
        if context.debuff_card
        and context.debuff_card.area ~= G.jokers
        and context.debuff_card:is_suit(card.ability.extra.debuffed_suit, true) then
            return {
                debuff = true
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.debuffed_suit = G.GAME.current_round.gb_club_card.suit
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_club")
    end
}

function reset_gb_club_card()
    G.GAME.current_round.gb_club_card = { suit = 'Spades' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card)
        and not playing_card:is_suit("Clubs") then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local chosen_card = pseudorandom_element(valid_cards, pseudoseed('gb_club' .. G.GAME.round_resets.ante))
    if chosen_card then
        G.GAME.current_round.gb_club_card.suit = chosen_card.base.suit
    end
end