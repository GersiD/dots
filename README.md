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

### Some Useful Notes

- On arch, you can use bluetuith for a text based interface to connect to bluetooth devices.
- For a GUI, use blueman-manager or blueman-applet (X11 only at the time of writing).
- For audio on arch, use pavucontrol

# Exporting and Importing arch packages

### Exporting

```bash
pacman -Qqe > pkglist.txt
```
### Importing

```bash
pacman -S --needed - < pkglist.txt
```
