SMODS.Joker{
    key = "head",
    loc_txt = {
		name = 'The Head',
		text = {
            "{C:hearts}Heart{} cards {C:attention}permanently",
            "gain {C:chips}+#1#{} Chips when scored",
            "{V:1}#2#{} cards are {C:attention}debuffed",
            "{C:inactive}(Changes at end of round)",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 1, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { chips = 20, debuffed_suit = "Spades" } },
    loc_vars = function(self, info_queue, card)
        local suit = (G.GAME.current_round.gb_head_card or {}).suit or 'Spades'
        return { vars = { 
            card.ability.extra.chips,
            localize(suit, 'suits_singular'),
            colours = { G.C.SUITS[suit] }
        } }
    end,
    calculate = function(self, card, context)
        if context.ending_shop then
            card.ability.extra.debuffed_suit = G.GAME.current_round.gb_head_card.suit
        end
        if context.individual
        and context.other_card:is_suit("Hearts") 
        and context.cardarea == G.play then
            context.other_card.ability.perma_bonus = (context.other_card.ability.perma_bonus or 0) + card.ability.extra.chips
            return {
                message = localize('k_upgrade_ex'),
                message_card = context.other_card,
                colour = G.C.CHIPS
            }
        end
        if context.debuff_card
        and context.debuff_card.area ~= G.jokers
        and context.debuff_card:is_suit(card.ability.extra.debuffed_suit) then
            return {
                debuff = true
            }
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        card.ability.extra.debuffed_suit = G.GAME.current_round.gb_head_card.suit
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_head")
    end
}

function reset_gb_head_card()
    G.GAME.current_round.gb_head_card = { suit = 'Spades' }
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card)
        and not playing_card:is_suit("Hearts") then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local chosen_card = pseudorandom_element(valid_cards, pseudoseed('gb_head' .. G.GAME.round_resets.ante))
    if chosen_card then
        G.GAME.current_round.gb_head_card.suit = chosen_card.base.suit
    end
end