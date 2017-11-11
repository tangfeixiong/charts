# Maintainer tangfeixiong <fxtang@qingyuanos.com>
---
apiVersion: "v1"
kind: "Service"
metadata:
  annotations:
    qingyuanos.io/catalog-by: '{"version": "v1alpha", "lib": "https://github.com/qingyuancloud/kube-harpoon"}'
  labels:
    app: {{ .Release.Name -}}-{{- .Values.hadoopVersion }}
    heritage: {{ .Release.Service }}
    version: {{ .Chart.Version }}
  name: {{ .Chart.Name }}
spec:
  ports:
{{- range $.Values.addresses -}}
  {{- if .yarn -}}
  {{- if .yarn.resourcemanager }}
  - name: yarn-resourcemanager-webapp
    protocol: "TCP"
    port: {{ .yarn.resourcemanager.webapp.port }}
    targetPort: {{ .yarn.resourcemanager.webapp.port }}
    nodePort: 0
  - name: yarn-resourcemanager
    protocol: "TCP"
    port: {{ .yarn.resourcemanager.port }}
    targetPort: {{ .yarn.resourcemanager.port }}
    nodePort: 0
  - name: yarn-resourcemanager-admin
    protocol: "TCP"
    port: {{ .yarn.resourcemanager.admin.port }}
    targetPort: {{- .yarn.resourcemanager.admin.port -}}
    nodePort: 0
  {{- end -}}
  {{- if .yarn.nodemanager }}
  - name: yarn-nodemanager-webapp
    protocol: "TCP"
    port: {{ .yarn.nodemanager.webapp.port }}
    targetPort: {{ .yarn.nodemanager.webapp.port }}
    nodePort: 0
  {{- end -}}
  {{- if .mapreduce.jobhistory }}
  - name: mapreduce-jobhistory-webapp
    protocol: "TCP"
    port: {{ .mapreduce.jobhistory.webapp.port }}
    targetPort: {{ .mapreduce.jobhistory.webapp.port }}
    nodePort: 0
  {{- end -}}
  {{- else -}}
  {{- with $.Values.addresses.mapred }}
  - name: mapred-job-tracker
    protocol: "TCP"
    port: {{ .job.tracker.port }}
    targetPort: {{ .job.tracker.port }}
    nodePort: 0
  - name: mapred-job-tracker-http
    protocol: "TCP"
    port: {{ .job.tracker.http.port }}
    targetPort: {{ .job.tracker.http.port }}
    nodePort: 0
  - name: mapred-task-tracker-http
    protocol: "TCP"
    port: {{ .task.tracker.http.port }}
    targetPort: {{ .task.tracker.http.port }}
    nodePort: 0
  {{- end -}}
  {{- end -}}
  {{- with .dfs.namenode }}
  - name: dfs-namenode-servicerpc
    protocol: "TCP"
    port: {{ .servicerpc_port }}
    targetPort: {{ .servicerpc_port }}
    nodePort: 0
  - name: dfs-namenode-http
    protocol: "TCP"
    port: {{ .http_port }}
    targetPort: {{ .http_port }}
    nodePort: 0
  {{- end -}}
  {{- with .dfs.datanode }}
  - name: dfs-datanode
    protocol: "TCP"
    port: {{ .port }}
    targetPort: {{ .port }}
    nodePort: 0
  - name: dfs-datanode-http
    protocol: "TCP"
    port: {{ .http.port }}
    targetPort: {{ .http.port }}
    nodePort: 0
  - name: dfs-datanode-ipc
    protocol: "TCP"
    port: {{ .ipc.port }}
    targetPort: {{ .ipc.port }}
    nodePort: 0
  {{ end -}}
{{- end -}}
  selector: {}