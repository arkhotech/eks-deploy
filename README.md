# eks-deploy


This action aims like a solution to deploy EKS services using HELM 3.

Parameters:

| Parameter | Description | Default | Required | Implemented |
| --------- | ----------- | ------- | -------- | ----------- |
| cluster_name | Nombre del cluster EKS | N/A | si | yes |
| helm_values | Parametros a sobrescribir | N/A  | no | yes | 
| region | Region AWS | us-east-1 | No | yes |
| aws_access_key_id | access key. If not especified env AWS variables is needed | N/A | No | yes |
| aws_secret_access_key | Secret access key | N/A | false | yes |
| service_name | Nombre del servicio o imagen | N/A | yes | yes |
| service_version | Version del container | N/A | yes | yes |
| template_path | Path where helm template is | tpl_service | no | yes |

Usage:

```yaml

    - uses: arkhotech/eks-deploy@v1.0.0
      name: Helm service upgrade
      with: 
        cluster_name: cluster_name
        service_name: ${{ env.SERVICE_NAME }}
        service_version: ${{ env.SERVICE_VERSION }}

```


Author: Marcelo Silva
Company: Aarkhotech Spa, Santiago de Chile

