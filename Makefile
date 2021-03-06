all: libwand_of_rust samples

libwand_of_rust:
	rustc --lib src/wand_of_rust/lib.rs -o lib/foo.so

samples: thumbnail resize extents floodfill

thumbnail: libwand_of_rust
	# ImageMagick requires that you use the MagickWand-config utility
	# to determine the specific libraries to link. We need to pass this
	# as a single argument to --link-args for rustc, hence the quotes 
	# surrounding the backticks
	rustc -L ./lib/ src/samples/thumbnail/main.rs -o bin/thumbnail \
		--link-args "`MagickWand-config  --libs)`" 

resize: libwand_of_rust
	rustc -L ./lib/ src/samples/resize/main.rs -o bin/resize \
		--link-args "`MagickWand-config  --libs)`" 

extents: libwand_of_rust
	rustc -L ./lib/ src/samples/extents/main.rs -o bin/extents \
		--link-args "`MagickWand-config  --libs)`" 

floodfill: libwand_of_rust
	rustc -L ./lib/ src/samples/floodfill/main.rs -o bin/floodfill \
		--link-args "`MagickWand-config  --libs)`" 

clean: 
	rm -Rf ./lib/*.so ./bin/*
