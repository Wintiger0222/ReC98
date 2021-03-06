# The Touhou PC-98 Restoration Project (*"ReC98"*)

[![4-week crowdfunding goal…](https://rec98.nmlgc.net/badge/cap)](https://rec98.nmlgc.net)

|    Reverse-engineered: | [![All games…](https://rec98.nmlgc.net/badge/re)][HP] | [![TH01…](https://rec98.nmlgc.net/badge/re/1)][HP] | [![TH02…](https://rec98.nmlgc.net/badge/re/2)][HP] | [![TH03…](https://rec98.nmlgc.net/badge/re/3)][HP] | [![TH04…](https://rec98.nmlgc.net/badge/re/4)][HP] | [![TH05…](https://rec98.nmlgc.net/badge/re/5)][HP] |
|-----------------------:|---|---|---|---|---|--|
| [Position independence]: | [![All games…](https://rec98.nmlgc.net/badge/pi)][HP] | [![TH01…](https://rec98.nmlgc.net/badge/pi/1)][HP] | [![TH02…](https://rec98.nmlgc.net/badge/pi/2)][HP] | [![TH03…](https://rec98.nmlgc.net/badge/pi/3)][HP] | [![TH04…](https://rec98.nmlgc.net/badge/pi/4)][HP] | [![TH05…](https://rec98.nmlgc.net/badge/pi/5)][HP] |

[Check the homepage for more detailed progress numbers and information about the crowdfunding!][HP]

[HP]: https://rec98.nmlgc.net
[Position independence]: https://rec98.nmlgc.net/faq#position-independence

----

### Overview

This project aims to perfectly reconstruct the source code of the first five [Touhou Project](http://en.wikipedia.org/wiki/Touhou_Project)  games by *ZUN Soft* (now *Team Shanghai Alice*), which were originally released exclusively for the NEC PC-9801 system.

The original games in question are:

* TH01: 東方靈異伝　～ The Highly Responsive to Prayers (1997)
* TH02: 東方封魔録　～ the Story of Eastern Wonderland (1997)
* TH03: 東方夢時空　～ Phantasmagoria of Dim.Dream (1997)
* TH04: 東方幻想郷　～ Lotus Land Story (1998)
* TH05: 東方怪綺談　～ Mystic Square (1998)

Since we only have the binaries, we obviously can't know how ZUN named any variables and functions, and which comments the original code was surrounded with. *Perfect* therefore means that the binaries compiled from the code in the ReC98 repository are [indistinguishable] from ZUN's original builds, making it impossible to *disprove* that the original code *couldn't* have looked like this. This property is maintained for every Git commit along the way.

Aside from the preservation angle and the resulting deep insight into the games' mechanics, the code can then serve as the foundation for any type of mod, or any port to non-PC-98 platforms, developed by the community. This is also why ReC98 values *readable and understandable* code over a pure decompilation.

#### Why?
There are a number reasons why achieving moddability via full decompilation seems to be more worthwhile for the PC-98 games, in contrast to a [PyTouhou](http://pytouhou.linkmauve.fr/)-style black-box reimplementation:

* While stage enemies and their bullet patterns are controlled by bytecode in TH04's and TH05's .STD files that *could* just be interpreted by an alternate VM, midboss and boss battles are entirely hardcoded into the executables.
* Even though complete decompilation will take a long time, partial reverse-engineering results will be very useful to modders who just want to work on the original PC-98 versions of the games.
* PC-98 emulation is messy and overly complicated. It has been getting better as of 2018 thanks to [DOSBox-X](https://github.com/joncampbell123/dosbox-x) adding support for the platform, but even at its best, it will always consume way more system resources than what would be appropriate for those games.
* thcrap-style multilingual translation on PC-98 would be painful for languages with non-ASCII scripts. The obvious method of modifying the font ROM specifically for each language is ugly and won't work on real hardware, so a custom renderer would be needed. That by itself requires a lot of reverse-engineering and, preferably, compilable source code to avoid the limits of hex-editing. Or, even better, the prospect to do this entirely on a more modern system.
* These games stopped being sold in 2002, ZUN has confirmed on multiple occasions to have lost all the data of the "earlier games" <sup>[citation needed]</sup>, and PC-98 hardware is long obsolete. In short, these games are as abandoned as they can possibly be, and are unlikely to ever turn a profit again.

#### Is this even viable?
Definitely. During the development of the static English patches for these games, we identified two main libraries used across all 5 games, and even found their source code. These are:

* [master.lib](http://www.koizuka.jp/~koizuka/master.lib/), a 16-bit x86 assembly library providing an abstraction layer for all components of a PC-98 DOS system
* as well as the Borland C/C++ runtime library, version 4.0.
* Additionally, TH01 includes the [Pi loader library by 電脳科学研究所/BERO](http://www.vector.co.jp/soft/dos/prog/se037608.html),
* and TH03's `ZUNSP.COM` (accessible via `ZUN.COM -4`) is a rebranded version of Promisence Soft's `SPRITE16.COM`, a 16-color PC-98 EGC display driver, version 0.04, which was bundled with the sample game *StormySpace*.

master.lib and the C/C++ runtime alone make up a sizable amount of the code in all the executables. In TH05, for example, they amount to 74% of all code in `OP.EXE`, and 40% of all code in `MAIN.EXE`. That's already quite a lot of code we do not have to deal with. Identifying the rest of the code shared across the games will further reduce the workload to a more acceptable amount.

With DOSBox-X and [the Debug edition of Neko Project II](https://github.com/nmlgc/np2debug), we now also have two open-source PC-9821 emulators capable of running the games. This will greatly help in understanding all hardware-specific code.

And while this project has made decent progress so far, completing the decompilation of even just a single game will still take a long time. Any help will be appreciated! If you are interested, check [`CONTRIBUTING.md`](CONTRIBUTING.md) for the general contribution guidelines.

## Dumped executables
* TH01: `zunsoft.com`, `op.exe`, `reiiden.exe`, `fuuin.exe`
* TH02: zun.com (<s>`ongchk.com`</s>, `zuninit.com`, `zun_res.com`, <s>`zunsoft.com`</s>), `op.exe`, `main.exe`, `maine.exe`
* TH03: zun.com (<s>`ongchk.com`</s> [-1], <s>`zuninit.com`</s> [-2], <s>`zunsoft.com`</s> [-3], `zunsp.com` [-4], `res_yume.com` [-5]), `op.exe`, `main.exe`, `mainl.exe`
* TH04: zun.com (<s>`ongchk.com`</s> [-O], `zuninit.com` [-I], `res_huma.com` [-S], `memchk.com` [-M]), `op.exe`, `main.exe`, `maine.exe`
* TH05: zun.com (<s>`ongchk.com`</s> [-O], `zuninit.com` [-I], `res_kso.com` [-S], `gjinit.com` [-G], `memchk.com` [-M]), `op.exe`, `main.exe`, `maine.exe`

Crossed-out files are identical to their version in the previous game. ONGCHK.COM is part of the PMD sound driver by KAJA, and therefore doesn't need to be disassembled either; we only need to keep the binary to allow bit-perfect rebuilds of ZUN.COM.

## Building
You will need:

* **Borland Turbo C++ 4.0J**

  This was the compiler ZUN originally used, so it's the only one that can deterministically compile this code to executables that are bit-perfect to ZUN's original ones.

  ----

* **Borland Turbo Assembler (TASM), version 4.1 or later, for 16-bit DOS (`TASM.EXE`)**

  Towards TH05, the games increasingly used raw ASM code that [can't be decompiled]. Thus, even the final 16-bit-only build will need some sort of assembler.

  ----

* **Borland Turbo Assembler (TASM), version 5.0 or later, for 32-bit Windows (`TASM32.EXE`)**

  Borland never made a cross compiler targeting 16-bit DOS that runs on 32-bit Windows, so the C++ parts *have* to be compiled using a 16-bit DOS program. The not yet decompiled ASM parts of the code, however, *can* be assembled using a 32-bit Windows tool. This not only way outperforms any 16-bit solution that would have to be emulated on modern 64-bit systems, making build times, well, tolerable. It also removes any potential EMS or XMS issues we might have had with `TASMX.EXE` on these emulators.

  These advantages were particularly relevant in the early days of ReC98, when the ASM files were pretty huge. That's also when I decided to freely use long file names that don't need to conform to the 8.3 convention… As a result, the build process still starts with a separate 32-bit part (`build32b.bat`), which must be run in Windows (or Wine).

  In the end though, we'd definitely like to have a single-step 16-bit build process that requires no 32-bit tools. This will probably happen some time after reaching 100% position independence over all games.

  ----

* **Borland C++ 5.5, for 32-bit Windows (`BCC32.EXE`)**

  Released as freeware, and as of July 2020, still sort of officially downloadable from

    http://altd.embarcadero.com/download/bcppbuilder/freecommandLinetools.exe

  (SHA-256 `433b44741f07f2ad673eb936511d498c5a6b7f260f98c4d9a6da70c41a56d855`)

  Needed to fulfill the role of being "just *any* native C++ compiler" for our own tools that either don't necessarily *have* to run on 16-bit DOS, or are required by the 32-bit build step, as long as that one still exists (see above).

  Currently, this category of tools only includes the [converter for hardcoded sprites]. Since that one is written to be as platform-independent as possible, it could easily be compiled with any other native C compiler you happen to have already installed. (Which also means that future port developers hopefully have one less thing to worry about.)
  However, choosing Borland C++ 5.5 fits ReC98 very well for a number of reasons:

  * It still happens to be the most hassle- and bloat-free way to get *any* sort of 32-bit Windows C++ compiler to people, clearly beating Open Watcom, and the required registration for [Borland/Embarcadero's own C++ 7.30]. Depending on anything bigger would be way out of proportion, considering how little we use it for
  * We already rely on a 32-bit Windows tool
  * Turbo C++ 4.0J defines the lower bound for our allowed level of C++ features anyway, making Borland C++ 5.5's old age and lacking C++ standard compliance a non-issue
  * Unlike 7.30, 5.5 still works on Windows 9x, which is what typically runs on the real PC-98 hardware that some people might want to compile ReC98 on.
  * Other tiny C compilers have no C++ support.

  ----

* **DOSBox** (if you're running a 64-bit version of Windows, or a non-Windows operating system)

  For the most part, it shouldn't matter whether you use [the original DOSBox](https://dosbox.com) or your favorite fork. A DOSBox with dynamic recompilation is highly recommended for faster compilation, though. Make sure to enable that feature by setting the following options in its configuration file (`dosbox.conf` for the original version):

  ```ini
  [cpu]
  core=dynamic
  cycles=max
  ```

  ----

To build, simply run `build.bat` and follow any instructions. The final executables will be put into `bin\th0?`, using the same names as the originals.

----

[indistinguishable]: https://github.com/nmlgc/mzdiff
[can't be decompiled]: Research/Borland%20C++%20decompilation.md#limits-of-decompilability
[converter for hardcoded sprites]: https://github.com/nmlgc/ReC98/issues/8
[Borland/Embarcadero's own C++ 7.30]: https://www.embarcadero.com/de/free-tools/ccompiler/free-download
