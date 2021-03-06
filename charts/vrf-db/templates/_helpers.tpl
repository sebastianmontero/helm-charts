{{/*
Expand the name of the chart.
*/}}
{{- define "vrf-db.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "vrf-db.fullname" -}}
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
{{- define "vrf-db.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vrf-db.labels" -}}
helm.sh/chart: {{ include "vrf-db.chart" . }}
{{ include "vrf-db.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vrf-db.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vrf-db.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
DB Endpoint
*/}}
{{- define "vrf-db.endpoint" -}}
{{- printf "%s.%s.cluster.local:%v/vrf" (include "vrf-db.fullname" .)  .Release.Namespace .Values.service.port }}
{{- end }}
