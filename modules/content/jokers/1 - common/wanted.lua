SMODS.Joker{
    key = "wanted",
    loc_txt = {
        name = 'Wanted',
		text = {
            "Earn {C:money}$#1#{} if played hand",
            "contains a scoring {C:attention}#2#",
            "{C:inactive}(Resets every trigger)"
		}
    },
    config = { extra = { rank = "Ace", id = 14, money = 4 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 3, y = 1 },
	cost = 4,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, localize((card.ability.extra.rank or 'Ace'), "ranks") } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint then
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == card.ability.extra.id then
                    card.ability.extra.rank, card.ability.extra.id = reroll_gb_wanted_rank()
                    return {
                        dollars = card.ability.extra.money,
                    }
                end
            end
        end
    end
}

function reroll_gb_wanted_rank()
    local returned_rank = "Ace"
    local returned_id = 14
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local chosen_card = pseudorandom_element(valid_cards, pseudoseed('gb_wanted' .. G.GAME.round_resets.ante))
    if chosen_card then
        returned_rank = chosen_card.base.value
        returned_id = chosen_card.base.id
    end
    return returned_rank, returned_id
end