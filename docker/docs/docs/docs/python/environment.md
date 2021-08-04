---
title: Environment
---

## Conda
```bash
# list env
conda env list

# create new env and specify packages
conda create -n ENV_NAME python=3.6
conda install -n ENV_NAME scipy=0.15.0

# deactivate env (weird behaviors, better explicitly use conda activate ENV_NAME)
conda deactivate

# remove environment
conda env remove -n ENV_NAME

# example
conda create -n pymongo python=3.7
conda install -n pymongo pymongo
conda activate pymongo
```

## Pyenv
* [managing-virtual-environment-with-pyenv](https://towardsdatascience.com/managing-virtual-environment-with-pyenv-ae6f3fb835f8)
* [pyenv](https://github.com/pyenv/pyenv)
* [pyenv-win](https://github.com/pyenv-win/pyenv-win)

## Setup
```bash
# install
brew install pyenv pyenv-virtualenv

# lisit available python versions
pyenv install --list

# install specific version
pyenv install 3.8.0

# list installed versions
pyenv versions

# activate new env
pyenv shell 3.8.0 # support multiple version

# config venv
pyenv virtualenv 3.8.0 my-data-project

# set env per folder/project
pyenv local my-data-project
```

### Windows
```bash
# install
git clone https://github.com/pyenv-win/pyenv-win.git "%USERPROFILE%\.pyenv"

# set PATH (in powershell only)
[System.Environment]::SetEnvironmentVariable('PYENV',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
[System.Environment]::SetEnvironmentVariable('PYENV_HOME',$env:USERPROFILE + "\.pyenv\pyenv-win\","User")
[System.Environment]::SetEnvironmentVariable('path', $HOME + "\.pyenv\pyenv-win\bin;" + $HOME + "\.pyenv\pyenv-win\shims;" + $env:Path,"User")
```

typing `pyenv version` should yield:
```
No global python version has been set yet. Please set the global version by typing:
pyenv global 3.7.2
```

### Notes
```bash title="default PATH"
set fish_user_paths /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
set PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/Library/Python/3.8/bin:/Users/kahnwong/.pyenv/versions/data-science/bin
```

1. Add `system python path` to use stuff installed via python that came with the system (less complicated than add multiple `global` virtualenv)
2. Also add `Jupyter-lab` path installed to an environment somewhere, so you can activate Jupyter env across virtualenv, see:
	* https://github.com/aiguofer/pyenv-jupyter-kernel

#### Set up linting in vscode
[Blog / Visual Studio Code with Python, pyenv and pylint | Ondrej Zeman](https://ondrejzeman.com/blog/vscode-python-pyenv-and-pylint)

## Pipenv

```bash
# pipenv to requirements.txt
jq -r '.default | to_entries[] | .key + .value.version ' Pipfile.lock > requirements.txt

# install from requirements.txt
pipenv install -r requirements.txt
```