SMODS.Seal {
    key = 'fortune',
    loc_txt = {
        name = "Fortune Seal",
        label = "Fortune Seal",
        text = {
            "{C:green}#2# in #1#{} chance to",
            "give an {C:dark_edition}Edition{} to",
            "a random played card",
            "if scoring",
        }
    },
    atlas = "gb_Cards",
    pos = { x = 7, y = 1 },
    config = { extra = { odds = 4 } },
    badge_colour = HEX('CAB785'),
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.odds, G.GAME.probabilities.normal or 1 } }
    end,
    calculate = function(self, card, context)
        if context.before 
        and context.cardarea == G.play then    
            if pseudorandom('gb_fortune') < G.GAME.probabilities.normal / self.config.extra.odds then
                local eligible_card = pseudorandom_element(context.scoring_hand, pseudoseed('gb_fortune'))
                local edition = poll_edition('gb_fortune', nil, true, true,
                    { 'e_polychrome', 'e_holo', 'e_foil' })
                if eligible_card then
                    eligible_card:set_edition(edition, true)
                end
            else
                SMODS.calculate_context{fortune_fail = true}
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.SECONDARY_SET.Tarot,
					sound = 'cancel'
                }
            end
        end
    end
}