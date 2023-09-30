{{/*
Expand the name of the chart.
*/}}
{{- define "strfry-relay.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "strfry-relay.fullname" -}}
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
Backup cronjob name
*/}}
{{- define "strfry-relay.backUpCronjob" -}}
{{- printf "%s-backup-job" (include "strfry-relay.fullname" .) }}
{{- end }}

{{/*
Sync cronjob name
*/}}
{{- define "strfry-relay.syncCronjob" -}}
{{- printf "%s-sync-job" (include "strfry-relay.fullname" .) }}
{{- end }}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "strfry-relay.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "strfry-relay.labels" -}}
helm.sh/chart: {{ include "strfry-relay.chart" . }}
{{ include "strfry-relay.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "strfry-relay.selectorLabels" -}}
app.kubernetes.io/name: {{ include "strfry-relay.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Endpoint
*/}}
{{- define "strfry-relay.endpoint" -}}
{{- printf "%s.%s.cluster.local:%v/postgres" (include "strfry-relay.fullname" .)  .Release.Namespace .Values.service.port }}
{{- end }}


{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "strfry-relay.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get hashed faucet server full domain
*/}}
{{- define "strfry-relay.fullDomain" -}}
{{ include "strfry-relay.getDomain" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}


{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "strfry-relay.getUrl" -}}
{{- printf "wss://%s" (include "strfry-relay.fullDomain" .) }}
{{- end }}
