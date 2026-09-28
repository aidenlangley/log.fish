# log.fish

Easily log messages. Include timestamps with `-t/--timestamp`.

## Install

via [oh-my-fish](https://github.com/oh-my-fish/oh-my-fish):

```fish
omf install log.fish

```

via [fisher](https://github.com/jorgebucaran/fisher):

```fish
fisher install aidenlangley/log.fish
```

## Usage

```fish
log --timestamp --level DBG [MSG]...
log --level INF [MSG]...
log --level WARN [MSG]...
log --level ERR [MSG]...
log --level OK [MSG]...
```
