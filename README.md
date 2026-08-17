# minimal-xcursor

A minimal Linux/X11 Xcursor theme based on a custom 16x16 RGBA PNG.

![Cursor](cursor.png)

The theme provides `left_ptr` with a hotspot at `(0, 0)` and inherits all
other cursors from `whiteglass`. The `top_left_arrow` alias points to the
custom cursor; generic aliases are intentionally not provided so that other
cursors keep using `whiteglass`.

## Requirements

- X.Org `xcursorgen`
- X11 `xsetroot` for the optional test command
- The `whiteglass` cursor theme

No additional software is required.

## Build and Install

Install the theme in the current user's `~/.icons` directory:

```sh
make install
```

Installation refuses to overwrite an existing theme directory or follow a
symlink. To intentionally update an existing `minimal-xcursor` installation:

```sh
make install FORCE=1
```

To install it under another icon root, such as `/usr/share/icons`:

```sh
make install ICON_ROOT=/usr/share/icons
```

The global installation only uses `/usr/share/icons/minimal-xcursor`. It does
not modify unrelated themes. Use `sudo` only when the target requires it:

```sh
sudo make install ICON_ROOT=/usr/share/icons
```

## Test

```sh
XCURSOR_THEME=minimal-xcursor XCURSOR_SIZE=16 \
  xsetroot -cursor_name left_ptr
```

Or build, install, and test in one step:

```sh
make test
```

## Persistent Configuration

Add these lines before `exec cwm` in `~/.xinitrc`:

```sh
export XCURSOR_THEME=minimal-xcursor
export XCURSOR_SIZE=16
```
