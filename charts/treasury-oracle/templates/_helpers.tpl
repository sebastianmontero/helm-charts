{{/*
Expand the name of the chart.
*/}}
{{- define "treasury-oracle.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "treasury-oracle.fullname" -}}
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
{{- define "treasury-oracle.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
BTC Credentials volume name
*/}}
{{- define "treasury-oracle.btc-credentials-volume" -}}
{{- printf "%s-btc-credentials" ( include "treasury-oracle.fullname" . )  }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "treasury-oracle.labels" -}}
helm.sh/chart: {{ include "treasury-oracle.chart" . }}
{{ include "treasury-oracle.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "treasury-oracle.selectorLabels" -}}
app.kubernetes.io/name: {{ include "treasury-oracle.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
