# # Tell FZF to use the Silver Searcher *and* ignore local .gitignore files
# export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'


# Configure 'thefuck'
eval "$(thefuck --alias)"


pyme() {
    if [ ! -d "./ve" ]; then
        echo "Creating ve.."
        python -m venv ve
        echo "Updating virtual environment..."
        ./ve/bin/pip install -I -U pip setuptools wheel
    fi
    source ./ve/bin/activate
}
