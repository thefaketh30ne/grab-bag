SMODS.Blind {
    key = "branch",
    loc_txt = {
        name = "The Branch",
        text = {
            "Destroy played #1#",
            "after scoring"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 20 },
    boss = { min = 3 },
    boss_colour = HEX("5f5177"),
    loc_vars = function(self)
        suit = gb_most_numerous_suit(G.playing_cards) or 'Spades'
        return { vars = {
            localize(suit, 'suits_plural')
        } }
    end,
    collection_loc_vars = function(self)
        return { vars = { "[most numerous suit]" } }
    end,
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.destroy_card
            and context.cardarea == G.play
            and context.destroy_card.base.suit == gb_most_numerous_suit(G.playing_cards) then
                return {
                    remove = true
                }
            end
        end
    end,
}