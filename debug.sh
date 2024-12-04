#!/bin/bash
set -e -o pipefail
kubectl run -i --tty --rm --restart=Never --image ubuntu debug-shell bash

