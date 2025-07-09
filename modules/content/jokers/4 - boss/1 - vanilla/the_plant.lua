SMODS.Joker{
    key = "plant",
    loc_txt = {
		name = 'The Plant',
		text = {
			"All {C:attention}face{} cards are {C:attention}debuffed",
            "{X:mult,C:white}X#2#{} Mult for every",
            "{C:attention}face{} card in {C:attention}full deck",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)"
		}
	},
    blueprint_compat = true,
	atlas = 'gb_BossJokers',
	pos = { x = 9, y = 1 },
    rarity = "gb_boss",
    cost = 6,
    config = { extra = { xmult_mod = 0.25 } },
    loc_vars = function(self, info_queue, card)
        local face_tally = 0
        for _, playing_card in pairs(G.playing_cards or {}) do
            if playing_card:is_face(true) then
                face_tally = face_tally + 1
            end
        end
        return { vars = { 
            1 + card.ability.extra.xmult_mod * face_tally,
            card.ability.extra.xmult_mod
        } }
    end,

    calculate = function(self, card, context)
        if context.debuff_card and context.debuff_card:is_face() then
            return {
                debuff_card = true
            }
        end
        if context.joker_main then
            local face_tally = 0
            for _, playing_card in pairs(G.playing_cards or {}) do
                if playing_card:is_face(true) then
                    face_tally = face_tally + 1
                end
            end
            return {
                xmult = 1 + card.ability.extra.xmult_mod * face_tally
            }
        end
    end,

    in_pool = function(self, args)
        return gb_is_blind_defeated("bl_plant")
    end
}