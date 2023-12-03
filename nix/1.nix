{ L, inputDir, ... }:

let
	inherit (builtins)
		readFile
		head
		split match
		concatLists
		filter
		isList
		stringLength
		;

	inherit (L)
		lines
		last
		charToInt
		pipe
		sum
		;
in rec {
	exports = self: { };

	input = pipe "${inputDir}/1/input.txt" [
		readFile
		lines
		(filter (v: stringLength v > 0))
	];

	parseDigit = d: (charToInt d) - (charToInt "0");

	matchAll = re: str: concatLists (filter isList (split re str));

	part1 = let
		lineToInt = line: let
			matches = matchAll "([[:digit:]])" line;

			fm = parseDigit (head matches);
			lm = parseDigit (last matches);
		in
			fm * 10 + lm;
	in
		sum (map lineToInt input);
	
	part2 = let
		lut = {
			"0" = 0;
			"1" = 1; one   = 1;
			"2" = 2; two   = 2;
			"3" = 3; three = 3;
			"4" = 4; four  = 4;
			"5" = 5; five  = 5;
			"6" = 6; six   = 6;
			"7" = 7; seven = 7;
			"8" = 8; eight = 8;
			"9" = 9; nine  = 9;
		};

		lineToInt = line: let
			d = "(one|two|three|four|five|six|seven|eight|nine|[0-9])";
			firstMatch = lut.${head (matchAll d line)};
			lastMatch = lut.${last (match ".*${d}.*" line)};
		in
			firstMatch * 10 + lastMatch;
	in
		sum (map lineToInt input);
}
