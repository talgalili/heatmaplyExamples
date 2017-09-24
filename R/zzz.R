# Clear large HTML files from the git history
# https://stackoverflow.com/questions/8083282/how-do-i-remove-a-big-file-wrongly-committed-in-git
# https://stackoverflow.com/questions/2100907/how-to-remove-delete-a-large-file-from-commit-history-in-git-repository
#
# git filter-branch --tree-filter 'rm -rf inst/doc/biological_data.html' HEAD
# git filter-branch --tree-filter 'rm -rf inst/doc/glmnet.html' HEAD
# git filter-branch --tree-filter 'rm -rf inst/doc/heatmaply_examples.html' HEAD
# git filter-branch --tree-filter 'rm -rf inst/doc/non_centred_heatmaps.html' HEAD
#
# rm -rf .git/refs/original/
#   git reflog expire --expire=now --all
# git gc --prune=now
# git gc --aggressive --prune=now
