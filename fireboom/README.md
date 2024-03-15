# Fireboom Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/fireboom)](https://artifacthub.io/packages/search?repo=fireboom)

## Usage

If you want to use this Fireboom helm charts, you may need to prepare some prerequisites.

1. `Application database`: When you have a database data source in fireboom. Please set the database in `fireboom.customEnv` value in the `values.yaml` file.
2. `OIDC database`: If you want to use `YuDai` oidc server, please set the `oidc.database.url` value in the `values.yaml` file.

If you want to view the `Fireboom` 9123 dashboard, you may need to and an Ingress or a LoadBalancer to expose the `Fireboom` service to the outside world.

## Configuration

- If you don't need our `oidc` server, you can disable it by setting `globa.oidc.enabled` to `false` in the `values.yaml` file. Otherwise, 
you should provide `oidc.database.url` in the `values.yaml` file.
- If you just need `Fireboom` server without web application, you can disable `web` by setting `globa.web.enabled` to `false` in the `values.yaml` file. Otherwise, you should provide `web.image.repository & tag  ` in the `values.yaml` file. If you want to expose web application, you should configure the `web.ingress` in the `values.yaml` file.
- In `fireboom` section, you should provide `fireboom.image.data.repository` `fireboom.image.hook.repository` at least. `fireboom.image.data.repository` is a init container that just copy `store` `upload` `custom-go/ts/java/python` folders to the shared `/app` folder, you can refer to our [amis-admin](https://github.com/fireboomio/amis-admin/blob/dev/backend/fb-data.Dockerfile) project for more details. `fireboom.image.hook.repository` is the container that provide the runtime for `Fireboom hooks`, you can refer to our [amis-admin](https://github.com/fireboomio/amis-admin/blob/dev/backend/fb-hook.Dockerfile) project for more details.
- This chart default enable health-check for all pods, you can disable it by setting `web/oidc/fireboom.healthCheck.enabled` to `false` in the `values.yaml` file.

## Example

There is [an example values.yaml](https://git.fireboom.io/fireboomio/helm-charts/blob/main/fireboom/test.values.yaml) of how to deploy `amis-admin` project with `Fireboom` helm charts.

Assuming that you have already prepared the database(`postgres://postgres:KKziaPBkybHWH729@10.233.47.102:5432/oidc_amis-admin`).
