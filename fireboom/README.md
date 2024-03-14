# Fireboom Helm Charts

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/fireboom)](https://artifacthub.io/packages/search?repo=fireboom)

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
