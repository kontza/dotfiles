fish_add_path -pP ~/.cargo/bin
if command -q starship
    starship init fish | source
end
