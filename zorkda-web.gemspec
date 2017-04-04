# coding: utf-8
lib = File.extend_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
	spec.name			= "zorkda-web"
	spec.version		= '1.0'
	spec.authors		= ["Shannon Capper"]
	spec.email			= ["ShannonLCapper@gmail.com"]
	spec.summary		= %q{Text-based web game version of The Legend of Zelda: OoT}
	spec.description	= %q{This web app combines two classic games: Nintendo's The Legend of Zelda: Ocarina of Time, and the text-based video game Zork.}
	spec.homepage		= "http://legendofzorkda.com/"
	spec.license		= "MIT"

	spec.files			= Dir["{lib}/**/*.rb", "{lib}/**/*.txt", "{lib}/**/*.json", "bin/*", "LICENSE", "*.md"]
	spec.executables	= []
	spec.test_files		= Dir["{tests}/**/*.rb"]
	spec.require_paths	= ["lib"]
end