return {
	s({ trig = "--", desc = "Multiline comment" }, { -- idk why but --[[ just doesnt work as trigger
		t({ "--[[", "" }),
		i(0),
		t({ "", "--]]" }),
	}),
}
