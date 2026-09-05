SMODS.Joker{
    key = "creepy_painting",
    loc_txt = {
        name = 'Creepy Painting',
		text = {
            "After #1# playing cards",
            "are destroyed, create",
            "a randox Hex card"
		}
    },
    config = { extra = { xmult = 2, odds = 2 } },
	rarity = 2,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 5 },
	cost = 6,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {  }, colours = { HEX("8EA4B3") } }
        
	end,
    calculate = function(self, card, context)
    end
}