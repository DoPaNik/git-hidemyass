ARGS = $(filter-out $@,$(MAKECMDGOALS))
MAKEFLAGS += --silent

.PHONY: help
help:
	awk 'BEGIN {FS = ":.*##"; printf "Usage: make \033[36m<target>\033[0m\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-10s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

LOCATION=/usr/local

GIT_HIDE_MY_ASS =git-hidemyass

##@ GIT-HIDEMYASS

.PHONY: install
install:  ##Install git-hidemyass
	install -m 0755 $(GIT_HIDE_MY_ASS) $(LOCATION)/bin

.PHONY: uninstall
uninstall: ##Uninstall git-hidemyass
	test -d $(LOCATION)/bin && \
	cd $(LOCATION)/bin && \
	rm -f $(GIT_HIDE_MY_ASS)

#############################
# Argument fix workaround
#############################
%:
	@: