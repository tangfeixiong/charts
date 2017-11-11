    serviceAccount: builder
    source:
      type: Git
      binary: null
      dockerfile: null
      git:
        uri: {{.git.uri}}
        ref: {{.git.ref}}
        httpProxy: null
        httpsProxy: null
      images: []
      contextDir: {{.ContextDir}}
      sourceSecret: null
      secrets: []
    revision: null
    strategy:
      type: Source
      sourceStrategy:
        from:
          kind: {{.FromKind}}
          name: {{.FromName}}
        pullSecret: null
        forcePull: {{.ForcePull}}
        runtimeImage: null
        runtimeArtifacts: []
    output:
      to:
        kind: {{.ToKind}}
        name: {{.ToName}}
      pushSecret: null
    resources: {},
    postCommit: {},
    CompletionDeadlineSeconds: null