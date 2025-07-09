SMODS.Joker{
    key = "wall",
    loc_txt = {
		name = 'The Wall',
		text = {
			"{C:red}X#1#{C:attention} Boss Blind{} size",
            "{X:mult,C:white}X#2#{} Mult for every {C:attention}Stone{} card",
            "in {C:attention}full deck{}",
            "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 2, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { boss_blind_size = 2, xmult_mod = 0.25 } },
    loc_vars = function(self, info_queue, card)
        local stone_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_stone') then stone_tally = stone_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.boss_blind_size, card.ability.extra.xmult_mod, 1 + card.ability.extra.xmult_mod * stone_tally } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind and G.GAME.blind.boss then
            G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.boss_blind_size
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            play_sound("cancel")
            card:juice_up()
        end
        if context.joker_main and context.main_eval then
            local stone_tally = 0
            if G.playing_cards then
                for _, playing_card in ipairs(G.playing_cards) do
                    if SMODS.has_enhancement(playing_card, 'm_stone') then stone_tally = stone_tally + 1 end
                end
            end
            if stone_tally > 0 then
                return {
                    xmult = 1 + card.ability.extra.xmult_mod * stone_tally
                }
            end
        end
    end,
    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_wall")
    end
}