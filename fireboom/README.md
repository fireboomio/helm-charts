# Fireboom Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/fireboom)](https://artifacthub.io/packages/search?repo=fireboom)

## Usage

If you want to use this Fireboom helm charts, you may need to prepare some prerequisites.

1. `Application database`: When you have a database data source in fireboom. Please set the database in `fireboom.customEnv` value in the `values.yaml` file.
2. `OIDC database`: If you want to use `YuDai` oidc server, please set the `oidc.database.url` value in the `values.yaml` file.

If you want to view the `Fireboom` 9123 dashboard, you may need to and an Ingress or a LoadBalancer to expose the `Fireboom` service to the outside world.

## Example

There is [an example values.yaml](https://git.fireboom.io/fireboomio/helm-charts/blob/main/fireboom/test.values.yaml) of how to deploy `amis-admin` project with `Fireboom` helm charts.

Assuming that you have already prepared the database(`postgres://postgres:KKziaPBkybHWH729@10.233.47.102:5432/oidc_amis-admin`).
