## Personal Dotfiles

### Installation

First install `GNU stow`:

```bash
sudo apt-get install stow
```
Then use GNU stow to install the dotfiles:

```bash
stow */
```

### To Install Apt Packages

```bash
sudo apt-get install $(cat ./packages.txt)
```
