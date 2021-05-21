{{/*
Expand the name of the chart.
*/}}
{{- define "dfuse-demo.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dfuse-demo.fullname" -}}
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
{{- define "dfuse-demo.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "dfuse-demo.get-domain" -}}
{{- printf "%s.%s" .subdomain .context.Values.domain.base }}
{{- end }}

{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "dfuse-demo.get-url" -}}
{{- printf "https://%s" (include "dfuse-demo.get-domain" .) }}
{{- end }}


{{/*
Get dfuse api domain
*/}}
{{- define "dfuse-demo.dapi-domain" -}}
{{ include "dfuse-demo.get-domain" (dict "context" . "subdomain" .Values.domain.dfuseApi ) }}
{{- end }}

{{/*
Get dfuse api url
*/}}
{{- define "dfuse-demo.dapi-url" -}}
{{ include "dfuse-demo.get-url" (dict "context" . "subdomain" .Values.domain.dfuseApi ) }}
{{- end }}

{{/*
Get nodeos domain
*/}}
{{- define "dfuse-demo.nodeos-domain" -}}
{{ include "dfuse-demo.get-domain" (dict "context" . "subdomain" .Values.domain.nodeos ) }}
{{- end }}

{{/*
Get nodeos url
*/}}
{{- define "dfuse-demo.nodeos-url" -}}
{{ include "dfuse-demo.get-url" (dict "context" . "subdomain" .Values.domain.nodeos ) }}
{{- end }}

{{/*
Get node manager domain
*/}}
{{- define "dfuse-demo.nm-domain" -}}
{{ include "dfuse-demo.get-domain" (dict "context" . "subdomain" .Values.domain.nodeManager ) }}
{{- end }}

{{/*
Get node manager url
*/}}
{{- define "dfuse-demo.nm-url" -}}
{{ include "dfuse-demo.get-url" (dict "context" . "subdomain" .Values.domain.nodeManager ) }}
{{- end }}

{{/*
Get prometheus domain
*/}}
{{- define "dfuse-demo.pm-domain" -}}
{{ include "dfuse-demo.get-domain" (dict "context" . "subdomain" .Values.domain.prometheus ) }}
{{- end }}

{{/*
Get prometheus url
*/}}
{{- define "dfuse-demo.pm-url" -}}
{{ include "dfuse-demo.get-url" (dict "context" . "subdomain" .Values.domain.prometheus ) }}
{{- end }}

{{/*
Get eosq domain
*/}}
{{- define "dfuse-demo.eosq-domain" -}}
{{ include "dfuse-demo.get-domain" (dict "context" . "subdomain" .Values.domain.eosq ) }}
{{- end }}

{{/*
Get eosq url
*/}}
{{- define "dfuse-demo.eosq-url" -}}
{{ include "dfuse-demo.get-url" (dict "context" . "subdomain" .Values.domain.eosq ) }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dfuse-demo.labels" -}}
helm.sh/chart: {{ include "dfuse-demo.chart" . }}
{{ include "dfuse-demo.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dfuse-demo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dfuse-demo.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

