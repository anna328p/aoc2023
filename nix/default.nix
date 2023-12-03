{ nix-prelude, ... }@flakes:

let
	L = nix-prelude.lib;

	inherit (L)
		mkLibrary
		;
in mkLibrary {
	inherit L flakes;
	inputDir = ../inputs;
	
} ({ using, ... }:
	using {
		day1 = ./1.nix;
	} (_: {}))
