GB.Hex {
    key = 'unstable_hex',
    atlas = 'gb_Hexes',
    pos = { x = 1, y = 1 },
    badge_colour = HEX("7B3939"),
    loc_txt = {
        name = "Unstable",
        text = {
            "When played, debuff",
            "another scoring card"
        },
        label = "Unstable",
    },
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            local eligible_cards = {}
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card ~= card and not playing_card.debuff then
                    eligible_cards[#eligible_cards + 1] = playing_card
                end
            end
            if #eligible_cards > 0 then
                local chosen_card = pseudorandom_element(eligible_cards)
                SMODS.debuff_card(chosen_card, true, "gb_unstable")
            end
        end
        if context.end_of_round then
            for _, playing_card in ipairs(G.playing_cards) do
                SMODS.debuff_card(playing_card, false, "gb_unstable")
            end
        end
    end
}