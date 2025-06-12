SMODS.Blind {
    key = "final_tile",
    loc_txt = {
        name = "Tangerine Tile",
        text = {
            "Selling a Joker",
            "reduces score",
            "requirement by 2X Base",
        }
    },
    dollars = 8,
    mult = 8,
    atlas = "gb_Blinds",
    pos = { y = 19 },
    boss = { showdown = true },
    boss_colour = HEX("f4a441"),
    config = { extra = { base_blind_chips = 0 } },
    calculate = function(self, blind, context)
        if context.setting_blind then
            self.config.extra.base_blind_chips = G.GAME.blind.chips / G.GAME.blind.mult
        end
        if not blind.disabled
        and context.selling_card
        and context.card.ability.set == 'Joker' 
        and to_big(G.GAME.blind.chips) > to_big(self.config.extra.base_blind_chips * 2) then
            G.GAME.blind.chips = G.GAME.blind.chips - self.config.extra.base_blind_chips * 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
    disable = function(self)
        G.GAME.blind.chips = self.config.extra.base_blind_chips * 2
        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
}
