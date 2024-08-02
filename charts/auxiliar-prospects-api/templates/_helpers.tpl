{{/*
Expand the name of the chart.
*/}}
{{- define "auxiliar-prospects-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "auxiliar-prospects-api.fullname" -}}
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
{{- define "auxiliar-prospects-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "auxiliar-prospects-api.labels" -}}
helm.sh/chart: {{ include "auxiliar-prospects-api.chart" . }}
{{ include "auxiliar-prospects-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "auxiliar-prospects-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "auxiliar-prospects-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "auxiliar-prospects-api.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get bdk services domain
*/}}
{{- define "auxiliar-prospects-api.domain" -}}
{{ include "auxiliar-prospects-api.getDomain" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}


{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "auxiliar-prospects-api.getUrl" -}}
{{- printf "https://%s" (include "auxiliar-prospects-api.getDomain" .) }}
{{- end }}

{{/*
Get bdk services url
*/}}
{{- define "auxiliar-prospects-api.url" -}}
{{ include "auxiliar-prospects-api.getUrl" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}
