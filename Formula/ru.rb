# Repo Updater (ru) - Homebrew formula
# Synchronize GitHub repositories to local projects directory

class Ru < Formula
  desc "Robust CLI tool for synchronizing GitHub repositories"
  homepage "https://github.com/Dicklesworthstone/repo_updater"
  url "https://github.com/Dicklesworthstone/repo_updater/releases/download/v1.3.1/ru"
  sha256 "6ae3ae2d850d26c0ad82e3b5e713338f74f2bfd483691e4d09d9d75e00a79b3a"
  license "MIT"

  # Runtime dependencies
  depends_on "git"
  depends_on "gh" => :recommended  # Required for private repos
  depends_on "gum" => :recommended # Beautiful terminal UI

  def install
    bin.install "ru"

    # Bash completion
    (bash_completion/"ru").write <<~BASH
      _ru_completions() {
          local cur prev words cword
          _init_completion || return

          local commands="sync status init add remove list doctor self-update config prune import review"
          local global_opts="-h --help -v --version --json -q --quiet --verbose --non-interactive"

          case "${prev}" in
              ru)
                  COMPREPLY=($(compgen -W "${commands} ${global_opts}" -- "${cur}"))
                  return
                  ;;
              sync)
                  local sync_opts="--clone-only --pull-only --autostash --rebase --dry-run --dir --parallel -j --resume --restart --timeout"
                  COMPREPLY=($(compgen -W "${sync_opts} ${global_opts}" -- "${cur}"))
                  return
                  ;;
              status)
                  COMPREPLY=($(compgen -W "--fetch --no-fetch ${global_opts}" -- "${cur}"))
                  return
                  ;;
              init)
                  COMPREPLY=($(compgen -W "--example ${global_opts}" -- "${cur}"))
                  return
                  ;;
              add)
                  COMPREPLY=($(compgen -W "--private ${global_opts}" -- "${cur}"))
                  return
                  ;;
              remove|list|doctor|self-update|config|prune)
                  COMPREPLY=($(compgen -W "${global_opts}" -- "${cur}"))
                  return
                  ;;
              import)
                  COMPREPLY=($(compgen -f -- "${cur}"))
                  return
                  ;;
              review)
                  local review_opts="--plan --apply --dry-run --mode --max-repos --repos --skip-days --parallel --push"
                  COMPREPLY=($(compgen -W "${review_opts} ${global_opts}" -- "${cur}"))
                  return
                  ;;
              --mode)
                  COMPREPLY=($(compgen -W "local ntm" -- "${cur}"))
                  return
                  ;;
          esac

          if [[ ${cword} -eq 1 ]]; then
              COMPREPLY=($(compgen -W "${commands} ${global_opts}" -- "${cur}"))
          fi
      }
      complete -F _ru_completions ru
    BASH

    # Zsh completion
    (zsh_completion/"_ru").write <<~ZSH
      #compdef ru
      _ru() {
          local -a commands global_opts
          commands=(
              'sync:Clone missing repos and pull updates'
              'status:Show repository status'
              'init:Initialize configuration'
              'add:Add a repository'
              'remove:Remove a repository'
              'list:Show configured repositories'
              'doctor:Run system diagnostics'
              'self-update:Update ru'
              'config:Show or set configuration'
              'prune:Manage orphan repositories'
              'import:Import repos from file'
              'review:Review GitHub issues and PRs'
          )
          global_opts=('-h[Show help]' '--help[Show help]' '-v[Show version]' '--version[Show version]' '--json[JSON output]' '-q[Quiet]' '--quiet[Quiet]' '--verbose[Verbose]' '--non-interactive[Never prompt]')

          _arguments -C '1: :->command' '*:: :->args' && return 0

          case $state in
              command) _describe -t commands 'ru commands' commands; _describe -t options 'options' global_opts ;;
              args)
                  case $words[1] in
                      sync) _arguments '--clone-only' '--pull-only' '--autostash' '--rebase' '--dry-run' '--dir:directory:_directories' '--parallel:number' '--resume' '--restart' '--timeout:seconds' $global_opts ;;
                      status) _arguments '--fetch' '--no-fetch' $global_opts ;;
                      init) _arguments '--example' $global_opts ;;
                      add) _arguments '--private' '*:repository:' $global_opts ;;
                      import) _arguments '*:file:_files' $global_opts ;;
                      review) _arguments '--plan' '--apply' '--dry-run' '--mode:mode:(local ntm)' '--max-repos:number' '--repos:pattern' '--skip-days:days' '--parallel:number' '--push' $global_opts ;;
                      *) _arguments $global_opts ;;
                  esac
              ;;
          esac
      }
      _ru "$@"
    ZSH

    # Fish completion
    (fish_completion/"ru.fish").write <<~FISH
      complete -c ru -f
      complete -c ru -n __fish_use_subcommand -a sync -d 'Clone missing repos and pull updates'
      complete -c ru -n __fish_use_subcommand -a status -d 'Show repository status'
      complete -c ru -n __fish_use_subcommand -a init -d 'Initialize configuration'
      complete -c ru -n __fish_use_subcommand -a add -d 'Add a repository'
      complete -c ru -n __fish_use_subcommand -a remove -d 'Remove a repository'
      complete -c ru -n __fish_use_subcommand -a list -d 'Show configured repositories'
      complete -c ru -n __fish_use_subcommand -a doctor -d 'Run system diagnostics'
      complete -c ru -n __fish_use_subcommand -a self-update -d 'Update ru'
      complete -c ru -n __fish_use_subcommand -a config -d 'Show or set configuration'
      complete -c ru -n __fish_use_subcommand -a prune -d 'Manage orphan repositories'
      complete -c ru -n __fish_use_subcommand -a import -d 'Import repos from file'
      complete -c ru -n __fish_use_subcommand -a review -d 'Review GitHub issues and PRs'
      complete -c ru -s h -l help -d 'Show help'
      complete -c ru -s v -l version -d 'Show version'
      complete -c ru -l json -d 'JSON output'
      complete -c ru -s q -l quiet -d 'Minimal output'
      complete -c ru -l verbose -d 'Detailed output'
      complete -c ru -l non-interactive -d 'Never prompt'
      complete -c ru -n '__fish_seen_subcommand_from sync' -l clone-only -d 'Only clone'
      complete -c ru -n '__fish_seen_subcommand_from sync' -l pull-only -d 'Only pull'
      complete -c ru -n '__fish_seen_subcommand_from sync' -l autostash -d 'Stash changes'
      complete -c ru -n '__fish_seen_subcommand_from sync' -l rebase -d 'Use rebase'
      complete -c ru -n '__fish_seen_subcommand_from sync' -l dry-run -d 'Show what would happen'
      complete -c ru -n '__fish_seen_subcommand_from review' -l plan -d 'Generate plans'
      complete -c ru -n '__fish_seen_subcommand_from review' -l apply -d 'Execute plans'
      complete -c ru -n '__fish_seen_subcommand_from review' -l mode -r -a 'local ntm' -d 'Review mode'
    FISH
  end

  def caveats
    <<~EOS
      ru requires the GitHub CLI (gh) for cloning private repositories.
      If you haven't already, install and authenticate gh:

        brew install gh
        gh auth login

      Initialize ru configuration:

        ru init

      For beautiful terminal UI, install gum:

        brew install gum
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin/"ru"} --version")
    assert_match "sync", shell_output("#{bin/"ru"} --help")
  end
end
