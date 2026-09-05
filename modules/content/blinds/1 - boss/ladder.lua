SMODS.Blind {
    key = "ladder",
    loc_txt = {
        name = "The Ladder",
        text = {
            "Discarding increases",
            "the Blind size",
            "by [1X Base]"
        }
    },
    dollars = 5,
    mult = 2,
    atlas = "gb_Blinds",
    pos = { y = 30 },
    boss = { min = 3 },
    boss_colour = HEX("b8e46b"),
    config = { extra = { base_blind_chips = 0 } },
    calculate = function(self, blind, context)
        if context.setting_blind then
            self.config.extra.base_blind_chips = G.GAME.blind.chips / G.GAME.blind.mult
        end
        if not blind.disabled then
            if context.pre_discard then
                G.GAME.blind.chips = G.GAME.blind.chips + self.config.extra.base_blind_chips
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