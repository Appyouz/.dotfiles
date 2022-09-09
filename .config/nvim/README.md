# nvim

A personal Neovim config along with c++ auto completion using ccls
### clangd is much easier (imo) ###

## Installation 
Takes arch linux as a platform, just use your respective package manager for installing packages(for eg:- `sudo apt install` for debian)

1. Install [Node.js](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiehrffoeT3AhWeRmwGHcKWAoYQFnoECAgQAQ&url=https%3A%2F%2Fnodejs.org%2F&usg=AOvVaw1tY2p-vJFWJmxWlq4sTxCn)
``` bash 
sudo pacman -S nodejs
``` 
2. Install [Ccls](https://github.com/MaskRay/ccls)

 ``` bash
 sudo pacman -S ccls
 ```
 
3. You will be needing [vim-plug](https://github.com/junegunn/vim-plug#installation) to install the required plugins.



## Usage
 - Once you are done installing vim-plug, 
 - Make a new directory inside `.config` folder named as `nvim` ( `mkdir .config/nvim`)<br>
 - open up the `init.vim` file and use the following commands<br>
 - (you might see some warnings just dont freak out, everything will be fine once done installing plugins) :

```bash
:PlugInstall
```
After that create a file named as `.ccls` in your project folder and add these two lines:
``` bash
clang++
%h %cpp -std=c++17
```
That's it you are now good to go if no errors were occured

You will need nerdfonts installed in your system for airline symbols mentioned in the init.vim file.


## License
[MIT](https://choosealicense.com/licenses/mit/)
