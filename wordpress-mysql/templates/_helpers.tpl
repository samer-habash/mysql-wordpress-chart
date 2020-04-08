{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "wordpress-mysql.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "mysql.fullname" -}}
{{- default "mysql" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wordpress.fullname" -}}
{{- default "wordpress" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wordpress.tier.fullname" -}}
{{- default "frontend" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wordpress-mysql.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "wordpress-mysql.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Mysql Common labels
*/}}
{{- define "mysql.labels" -}}
app: {{ include "wordpress.fullname" . }}
{{- end -}}

{{/*
Mysql Selector labels mysql
*/}}
{{- define "mysql.selectorLabels" -}}
app: {{ include "wordpress.fullname" . }}
tier: {{ include "mysql.fullname" . }}
{{- end -}}

{{/*
Mysql Volume
*/}}
{{- define "mysql.volumes" -}}
{{- default "mysql-persistent-storage" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Mysql Persistent Volume Claim
*/}}
{{- define "mysql.persistentVolumeClaim" -}}
{{- default  "mysql-pv-claim" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}


{{/*
Wordpress Common labels
*/}}
{{- define "wordpress.labels" -}}
app: {{ include "wordpress.fullname" . }}
{{- end -}}

{{/*
Wordpress Selector labels mysql
*/}}
{{- define "wordpress.selectorLabels" -}}
app: {{ include "wordpress.fullname" . }}
tier: {{ include "wordpress.tier.fullname" . }}
{{- end -}}

{{/*
Wordpress Volume
*/}}
{{- define "wordpress.volumes" -}}
{{- default "wordpress-persistent-storage" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Wordpress Persistent Volume Claim
*/}}
{{- define "wordpress.persistentVolumeClaim" -}}
{{- default  "wp-pv-claim" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Wordpress and mysql labels for Global resources (serviceAccount, ingress)
*/}}
{{- define "wordpress-mysql.labels" -}}
app: {{ include "wordpress.fullname" . }}
tier: {{ include "wordpress.tier.fullname" . }}

{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "wordpress-mysql.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{ default (include "mysql.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
{{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}




