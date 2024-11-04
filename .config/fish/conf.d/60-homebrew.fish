set --global --export HOMEBREW_PREFIX "/opt/homebrew"
set --global --export HOMEBREW_CELLAR "/opt/homebrew/Cellar"
set --global --export HOMEBREW_REPOSITORY "/opt/homebrew"
fish_add_path --global --move --path \
	"/opt/homebrew/bin" \
	"/opt/homebrew/sbin" \
	(python3 -c 'import sysconfig;import os;print(sysconfig.get_path("scripts", f"{os.name}_user"))')
if test -n "$MANPATH[1]"; set --global --export MANPATH '' $MANPATH; end
if not contains "/opt/homebrew/share/info" $INFOPATH; set --global --export INFOPATH "/opt/homebrew/share/info" $INFOPATH; end
