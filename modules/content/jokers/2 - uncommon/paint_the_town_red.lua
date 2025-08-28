SMODS.Joker {
    key = 'paint_the_town_red',
	loc_txt = {
		name = 'Paint The Town Red',
		text = {
			"{C:mult}+#1#{} Mult for every",
            "{C:hearts}Heart{} in {C:attention}full deck{}",
            "{C:mult}-#1#{} Mult for every",
            "{C:spades}Spade{} in {C:attention}full deck{}",
            "{C:inactive}(Currently {C:mult}+#2#{}{C:inactive} Mult)",
		}
	},
    config = { extra = { mult_mod = 4, mult = 0 } },
    rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 2 },
	cost = 6,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local cumulative_mult = 0
        if G.playing_cards then
            for _, playing_card in pairs(G.playing_cards) do
                if playing_card:is_suit('Hearts') then
                    cumulative_mult = cumulative_mult + card.ability.extra.mult_mod
                end
            end
            for _, playing_card in pairs(G.playing_cards) do
                if playing_card:is_suit('Spades') then
                    cumulative_mult = cumulative_mult - card.ability.extra.mult_mod
                end
            end
        end
        return { vars = {
            card.ability.extra.mult_mod,
            math.max(0, cumulative_mult)
        } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then 
            local cumulative_mult = 0
            for _, playing_card in pairs(G.playing_cards) do
                if playing_card:is_suit('Hearts') then
                    cumulative_mult = cumulative_mult + card.ability.extra.mult_mod
                end
            end
            for _, playing_card in pairs(G.playing_cards) do
                if playing_card:is_suit('Spades') then
                    cumulative_mult = cumulative_mult - card.ability.extra.mult_mod
                end
            end
            card.ability.extra.mult = math.max(0, cumulative_mult)
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}