{{/*
Expand the name of the chart.
*/}}
{{- define "governance-chatbot-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "governance-chatbot-server.fullname" -}}
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
{{- define "governance-chatbot-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "governance-chatbot-server.labels" -}}
helm.sh/chart: {{ include "governance-chatbot-server.chart" . }}
{{ include "governance-chatbot-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "governance-chatbot-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "governance-chatbot-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Generate Database HOST
*/}}
{{- define "governance-chatbot-server.dbHost" -}}
{{- printf "%s-governance-db.%s.svc.cluster.local" .Release.Name .Release.Namespace }}
{{- end }}

{{/*
Generate Database URL
*/}}
{{- define "governance-chatbot-server.dbURL" -}}
{{- printf "postgresql://postgres:%s@%s:5432/postgres" (index .Values "governance-db" "postgresPassword") (include "governance-chatbot-server.dbHost" .) }}
{{- end }}

{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "governance-chatbot-server.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get hashed faucet server full domain
*/}}
{{- define "governance-chatbot-server.fullDomain" -}}
{{ include "governance-chatbot-server.getDomain" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}


{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "governance-chatbot-server.getUrl" -}}
{{- printf "https://%s" (include "governance-chatbot-server.fullDomain" .) }}
{{- end }}