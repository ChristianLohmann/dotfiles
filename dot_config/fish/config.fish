if status is-interactive
    # Commands to run in interactive sessions can go here
    # fish_config theme choose "Catppuccin Mocha"
    set -g fish_greeting

    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    # set fish_cursor_default block blink
    # Set the insert mode cursor to a line
    # set fish_cursor_insert line blink
    # Set the replace mode cursor to an underscore
    # set fish_cursor_replace_one underscore blink
    # set fish_cursor_replace underscore blink
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    # set fish_cursor_visual block blink
    set -x PATH ~/bin ~/.cargo/bin ~/go/bin $HOME/Applications/podman-on-mac /opt/homebrew/bin $PATH

    # set fish_vi_force_cursor true
    # fish_vi_key_bindings
    # fish_vi_cursor

    # bind -M insert \cp up-or-search
    # bind -M insert \cn down-or-search
    bind -M insert \cf accept-autosuggestion

    if command -q fzf
        fzf_key_bindings
    end
    if command -q fnm
        fnm env | source
    end

    if command -q fw
        if command -q fzf
            fw print-fish-setup -f | source
        else
            fw print-fish-setup | source
        end
    end

    if command -q starship
        starship init fish | source
    end

    if command -q eza
        functions -e ls
        functions -e la
        functions -e ll
        functions -e lt

        alias ls "command eza --icons=auto"
        alias la "command eza -la --icons=auto"
        alias ll "command eza -l --icons=auto"
        alias lt "command eza --tree --icons=auto"
    end

    alias zbn "zellij action rename-tab (basename (pwd))"
    alias back-to-master "git checkout (git remote show origin | awk '/HEAD branch/ { print \$3 }') && git uff && git-trim"
    alias ll "ls -Glaht"
    alias ls "ls -Gh"
    alias .. "cd .."
    alias mvnDebug /usr/share/maven/bin/mvnDebug
    alias mvn_inst 'mvn clean install'
    alias mvn_test 'mvn clean test'
    alias mvn_test_res 'mvn clean process-test-resources -Pintegration-test'
    alias mvn_veri 'mvn clean verify -Pintegration-test'
    alias yubi 'gpg2 --card-status'
    alias west 'export AWS_DEFAULT_REGION=eu-west-1 && export AWS_REGION=eu-west-1'
    alias central 'export AWS_DEFAULT_REGION=eu-central-1 && export AWS_REGION=eu-central-1'

    alias pods 'zkubectl get pods'
    alias logs 'zkubectl logtail -f'
    alias sandbox-ztoken 'ztoken token -t https://sandbox.identity.zalando.com/oauth2/token -p 810d1d00-4312-43e5-bd31-d8373fdd24c7 -a https://sandbox.identity.zalando.com/oauth2/authorize -n sandbox'
    alias zhttp "http -A zign -a zhttp: --default-scheme=https"
    alias cleanztoken 'ztoken | tr -d \\n | pbcopy'
    alias delete-dependabot-branches 'git ls-remote --heads | grep dependabot | sed -e "s|^.*refs/heads/||" | xargs git push origin --delete'
    alias kubectl zkubectl
    alias kc kubectx

    abbr --add gst "git status"

    set -x SUDO_EDITOR nvim
    set -x EDITOR code
    set -x KUBE_EDITOR nvim
    set -x PAGER bat
    set -x MANPAGER bat
    set -x WORDCHARS '*?_-.[]~=&;!#$%^(){}<>'
    set -x GOPATH ~/go
    set -x LANG en_US.UTF-8
    set -x LC_ALL en_US.UTF-8
    set -x DOCKER_HOST 'unix:///Users/clohmann/.local/share/containers/podman/machine/podman.sock'
    set -x TESTCONTAINERS_CHECKS_DISABLE true
    set -x TESTCONTAINERS_RYUK_DISABLED true
    set -x CREDENTIALS_DIR ~/credentials
    set -x WORK_DIR ~/projects/zalando

    defaults write .GlobalPreferences com.apple.mouse.scaling -1

    function brand_by_name
        zhttp https://masterdata-service.retail-operations.zalan.do/brands | jq ".[] | select(.name == \"$argv[1]\")"
    end


    function brand_by_code
        zhttp https://masterdata-service.retail-operations.zalan.do/brands | jq ".[] | select(.code == \"$argv[1]\")"
    end

    function subunit_by_code
        zhttp https://organizational-structure-hierarchy.retail-operations.zalan.do/organizational-units\?level=sub_unit | jq ".items[] | select(.code == \"$argv[1]\")"
    end

    function subunit_by_name
        zhttp https://organizational-structure-hierarchy.retail-operations.zalan.do/organizational-units\?level=sub_unit | jq ".items[] | select(.name == \"$argv[1]\")"
    end

    set groot_chat_hook 'https://chat.googleapis.com/v1/spaces/AAAA74pSpWM/messages?key=AIzaSyDdI0hCZtE6vySjMm-WEfRq3CPzqKqqsHI&token=NvWEK17t0buGjUjfuGsjjFicrWwFr7lUakSlOrs9BwA'

    function notify_team
        printf "{\"text\": \"$argv[1]\"}" | http POST $groot_chat_hook Content-Type:application/json
    end

    function ca
        zkubectl cluster-access request \"$argv[1]\" --no-wait-for-approval | grep "zkubectl login" | sed "s/^[ \t]*//"
    end

    function ca_and_notify
        notify_team $(ca "$argv[1]")
    end

    function fetch_articles
        printf "{ \"ids\": [$argv[1]] }" | zhttp -v --follow --timeout 3600 POST https://article-management-service.retail-operations.zalan.do/configs/search
    end

    function zl
        zkubectl login $argv[1] --force-refresh
    end

    function zlr
        zkubectl login retail-operations --force-refresh
    end

    function zlrt
        zkubectl login retail-operations-test --force-refresh
    end

    function zli
        zkubectl login in-season-management --force-refresh
    end

    function zlit
        zkubectl login in-season-management-test --force-refresh
    end

end
# Created by `pipx` on 2025-01-23 09:19:38
set -x PATH $PATH /Users/clohmann/.local/bin
