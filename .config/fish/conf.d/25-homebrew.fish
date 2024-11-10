# Environment settings purely for Homebrew.
# Other env settings are in './40-env-settings.fish'.
if test (uname|grep Darwin)
    set --global --export HOMEBREW_PREFIX /opt/homebrew
    set --global --export HOMEBREW_CELLAR /opt/homebrew/Cellar
    set --global --export HOMEBREW_REPOSITORY /opt/homebrew
    fish_add_path --global --move --path \
        /opt/homebrew/bin \
        /opt/homebrew/sbin \
        /opt/homebrew/opt/ruby/bin \
        /opt/homebrew/lib/ruby/gems/3.3.0/bin

    if test -n "$MANPATH[1]"
        set --global --export MANPATH '' $MANPATH
    end
    if not contains /opt/homebrew/share/info $INFOPATH
        set --global --export INFOPATH /opt/homebrew/share/info $INFOPATH
    end
end
