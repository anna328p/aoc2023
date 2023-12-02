{ stdenv
, lib
, ruby_3_2
}:

stdenv.mkDerivation {
	pname = "TODO";
	version = "0";

	nativeBuildInputs = [

	];

	buildInputs = [
		ruby_3_2
	];

	meta = {
		maintainers = [ lib.maintainers.anna328p ];
	};
}
