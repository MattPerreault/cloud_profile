compile:
	terraform -chdir=infrastructure init && \
	terraform -chdir=infrastructure fmt

plan:
	terraform -chdir=infrastructure plan