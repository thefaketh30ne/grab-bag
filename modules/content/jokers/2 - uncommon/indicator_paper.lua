SMODS.Joker {
    key = 'indicator_paper',
    loc_txt = {
        name = 'Indicator Paper',
        text = {
            "{X:mult,C:white}X#1#{} Mult if {C:attention}average{} rank",
            "of played cards is {C:attention}#2#{} or less",
            "{C:inactive,s:0.85}({C:attention,s:0.85}Kings{C:inactive,s:0.85}, {C:attention,s:0.85}Queens{C:inactive,s:0.85} and {C:attention,s:0.85}Jacks{C:inactive,s:0.85} count as {C:attention,s:0.85}10{C:inactive,s:0.85}){}",
            "{C:inactive,s:0.85}({C:attention,s:0.85}Aces{C:inactive,s:0.85} count as {C:attention,s:0.85}1{C:inactive,s:0.85})"
		}
    },
    config = { extra = { xmult = 2.5, threshold = 7 } },
    rarity = 2,
    cost = 7,
    atlas = 'gb_Jokers',
    pos = { x = 9, y = 6 },
    soul_pos = { x = 8, y = 6 },
       blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.threshold } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local rank_sum = 0
            for _, playing_card in pairs(context.full_hand) do
                if not SMODS.has_no_rank(playing_card) then
                    if playing_card:get_id() == 14 then
                        rank_sum = rank_sum + 1
                    end
                    rank_sum = rank_sum + playing_card.base.nominal
                end
            end
            local average_rank = rank_sum / #context.full_hand
            if average_rank <= card.ability.extra.threshold then
                return {
                    xmult = card.ability.extra.xmult
                }
            else
                return {
                    message = string.format("%.1f", average_rank),
                    colour = G.C.FILTER
                }
            end
        end
    end
}