{{/*
Expand the name of the chart.
*/}}
{{- define "doccache.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "doccache.fullname" -}}
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
{{- define "doccache.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create alpha service name.
*/}}
{{- define "dgraph.alphaServiceName" -}}
{{- printf "%s-dgraph-alpha" .Release.Name }}
{{- end }}

{{/*
Create ratel service name.
*/}}
{{- define "dgraph.ratelServiceName" -}}
{{- printf "%s-dgraph-ratel" .Release.Name }}
{{- end }}


{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "dgraph.getDomain" -}}
{{- printf "%s.%s" .subdomain .context.Values.domain.base }}
{{- end }}

{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "dgraph.getUrl" -}}
{{- printf "https://%s" (include "dgraph.getDomain" .) }}
{{- end }}


{{/*
Get dgraph alpha domain
*/}}
{{- define "dgraph.alphaDomain" -}}
{{ include "dgraph.getDomain" (dict "context" . "subdomain" .Values.domain.alpha ) }}
{{- end }}

{{/*
Get dgraph ratel domain
*/}}
{{- define "dgraph.ratelDomain" -}}
{{ include "dgraph.getDomain" (dict "context" . "subdomain" .Values.domain.ratel ) }}
{{- end }}


{{/*
Get dgraph alpha url
*/}}
{{- define "dgraph.alphaUrl" -}}
{{ include "dgraph.getUrl" (dict "context" . "subdomain" .Values.domain.alpha ) }}
{{- end }}

{{/*
Get dgraph ratel url
*/}}
{{- define "dgraph.ratelUrl" -}}
{{ include "dgraph.getUrl" (dict "context" . "subdomain" .Values.domain.ratel ) }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "doccache.labels" -}}
helm.sh/chart: {{ include "doccache.chart" . }}
{{ include "doccache.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "doccache.selectorLabels" -}}
app.kubernetes.io/name: {{ include "doccache.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}