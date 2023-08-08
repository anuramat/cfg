#!/usr/bin/env bash
# shellcheck disable=2086
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Misc ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
bleopt input_encoding=UTF-8
bleopt pager=bat
bleopt editor=nvim

bleopt vbell_default_message=' HEHE '
bleopt vbell_duration=2000
bleopt vbell_align=center

# bells during edit
bleopt edit_abell=
bleopt edit_vbell=

bleopt history_lazyload=1

bleopt term_index_colors=auto
#bleopt term_true_colors=semicolon
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Colors ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ #
# https://spec.draculatheme.com/
c_cyan="#8BE9FD"      # builtin
c_fg="#F8F8F2"        # vars
c_pink="#FF79C6"      # escapes
c_green="#50FA7B"     # function
c_purple="#BD93F9"    # constant
c_red="#FF5555"       # error
c_yellow="#F1FA8C"    # strings
c_selection="#44475A" # blue grey
c_comment="#6272A4"   # comment
c_orange="#FFB86C"    # ?
gigaerr="fg=$c_red,standout"
# ~~~~~~~~~~~~~~~~~~~~~~~ Editor ~~~~~~~~~~~~~~~~~~~~~~~~ #
ble-face -s region fg=$c_selection
ble-face -s region_target fg=$c_selection
ble-face -s region_match fg=$c_orange,reverse
ble-face -s disabled fg=$c_comment
ble-face -s auto_complete fg=$c_purple
# ~~~~~~~~~~~~~~~~~~~~~~~ Syntax ~~~~~~~~~~~~~~~~~~~~~~~~ #
ble-face -s syntax_default fg=$c_fg
ble-face -s syntax_command fg=$c_green
ble-face -s syntax_quoted fg=$c_yellow
ble-face -s syntax_quotation fg=$c_orange
ble-face -s syntax_escape fg=$c_pink
ble-face -s syntax_expr fg=$c_pink
ble-face -s syntax_error fg=$c_red
ble-face -s syntax_varname fg=$c_fg
ble-face -s syntax_delimiter fg=$c_pink
ble-face -s syntax_param_expansion fg=$c_pink
ble-face -s syntax_history_expansion fg=$c_purple
ble-face -s syntax_function_name fg=$c_green
ble-face -s syntax_document fg=$c_yellow
ble-face -s syntax_document_begin fg=$c_yellow
ble-face -s syntax_comment fg=$c_comment
ble-face -s syntax_glob fg=$c_green
ble-face -s syntax_brace fg=$c_green
ble-face -s syntax_tilde fg=$c_cyan
# ~~~~~~~~~~~~~~~~~~~~~~ Commands ~~~~~~~~~~~~~~~~~~~~~~~ #
ble-face -s command_builtin_dot fg=$c_cyan
ble-face -s command_builtin fg=$c_cyan
ble-face -s command_alias fg=$c_orange
ble-face -s command_function fg=$c_green
ble-face -s command_file fg=$c_green
ble-face -s command_directory fg=$c_pink
ble-face -s command_keyword fg=$c_purple
ble-face -s command_jobs fg=$c_red
# ~~~~~~~~~~~~~~~~~~~~~~~~ Files ~~~~~~~~~~~~~~~~~~~~~~~~ #
ble-face -s filename_directory fg=$c_pink,underline
ble-face -s filename_directory_sticky fg=$c_pink,underline
ble-face -s filename_link fg=$c_cyan,underline
ble-face -s filename_orphan fg=$c_red,underline
ble-face -s filename_executable fg=$c_green,underline
ble-face -s filename_other fg=$c_green,underline
ble-face -s filename_socket fg=$c_pink,underline
ble-face -s filename_pipe fg=$c_pink,underline
ble-face -s filename_setuid fg=$c_fg,underline
ble-face -s filename_setgid fg=$c_fg,underline
ble-face -s filename_character fg=$c_fg,underline
ble-face -s filename_block fg=$c_fg,underline
ble-face -s filename_warning fg=$c_fg,underline
ble-face -s filename_url fg=$c_cyan,underline
ble-face -s filename_ls_colors none
# ~~~~~~~~~~~~~~~~~~~~~~ Variables ~~~~~~~~~~~~~~~~~~~~~~ #
ble-face -s varname_readonly fg=$c_purple
ble-face -s varname_array fg=$c_fg
ble-face -s varname_empty fg=$c_comment
ble-face -s varname_export fg=$c_purple
ble-face -s varname_expr fg=$c_fg
ble-face -s varname_hash fg=$c_fg
ble-face -s varname_number fg=$c_green
ble-face -s varname_transform fg=$c_fg
ble-face -s varname_unset fg=$c_comment
ble-face -s argument_option fg=$c_orange,italic
ble-face -s argument_error fg=$c_red
# ~~~~~~~~~~~~~~~~~~~~~~~~ Junk ~~~~~~~~~~~~~~~~~~~~~~~~~ #
# replace mode in vi mode
ble-face -s overwrite_mode standout
# dunno
ble-face -s region_insert fg=$c_fg,bold
# visual bell
ble-face -s vbell $gigaerr
ble-face -s vbell_erase $gigaerr
ble-face -s vbell_flash $gigaerr
# prompt on the bottom of the screen (currently empty)
ble-face -s prompt_status_line $gigaerr
# eg when typing a path: /first_part/second
# doesn't work in rc for some reason
# ble-face -s menu_filter_input fg=$c_fg,bold # second part
# ble-face -s menu_filter_fixed bold          # first part