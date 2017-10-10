# source ~/.asdf/asdf.fish
set -gx PATH ~/.ncx/system/bin $PATH

# bobthefish theme overrides
set -g theme_display_vagrant no
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_ruby no
set -g theme_display_user no
set -g theme_display_docker_machine no
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%Y/%m/%d %H:%M:%S"
set -g theme_nerd_fonts yes
set -g theme_color_scheme gruvbox
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 0

alias setclip "xclip -selection c"
alias getclip "xclip -selection clipboard -o"
