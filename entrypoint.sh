#!/bin/bash

ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')

IMAGE="${ACCOUNT_ID}.dkr.ecr.${INPUT_AWS_REGION}.amazonaws.com/${INPUT_SERVICE_NAME}"
helm upgrade --install tpl-service tpl-service --set image.repository=$IMAGE --set image.tag=$INPUT_SERVICE_VERSION --debug