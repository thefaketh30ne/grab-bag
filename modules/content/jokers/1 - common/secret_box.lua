SMODS.Joker {
	key = 'secret_box',
	loc_txt = {
		name = 'Secret Box',
		text = {
            "Sell this card to create",
            "a random {V:1}#1#{} Joker",
            "{C:inactive,s:0.85}(Rerolls rarity at end of round",
            "{C:inactive,s:0.85}with the probabilites {C:common,s:0.85}45{C:inactive,s:0.85}/{C:uncommon,s:0.85}35{C:inactive,s:0.85}/{C:rare,s:0.85}15{C:inactive,s:0.85}/{C:legendary,s:0.85}5{C:inactive,s:0.85})"
		}
	},
	config = { extra = { current_rarity = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 3 },
	cost = 4,
	blueprint_compat = false,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        local rarities = {
            {G.C.RARITY.Common, "Common"},
            {G.C.RARITY.Uncommon, "Uncommon"},
            {G.C.RARITY.Rare, "Rare"},
            {G.C.RARITY.Legendary, "Legendary"}
        }
        return { vars = {
            rarities[card.ability.extra.current_rarity][2],
            colours = {
                rarities[card.ability.extra.current_rarity][1],
            }
        }}
	end,
	calculate = function(self, card, context)
        local rarities = { "Common", "Uncommon", "Rare", "Legendary" }
        if context.end_of_round
        and context.main_eval
        and not context.blueprint then
            local rarity_value = pseudorandom("gb_secret_box")
            if rarity_value < 0.45 then
                card.ability.extra.current_rarity = 1
            elseif rarity_value < 0.80 then
                card.ability.extra.current_rarity = 2
            elseif rarity_value < 0.95 then
                card.ability.extra.current_rarity = 3
            else
                card.ability.extra.current_rarity = 4
            end
            return {
                message = rarities[card.ability.extra.current_rarity],
                colour = G.C.RARITY[card.ability.extra.current_rarity],
            }
        end
		if context.selling_self and not context.blueprint then
        G.GAME.joker_buffer = G.GAME.joker_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card {
                        set = 'Joker',
                        rarity = rarities[card.ability.extra.current_rarity],
                        key_append = 'gb_secret_box'
                    }
                    G.GAME.joker_buffer = 0
                    return true
                end
            }))
            return {
                message = localize('k_plus_joker'),
                colour = G.C.RARITY[card.ability.extra.current_rarity],
            }
        end
	end
}