# Setup

## Deployment

### Linux

```sh
$ git clone https://github.com/aldn/dotfiles .cfg
$ cd .cfg
$ ./deploy.sh
```

### Windows

Run cmd.exe as administrator (for mklink)
```cmd
> c:
> cd %USERPROFILE%
> git clone https://github.com/aldn/dotfiles
> dotfiles\deploy-win.cmd
```

## Aux installations

### oh-my-zsh

https://github.com/robbyrussell/oh-my-zsh
 
```
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
