Hydra-Config
============

A more modular and extensible take on a [Hydra](https://github.com/sdegutis/hydra) configuration.

#### Design Consideraitons
 
I've opted against using the hydra.ext namespace, as I have written my own importer to take care of this. Ideally, everything should be erased, and re-loaded upon config reload. This is something hydra.ext doesn't really take care of in a way that I like.

**NOTE: This hydra config uses the latest features (some of which I contributed) to Hydra. If it does not work on the latest release of hydra, you'll need to compile the latest version of Hydra from git and run it yourself.**

### Important Files

 * `config.lua` - The configuration file, that contains configuration options for every module.
 * `init.lua` - The bootstrapper that loads modules defined in the config, and handles the menu. 
 
### Utils
I've written a few utilities to take care of some general purpose functionality: 

 * `utils/find.lua` - Convenience methods for finding windows, and audio devices. 
 * `utils/import.lua` - My own take of require() with its own cache. Use `import` everywhere you would have used `require`. `init.lua` takes care of clearing the cache, each reload, so you don't have to worry.
 * `utils/inspect.lua` - Table inspector from http://github.com/kikito/inspect.lua
 * `utils/monitors.lua` - Monitor detection & window positioning helpers.
 * `utils/position.lua` - Functions to resize a window within a screen.
 * `utils/matchers/match.lua` - A shitty fuzzy matching & scoring function.
 * `utils/match_dialgoue.lua` - Utility to create a specialized text view that can be used to do fuzzy match navigating (or menus or whatever.. see `utils/fuzzy_match.lua`, and `modules/app_selector.lua`).
 * `utils/nudge.lua` - Utility functions to nudge a window. Thanks @josheschulz.
 * `utils/music/*.lua` - Utility functions for controlling Spotify, iTunes and Rdio.
 
### Modules 
A few modules to handle stuff I needed hydra to do:

* `modules/reload.lua` - Handles reloading hydra.
* `modules/repl.lua` - Handles launching the repl.
* `modules/updates.lua` - Handles checking for Hydra updates.
* `modules/lock.lua` - Handles locking the screen when F13 is pressed.
* `modules/arrows.lua` - Handles positioning a window on the current screen.
* `modules/monitors.lua` - Handles moving windows between screens. 
* `modules/arrangement.lua` - Handles building window arrangements, that arrange windows on multiple screens. I use this to move windows to different monitors automatically.
* `modules/app_selector.lua` - Focus windows by fuzzy matching their titles. Uses `utils/match_dialogue`.
* `modules/fullscreen.lua` - Universal shortcut to toggle full screen.
* `modules/slide.lua` - Handles nudging windows via `utils/nudge.lua`. Thanks @josheschulz.
* `modules/hop.lua` - Handles focusing windows in relative directions. Thanks @josheschulz.


### License

> Released under MIT license.
>
> Copyright (c) 2014 Jacob Heinz
>
> Permission is hereby granted, free of charge, to any person obtaining a copy
> of this software and associated documentation files (the "Software"), to deal
> in the Software without restriction, including without limitation the rights
> to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> copies of the Software, and to permit persons to whom the Software is
> furnished to do so, subject to the following conditions:
>
> The above copyright notice and this permission notice shall be included in
> all copies or substantial portions of the Software.
>
> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
> AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> THE SOFTWARE.