{ nix-prelude, ... }@flakes:

let
	L = nix-prelude.lib;

	inherit (builtins)
		readFile
		toString
		filter
		stringLength
		;

	inherit (L)
		mkLibrary
		pipe
		lines
		;
in mkLibrary rec {
	inherit L flakes;
	inputDir = ../inputs;

	getInput = day: name:
		readFile "${inputDir}/${toString day}/${name}.txt";
	
	getInputLines = day: name:
		pipe (getInput day name) [
			lines
			(filter (v: stringLength v > 0))
		];
	
} ({ using, ... }:
	using {
		day1 = ./1.nix;
		day2 = ./2.nix;
	} (_: {}))
