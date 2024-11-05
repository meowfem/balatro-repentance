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
  key = "Cards2",
  path = "cards2.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas ({
  key = "Cards3",
  path = "cards3.png",
  px = 71,
  py = 95
}):register()

SMODS.Atlas ({
key = "modicon",
path = "icon.png",
px = 41,
py = 41
}):register()


local quality1 = function(self, card, badges)
	badges[#badges + 1] = create_badge('Quality 1', HEX('91fe51'), G.C.WHITE, 1)
end

local quality2 = function(self, card, badges)
	badges[#badges + 1] = create_badge('Quality 2', HEX('65d4fe'), G.C.WHITE, 1.5)
end

local quality3 = function(self, card, badges)
	badges[#badges + 1] = create_badge('Quality 3', HEX('fe54ed'), G.C.WHITE, 2)
end

local quality4 = function(self, card, badges)
	badges[#badges + 1] = create_badge('Quality 4', HEX('fed000'), G.C.WHITE, 2.5)
end


SMODS.Joker {
  key = 'thesadonion',
  loc_txt = {
    name = 'The Sad Onion',
    text = {
      "{C:inactive,s:1.5}Tears up{}",
      "{C:chips}+#1#{} Chips"
    }
  },
  config = { extra = { chips = 70}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 3,
  set_card_type_badge = quality3,
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
      "{C:inactive,s:1.5}Triple shot{}",
      "{C:blue}+#1#{} Hands"
    }
  },
  config = { extra = { hands = 3}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 1, y = 0},
  cost = 5,
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands + 3,
    ease_hands_played(3)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.GAME.round_resets.hands = G.GAME.round_resets.hands - 3,
    ease_hands_played(-3)
  end
}

SMODS.Joker {
  key = 'spoonbender',
  loc_txt = {
    name = 'Spoon Bender',
    text = {
      "{C:inactive,s:1.5}Homing shots{}",
      "Balances {C:chips}Chips{} and {C:mult}Mult{}"
    }
  },
  rarity = 3,
  set_card_type_badge = quality3,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 2, y = 0},
  cost = 8,
  blueprint_compat = false,
  calculate = function(self, card, context)
		if context.cardarea == G.jokers and not context.before and not context.after and not context.blueprint then
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
      "{C:inactive,s:1.5}DMG up{}",
      "{C:mult}+#1#{} Mult",
      "{X:mult,C:white}#2#x{} Mult"
    }
  },
  config = { extra = {mult = 5, xmult = 1.5}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult, card.ability.extra.xmult}}
  end,
  rarity = 4,
  set_card_type_badge = quality4,
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
        message = localize {type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
      }
    end
  end
}

SMODS.Joker {
  key = 'myreflection',
  loc_txt = {
    name = 'My Reflection',
    text = {
      "{C:inactive,s:1.5}Boomerang tears{}",
      "{C:attention}+#1#{} Hand Size"
    }
  },
  config = { extra = {h_size = 2}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.h_size}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 4, y = 0},
  cost = 4,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

SMODS.Joker {
  key = 'numberone',
  loc_txt = {
    name = 'Number One',
    text = {
      "{C:inactive,s:1.5}Tears up{}",
      "{C:chips}+#1#{} Chips",
      "{C:attention}-#2#{} Hand Size"
    }
  },
  config = { extra = {chips = 150, h_size = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips, card.ability.extra.h_size}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 0, y = 1},
  cost = 4,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  calculate = function(self, card, context)
    if context.joker_main and not context.blueprint then
      return {
        chip_mod = card.ability.extra.chips,
        message = localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}}
      }
    end
  end
}

SMODS.Joker {
  key = 'bloodofthemartyr',
  loc_txt = {
    name = 'Blood of The Martyr',
    text = {
      "{C:inactive,s:1.5}DMG up{}",
      "{C:mult}+#1#{} Mult"
    }
  },
  config = { extra = {mult = 10}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 3,
  set_card_type_badge = quality3,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 1, y = 1},
  cost = 5,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        message = localize {type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
      }
    end
  end
}

SMODS.Joker {
  key = '1up',
  loc_txt = {
    name = '1up!',
    text = {
      "{C:inactive,s:1.5}Extra life{}",
      "Prevents death {C:attention}once{}",
      "{C:red}Self destructs{}"
    }
  },
  config = { extra = {hands = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 0, y = 2},
  cost = 6,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if context.end_of_round and not context.blueprint and context.game_over then
      G.E_MANAGER:add_event(Event({
        func = function()
          G.hand_text_area.blind_chips:juice_up()
          G.hand_text_area.game_chips:juice_up()
          return true
        end
      }))
      return {
        message = ('Revive!'),
        saved = true,
        colour = G.C.ATTENTION,
        card:start_dissolve()
      }
    end
  end
}

SMODS.Joker {
  key = 'magicmushroom',
  loc_txt = {
    name = 'Magic Mushroom',
    text = {
      "{C:inactive,s:1.5}All stats up!{}",
      "{X:attention,C:white}#1#x{} Blind Requirement",
      "{C:mult}+#2#{} Mult",
      "{X:mult,C:white}#3#x{} Mult",
      "{C:attention}+#4#{} Hand Size"
    }
  },
  config = {extra = {blindreq = 0.9, mult = 10, xmult = 1.5, h_size = 3}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq, card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.h_size,}}
  end,
  rarity = 4,
  set_card_type_badge = quality4,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 1, y = 2},
  cost = 12,
  blueprint_compat = true,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
    if context.joker_main then
      return {
        mult_mod = card.ability.extra.mult,
        Xmult_mod = card.ability.extra.xmult,
        message = (localize {type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}})
      }
    end
  end
}

SMODS.Joker {
  key = 'thevirus',
  loc_txt = {
    name = 'The Virus',
    text = {
      "{C:inactive,s:1.5}Poison touch{}",
      "{C:mult}+#1#{} Mult if {C:attention}first{} hand of blind"
    }
  },
  config = {extra = {mult = 12}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.mult}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 2, y = 2},
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_played == 0 then
      return {
        mult_mod = card.ability.extra.mult,
        message = (localize {type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}})
      }
    end
  end
}

SMODS.Joker {
  key = 'roidrage',
  loc_txt = {
    name = 'Roid Rage',
    text = {
      "{C:inactive,s:1.5}Speed and range up{}",
      "Gains {C:attention}+#1#{} Hand Size per {C:attention}Blind Skipped{}",
      "{C:inactive}(Currently{} {C:attention}+#2#{} {C:inactive}Hand Size){}"
    }
  },
  config = {extra = {increase = 1}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.increase, card.ability.extra.increase * G.GAME.skips}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 3, y = 2},
  cost = 6,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.increase - 1)
  end,
  calculate = function(self, card, context)
    if context.skip_blind and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        func = function() 
          card_eval_status_text(card, 'extra', nil, nil, nil, {
            G.hand:change_size(card.ability.extra.increase),
            message = ("+" .. (G.GAME.skips) .. " Hand Size"),
            colour = G.C.ATTENTION,
            card = card
          }) 
          return true
        end}))
    end
  end,
  calc_size_bonus = function(self, card)
    if G.GAME.skips > 0 then
      return G.GAME.skips * card.ability.extra.increase
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.increase)
  end
}

SMODS.Joker {
  key = 'heart',
  loc_txt = {
    name = '<3',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.9}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 4, y = 2},
  cost = 5,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'rawliver',
  loc_txt = {
    name = 'Raw Liver',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.85}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 2,
  set_card_type_badge = quality2,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 0, y = 3},
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'lunch',
  loc_txt = {
    name = 'Lunch',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.95}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 3, y = 3},
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'dinner',
  loc_txt = {
    name = 'Dinner',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.95}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards',
  pos = {x = 4, y = 3},
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'dessert',
  loc_txt = {
    name = 'Dessert',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.95}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 0, y = 0},
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'breakfast',
  loc_txt = {
    name = 'Breakfast',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.95}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 1, y = 0},
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'rottenmeat',
  loc_txt = {
    name = 'Rotten Meat',
    text = {
      "{C:inactive,s:1.5}HP up{}",
      "{X:attention,C:white}#1#x{} Blind Requirement"
    }
  },
  config = {extra = {blindreq = 0.95}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.blindreq}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 2, y = 0},
  cost = 4,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.setting_blind then
      G.GAME.blind.chips = G.GAME.blind.chips * card.ability.extra.blindreq
      G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
    end
  end
}

SMODS.Joker {
  key = 'momsunderwear',
  loc_txt = {
    name = "Mom's Underwear",
    text = {
      "{C:inactive,s:1.5}Range up{}",
      "{C:attention}+#1#{} Hand Size"
    }
  },
  config = { extra = {h_size = 3}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.h_size}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 3, y = 0},
  cost = 6,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

SMODS.Joker {
  key = 'momsheels',
  loc_txt = {
    name = "Mom's Heels",
    text = {
      "{C:inactive,s:1.5}Range up{}",
      "{C:attention}+#1#{} Hand Size"
    }
  },
  config = { extra = {h_size = 3}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.h_size}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 4, y = 0},
  cost = 6,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

SMODS.Joker {
  key = 'momslipstick',
  loc_txt = {
    name = "Mom's Lipstick",
    text = {
      "{C:inactive,s:1.5}Range up{}",
      "{C:attention}+#1#{} Hand Size"
    }
  },
  config = { extra = {h_size = 3}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.h_size}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 4, y = 0},
  cost = 6,
  blueprint_compat = false,
  add_to_deck = function(self, card, from_debuff)
    G.hand:change_size(card.ability.extra.h_size)
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.hand:change_size(-card.ability.extra.h_size)
  end,
}

SMODS.Joker {
  key = 'wirecoathanger',
  loc_txt = {
    name = 'Wire Coat Hanger',
    text = {
      "{C:inactive,s:1.5}Tears up{}",
      "{C:chips}+#1#{} Chips"
    }
  },
  config = { extra = { chips = 70}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 3,
  set_card_type_badge = quality3,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 0, y = 1},
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
  key = 'mrboom',
  loc_txt = {
    name = 'Mr. Boom',
    text = {
      "{C:inactive,s:1.5}Reusable bomb buddy{}",
      "{C:chips}+#1#{} Chips if {C:attention}last{} hand of blind"
    }
  },
  config = {extra = {chips = 333}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.chips}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 1, y = 1},
  cost = 6,
  blueprint_compat = true,
  calculate = function(self, card, context)
    if context.joker_main and G.GAME.current_round.hands_played == G.GAME.round_resets.hands - 1 then
      return {
        chip_mod = card.ability.extra.chips,
        message = (localize {type = 'variable', key = 'a_chips', vars = {card.ability.extra.chips}})
      }
    end
  end
}

SMODS.Joker {
  key = 'momsbra',
  loc_txt = {
    name = "Mom's Bra",
    text = {
      "{C:inactive,s:1.5}Mass fear{}",
      "{C:attention}Disables{} Boss Blind",
      "abilities for {C:attention}#1#{} Hands"
    }
  },
  config = {extra = {hands = 2}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 2, y = 1},
  cost = 5,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if G.GAME.blind and G.GAME.current_round.hands_played == 0 and not G.GAME.blind.disabled and G.GAME.blind:get_type() == 'Boss'and not context.blueprint then
      message = localize('ph_boss_disabled')
      print("DISABLE")
      G.GAME.blind:disable()
    end
    if context.joker_main and G.GAME.round_resets.hands <= G.GAME.current_round.hands_played + 3 then
      print("ENABLE")
      G.GAME.blind:set_blind(G.GAME.blind.config.blind)
    end
  end
}

SMODS.Joker {
  key = 'momspad',
  loc_txt = {
    name = "Mom's Pad",
    text = {
      "{C:inactive,s:1.5}Gross...{}",
      "{C:attention}Disables{} Boss Blind",
      "abilities for {C:attention}#1#{} Hands"
    }
  },
  config = {extra = {hands = 2}},
  loc_vars = function(self, info_queue, card)
    return {vars = {card.ability.extra.hands}}
  end,
  rarity = 1,
  set_card_type_badge = quality1,
  unlocked = true,
  discovered = true,
  atlas = 'Cards2',
  pos = {x = 3, y = 1},
  cost = 5,
  blueprint_compat = false,
  calculate = function(self, card, context)
    if G.GAME.blind and G.GAME.current_round.hands_played == 0 and not G.GAME.blind.disabled and G.GAME.blind:get_type() == 'Boss'and not context.blueprint then
      message = localize('ph_boss_disabled')
      print("DISABLE")
      G.GAME.blind:disable()
    end
    if context.joker_main and G.GAME.round_resets.hands <= G.GAME.current_round.hands_played + 3 then
      print("ENABLE")
      G.GAME.blind:set_blind(G.GAME.blind.config.blind)
    end
  end
}