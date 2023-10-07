{{/*
Expand the name of the chart.
*/}}
{{- define "smartvaults-notification-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "smartvaults-notification-server.fullname" -}}
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
{{- define "smartvaults-notification-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "smartvaults-notification-server.labels" -}}
helm.sh/chart: {{ include "smartvaults-notification-server.chart" . }}
{{ include "smartvaults-notification-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "smartvaults-notification-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "smartvaults-notification-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{/*
Generate the name for environment secrets secret
*/}}
{{- define "smartvaults-notification-server.envSecrets" -}}
{{- printf "%s-env-secrets" (include "smartvaults-notification-server.fullname" .) }}
{{- end }}

{{/*
Generate Database URL
*/}}
{{- define "smartvaults-notification-server.dbHost" -}}
{{- printf "%s-hashed-faucet-db.%s.svc.cluster.local" .Release.Name .Release.Namespace }}
{{- end }}

{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "smartvaults-notification-server.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get hashed faucet server full domain
*/}}
{{- define "smartvaults-notification-server.fullDomain" -}}
{{ include "smartvaults-notification-server.getDomain" (dict "context" . "subdomain" .Values.url.domain.subdomain ) }}
{{- end }}


{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "smartvaults-notification-server.getUrl" -}}
{{- printf "https://%s" (include "smartvaults-notification-server.fullDomain" .) }}
{{- end }}


{{/*
Keys volume name
*/}}
{{- define "smartvaults-notification-server.keysVolume" -}}
{{- printf "%s-keys" ( include "smartvaults-notification-server.fullname" . )  }}
{{- end }}