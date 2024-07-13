build:
	mkdir -p build
	# Build C++ tools
	for f in tool/*.cpp; do \
		g++ -std=c++17 -o build/$$(basename $${f%.cpp}) $$f; \
	done
	# Copy shell scripts and remove .sh extension (if scripts exist)
	for f in script/*.sh; do \
		if [ -f "$$f" ]; then \
			cp $$f build/$$(basename $${f%.sh}); \
		fi \
	done; \
	chmod +x build/*

install:
	mv build/* ~/.local/bin

clean:
	rm -rf build

.PHONY: build clean
