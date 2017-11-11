# Maintainer tangfeixiong <fxtang@qingyuanos.com>
---
apiVersion: "v1"
kind: "Endpoints"
metadata:
  annotations:
    qingyuanos.io/catalog-by: '{"version": "v1alpha", "lib": "https://github.com/qingyuancloud/kube-harpoon"}'
  labels:
    app: {{ .Release.Name -}}-{{- .Values.hadoopVersion }}
    heritage: {{ .Release.Service }}
    version: {{ .Chart.Version }}
  name: {{ .Chart.Name }}
subsets: 
{{ range $.Values.addresses -}}
- addresses:
  - ip: {{ .ip }}
  ports:
  {{- if .yarn -}}
  {{- if .yarn.resourcemanager }}
  - name: yarn-resourcemanager-webapp
    port: {{ .yarn.resourcemanager.webapp.port }}
  - name: yarn-resourcemanager
    port: {{ .yarn.resourcemanager.port }}
  - name: yarn-resourcemanager-admin
    port: {{ .yarn.resourcemanager.admin.port }}
  {{- end -}}
  {{- if .yarn.nodemanager }}
  - name: yarn-nodemanager-webapp
    port: {{ .yarn.nodemanager.webapp.port }}
  {{- end -}}
  {{- if .mapreduce.jobhistory }}
  - name: mapreduce-jobhistory-webapp
    port: {{ .mapreduce.jobhistory.webapp.port }}
  {{- end -}}
  {{- else if .mapred }}
  - name: mapred-job-tracker
    port: {{ .mapred.job.tracker.port }}
  - name: mapred-job-tracker-http
    port: {{ .mapred.job.tracker.http.port }}
  - name: mapred-task-tracker-http
    port: {{ .mapred.task.tracker.http.port }}
  {{- end -}}
  {{- if .dfs.namenode }}
  - name: dfs-namenode-servicerpc
    port: {{ .dfs.namenode.servicerpc_port }}
  - name: dfs-namenode-http
    port: {{ .dfs.namenode.http_port }}
  {{- end -}}
  {{- if .dfs.datanode }}
  - name: dfs-datanode
    port: {{ .dfs.datanode.port }}
  - name: dfs-datanode-http
    port: {{ .dfs.datanode.http.port }}
  - name: dfs-datanode-ipc
    port: {{ .dfs.datanode.ipc.port }}
  {{- end -}}
{{- end }}