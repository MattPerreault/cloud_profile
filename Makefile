compile:
	terraform -chdir=infrastructure/s3 init && \
	terraform -chdir=infrastructure/s3 fmt
