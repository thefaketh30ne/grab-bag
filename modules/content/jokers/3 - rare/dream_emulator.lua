SMODS.Joker {
	key = 'dream_emulator',
	loc_txt = {
		name = 'Dream Emulator',
		text = {
            "Create {C:attention}#1# {C:dark_edition}Temporary{} copies",
            "of the first sold Joker",
            "of the round"
		}
	},
	config = { extra = { copies = 2, active = true } },
	rarity = 3,
	atlas = 'gb_Jokers',
	pos = { x = 5, y = 6 },
	cost = 8,
	blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.copies } }
	end,
    calculate = function(self, card, context)
        if context.selling_card
        and not context.card == card
        and context.card.ability.set == "Joker"
        and card.ability.extra.active == true 
        and not context.blueprint then
            card.ability.extra.active = false
            for _ = 1, card.ability.extra.copies do
                local copied_joker = copy_card(context.card)
                copied_joker:set_edition("e_gb_temporary")
                copied_joker:add_to_deck()
                G.jokers:emplace(copied_joker)
            end
            return {
                message = "Copied!",
                colour = G.C.FILTER
            }
        end
        if context.starting_shop then
            card.ability.extra.active = true
            return {
                message = localize("k_reset"),
                colour = G.C.FILTER
            }
        end
    end
}