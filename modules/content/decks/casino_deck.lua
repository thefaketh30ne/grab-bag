SMODS.Back {
    key = "casino",
    loc_txt = {
        name = "Casino Deck",
        text = {
            "{C:attention}Double{} all {C:green}listed probabilities{}",
            "Earn no {C:attention}Interest"
        }
    },
    atlas = "gb_Decks",
    config = { no_interest = true },
    pos = { x = 3, y = 1 },
    calculate = function(self, card, context)
        if context.mod_probability and not context.blueprint then
            return {
                numerator = context.numerator * 2
            }
        end
    end,
}
