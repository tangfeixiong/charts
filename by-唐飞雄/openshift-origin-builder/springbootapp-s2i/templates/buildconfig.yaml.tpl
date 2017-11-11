# Maintainer tangfeixiong <fxtang@qingyuanos.com>
---
kind: BuildConfig,
apiVersion: v1,
metadata:
  name: {{.Values.buildConfigName}}
  namespace: {{.Values.projectName}}
spec:
  triggers:
  {{range $trigger := .Values.buildtriggers -}}
  {{- if $trigger.gitHubWebHook }}
  - type: GitHub
    gitHubWebHook:
      secret: {{.secret}}
  {{- else if $trigger.genericWebHook }}
  - type: Generic
    genericWebHook:
      secret: {{.secret}}
      allowEnv: {{.allowEnv}}
  {{- else if $trigger.imageChange }}
  - type: ImageChange
    imageChange: 
      {{- if .from }}
      from: 
        kind: {{.kind}}
        name: {{.name}}
      {{end -}}
  {{end -}}
  {{- end}}
  runPolicy: {{.Values.buildRunPolicy}}
  commonSpec: {{template "buildcommon" .}} 
