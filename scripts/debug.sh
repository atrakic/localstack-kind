#!/bin/bash
set -e -o pipefail
# k get bucket crossplane-s3-bucket  -o yaml
kubectl run -i --tty --rm --restart=Never --image ubuntu debug-shell bash

