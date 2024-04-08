pkgs: {
  enable = true;
  loginShellInit = ''
    set -x EDITOR lvim
    set -x LIBVIRT_DEFAULT_URI "qemu:///system"
    fish_add_path "~/.local/bin"
    fish_add_path ~/.local/bin/scripts
    fish_add_path /var/lib/flatpak/exports/bin
    fish_add_path ~/.cargo/bin
    fish_add_path ~/.local/share/npm-global/bin
  '';

  shellAbbrs = {
    b = "bat";
    "1" = "prevd";
    "2" = "prevd 2";
    "3" = "prevd 3";
    "4" = "prevd 4";
    c = "cd";
    cg = "cargo";
    reload = "exec fish";
    nv = "lvim";
    sshfix = "kitty +kitten ssh";
    tree = "eza -TR --git-ignore";
    up = "topgrade";
    gay = "curl fetch.sashanoraa.gay";
    sc = "sudo systemctl";
    scs = "systemctl status";
    scst = "sudo systemctl start";
    scsp = "sudo systemctl stop";
    scr = "sudo systemctl restart";
    jr = "journalctl";
    jre = "journalctl -e -u";
    jrf = "journalctl -f -u";

    nxp = "nix-shell --command fish -p";
    nxs = "nix search nixpkgs";
    # nxr = {
    #   expansion = "nix run nixpkgs#%";
    #   setCursor = true;
    # };
    # nxsh = {
    #   expansion = "nix shell nixpkgs#%";
    #   setCursor = true;
    # };

    g = "git";
    ga = "git add";
    gaa = "git add --all";
    gau = "git add -u";
    gb = "git branch";
    gco = "git checkout";
    gc = "git commit";
    gca = "git commit --amend";
		gcl = "git clone";
    gd = "git diff";
    gf = "git fetch";
    gl = "git log";
    gm = "git merge";
    gp = "git push";
    gpl = "git pull";
    gpn = "git push -u origin (current_branch)";
    gr = "git remote";
    gra = "git remote add";
    grao = "git remote add origin";
    grb = "git rebase";
    grbi = "git rebase -i";
    gs = "git status -sb";
    gsu = "git submodule";
    gro = "git restore";
    gsw = "git switch";
  };

  shellAliases = {
    cl = "printf '\\033[2J\\033[3J\\033[1;1H'";
    git-master-to-main = "git branch -m master main && git push origin :master main:main";
    l = "eza";
    la = "eza -a";
    ll = "eza -l";
    lla = "eza -al";
    shn = "git remote add origin git@git.sr.ht:~zethra/$(basename $(pwd))";
    scratch = "lvim /tmp/scratch";
    tmp = "lvim /dev/null";
    ssh = "kitty +kitten ssh";
  };

  interactiveShellInit = ''
    fish_vi_key_bindings
    set fish_cursor_default block
    set fish_cursor_insert line
    set fish_cursor_replace_one underscore
    set fish_cursor_replace underscore
    set fish_cursor_external line
    set fish_cursor_visual block


    set -x EXA_COLORS 'di=35;01:da=35'

    # Syntax Highlighting Colors
    set -Ux fish_color_normal c0caf5
    set -Ux fish_color_command 7dcfff
    set -Ux fish_color_keyword bb9af7
    set -Ux fish_color_quote e0af68
    set -Ux fish_color_redirection c0caf5
    set -Ux fish_color_end ff9e64
    set -Ux fish_color_error f7768e
    set -Ux fish_color_param 9d7cd8
    set -Ux fish_color_comment 565f89
    set -Ux fish_color_selection --background=33467c
    set -Ux fish_color_search_match --background=33467c
    set -Ux fish_color_operator 9ece6a
    set -Ux fish_color_escape bb9af7
    set -Ux fish_color_autosuggestion 565f89

    # Completion Pager Colors
    set -Ux fish_pager_color_progress 565f89
    set -Ux fish_pager_color_prefix 7dcfff
    set -Ux fish_pager_color_completion c0caf5
    set -Ux fish_pager_color_description 565f89
    set -Ux fish_pager_color_selected_background --background=33467c

    source ~/.config/fish/functions/__fre_cd.fish

    abbr -a nxr --set-cursor "nix run nixpkgs#%"
    abbr -a nxsh --set-cursor "nix shell nixpkgs#%"

    complete -x -c mkproj -d "Template name" -a "(ls ~/Projects/nixcfg/programs/cookiecutter)"
  '';

  functions = {
    fre-clean = ''
      			for p in (fre --sorted)
      				if ! [ -d $p ]
      					echo $p
      					fre -D $p
      				end
      			end
      		'';
    fish_greeting = ''
      if type -q kitty-img
          printf '💖 hiya sashanoraa '
          kitty-img ~/.config/fish/pfp.png 2>/dev/null
          echo ' 'welcome to (gethost) "~" 🏳️‍⚧️
      else
          echo 💖 hiya sashanoraa welcome to (gethost) "~" 🏳️‍⚧️
      end
    '';
    gbd = {
      wraps = "git branch -d";
      body = "git branch -d $argv[1] && git push --delete origin $argv[1]";
    };
    gbD = {
      wraps = "git branch -D";
      body = "git branch -D $argv[1] && git push --delete origin $argv[1]";
    };
    mkproj = {
      body = ''
        cookiecutter "$HOME/Projects/nixcfg/programs/cookiecutter/$argv[1]"
      '';
    };

    gethost = ''
      if test -f /run/.containerenv
          function gethost
              grep -F name= /run/.containerenv | cut -d '"' -f2; 
          end
      else if command -v hostnamectl &> /dev/null
          function gethost --wraps=hostnamectl --description 'alias gethost hostnamectl'
              hostnamectl --pretty; 
          end
      else if command -v hostname &> /dev/null
          function gethost --wraps=hostname --description 'alias gethost hostname -s'
              hostname -s;
          end
      else
          function gethost --wraps=hostname --description 'alias gethost hostname'
              echo host_error;
          end
      end
    '';

    mkshell = ''
            echo "{ pkgs ? import <nixpkgs> {} }:

            pkgs.mkShell {
              packages = with pkgs; [ $argv ];
            }" > shell.nix
            echo "use nix" > .envrc && direnv allow .
      			printf ".envrc\n.direnv" >> .gitignore
    '';

    copy = ''
      if command -v wl-copy &> /dev/null
          if test -f "$argv[1]"
              wl-copy < "$argv[1]"
          else
              wl-copy $argv
          end
      else
          xclip -sel clip "$argv"
      end
    '';

    paste = ''
      if command -v wl-paste &> /dev/null
          wl-paste
      else
          xclip -sel clip -o "$argv"
      end
    '';

    current_branch = ''
      set ref (git symbolic-ref HEAD 2> /dev/null); or \
      set ref (git rev-parse --short HEAD 2> /dev/null); or return
      echo $ref | sed s-refs/heads/--
    '';

    __fre_cd = {
      onVariable = "PWD";
      body = ''
                status --is-command-substitution; and return
        	      fre --add (pwd)
      '';
    };

    mommy = ''
      set -g prev_status $status

      # SHELL_MOMMYS_LITTLE - what to call you~ (default: "girl")
      # SHELL_MOMMYS_PRONOUNS - what pronouns mommy will use for themself~ (default: "her")
      # SHELL_MOMMYS_ROLES - what role mommy will have~ (default "mommy")

      set -g COLORS_LIGHT_PINK '\e[38;5;217m'
      set -g COLORS_LIGHT_BLUE '\e[38;5;117m'
      set -g COLORS_FAINT '\e[2m'
      set -g COLORS_RESET '\e[0m'

      set -g DEF_WORDS_LITTLE "girl"
      set -g DEF_WORDS_PRONOUNS "her"
      set -g DEF_WORDS_ROLES "mommy"
      set -g DEF_MOMMY_COLOR "$COLORS_LIGHT_PINK"
      set -g DEF_ONLY_NEGATIVE "false"

      set -g NEGATIVE_RESPONSES \
        "do you need MOMMYS_ROLE's help~? ❤️" \
        "Don't give up, my love~ ❤️" \
        "Don't worry, MOMMYS_ROLE is here to help you~ ❤️" \
        "I believe in you, my sweet AFFECTIONATE_TERM~ ❤️" \
        "It's okay to make mistakes, my dear~ ❤️" \
        "just a little further, sweetie~ ❤️" \
        "Let's try again together, okay~? ❤️" \
        "MOMMYS_ROLE believes in you, and knows you can overcome this~ ❤️" \
        "MOMMYS_ROLE believes in you~ ❤️" \
        "MOMMYS_ROLE is always here for you, no matter what~ ❤️" \
        "MOMMYS_ROLE is here to help you through it~ ❤️" \
        "MOMMYS_ROLE is proud of you for trying, no matter what the outcome~ ❤️" \
        "MOMMYS_ROLE knows it's tough, but you can do it~ ❤️" \
        "MOMMYS_ROLE knows MOMMYS_PRONOUN little AFFECTIONATE_TERM can do better~ ❤️" \
        "MOMMYS_ROLE knows you can do it, even if it's tough~ ❤️" \
        "MOMMYS_ROLE knows you're feeling down, but you'll get through it~ ❤️" \
        "MOMMYS_ROLE knows you're trying your best~ ❤️" \
        "MOMMYS_ROLE loves you, and is here to support you~ ❤️" \
        "MOMMYS_ROLE still loves you no matter what~ ❤️" \
        "You're doing your best, and that's all that matters to MOMMYS_ROLE~ ❤️" \
        "MOMMYS_ROLE is always here to encourage you~ ❤️"

      set -g POSITIVE_RESPONSES \
        "*pets your head*" \
        "awe, what a good AFFECTIONATE_TERM~\nMOMMYS_ROLE knew you could do it~ ❤️" \
        "good AFFECTIONATE_TERM~\nMOMMYS_ROLE's so proud of you~ ❤️" \
        "Keep up the good work, my love~ ❤️" \
        "MOMMYS_ROLE is proud of the progress you've made~ ❤️" \
        "MOMMYS_ROLE is so grateful to have you as MOMMYS_PRONOUN little AFFECTIONATE_TERM~ ❤️" \
        "I'm so proud of you, my love~ ❤️" \
        "MOMMYS_ROLE is so proud of you~ ❤️" \
        "MOMMYS_ROLE loves seeing MOMMYS_PRONOUN little AFFECTIONATE_TERM succeed~ ❤️" \
        "MOMMYS_ROLE thinks MOMMYS_PRONOUN little AFFECTIONATE_TERM earned a big hug~ ❤️" \
        "that's a good AFFECTIONATE_TERM~ ❤️" \
        "you did an amazing job, my dear~ ❤️" \
        "you're such a smart cookie~ ❤️"

      # allow for overriding of default words (IF ANY SET)

      if test -n "$SHELL_MOMMYS_LITTLE"
        set DEF_WORDS_LITTLE "$SHELL_MOMMYS_LITTLE"
      end
      if test -n "$SHELL_MOMMYS_PRONOUNS"
        set DEF_WORDS_PRONOUNS "$SHELL_MOMMYS_PRONOUNS"
      end
      if test -n "$SHELL_MOMMYS_ROLES"
        set DEF_WORDS_ROLES "$SHELL_MOMMYS_ROLES"
      end
      if test -n "$SHELL_MOMMYS_COLOR"
        set DEF_MOMMY_COLOR "$SHELL_MOMMYS_COLOR"
      end
      # allow overriding to true
      if test "$SHELL_MOMMYS_ONLY_NEGATIVE" = "true"
        set DEF_ONLY_NEGATIVE "true"
      end
      # if the array is set for positive/negative responses, overwrite it
      if test -n "$SHELL_MOMMYS_POSITIVE_RESPONSES"
        set POSITIVE_RESPONSES "$SHELL_MOMMYS_POSITIVE_RESPONSES"
      end
      if test -n "$SHELL_MOMMYS_NEGATIVE_RESPONSES"
        set NEGATIVE_RESPONSES "$SHELL_MOMMYS_NEGATIVE_RESPONSES"
      end

      # split a string on forward slashes and return a random element
      function pick_word
       random choice (string split -n / $argv)
      end

      function pick_response # given a response type, pick an entry from the array

        if test $argv[1]  = "positive"
          set element (random choice $POSITIVE_RESPONSES)
        else if test $argv[1] = "negative"
          set element (random choice $NEGATIVE_RESPONSES)
        else
          echo "Invalid response type: $argv[1]"
          exit 1
        end

        # Return the selected response
        echo "$element"

      end

      function sub_terms # given a response, sub in the appropriate terms
        set -l response $argv
        # pick_word for each term
        set -l affectionate_term (pick_word $DEF_WORDS_LITTLE)
        set -l pronoun (pick_word $DEF_WORDS_PRONOUNS)
        set -l role (pick_word $DEF_WORDS_ROLES)
        # sub in the terms, store in variable
        set -l response (echo "$response" | string replace "AFFECTIONATE_TERM" "$affectionate_term")
        set -l response (echo "$response" | string replace "MOMMYS_PRONOUN" "$pronoun")
        set -l response (echo "$response" | string replace "MOMMYS_ROLE" "$role")
        # we have string literal newlines in the response, so we need to printf it out
        # print faint and colorcode
        echo -e "$DEF_MOMMY_COLOR$response$COLORS_RESET"
      end

      function success
        if test "$DEF_ONLY_NEGATIVE" = "true"
          return 0
        end
        # pick_response for the response type
        set -l response (pick_response "positive")
        sub_terms "$response" >&2
        return 0
      end

      function failure
        set -l response (pick_response "negative")
        sub_terms "$response" >&2
        return $prev_status
      end

      if test $prev_status -eq 0
        success
      else
        failure
      end
    '';
  };

  plugins = [
    # {
      # name = "done";
      # src = pkgs.fishPlugins.done.src;
    # }
    # {
      # name = "puffer";
      # src = pkgs.fishPlugins.puffer.src;
    # }
    # {
      # name = "autopair";
      # src = pkgs.fishPlugins.autopair.src;
    # }
  ];
}
