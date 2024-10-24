--- STEAMODDED HEADER
--- MOD_NAME: Balatro: Repentance
--- MOD_ID: REP
--- MOD_AUTHOR: [fem]
--- MOD_DESCRIPTION: Adds cards based on the items from The Binding of Isaac: Repentance.
--- BADGE_COLOR: c7638f
--- PREFIX: rep

----------------------------------------------
------------MOD CODE -------------------------

SMODS.Atlas ({
  key = "Cards",
  path = "cards.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas ({
key = "modicon",
path = "icon.png",
px = 64,
py = 64
}):register()

SMODS.Joker {
  key = 'thesadonion',
  loc_txt = {
    name = 'The Sad Onion',
    text = {
      "{C:chips}+#1#{} Chips Up"
    }
  },
  config = { extra = { chips = 70}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 3,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 0, y = 0},
  cost = 3,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}
      }
    end
  end
}

SMODS.Joker {
  key = 'theinnereye',
  loc_txt = {
    name = 'The Inner Eye',
    text = {
      "{X:chips,C:white}#1#x{} Chips"
    }
  },
  config = { extra = { xchips = 3}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.xchips}}
  end,
  rarity = 2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 1, y = 0},
  cost = 5,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        Xchip_mod = card.ability.extra.xchips,
        message = "3x",
        colour = G.C.CHIPS,
        card = card,
      }
    end
  end
}

SMODS.Joker {
  key = 'spoonbender',
  loc_txt = {
    name = 'Spoon Bender',
    text = {
      "Balances {C:chips}Chips{} and {C:mult}Mult{}"
    }
  },
  rarity = 3,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 2, y = 0},
  cost = 8,
  blueprint_compat = false,
  calculate = function(self, card, context)
		if context.cardarea == G.jokers and not context.before and not context.after then
			local tot = hand_chips + mult
			if not tot.array or #tot.array < 2 or tot.array[2] < 2 then
				hand_chips = mod_chips(math.floor(tot / 2))
				mult = mod_mult(math.floor(tot / 2))
			else
				if hand_chips > mult then
					tot = hand_chips
				else
					tot = mult
				end
				hand_chips = mod_chips(tot)
				mult = mod_chips(tot)
			end
			update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
			return {
				message = localize("k_balanced"),
				colour = { 0.8, 0.45, 0.85, 1 },
			}
		end
	end,
}

SMODS.Joker {
  key = 'cricketshead',
  loc_txt = {
    name = "Cricket's Head",
    text = {
      "{C:mult}+#1#{} Mult",
      "{X:mult,C:white}#2#x{} Mult"
    }
  },
  config = { extra = {mult = 5, xmult = 1.5}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult, card.ability.extra.xmult}}
  end,
  rarity = 4,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 3, y = 0},
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        Xmult_mod = card.ability.extra.xmult,
        message = "+5 1.5x",
        colour = G.C.MULT,
        card = card,
      }
    end
  end
}

SMODS.Joker {
  key = 'myreflection',
  loc_txt = {
    name = 'My Reflection',
    text = {
      "{C:blue}+#1#{} Hands"
    }
  },
  config = { extra = {hands = 2}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = 2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 4, y = 0},
  cost = 5,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 2,
    ease_hands_played(2)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - 2,
    ease_hands_played(-2)
end
}

SMODS.Joker {
  key = 'numberone',
  loc_txt = {
    name = 'Number One',
    text = {
      "{C:chips}+#1#{} Chips",
      "{C:blue}#2#{} Hands"
    }
  },
  config = { extra = {chips = 150, hands = -1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.hands}}
  end,
  rarity = 2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 0, y = 1},
  cost = 4,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - 1,
    ease_hands_played(-1)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1,
    ease_hands_played(1)
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}
      }
    end
  end
}