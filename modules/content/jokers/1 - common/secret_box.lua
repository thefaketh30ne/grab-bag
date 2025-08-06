SMODS.Joker {
	key = 'secret_box',
	loc_txt = {
		name = 'Secret Box',
		text = {
            "Sell this card to create",
            "a random {V:1}#1#{} Joker",
            "{C:inactive,s:0.85}(Changes to {V:2,s:0.85}#2#{C:inactive,s:0.85} in {C:attention,s:0.85}#3#{C:inactive,s:0.85} rounds)"
		}
	},
	config = { extra = { current_rarity = 1, rounds_left = 2, round_total = 2 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 3 },
	cost = 4,
	blueprint_compat = false,
    eternal_compat = false,
	perishable_compat = false,
    loc_vars = function(self, info_queue, card)
        local rarities = {
            {G.C.RARITY.Common, "Common"},
            {G.C.RARITY.Uncommon, "Uncommon"},
            {G.C.RARITY.Rare, "Rare"},
            {G.C.RARITY.Legendary, "Legendary"}
        }
        local next_rarity_index = math.min(card.ability.extra.current_rarity + 1, 4)
        return { vars = {
            rarities[card.ability.extra.current_rarity][2],
            rarities[next_rarity_index][2],
            card.ability.extra.rounds_left,
            colours = {
                rarities[card.ability.extra.current_rarity][1],
                rarities[next_rarity_index][1]
            }
        }}
	end,
	calculate = function(self, card, context)
        local rarities = { "Common", "Uncommon", "Rare", "Legendary" }
        if context.end_of_round
        and context.main_eval
        and not context.blueprint then
            if card.ability.extra.current_rarity < 4 then
                card.ability.extra.rounds_left = math.max(card.ability.extra.rounds_left - 1, 0)
                if card.ability.extra.rounds_left == 0 then
                    if card.ability.extra.current_rarity < 4 then
                        card.ability.extra.current_rarity = card.ability.extra.current_rarity + 1
                        card.ability.extra.round_total = card.ability.extra.round_total + 1
                        card.ability.extra.rounds_left = card.ability.extra.round_total
                        if card.ability.extra.current_rarity == 4 then
                            local eval = function(card) return not card.REMOVED end
                            juice_card_until(card, eval, true)
                            card.ability.extra.round_total = 0
                        end
                        return {
                            message = localize('k_upgrade_ex'),
                            colour = G.C.RARITY[card.ability.extra.current_rarity],
                        }
                    end
                end
            end
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