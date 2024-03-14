# Fireboom Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/fireboom)](https://artifacthub.io/packages/search?repo=fireboom)

## Usage

If you want to use this Fireboom helm charts, you may need to prepare some prerequisites.

1. `Application database`: When you have a database data source in fireboom. Please set the database in `fireboom.customEnv` value in the `values.yaml` file.
2. `OIDC database`: If you want to use `YuDai` oidc server, please set the `oidc.database.url` value in the `values.yaml` file.

## Example

The following is an example of how to deploy `amis-admin` project with `Fireboom` helm charts.

Assuming that you have already prepared the database(`postgres://postgres:KKziaPBkybHWH729@10.233.47.102:5432/oidc_amis-admin`).

```yaml
global:
  nameOverride:
  fullnameOverride:
  imagePullSecrets: []
  web:
    enabled: true
  oidc:
    enabled: true

web:
  # web project image
  image:
    repository: fireboomapi/amis-admin_front
    pullPolicy: IfNotPresent
    tag: latest

  service:
    type: NodePort
    externalPort: 30987

  ingress:
    enabled: false
    className: ""
    annotations: {}
      # kubernetes.io/ingress.class: nginx
      # kubernetes.io/tls-acme: "true"
    hosts:
      - host: fireboom.local
        paths:
          - path: /
            pathType: ImplementationSpecific
    tls: []

  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 100m
  #   memory: 128Mi
  resources: {}

  autoscaling:
    enabled: false
    minReplicas: 1
    maxReplicas: 100
    targetCPUUtilizationPercentage: 80
    targetMemoryUtilizationPercentage: 80

  servicemesh:
    enabled: false

fireboom:
  # Pod replica count
  replicaCount: 1

  image:
    data:
      # where to pull the fireboom app data
      repository: fireboomapi/amis-admin_fb-data
      tag: "latest"
      pullPolicy: IfNotPresent
    fireboom:
      pullPolicy: IfNotPresent
      # Overrides the image tag whose default is the chart appVersion.
      tag: "v2.0.10"
    hook:
      repository: fireboomapi/amis-admin_fb-hook
      tag: "latest"
      pullPolicy: IfNotPresent
  
  customEnv:
    DB_ADMIN: "postgres://postgres:KKziaPBkybHWH729@10.233.47.102/oidc_amis-admin"
    SUPER_ROLE_CODE: "admin"

  service:
    type: NodePort
    externalUrl: 'http://192.168.211.213:30987'
    fbPort: 30988

  ingress:
    enabled: false
    className: ""
    annotations: {}
      # kubernetes.io/ingress.class: nginx
      # kubernetes.io/tls-acme: "true"
    hosts:
      - host: fireboom.local
        paths:
          - path: /
            pathType: ImplementationSpecific
    tls: []

  customInitContainers:
    - name: update-db
      image: 'fireboomapi/jq:alpine-3.19'
      command:
        - sh
        - '-c'
      args:
        - |
          jq '.kind = 3' /app/store/datasource/admin.json > temp.json
          mv temp.json /app/store/datasource/admin.json
      ports:
        - name: http-0
          containerPort: 1
          protocol: TCP
      resources: {}
      volumeMounts:
        - name: share-app
          mountPath: /app
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      imagePullPolicy: IfNotPresent

  resources:
    fireboom: {}
    hook: {}
    # We usually recommend not to specify default resources and to leave this as a conscious
    # choice for the user. This also increases chances charts run on environments with little
    # resources, such as Minikube. If you do want to specify resources, uncomment the following
    # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
    # limits:
    #   cpu: 100m
    #   memory: 128Mi
    # requests:
    #   cpu: 100m
    #   memory: 128Mi

  autoscaling:
    enabled: false
    minReplicas: 1
    maxReplicas: 100
    targetCPUUtilizationPercentage: 80
    # targetMemoryUtilizationPercentage: 80

  servicemesh:
    enabled: true

oidc:
  # Pod replica count
  replicaCount: 1

  # Database of oidc
  database: 
    url: 'postgres://postgres:KKziaPBkybHWH729@10.233.47.102:5432/oidc_amis-admin?sslmode=disable'

  image:
    repository: fireboomapi/yudai
    pullPolicy: IfNotPresent
    tag: master

  service:
    type: ClusterIP

  # We usually recommend not to specify default resources and to leave this as a conscious
  # choice for the user. This also increases chances charts run on environments with little
  # resources, such as Minikube. If you do want to specify resources, uncomment the following
  # lines, adjust them as necessary, and remove the curly braces after 'resources:'.
  # limits:
  #   cpu: 100m
  #   memory: 128Mi
  # requests:
  #   cpu: 100m
  #   memory: 128Mi
  resources: {}

  autoscaling:
    enabled: false
    minReplicas: 1
    maxReplicas: 100
    targetCPUUtilizationPercentage: 80
    targetMemoryUtilizationPercentage: 80

  servicemesh:
    enabled: false
```

## Development

### Build

```sh
helm package . -d output
helm repo index output --url https://helm.fireboom.io/fireboom
```

### Push

Upload output directory to the Fireboom R2.

```sh
# eg: use rclone
rclone copy output/ fb_cf:/helm-charts/fireboom/ --progress
```
