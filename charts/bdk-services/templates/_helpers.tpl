{{/*
Expand the name of the chart.
*/}}
{{- define "bdk-services.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bdk-services.fullname" -}}
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
{{- define "bdk-services.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bdk-services.labels" -}}
helm.sh/chart: {{ include "bdk-services.chart" . }}
{{ include "bdk-services.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bdk-services.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bdk-services.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "bdk-services.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get bdk services domain
*/}}
{{- define "bdk-services.domain" -}}
{{ include "bdk-services.getDomain" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}


{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "bdk-services.getUrl" -}}
{{- printf "https://%s" (include "bdk-services.getDomain" .) }}
{{- end }}

{{/*
Get bdk services url
*/}}
{{- define "bdk-services.url" -}}
{{ include "bdk-services.getUrl" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}
