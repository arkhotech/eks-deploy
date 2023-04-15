#!/bin/bash
set -e

echo "Iniciando despliegue usando HELM"

env

echo "Obteniendo configuración"
aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name $INPUT_CLUSTER_NAME

ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')

IMAGE="${ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${INPUT_SERVICE_NAME}"
helm upgrade --install tpl-service tpl-service --set image.repository=$IMAGE --set image.tag=$INPUT_SERVICE_VERSION --debug

