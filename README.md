# code test

**Bug 1:**
Pads had no UI for the object/price information. I used the UI given for the Portal and replicated it across each of the pads, with updated elements to reflect the price/item you were purchasing.

**Bug 2:**
Dependencies were extremely unclear. All pads were shown, and you had to guess what pad to step on first to unlock the next pad for purchase. I fixed this by implementing a "RevealPad" system that only shows a pad to a player when the dependencies for that pad have been purchased, making it so there was no confusion about what was and was not purchasable.

**Bug 3:**
The debouncer for the paycheck machine didn't work. When you stepped on the pad, you could get multiple body part hits in quick succession and thus get several paychecks when you shouldn't be able to. This was because the RequestPaycheck invocation takes time and happened before the debouncer variable was reset, so multiple requests could be processed before the first invocation was completed. I fixed this by immediately resetting the debouncer before the server invocation was made.

**Bug 4:**
The given audio assets caused meaningless "failed to load" errors because they were (probably) Voldex private assets. I deleted everything besides what I used, and I only used assets that didn't have permission issues. This is mostly just a housekeeping thing; I don't like the Output in studio being cluttered by bad error reports.

**Vulnerability:**
The only real vulnerability I was concerned about affecting gameplay was the ability to exploit your money. The client has access to a RequestPaycheck function, which could be used to request any amount of money. I fixed this by checking the machine's withdraw amount on the server when a paycheck was requested by the client, and if there was a mismatch between the server's value for the withdraw value on the machine and the client's paycheck request amount, I declined the request and instead printed a statement saying the paycheck request was not valid.

**Addition 1:**
I rebuilt the map. I used a bunch of assets from the given collection for convenience, then brought in some of my own assets from my myriad of games built over the years. Every new addition to the map was built by me; none of these are modeled by anyone else. You can probably tell that I have a bit of an older style, building models from parts rather than using imported meshes; I like the look.

**Addition 2:**
I added a bunch of pads/buildings and a new dependency/target chain. Again, if you don't recognize the asset, I created it. 

**Addition 3:**
I added music to the game. I like having a little background noise, so I grabbed an old song asset I had uploaded to be loopable on Roblox (before copyright strikes hit; a bunch of my old audio files are definitely copyright infringement, this song probably is too.)

**Addition 4:**
UIs! I revamped the money UI, added a help UI, and 2 buttons to allow the player to teleport to the floating islands as well as to teleport back to the base (with debouncers, of course.) The new money UI now shows when money is being added or subtracted, telling you the change in your money momentarily (green for getting money, red for subtracting money.) The help UI is a pretty little scrolling frame that explains what I will in a moment; the basics of a tycoon, and my favorite addition:

**Addition 5:**
DRAGONS!
Yep. I added dragons. Flying, animated, humanoid dragons. I built them from scratch and animated them for this project, since I was supposed to have a little fun with it. They have a collection of start/finish locations to fly from/to that are randomly picked when they spawn. Every 7 seconds, there is a 25% chance of spawning a dragon overhead. There are 5 separate dragon species, with differing rarities. 1 in 20 will be an Ancient White, 2 in 20 will be a Black Nightstalker, and the remaining 17 will be generic dragons. They tween to the locations, adjusting their orientation to reflect where the target location is, so they look like they're flying properly. You can teleport to the islands to go dragon watching, up closer! There's also a pet dragon (with an animation to look alive) that you can buy at the tycoon. 

**Addition 6:**
Obvious sound effects collecting from the paycheck machine, purchasing a pad, or not having enough money to purchase a pad. There's also a visual effect for purchasing pads.

**Addition 7:**
An autocollect gamepass. I saw it as a given asset and decided to implement it. The money will not go to the paycheck machine, instead directly updating your money. This will reflect the rate of your current income, which brings me to:

**Addition 8:**
Variable income rates. Now, when you purchase pads, your income will increase. Every pad will increase your income by 10/second - this is a constant you can change to whatever, just like the base income rate (currently 25). I updated the playerData modulescript to keep track of how many pads you have purchased. This total income rate is also passed to the paycheck machines, with a UI displaying the income rate above the machine. 

**Addition 9:**
Loading screen. I like custom loading screens because they feel more polished in a game, so I used a loading screen I made for my last game (under Gamma studios, thus the Gamma Studios watermark - it's my own group for my projects.)

**Final notes:**

For the UI handling, I probably could have easily put the code for each of the teleport/help buttons into the UIHandler, but with the scale of the game and how simple the scripts were, I decided to just put them in localscripts attached to the buttons. If this were more complicated UI logic or a full game, I would handle these scripts in a more modular manner than an individual script handling it's own button.

I also recognize that I did some things that might be frowned upon for performance considerations, like using textures for all the parts, and having lots of humanoids in the place, and not using meshes that have LoD for different distances, and not using content streaming. If this were a performance-intensive game, I would have used different implementations, but these made the most sense given that it's a single player map without a ton going on. I didn't really peak above 500mb for memory, so it should run okay either way. I like the detail and the ability to look around at the floating islands and dragons, so it seemed like a good use of computational resources that should still work on mobile. A couple of the UI buttons look weird at really low resolutions, but the Money display is scaled for any device; I figured it wouldn't be especially important if the buttons are all scaled to be aesthetically pleasing on mobile.

I could write the code with different convention if given guidelines, I was working with my existing understanding of proper code convention/lua styling. The comments were to help readers understand where I made modifications, and could also be stylized differently in a professional setting.

Thanks for reading, and happy dragon watching!

-Glenn
