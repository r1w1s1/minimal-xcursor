THEME       ?= minimal-xcursor
ICON_ROOT   ?= $(HOME)/.icons
DESTDIR     ?=
THEME_DIR   = $(DESTDIR)$(ICON_ROOT)/$(THEME)
BUILD_DIR   = build/$(THEME)/cursors
CURSOR      = $(BUILD_DIR)/left_ptr

.PHONY: all build check-install install test clean

all: build

build: $(CURSOR)

$(CURSOR): cursor.png cursors/left_ptr.conf
	@mkdir -p $(BUILD_DIR)
	xcursorgen -p . cursors/left_ptr.conf $@

check-install:
	@if [ -L "$(THEME_DIR)" ]; then \
		echo "Refusing to install through symlink: $(THEME_DIR)" >&2; \
		exit 1; \
	elif [ -e "$(THEME_DIR)" ] && [ "$(FORCE)" != "1" ]; then \
		echo "Refusing to overwrite existing theme: $(THEME_DIR)" >&2; \
		echo "Use FORCE=1 only if replacing this theme is intentional." >&2; \
		exit 1; \
	fi

install: check-install $(CURSOR)
	install -d $(THEME_DIR)/cursors
	install -m 0644 index.theme $(THEME_DIR)/index.theme
	install -m 0644 cursor.png $(THEME_DIR)/cursors/cursor.png
	install -m 0644 $(CURSOR) $(THEME_DIR)/cursors/left_ptr
	ln -sfn left_ptr $(THEME_DIR)/cursors/top_left_arrow

test: install
	XCURSOR_THEME=$(THEME) XCURSOR_SIZE=16 xsetroot -cursor_name left_ptr

clean:
	rm -rf build
