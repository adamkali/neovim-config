# Based Config 

This config is meant to be a rework of my Configuration for Neovim that was built of the Lazy plugin manager.

This config only uses the neovim native package manager `vim.pack` to install the plugins.

I hope you enjoy.

## Installation

```bash
```


## Keybindings

This keybinding convention is meant to be used with mnemonic keybindings.
so you should be able to remember once you try them out and not have to look them up a second time.

### Base Keybindings


| Mapping | Value |
| -------------- | --------------- |
| <leader> | `<space>` |


| Mapping | Value | Does |
| --------------- | --------------- | --------------- |
| t | j | Moves Down |
| n | k | Moves Up |
| s | l | Moves Right |
| k | n | Moves Left |
| T | J | Moves Down |
| N | K | Moves Up |
| S | L | Moves Right |
| K | N | Moves Left |
| <C-h> | :wincmd h <CR> | Moves to the Left Window |
| <C-t> | :wincmd j <CR> | Moves to the Bottom Window |
| <C-n> | :wincmd k <CR> | Moves to the Top Window |
| <C-s> | :wincmd l <CR> | Moves to the Right Window |
| <C-[> | <C-f>zz<CR> | Moves page down, and recenters |
| <C-]> | <C-d>zz<CR> | Moves page up, and recenters |
| <C-a> | :wall<CR> | Save All Files |
| <C-z> | :qa<CR> | Quit All Files |
| <C-q> | :bd!<CR> | Remove Current Buffer |
| <C-A-H> | :nohlsearch<CR> | Remove Highlight |
| Y | "+y" | Copy to clipboard |
| <C-y> | y$ | Yank from cursor to end of line |
| <C-h> | :wincmd h <CR> | Move to the left window |
| <C-t> | :wincmd j <CR> | Move to the bottom window |
| <C-n> | :wincmd k <CR> | Move to the top window |
| <C-s> | :wincmd l <CR> | Move to the right window |
| <C-o> | :Oil<CR> | Open the current directory in Oil |
| <C-R> | <cmd>restart<CR> | Restart Neovim |


### Arbitrary Keybindings

The following are arbitrary keybindings that I have used in the past. 

#### Leader

| Mapping | Value |
| -------------- | --------------- |
| <leader>a | Arbitrary Leader |


#### Keybindings

##### Normal Mode

| Mapping | Value | Description |
| --------------- | --------------- | --------------- |
| f | <space>af | Insert the current filename |
| F | <space>aF | Insert the fully qualified filename |
| y | <space>ay | Yank the filename |
| Y | <space>aY | Yank the fully qualified filename |
| d | <space>ad | Insert the current date and time |
| c | <space>ac | Copy the filename |
| C | <space>aC | Copy the fully qualified filename |
| '\|' | '<space>a\|` | (vertical) Split the current buffer with a scratch buffer |
| - | <space>a- | Split the current buffer with a scratch buffer |
| D | <space>aD | Insert the current date with the specified number of days |


##### Visual Mode

| Mapping | Value | Description |
| --------------- | --------------- | --------------- |
| j | <space>aj | Format selected lines with jq |

### Control Keybindings 

#### Leader

| Mapping | Value |
| -------------- | --------------- |
| <leader>c | Control Leader |
| <leader>cc | Config Leader |
| <leader>ct | Console Leader |


#### Config Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| h | <space>ch | Change Directory to Hyprland Config |
| n | <space>cn | Change Directory to NeoVim Config |
| f | <space>cf | Change Directory to Fish Config |
| o | <space>co | Change Directory to Obsidian Config |


#### Console Keybindings

| Mapping | Value | Description |

##### Normal Mode

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| t | <space>ctt | Toggle Terminal in current buffer |
| b | <space>ctb | Toggle Bottom Terminal |
| <C-M-t> | <space>ctt | Toggle Terminal in floating buffer |


##### Terminal Mode

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| <esc><esc> | <C-\\><C-n> | Escape Terminal Mode |

### Debug Keybindings

#### Leader

| Mapping | Value |
| -------------- | --------------- |
| <leader>d | Debug Leader |


#### Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| b | <leader>db | Toggle Breakpoint |
| e | <space>de | Evaluate Under Cursor |
| g | <space>dg | Go Here |
| r | <space>dr | Restart |
| o | <space>do | Step Over |
| i | <space>di | Step Into |
| O | <space>dO | Step Out |
| d | <space>dd | Continue |
| <C-X> | <space>d<C-X> | Toggle Ui |


### Lsp Keybindings

#### Leader

| Mapping | Value |
| -------------- | --------------- |
| <leader>l | Lsp Leader |


#### Keybindings
| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| d | <space>ld | Go to definition |
| D | <space>lD | Go to declaration |
| h | <space>lh | Go to hover |
| r | <space>lr | Rename |
| a | <space>la | Code action |
| f | <space>lf | Format file |
| n | <space>ln | Go to next diagnostic |
| p | <space>lp | Go to previous diagnostic |
| q | <space>lq | Go to next diagnostic |
| Q | <space>lQ | Go to previous diagnostic |
| r | <space>lr | Rename |



### Notes Keybindings

#### Leader

| Mapping | Value |
| -------------- | --------------- |
| <leader>o | Obsidian Leader |
| <leader>on | New Note Leader |
| <leader>of | Find Leader |
| <leader>ot | Todo / Template Leader |
| <leader>od | Daily Log / Journal Leader |
| <leader>og | Goto / Follow Links Leader |


#### Keybindings

##### Root-level obsidian actions

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| o | <space>oo | Open Obsidian |
| O | <space>oO | Open Note in App |
| r | <space>or | Rename / Refile Note |
| w | <space>ow | Switch Workspace |
| c | <space>oc | Toggle Checkbox |
| p | <space>op | Paste Image |
| x | <space>ox | Extract Selection |


##### New note actions

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| n | <space>onn | New Note |
| t | <space>ont | New Note from Template |
| l | <space>onl | New Note from Selection |


##### Find actions

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| f | <space>off | Search Linkable  |
| q | <space>ofq | Quick Switch |
| l | <space>ofl | List Links |
| b | <space>ofb | Backlinks |
| d | <space>ofd | Browse Dailies |
| t | <space>oft | Browse Tags |
| T | <space>ofT | Browse Templates |
| s | <space>ofs | Search Notes |


##### Template actions

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| t | <space>ott | Select / Insert Template |
| n | <space>ont | New Note from Template |


##### Todo actions (Shares the same space as Template actions)

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| a | <space>ota | Todo: Uncertain |
| p | <space>otp | Todo: Pending |
| u | <space>otu | Todo: Undone |
| d | <space>otd | Todo: Done |
| h | <space>oth | Todo: Hold |
| c | <space>otc | Todo: Cancelled |
| r | <space>otr | Todo: Recurring |
| o | <space>ot! | Todo: Urgent |


##### Daily log / Journal actions

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| o | <space>odo | Today |
| y | <space>ody | Yesterday |
| t | <space>odt | Tomorrow |


##### Goto / Follow links actions

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| l | <space>ogl | Follow Link |
| s | <space>ogs | Follow Link (vsplit) |
| h | <space>ogh | Follow Link (hsplit) |

### Tasks Keybindings
Usese `overseer.nvim`

#### Leader

| Mapping | Value |
| -------------- | --------------- |
| <leader>v | Task Leader |

#### Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| <C-x> | <space>v<C-x> | Toggle Task |

### Quickfix Keybindings

| Mapping | Value |
| -------------- | --------------- |
| <leader>q | Quickfix Leader |

#### Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| a | <space>qa | Quickfix Prev |
| c | <space>qc | Quickfix Close |
| o | <space>qo | Quickfix Toggle |
| s | <space>qs | Quickfix Next |
| i | <space>qi | Quickfix Info |
| x | <space>qx | Quickfix Clear |  


### Fuzzy Finder Keybindings

| Mapping | Value |
| -------------- | --------------- |
| <leader>f | Fuzzy Finder Leader |

#### Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| f | <space>ff | Find Files |
| h | <space>fh | Help Tags |
| g | <space>fg | Grep |
| c | <space>fc | Commands |
| b | <space>fb | Buffers |
| m | <space>fm | Marks |
| r | <space>fr | Registers |
| n | <space>fn | Nerdy |
| k | <space>fk | Keymaps |
| q | <space>fq | Quickfix |
| d | <space>fd | LSP Diagnostics |
| s | <space>fs | LSP Symbols |
| r | <space>fR | LSP Code Actions |
| <C-x> | <space>f<C-x> | Toggle Fuzzy Finder |


### UI Keybindings

| Mapping | Value |
| -------------- | --------------- |
| <leader>u | UI Leader |
| <leader>us | Sharpie Leader |


#### UI Keybindings

| Mapping | Value |
| -------------- | --------------- |
| <leader>ug | Open LazyGit |

#### Sharpie Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| s | <leader>uss | Sharpie Open |
| <c-s>  |<leader>us<C-s> | Sharpie Close |
| f |<leader>usf | Sharpie Next Symbol |
| b |<leader>usb | Sharpie Prev Symbol |
| t |<leader>ust | Sharpie Toggle Namespace Mode |
| <C-f> |<leader>us<C-f> | Sharpie Search Symbols |
| <C-h> |<leader>us<C-h> | Sharpie Toggle Highlight |



### Web dev Keybindings

| Mapping | Value |
| -------------- | --------------- |
| <leader>w | Web Leader |

#### Keybindings

| Mapping | Value | Description |
| -------------- | --------------- | --------------- |
| w | <space>ww | Open ui in Default view |



wk {
	{ kulala_leader, expr = false, group = "Web", nowait = false, remap = false, icon = { icon = "󰖟", hl = "@comment.hint" } },
	{ kulala_leader .. "w", kulala.open, desc = 'Open ui in Default view' },
	{ kulala_leader .. "r", kulala.run, desc = 'Run Request' },
	{ kulala_leader .. "a", run_all, desc = 'Run All' },
	{ kulala_leader .. "y", kulala.replay, desc = 'Run the last request' },
	{ kulala_leader .. "p", kulala.preview, desc = 'Preview Request' },
	{ kulala_leader .. "s", kulala.inspect, desc = 'Save Request' },
	{ kulala_leader .. "[", kulala.jump_prev, desc = 'Jump to Previous Request' },
	{ kulala_leader .. "]", kulala.jump_next, desc = 'Jump to Next Request' },
}

