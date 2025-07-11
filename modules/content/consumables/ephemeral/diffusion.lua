SMODS.Consumable {
    key = "diffusion",
    set = "Ephemeral",
    loc_txt = {
        name = 'Diffusion',
        text = {
            "Adds {C:dark_edition}Temporary{} copies",
            "of {C:green}#1# in #2#{} cards",
            "in hand to hand",
        }
    },
    config = {extra = { odds = 2 } },
    atlas = 'gb_Ephemerals',
    pos = { x = 6, y = 1 },
    loc_vars = function(self, info_queue, card)
        local new_numerator, new_denominator = SMODS.get_probability_vars(self, 1, card.ability.extra.odds)
        return { vars = { new_numerator, new_denominator } }
    end,
    use = function(self, card, area, copier)
        local eligible_cards = {}
        for _, playing_card in ipairs(G.hand.cards) do
            table.insert(eligible_cards, playing_card)
        end
        for _, v in ipairs(eligible_cards) do
            if SMODS.pseudorandom_probability(blind, 'gb_diffusion', 1, card.ability.extra.odds) then
                G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                local copy_card = copy_card(v, nil, nil, G.playing_card)
                copy_card.playing_card = G.playing_card
                copy_card:add_to_deck()
                G.deck.config.card_limit = G.deck.config.card_limit + 1
                table.insert(G.playing_cards, copy_card)
                copy_card:start_materialize({ G.C.SECONDARY_SET.Enhanced })
                G.hand:emplace(copy_card)
                copy_card:set_edition('e_gb_temporary', true, true)
                SMODS.debuff_card(copy_card, "prevent_debuff", "source")
            end
        end
    end,
    can_use = function(self, card)
        if G.hand and G.GAME.blind.in_blind then
            return true
        else
            return false
        end
    end
}