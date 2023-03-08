# cloud_profile
A cloud native stack to host my stuff

Current Stack:
- HTML/CSS static website
- <b>S3</b> bucket hosting the site
- <b>Cloudfront distribution</b> fronting my <b>S3 origin</b> to serve with SSL/TLS and Cloudfront edge locations for speed.
- <b>Route53</b> to manage DNS records
- <b>ACM</b> to create and manage SSL certs.
- <b> API Gateway </b> used to manage and server view counts for my profile
- <b> Lambda </b> used as a handler for the API responses. 
- All infrastructure is managed by <b>Terraform</b>

View my site! https://mpcloudstack.com

TODO: Create documention to show data flow and cloud resource communication. Reference Issue https://github.com/MattPerreault/cloud_profile/issues/15
