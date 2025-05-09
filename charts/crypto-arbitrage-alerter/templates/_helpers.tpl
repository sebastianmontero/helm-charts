{{/*
Expand the name of the chart.
*/}}
{{- define "crypto-arbitrage-alerter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "crypto-arbitrage-alerter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "crypto-arbitrage-alerter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "crypto-arbitrage-alerter.labels" -}}
helm.sh/chart: {{ include "crypto-arbitrage-alerter.chart" . }}
{{ include "crypto-arbitrage-alerter.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "crypto-arbitrage-alerter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "crypto-arbitrage-alerter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Get custom env vars configmap name
Params:
  context: chart context
*/}}
{{- define "crypto-arbitrage-alerter.custom-env-vars-configmap" -}}
{{- printf "%s-custom-env-vars" (include "crypto-arbitrage-alerter.fullname" .) }}
{{- end }}

