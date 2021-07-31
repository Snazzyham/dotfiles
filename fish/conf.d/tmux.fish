if set -q $TMUX
  tmux new-session
else
  echo "in tmux session"
end
