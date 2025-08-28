GB.Hex {
    key = 'despot_hex',
    atlas = 'gb_Hexes',
    pos = { x = 4, y = 0 },
    badge_colour = HEX("623D88"),
    loc_txt = {
        name = "Despot",
        text = {
            "When played, {C:attention}randomise",
            "suit and rank of a",
            "random card held in hand"
        },
        label = "Despot",
    },
    calculate = function(self, card, context)
        if context.before and context.cardarea == G.play then
            local card_to_randomise = pseudorandom_element(G.hand.cards, pseudoseed("gb_despot"))
            assert(SMODS.change_base(
                card_to_randomise,
                pseudorandom_element(SMODS.Ranks, pseudoseed("gb_despot")).key,
                pseudorandom_element(SMODS.Suits, pseudoseed("gb_despot")).key
            ))
            card_to_randomise:juice_up()
        end
    end
}