SMODS.Joker{
    key = "pontoon",
    loc_txt = {
        name = 'Pontoon',
        -- formatting fuck storm
		text = {
			"{C:mult}+#1#{} Mult and {C:chips}+#2#{} Chips if",
            "ranks of played cards {C:attention}add to #3#{}",
            "{C:inactive,s:0.85}({C:attention,s:0.85}Kings{C:inactive,s:0.85}, {C:attention,s:0.85}Queens{C:inactive,s:0.85} and {C:attention,s:0.85}Jacks{C:inactive,s:0.85} count as {C:attention,s:0.85}10{C:inactive,s:0.85}){}",
            "{C:inactive,s:0.85}({C:attention,s:0.85}Aces{C:inactive,s:0.85} count as both {C:attention,s:0.85}1{C:inactive,s:0.85} and {C:attention,s:0.85}11{C:inactive,s:0.85})",
		}
    },
    config = { extra = { mult = 20, chips = 100, rank_count = 21 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 3 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.rank_count } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rank_sum = 0
            local ace_count = 0
            for _, playing_card in pairs(context.full_hand) do
                if SMODS.has_no_rank(playing_card) then
                    rank_sum = rank_sum + playing_card.base.nominal
                end
                if playing_card:get_id() == 14 then
                    ace_count = ace_count + 1
                end
            end
            for i = 1, ace_count + 1 do
                if rank_sum < 21 then
                    return {
                        message = rank_sum .. "",
                        colour = G.C.FILTER
                    }
                elseif rank_sum == 21 then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult
                    }
                else
                    rank_sum = rank_sum - 10
                end
            end
            return 
                {
                    message = "Bust!",
                    colour = G.C.RED
                }
        end
    end
}