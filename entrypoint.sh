#!/bin/bash
set -e

echo "Iniciando despliegue usando HELM"

env

export AWS_ACCESS_KEY_ID=$INPUT_ACCESS_KEY_ID

export AWS_SECRET_ACCESS_KEY=$INPUT_AWS_SECRET_ACCESS_KEY

export AWS_REGION=$INPUT_AWS_REGION

echo "Obteniendo configuración"
aws eks update-kubeconfig --region $AWS_REGION --name $INPUT_CLUSTER_NAME

ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')

IMAGE="${ACCOUNT_ID}.dkr.ecr.${INPUT_AWS_REGION}.amazonaws.com/${INPUT_SERVICE_NAME}"
helm upgrade --install tpl-service tpl-service --set image.repository=$IMAGE --set image.tag=$INPUT_SERVICE_VERSION --debug

