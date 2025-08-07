SMODS.Seal {
    key = 'fortune',
    loc_txt = {
        name = "Fortune Seal",
        label = "Fortune Seal",
        text = {
            "{C:green}#1# in #2#{} chance to",
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
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, self.config.extra.odds)
        return { vars = { new_numerator, new_denominator } }
    end,
    calculate = function(self, card, context)
        if context.before 
        and context.cardarea == G.play then    
            if SMODS.pseudorandom_probability(card, 'gb_fortune', 1, self.config.extra.odds) then
                local eligible_card = pseudorandom_element(context.scoring_hand, pseudoseed('gb_fortune'))
                local edition = poll_edition('gb_fortune', nil, true, true)
                if eligible_card and eligible_card.edition then
                    eligible_card:set_edition(edition, true)
                end
            else
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.SECONDARY_SET.Tarot,
					sound = 'cancel'
                }
            end
        end
    end
}