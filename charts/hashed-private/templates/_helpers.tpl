{{/*
Expand the name of the chart.
*/}}
{{- define "hashed-private.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hashed-private.fullname" -}}
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
{{- define "hashed-private.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}



{{/*
Create action server url 
REQUIRED TO FIX THE CHART NAME, BECAUSE WHEN TRYING TO USE FULL NAME
IT IS RUN IN THE SUBCHART CONTEXT AND GENERATES THE INCORRECT NAME
*/}}
{{- define "hashed-private.fullNameForSubcharts" -}}
{{- printf "%s-hashed-private" .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create action server url
*/}}
{{- define "hashed-private.actionServerUrl" -}}
{{- printf "http://%s:3000" (include "hashed-private.fullNameForSubcharts" .) }}
{{- end }}

{{/*
Hasura service name.
*/}}
{{- define "hasura.serviceName" -}}
{{ include "hasura.fullName" . }}
{{- end }}

{{/*
Hasura full name.
*/}}
{{- define "hasura.fullName" -}}
{{ template "hasura.fullname" .Subcharts.hasura }}
{{- end }}

{{/*
Create gql endpoint.
*/}}
{{- define "hasura.gqlEndpoint" -}}
{{- printf "http://%s:%v/v1/graphql" (include "hasura.serviceName" .) .Subcharts.hasura.Values.service.port }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hashed-private.labels" -}}
helm.sh/chart: {{ include "hashed-private.chart" . }}
{{ include "hashed-private.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hashed-private.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hashed-private.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get full domain function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "hashed-private.getDomain" -}}
{{- if .subdomain }}
{{- printf "%s.%s" .subdomain .context.Values.url.domain.base }}
{{- else }}
{{- .context.Values.url.domain.base }}
{{- end }}
{{- end }}


{{/*
Get hashed private gql domain
*/}}
{{- define "hashed-private.gqlDomain" -}}
{{ include "hashed-private.getDomain" (dict "context" . "subdomain" .Values.url.domain.gql ) }}
{{- end }}


{{/*
Get full url function
Params:
  context: chart context
  subdomain: subdomain to use
*/}}
{{- define "hashed-private.getUrl" -}}
{{- printf "https://%s" (include "hashed-private.getDomain" .) }}
{{- end }}

{{/*
Get hashed private gql url
*/}}
{{- define "hashed-private.url" -}}
{{- printf "%s/v1/graphql" (include "hashed-private.getUrl" (dict "context" . "subdomain" .Values.url.domain.gql )) }}
{{- end }}

{{/*
JWT Keys volume name
*/}}
{{- define "hashed-private.jwtKeysVolume" -}}
{{- printf "%s-jwt-keys" ( include "hashed-private.fullname" . )  }}
{{- end }}

{{/*
JWT Keys local glob path
*/}}
{{- define "hashed-private.jwtKeysLocalGlobPath" -}}
{{- clean (printf "%s/*.key*" .Values.jwt.localKeyPath)  }}
{{- end }}


