#!/bin/bash
set -e -o pipefail
# Within localstack, all services are available behind localhost.localstack.cloud
curl -v -k -H "Host: localhost.localstack.cloud" http://localhost:4566/crossplane-s3-bucket
