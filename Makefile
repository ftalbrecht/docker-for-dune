# This file is part of the dune-community/Dockerfiles project:
#   https://github.com/dune-community/Dockerfiles
# Copyright 2017 dune-community/Dockerfiles developers and contributors. All rights reserved.
# License: Dual licensed as BSD 2-Clause License (http://opensource.org/licenses/BSD-2-Clause)
#      or  GPL-2.0+ (http://opensource.org/licenses/gpl-license)
# Authors:
#   Rene Milk (2017)

SUBDIRS = manylinux arch debian gitlabci testing

.PHONY: subdirs $(SUBDIRS) base push debian_*

subdirs: $(SUBDIRS)

testing: debian_full debian_unstable-full

$(SUBDIRS):
	make -C $@
	make -C $@ readme

debian_%:
	make -C debian $*

arch_%:
	make -C arch $*

push: push_arch push_debian push_gitlabci push_testing

push_debian_ci:
	make -C debian ci_push
push_debian_unstable_ci:
	make -C debian unstable_ci_push

push_%: %
	make -C $< push

all: subdirs

dockerignore:
	find . -mindepth 2 -name .dockerignore  | xargs -I{} cp -f .dockerignore {}
