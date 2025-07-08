SMODS.Joker{
    key = "mouth",
    loc_txt = {
		name = 'The Mouth',
		text = {
            "{C:attention}Retrigger{} all scoring cards",
            "Must play {C:attention}most played poker hand",
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 9, y = 0 },
    rarity = "gb_boss",
    cost = 6,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = 1
            }
        end
        if context.debuff_hand then 
            local lower = false
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    lower = true
                    break
                end
            end
            if lower then
                return {
                    debuff = true,
                    debuff_text = "Must play most played poker hand"
                }
            end
        end
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size_tally)
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_mouth")
    end
}