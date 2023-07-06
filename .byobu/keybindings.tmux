set-option -g mouse on
setw -g mode-keys vi
set-option -s set-clipboard off
unbind-key -n C-a
unbind-key -n C-b
set -g prefix ^B
set -g prefix2 F12
bind b send-prefix

bind P paste-buffer
bind-key -T copy-mode-vi v send-keys -X begin-selection
bind-key -T copy-mode-vi y send-keys -X rectangle-toggle
unbind -T copy-mode-vi Enter
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -se c -i'