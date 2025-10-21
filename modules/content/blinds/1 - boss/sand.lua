SMODS.Blind {
    key = "sand",
    loc_txt = {
        name = "The Sand",
        text = {
            "Retriggered cards are",
            "destroyed after scoring"

        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 34 },
    boss = { min = 6 },
    boss_colour = HEX("e4ce6b"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.individual and context.cardarea == (G.play or G.hand) then
                if context.other_card.ability.sands_triggered == true then
                    context.other_card.ability.sands_destroy = true
                else
                    context.other_card.ability.sands_triggered = true
                end
            end
        end
        if context.destroy_card and context.cardarea == (G.play or G.hand) then
            if context.destroy_card.ability.sands_destroy == true then
                return {
                    remove = true
                }
            end
            context.destroy_card.ability.sands_triggered = nil
        end
    end,
    disable = function(self)
        for _, playing_card in ipairs(G.playing_cards) do
            playing_card.other_card.ability.sands_triggered = nil
            playing_card.other_card.ability.sands_destroy = nil
        end
    end
}