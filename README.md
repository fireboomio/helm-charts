# Helm Charts

- `fireboom`: The main chart for deploying Fireboom.

## Fireboom Chart Development

### Test

```sh
cd fireboom
helm template -f test.values.yaml --debug .
# helm install --dry-run --debug -f test.values.yaml amis-admin .
```

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
