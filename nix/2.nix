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
		;
in rec {
	exports = self: {};

	toInt = fromJSON;

	parseLine = line: let
		re = "Game (.+): (.*)$";
		matchRes = match re line;

		id = toInt (elemAt matchRes 0);

		subsets = split "; " (elemAt matchRes 1);
		subsets' = filter isString subsets;

		parseSubset = s: let
			colors = filter isString (split ", " s);

			parseColor = c: let
				res = match "([0-9]+) +(.+)" c;
			in
				{ name = elemAt res 1; value = toInt (elemAt res 0); };
		in
			listToAttrs (map parseColor colors);

		subsets'' = map parseSubset subsets';

		res = { inherit id; subsets = subsets''; };
	in
		res;

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
