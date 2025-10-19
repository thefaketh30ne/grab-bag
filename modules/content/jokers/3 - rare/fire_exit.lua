SMODS.Joker {
	key = 'fire_exit',
	loc_txt = {
		name = 'Fire Exit',
		text = {
			"Skipping a {C:attention}Blind{} gives",
            "{C:attention}#1#{} extra random {C:attention}Tags",
            "Increases by {C:attention}#2#{} when",
            "score {C:attention}catches fire"
		}
	},
	config = { extra = { tags = 1, tags_mod = 1 } },
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 5 },
	cost = 8,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.tags, card.ability.extra.tags_mod } }
	end,
    calculate = function(self, card, context)
        if context.skip_blind then
            for _ = 1, card.ability.extra.tags do
                local tag_pool = get_current_pool('Tag')
                local selected_tag = pseudorandom_element(tag_pool, pseudoseed('gb_fire_exit'))
                local it = 1
                while selected_tag == 'UNAVAILABLE' do
                    it = it + 1
                    selected_tag = pseudorandom_element(tag_pool, pseudoseed('gb_fire_exit' .. it))
                end
                add_tag(Tag(selected_tag, false, 'Small'))
            end
        end
        if context.final_scoring_step and gb_is_score_on_fire()
        and not context.blueprint then
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "tags",
                scalar_value = "tags_mod",
                no_message = true
            })
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.FILTER
            }
        end
    end
}