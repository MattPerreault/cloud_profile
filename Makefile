compile:
	terraform -chdir=infrastructure init && \
	terraform -chdir=infrastructure fmt
