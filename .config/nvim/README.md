# nvim

A personal Neovim config along with c++ auto completion using clangd

## Installation 
Takes arch linux as a platform, just use your respective package manager for installing packages(for eg:- `sudo apt install` for debian)

1. Install [Node.js](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwiehrffoeT3AhWeRmwGHcKWAoYQFnoECAgQAQ&url=https%3A%2F%2Fnodejs.org%2F&usg=AOvVaw1tY2p-vJFWJmxWlq4sTxCn)
``` bash 
sudo pacman -S nodejs
``` 
2. Install [Clangd](https://clangd.llvm.org/installation)

 ``` bash
 sudo pacman -S clangd
 ```
 
3. You will be needing [vim-plug](https://github.com/junegunn/vim-plug#installation) to install the required plugins.



## Usage
 - Once you are done installing vim-plug, 
 - Create a new directory inside `.config` folder named as `nvim` ( `mkdir .config/nvim`)<br>
 - open up the `init.vim` file and use the following command<br>
 - (you might see some warnings just dont freak out, everything will be fine once plugins are installed) :

```bash
:PlugInstall
```
In case you haven't installed clangd use the following command
```bash
:CocInstall coc-clangd
```
Check this if you get confused or coc.nvim is not working as intended [coc.clangd](https://github.com/clangd/coc-clangd#quick-start) and [coc.nvim](https://github.com/clangd/coc-clangd#quick-start)

That's it 

<mark>Note: You will need [nerdfonts](https://www.nerdfonts.com/font-downloads) installed in your system for airline symbols mentioned in the init.vim file.</mark>


## License
[MIT](https://choosealicense.com/licenses/mit/)
