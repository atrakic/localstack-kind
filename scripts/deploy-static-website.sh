#!/bin/bash
set -e -o pipefail

# Deploy a static website

# helm list -A
# helm -n crossplane-system get values crossplane
# helm -n localstack-system get values localstack

#kubectl get providers
kubectl get providers provider-aws-s3
kubectl apply -f s3-website-bucket.yaml
kubectl get buckets -n crossplane-system

# https://docs.aws.amazon.com/cli/v1/userguide/cli-configure-endpoints.html
kubectl get secret localstack-aws-token -n crossplane-system  -o jsonpath="{.data.credentials}" | base64 -d > .aws
export AWS_CONFIG_FILE=.aws
aws_args=( --endpoint-url http://localhost:4567 )
aws s3 ls "${aws_args[@]}"
aws s3 sync "${aws_args[@]}" ./website/ s3://crossplane-s3-bucket --acl public-read
