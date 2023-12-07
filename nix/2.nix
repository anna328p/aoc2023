{ L, getInputLines, ... }:

let
	inherit (builtins)
		map
		match
		fromJSON
		split
		elemAt
		filter
		isString
		listToAttrs
		mapAttrs
		attrValues
		all
		zipAttrsWith
		;
	
	inherit (L)
		id
		sum
		max
		product
		pipe'
		foldl1
		o oo
		fst snd
		mkMapping
		;
in rec {
	exports = self: {};

	toInt = fromJSON;

	split' = oo (filter isString) split;

	parseLine = line: let
		matchRes = match "Game ([0-9]+): (.*)$" line;

		id = toInt (fst matchRes);
		subsetsStr = split' "; " (snd matchRes);

		parseSubset = s: let
			parseColor = c: let
				res = match "([0-9]+) +(.+)" c;
			in
				mkMapping (snd res) (o toInt fst res);

			colors = split' ", " s;
		in
			listToAttrs (map parseColor colors);

		subsets = map parseSubset subsetsStr;
	in
		{ inherit id subsets; };

	input = map parseLine (getInputLines 2 "input");

	part1 = let
		max = { red = 12; green = 13; blue = 14; };

		isValid = s: let
			res = mapAttrs (k: v: v <= max.${k}) s; 
		in
			all id (attrValues res);

		allValid = filter (g: all isValid g.subsets) input;
	in
		sum (map (g: g.id) allValid);

	part2 = let
		listMax = foldl1 max;
		minCounts = g: zipAttrsWith (_: listMax) g.subsets;
		power = pipe' [ minCounts attrValues product ];
	in
		sum (map power input);
}
