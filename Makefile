.PHONY: help clean test check fmt build release
.DEFAULT_GOAL := help
PROJECT := tea_console

help:                ## Show help.
	@grep -E '^[a-zA-Z2_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


clean:               ## Cleanup the project.
	@find . -type d -name __pycache__ -delete
	@find . -type f -name "*.py[cod]" -delete
	@rm -fr build dist "$(PROJECT).egg-info"
	@rm -fr docs/_build/*


test:                ## Run tests and code checks.
	@py.test -v --cov "$(PROJECT)" "$(PROJECT)"


check:               ## Run code checks.
	@flake8 "$(PROJECT)"
	@pydocstyle "$(PROJECT)"


fmt:                 ## Format the code.
	@black --safe --line-length=79 --target-version=py38 "$(PROJECT)"


build:               ## Build the source and wheel distribution packages.
	@python3 setup.py sdist bdist_wheel


release: build       ## Build and upload the package to PyPI.
	@twine upload --skip-existing  dist/*
	@rm -fr build dist "$(PROJECT).egg-info"
