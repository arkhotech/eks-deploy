#!/bin/bash
set -e

echo "Iniciando despliegue usando HELM"

ACCOUNT_ID=$(aws sts get-caller-identity | jq -r '.Account')

aws eks update-kubeconfig --region ${AWS_DEFAULT_REGION} --name ${INPUT_CLUSTER_NAME}

if [ ! -z "${INPUT_PRE_COMMAND}" ];
then
    echo "Ejecutando comando pre execution"
    eval "${INPUT_PRE_COMMAND}"
fi

IMAGE="${ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${INPUT_SERVICE_NAME}:${INPUT_SERVICE_VERSION}"
helm upgrade --install ${INPUT_SERVICE_NAME} ./${INPUT_TEMPLATE_PATH} --set image.repository=$IMAGE --set image.tag=$INPUT_SERVICE_VERSION --debug

