compile:
	terraform -chdir=infrastructure init && \
	terraform -chdir=infrastructure fmt -recursive

plan:
	terraform -chdir=infrastructure plan