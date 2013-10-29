meld:
  pkg:
    - installed

set-meld-as-default-git-mergetool:
  cmd.run:
    - names:
      - git config --global merge.tool meld
      - git config --global merge.conflictstyle diff3
      - git config --global mergetool.meld.cmd meld '$BASE $LOCAL $REMOTE $MERGED'
      - git config --global mergetool.trustExitCode false
      - git config --global diff.tool meld
      - git config --global difftool.meld.cmd meld '$LOCAL $REMOTE'
