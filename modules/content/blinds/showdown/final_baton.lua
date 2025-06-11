SMODS.Blind {
    key = "final_baton",
    loc_txt = {
        name = "Wooden Baton",
        text = {
            "Debuffs all cards",
            "until 1 hand remaining",
        }
    },
    dollars = 8,
    mult = 3,
    atlas = "gb_Blinds",
    pos = { y = 15 },
    boss = { showdown = true },
    boss_colour = HEX("be7022"),
    calculate = function(self, blind, context)
        if not blind.disabled then
            if context.debuff_card and context.debuff_card.area ~= G.jokers then
                if G.GAME.current_round.hands_left > 1 then
                    return { debuff = true }
                else
                    G.GAME.blind:disable()
                    return { debuff = false }
                end
            end
            if context.after then
                if G.GAME.current_round.hands_left <= 1 then
                    G.GAME.blind:disable()
                end
            end
        end
    end
}