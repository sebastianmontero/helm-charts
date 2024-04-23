{{/*
Expand the name of the chart.
*/}}
{{- define "conversational-rag-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "conversational-rag-server.fullname" -}}
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
{{- define "conversational-rag-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "conversational-rag-server.labels" -}}
helm.sh/chart: {{ include "conversational-rag-server.chart" . }}
{{ include "conversational-rag-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "conversational-rag-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "conversational-rag-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "conversational-rag-server.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get hashed faucet server full domain
*/}}
{{- define "conversational-rag-server.fullDomain" -}}
{{ include "conversational-rag-server.getDomain" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}

{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "conversational-rag-server.getUrl" -}}
{{- printf "https://%s" (include "conversational-rag-server.fullDomain" .) }}
{{- end }}

{{/*
Get docs url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "conversational-rag-server.getDocsUrl" -}}
{{- printf "%s/docs" (include "conversational-rag-server.getUrl" .) }}
{{- end }}



{{/*
Create the name of the service account to use
*/}}
{{- define "conversational-rag-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "conversational-rag-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
