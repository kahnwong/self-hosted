{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Values.name | trunc 63 | trimSuffix "-" }}
{{- end }}
