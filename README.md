
# Table of Contents <!-- omit from toc -->
- [🛫 Overview: What the Skibidi is it?](#-overview-what-the-skibidi-is-it)
- [🌟 Highlights](#-highlights)
- [💭 Why Use it](#-why-use-it)
- [🚀 Getting Started](#-getting-started)
    - [Dependencies](#dependencies)
    - [Installation:](#installation)
    - [Recommended Usage](#recommended-usage)
- [💥 What to Put Where](#-what-to-put-where)
- [📖 Resources](#-resources)
- [✏ Contributing](#-contributing)


# 🛫 Overview: What the Skibidi is it?
Simple cross-platform (Mac and Windows) dotfiles manager CLI built on top of dotbot. Lets you have a consistant dev environment by bootstrapping and automatically adding dotfile symlinks to your computers from within the terminal, think GNU Stow (kinda?) but works on windows too!

Soooo... use cases kinda like this:

> *working on windows* "I want my .config folder symlinked to my dotfiles on both Mac and Windows!"
- in terminal run `dotfiles add .config` to symlink your .config folder
  
  ```yaml
  # this will be added to dotbot's install.conf.yaml
  - link:
    ~/.config: .config
  ```
> "I *only* want my ~/AppData/Roaming/fd folder to be symlinked on windows"
- in terminal run `dotfiles add -w ~/AppData/Roaming/fd` to symlink your .config folder
  ```yaml
  # this will be added to dotbot's install.conf.yaml
  - link:
    ~/AppData/Roaming/fd:
    path: AppData/Roaming/fd
    if: "[ `uname` != Darwin ]"
  ```
> *working from pc:* "hey, this is a really cool package/alias! let me add it to my aliases"
- add to your .global_rc/.global_aliases file: `alias ls='eza --color=always --icons=always'`
- run `dotfiles yeet` in terminal to &#xf1d8; YEET your dotfiles repo to remote (basically git push)
- goto coffee shop (required ;P) and whip out your ***shiny*** mac
- run `dotfiles yank` in mac terminal to *"GET OVAH-HERE"* your dotfiles (basically git pull). Then `dotfiles bootstrap` to add any new packages/fonts/plugins and link any new symlinks you may have added to you're dotfiles!
> [!NOTE]
> You can also just run `dotfiles link` to skip bootstrapping and just link symlinks

# 🌟 Highlights
- Simple File Management: Easily add files and directories to your dotfiles repository with a single terminal command.

- OS-Specific Symlinks: Define macOS- or Windows-specific symlinks for platform-dependent configurations.

- Integrated Bootstrapping: Automatically install fonts, package managers, packages, and tools tailored to macOS or Windows environments.

- Backup current homebrew/choco packages directly to your dotfiles.

- Cross-Platform Support: Aimed at users who frequently switch between macOS and Windows without relying on WSL2.

- Customizable Bootstrapping: Extend the bootstrapping process to install additional plugins or packages.

> [!IMPORTANT]
> For windows you must be using git bash. Cygwin and other emulators might work, but i didn't test them.

# 💭 Why Use it
Simply put i *really* wanted gnu stow or something similar on my windows pc, just some way to make my experience on windows similar to mac. [Chezmoi](https://github.com/twpayne/chezmoi) for some reason didnt work for me so i made this, but feel free to first try CHEZZZZ-moooooiii 🎶 Fuis-moi, le pire, c'est toi et moi 🎶 (kudos if you get the ref)

This leads me to the tinnie tiny elphant in the room... git bash. Yaaa i know werid. But fr couldnt really find a better solution. I didnt want to go the WSL2 route and well... powershell... "*sheesh, i aint that crazy*" (kudos x2)

# 🚀 Getting Started
### Dependencies

Make sure the following are installed on your systems
<details>
  <summary>Choco</summary>
  
  https://chocolatey.org/install
  
  > Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'

</details>

<details>
  <summary>Git (obviously) and git bash</summary>
  
  you should already have this installed. For more info see [📖 Resources](#-resources) "Getting unix commands"

</details>

<details>
  <summary>Dotbot</summary>
  
  https://github.com/anishathalye/dotbot

  Dotbot handles all the backend symlinking and runs off of python. It's already a submodule on this project so you shouldn't need to do anything extra unless your integrating into an existing dotfiles repo. For that follow the proper install method down below.

</details>

<details>
  <summary>Python</summary>
  hsssss 🐍

</details>

<details>
  <summary>Others</summary>
  These following are needed but get installed during the bootstrap process so you dont need to install them separately.

  - Homebrew
  - Homebrew/bundle
  - YQ

</details>
 
### Installation:

First add to .bashrc & .zshrc
```
# sourcing univeral aliases add to both .bashrc & .zshrc
source ~/.config/global-rc/.global-aliases
source ~/.config/global-rc/.global-rc
```

Next adjust export DOTFILES in `~/.config/global-rc/.global-rc` to point to where your dotfiles dir is located in both pcs. If they are different on each pc delete the entry from .global-rc and set the export in each .bashrc & .zshrc respectively. Ignore this if you already have the env var setup. Then follow one of the below 

<details>
<summary>Fresh Install:</summary>

- Fork this repo and clone it to your system with all submodules (or ssh if thats your thang)
  ```
  git clone --recurse-submodules https://github.com/YouSame2/dotfiles.git
  ```

- Ensure submodules are up-to-date
  ```
  git submodule update --init --recursive
  ```

- Add any homebrew recipes and any choco packages you would like to install in the bootstrap process to `$DOTFILES/bootstrap/mac/brewfile` & `$DOTFILES/bootstrap/windows/packages.config` respectively. **Do not** remove any.

- Add any additional commands/plugins you would like to install with the bootstrap process to the bottom of `$DOTFILES/bootstrap/bootstrap.sh` under 'echo "------- Bootstrapping plugins..."'

  > [!NOTE]
  > Check out my personal dotfiles for ideas/reference

- Restart your preferred terminal, navigate to `$DOTFILES/bootstrap` dir and run:
  ```
  ./bootstrap.sh
  ```
 
</details>

<details>
<summary>Integrate With Existing Dotfiles:</summary>

- If your dotfiles do not already have the dotbot submodule run the following inside dotfiles dir:
  ```shell
  git submodule add https://github.com/anishathalye/dotbot
  git config -f .gitmodules submodule.dotbot.ignore dirty # ignore dirty commits in the submodule
  # no need to copy install file & install.conf.yaml i provided templates already
  ```

Imma be honest i havnt done this before so let me just explain what you need to do and go based of that 👍🏽. Essentially all contents of this project (i.e. dotfiles.sh, bootstrap/, dotbot, etc) need to be in the root of your dotfiles repo. Best thing i can think of is clone this repo (after doing initial steps above) into a temp dir and paste the files inside your dotfiles. If anyone knows a better way please let me know.

Once they are copied should should be able to process the same as 'Fresh Install'. Continue from 3rd bullet point.

</details>
    
### Recommended Usage
# 💥 What to Put Where
# 📖 Resources
- similar concept:
  
  https://gilbertsanchez.com/posts/terminals-shells-and-prompts/
  
- getting unix commands on windows powershell (towards bottom of page)
  
  https://medium.com/@GalarnykMichael/install-git-on-windows-9acf2a1944f0
  
  https://medium.com/@thopstadredner/transforming-your-windows-terminal-into-a-mac-like-experience-1ec95d206114

- wezterm os detection. The most common triples are:

  for more information see docs: https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html?h=windows
  - x86_64-pc-windows-msvc - Windows
  - x86_64-apple-darwin - macOS (Intel)
  - aarch64-apple-darwin - macOS (Apple Silicon)
  - x86_64-unknown-linux-gnu - Linux

# ✏ Contributing
TODO:

still a lot to do as im learning bash and terminal.

- [x] consolodate dotfiles-add and dotfiles-sync into the same script taking args. So instead you use it like a normal cli: i.e. dotfiles add -m file1.lua
- [x] change format of yaml yq command so you can choose to specify if a committed dotfile should be MAC/WINDOWS/BOTH (-m -w) specific
- [x] change dotfiles-sync name (maybe link?)
- [x] change dotfiles-link function in script and aliases
- [x] fix git functionality and test it
- [x] add if statements for os specific symlinks
- [ ] when adding file/folder with no OS_FLAG (i.e. 'dotfiles add .config') in 'install.conf.yaml', if that file/folder already had an if statement the if statement wont get removed. this can lead so some unexpected behavior in rare situations. Im probably not going to deal with it since its niche, but feel free for a simple contribution if u want.

<!--
# Windows:

so far this is what ive done to get this to work on windows. Im still in the process making it.

In evalated PS:

## 1. Clone Dotfiles Repo

## 2. CHOCOLATEY
   ```
   Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
   ```

## 3. Install DotBot

   ```pip install dotbot```

## 4. Update Submodule

   ```git submodule update --init --recursive```

## 5. Run Dotbot

   ```dotbot -c install.conf.yaml```

## 6. Install Nerd Fonts

## 7. Explainations

   - Shells & Aliases
   
     setting aliases across mac and windows is a bit scuffed so in the end i settled on this:

     windows i use git bash as my shell (currently, unless i find something better without WSL) and mac i use default zsh. doing this means both shells are fairly similar so i dont have to remember "oh, what was ls in windows again?"

     for aliases since windows uses bash and mac uses zsh just put os specific aliases in there corresponding dotfile. for universal aliases (that work on both platforms) put it into .config/aliases/.universal_aliases. this file is then sourced in both .zshrc and .bashrc 🤯
 -->