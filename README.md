# cloud_profile
A cloud native stack to host my blog "Know Your Systems."

Current Stack:
- HTML/CSS static website using [Hugo](https://themes.gohugo.io/) as the site generator 
- <b>S3</b> bucket hosting the site
- <b>Cloudfront distribution</b> fronting my <b>S3 origin</b> to serve with SSL/TLS and Cloudfront edge locations for speed.
- <b>Route53</b> to manage DNS records
- <b>ACM</b> to create and manage SSL certs.
- <b> API Gateway </b> used to serve view counts for my profile
- <b> Lambda </b> used as handlers for the API responses.
- <b> DynamoDB </b> to manage site statistics. 
- All infrastructure is managed by <b>Terraform</b>

View my site! https://mpcloudstack.com
