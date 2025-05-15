SMODS.Atlas {
	-- Key for code to find it with
	key = "Jokers",
	-- The name of the file, for the code to pull the atlas from
	path = "Jokers.png",
	-- Width of each sprite in 1x size
	px = 71,
	-- Height of each sprite in 1x size
	py = 95
}

SMODS.Atlas({
	key = "modicon",
	path = "icon.png",
	px = 34,
	py = 34,
})

--common jokers

SMODS.Joker {
	key = 'boring_joker',
	loc_txt = {
		name = 'Boring Joker',
		text = {
			"Retrigger all scoring {C:attention}unenhanced{} cards",
		}
	},
	config = { extra = { repetitions = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 5, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.repetitions } }
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if not next(SMODS.get_enhancements(context.other_card)) then		
                return {
                    repetitions = card.ability.extra.repetitions
                }
			end
		end
	end
}

SMODS.Joker {
	key = 'counterfeit',
	loc_txt = {
		name = 'Counterfeit Joker',
		text = {
			"Gives {C:mult}+#1#{} Mult,",
			"lose {C:red}-$#2#{} at end of round",
		}
	},
	config = { extra = { mult = 15, money = 1 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 2 },
	cost = 2,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.money } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
	calc_dollar_bonus = function(self, card)
        return -card.ability.extra.money
    end
}

SMODS.Joker {
	key = 'gasoline',
	loc_txt = {
		name = 'Gasoline',
		text = {
			"Earn {C:money}$#1#{} if played hand",
			"causes score to {C:attention}catch fire{}",
		}
	},
	config = { extra = { dollars = 6 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 2 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
    calculate = function(self, card, context)
        if context.final_scoring_step and G.GAME.blind.chips <= hand_chips * mult then
			return {
                dollars = card.ability.extra.dollars
			}
		end
	end
}

SMODS.Joker {
	key = 'jackpot',
	loc_txt = {
		name = 'Jackpot',
		text = {
			"Earn {C:money}$#1#{} if played hand",
			"contains three {C:attention}7{}s",
		}
	},
	config = { extra = { dollars = 7 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 1, y = 3 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.dollars } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			local tally = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 7 then
					tally = tally + 1
				end
            end
			if tally >= 3 then
            	return {
                	dollars = card.ability.extra.dollars
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'morose_joker',
	loc_txt = {
		name = 'Morose Joker',
		text = {
			"Gives {C:mult}+#1#{} Mult",
			"if played hand",
			"does not contain a {C:attention}Pair{}"
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 2, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult} }
	end,
	calculate = function(self, card, context)
		if context.joker_main and not next(context.poker_hands['Pair']) then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
			}
		end
	end
}

SMODS.Joker {
	key = 'postage',
	loc_txt = {
		name = 'Postage Stamp',
		text = {
            "This Joker gains {C:chips}+#2#{} Chips",
            "if played hand has",
            "exactly {C:attention}1{} card",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
		}
	},
	config = { extra = { chips = 0, chip_mod = 8 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 4, y = 1 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and #context.full_hand == 1 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}

SMODS.Joker {
	key = 'sketchy_joker',
	loc_txt = {
		name = 'Sketchy Joker',
		text = {
            "This Joker gains {C:mult}+#1#{} Mult",
            "for every {C:attention}#4#{} cards drawn",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult) (#3#/#4#)",
		}
	},
	config = { extra = { mult = 0, mult_mod = 1, draw_tally = 0, draws = 7 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 3, y = 3 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, card.ability.extra.mult, card.ability.extra.draw_tally, card.ability.extra.draws } }
	end,
	calculate = function(self, card, context)
		if context.hand_drawn then
			local upgraded = false
			for _, playing_card in ipairs(context.hand_drawn) do
				card.ability.extra.draw_tally = card.ability.extra.draw_tally + 1
				if card.ability.extra.draw_tally >= card.ability.extra.draws then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					card.ability.extra.draw_tally = card.ability.extra.draw_tally - card.ability.extra.draws
					upgraded = true
				end
			end
			if upgraded == true then
				return {
					message = localize('k_upgrade_ex'),
                	colour = G.C.MULT
				}
			end
		end
		if context.other_drawn then
			local upgraded = false
			for _, playing_card in ipairs(context.other_drawn) do
				card.ability.extra.draw_tally = card.ability.extra.draw_tally + 1
				if card.ability.extra.draw_tally >= card.ability.extra.draws then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					card.ability.extra.draw_tally = card.ability.extra.draw_tally - card.ability.extra.draws
					upgraded = true
				end
			end
			if upgraded == true then
				return {
					message = localize('k_upgrade_ex'),
                	colour = G.C.MULT
				}
			end
		end
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end
	end
}

SMODS.Joker {
	key = 'wild_joker',
	loc_txt = {
		name = 'Wild Joker',
		text = {
            "Gives {C:mult}+#1#{} Mult for",
            "each {C:attention}Wild Card",
            "in your {C:attention}full deck",
            "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 1,
	atlas = 'Jokers',
	pos = { x = 4, y = 2 },
	cost = 4,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_wild

        local wild_tally = 0
        if G.playing_card then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_wild') then wild_tally = wild_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.mult, card.ability.extra.mult * wild_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local wild_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_wild') then wild_tally = wild_tally + 1 end
            end
            return {
                mult = card.ability.extra.mult * wild_tally
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}

--uncommon jokers

SMODS.Joker {
	key = 'boing_ball',
	loc_txt = {
		name = 'Boing Ball',
		text = {
			"{C:green}#1# in #2# chance{} for",
			"played cards to retrigger",
		}
	},
	config = { extra = { odds = 2, repetitions = 1 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 6, y = 3 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
			if pseudorandom('gb_boing_ball') < G.GAME.probabilities.normal / card.ability.extra.odds then		
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}

SMODS.Joker {
	key = 'hot_potato',
	loc_txt = {
		name = 'Hot Potato',
		text = {
			"When {C:attention}Blind{} is skipped,",
			"this Joker gains {C:mult}+#2#{} Mult",
			"{C:green}#3# in #4# chance{} to {C:red}self-destruct{}",
			"at end of round",
			"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
		}
	},
	config = { extra = { mult = 0, mult_mod = 12, odds = 8 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 7, y = 2 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            if pseudorandom('gb_hot_potato') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Cooked!'
                }
            else
                return {
                    message = localize('k_safe_ex')
                }
            end
        end
        if context.skip_blind and not context.blueprint then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } }
			}
                
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
			}
        end
	end
}
SMODS.Joker {
	key = 'impostor',
	loc_txt = {
		name = 'Impostor',
		text = {
			"{C:common}Common{} {C:attention}Jokers{}",
			"give {C:mult}+#1#{} Mult each",
		}
	},
	config = { extra = { mult = 8 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 0 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult } }
	end,
	calculate = function(self, card, context)
        if context.other_joker and (context.other_joker.config.center.rarity == 1 or context.other_joker.config.center.rarity == "Common") then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}

SMODS.Joker {
	key = 'knight',
	loc_txt = {
		name = 'Knight',
		text = {
            "{C:attention}Steel Cards{} give",
            "{X:mult,C:white}#1#X{} Mult when scored",
		}
	},
	config = { extra = { xmult = 1.5 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 2 },
	cost = 5,
	blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_steel') then
            return {
                xmult = card.ability.extra.xmult
			}
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_steel') then
                return true
            end
        end
        return false
    end,
}

SMODS.Joker {
	key = 'misfortune',
	loc_txt = {
		name = 'Wheel Of Misfortune',
		text = {
			"{X:mult,C:white}X#1#{} Mult, {C:green}#2# in #3# chance{}",
			"for played hand",
			"to score nothing",
		}
	},
	config = { extra = { xmult = 3, odds = 4 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 0, y = 1 },
	cost = 5,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult, G.GAME.probabilities.normal or 1, card.ability.extra.odds } }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = card.ability.extra.xmult
			}
		end
		if context.final_scoring_step then
			if pseudorandom('gb_misfortune') < G.GAME.probabilities.normal / card.ability.extra.odds then		
				hand_chips = 0
				mult = 0
				return {
					message = localize('k_nope_ex'),
					colour = G.C.SECONDARY_SET.Tarot,
					sound = 'cancel'
				}
			end
		end
	end
}

SMODS.Joker {
	key = 'polariser',
	loc_txt = {
		name = 'Polariser',
		text = {
			"Scored {C:attention}Bonus Cards{} give {C:mult}+#1#{} Mult",
			"Scored {C:attention}Mult Cards{} give {C:chips}+#2#{} Chips",
		}
	},
	config = { extra = { mult = 4, chips = 30 } },
	rarity = 2,
	atlas = 'Jokers',
	pos = { x = 4, y = 0 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_bonus') then
            return {
                mult = card.ability.extra.mult
			}
        end
		if context.individual and context.cardarea == G.play and
            SMODS.has_enhancement(context.other_card, 'm_mult') then
            return {
                chips = card.ability.extra.chips
			}
        end
    end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_mult') or SMODS.has_enhancement(playing_card, 'm_bonus') then
                return true
            end
        end
        return false
    end
}

-- rare jokers
SMODS.Joker {
	key = 'double_king',
	loc_txt = {
		name = 'Double King',
		text = {
			"If played hand contains two {C:attention}Kings{},",
			"this joker gains {X:mult,C:white}X#1#{} Mult and",
			"{C:red}destroys{} the leftmost {C:attention}King{}",
			"{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)"
		}
	},
	config = { extra = { xmult = 1, xmult_mod = 1, king_removed = false, activates = false } },
	rarity = 3,
	atlas = 'Jokers',
	pos = { x = 5, y = 2 },
	cost = 7,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.xmult_mod, card.ability.extra.xmult } }
	end,
    calculate = function(self, card, context)
		if context.before then
			card.ability.extra.king_removed = false
			card.ability.extra.activates = false
			local tally = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:get_id() == 13 then
					tally = tally + 1
				end
            end
			if tally >= 2 then
				card.ability.extra.activates = true
				card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
				return {
					message = localize('k_upgrade_ex'),
                	colour = G.C.MULT
				}
			end
		end
        if context.joker_main then
            return {
                xmult = card.ability.extra.xmult
			}
		end
		if context.destroy_card then
			if card.ability.extra.activates then
				for _, playing_card in ipairs(context.scoring_hand) do
					if playing_card:get_id() == 13 and context.destroy_card == playing_card and not card.ability.extra.king_removed then
						card.ability.extra.king_removed = true
						return { remove = true }
					end
				end
			end
		end
	end
}