{{/*
Expand the name of the chart.
*/}}
{{- define "fireboom.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "fireboom.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "fireboom.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "fireboom.labels" -}}
helm.sh/chart: {{ include "fireboom.chart" . }}
{{ include "fireboom.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app: {{ include "fireboom.name" . }}
version: v1
{{- end }}

{{/*
Common annotations
*/}}
{{- define "fireboom.annotations" -}}
{{- if .Values.servicemesh.enabled }}
servicemesh.kubesphere.io/enabled: 'true'
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "fireboom.selectorLabels" -}}
app.kubernetes.io/name: {{ include "fireboom.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common template spec
*/}}
{{- define "fireboom.templateSpec" -}}
{{- with .Values.global.imagePullSecrets }}
imagePullSecrets:
  {{- toYaml . | nindent 8 }}
{{- end -}}
serviceAccount: default
serviceAccountName: default
restartPolicy: Always
{{- end }}

