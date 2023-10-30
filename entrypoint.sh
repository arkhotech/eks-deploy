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

if [ -z "${INPUT_NAMESPACE}" ];
then
    NAMESPACE=cpat
    HELM_NAMESPACE=default
else
    NAMESPACE=$INPUT_NAMESPACE
    HELM_NAMESPACE=$INPUT_NAMESPACE
fi
echo "Namespace: $NAMESPACE"

IMAGE="${ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${INPUT_SERVICE_NAME}:${INPUT_SERVICE_VERSION}"
helm upgrade --namespace  ${INPUT_NAMESPACE} \
        --install ${INPUT_SERVICE_NAME} ./${INPUT_TEMPLATE_PATH} \
        --set image.repository=$IMAGE \
        --set image.tag=$INPUT_SERVICE_VERSION \
        --set namespace=$NAMESPACE --debug

