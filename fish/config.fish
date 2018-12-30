##### environments #####
set -x PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Users/kettan/go/bin:~/projects/dotfiles/scripts

##### aliases #####

# sshu writes all config.d/* contents to config.
alias sshu="cat ~/.ssh/config.d/* > ~/.ssh/config"
# k saves life by not to type kubectl.
alias k="kubectl"
# v saves lift by not to type nvim $PWD.
alias v='nvim .'

##### prompt #####
function fish_prompt
	test $SSH_TTY
	and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
	test "$USER" = 'root'; and echo (set_color red)"#"

	printf (set_color cyan)(pwd)

	if set -l is_git_dir (git rev-parse --git-dir 2>/dev/null)
		printf ' ['
		# Show the current branch name.
		set -l branch (git rev-parse --abbrev-ref HEAD)
		set -l changed (git status --porcelain)
		test -z "$changed"; and	set_color green; or set_color yellow
		printf $branch
		# Get the commit difference counts between local and remote.
    command git rev-list --count --left-right 'HEAD...@{upstream}' 2>/dev/null \
      | read -d \t -l status_ahead status_behind
    if test $status -ne 0
      set status_ahead 0
      set status_behind 0
		end
		test $status_ahead -ne 0; and printf (set_color brmagenta)'⇡'
		test $status_behind -ne 0; and printf (set_color brmagenta)'⇣'
		printf (set_color normal)']'
	end

	printf '\n'(set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
end

##### functions #####

# fuzzy shows interactive file search UI.
# rg list all target files, pipe to fzf.
# @val argv[1] <target default=*>
function fuzzy --description "fuzzy <target_path> | fuzzy"
	set -q argv[1]; or set argv[1] *
	rg $argv[1] --files | fzf -0 -1
end

# t provides a more convenient way to use command tree.
# @argv[1]     <layer default=10>
# @argv[2..-1] <path default=.>
function t --description "t <layer> <path...> | t"
	set -q argv[1]; or set argv[1] 10
	test -n "$argv[2]"; or set argv[2] .
	tree -I '.git|node_modules|vendor|.DS_Store' --dirsfirst --filelimit 100 -L $argv[1] -aC $argv[2..-1]
end
