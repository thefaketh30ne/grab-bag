SMODS.Blind {
    key = "bracket",
    loc_txt = {
        name = "The Bracket",
        text = {
            "Halves Blind size",
            "after hand played"
        }
    },
    dollars = 5,
    mult = 16,
    atlas = "gb_Blinds",
    pos = { y = 29 },
    boss = { min = 3 },
    boss_colour = HEX("e46b6b"),
    config = { extra = { base_blind_chips = 0 } },
    calculate = function(self, blind, context)
        if context.setting_blind then
            self.config.extra.base_blind_chips = G.GAME.blind.chips / G.GAME.blind.mult
        end
        if not blind.disabled then
            if context.before then
                G.GAME.blind.chips = G.GAME.blind.chips * 0.5
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                play_sound("cancel")
                SMODS.juice_up_blind()
            end
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = self.config.extra.base_blind_chips * 2
    end
}