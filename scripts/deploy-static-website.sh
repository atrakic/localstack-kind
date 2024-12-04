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
export AWS_PAGER=""
export AWS_CONFIG_FILE=.aws
aws_args=( --endpoint-url http://localhost:4566 --region us-east-1 )
aws sts get-caller-identity "${aws_args[@]}"
aws s3 ls "${aws_args[@]}"
# FIXME:
# https://github.com/crossplane-contrib/provider-upjet-aws/issues/1549
aws s3 sync "${aws_args[@]}" ./website/ s3://crossplane-s3-bucket --acl public-read
