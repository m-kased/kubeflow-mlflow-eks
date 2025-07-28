serviceAccount:
  create: true
  annotations:
    eks.amazonaws.com/role-arn: "${service_account_role_arn}"
  name: "mlflow"

backendStore:
  postgres:
    enabled: true
    host: ${postgres_host}
    port: ${postgres_port}
    database: ${postgres_database}
    user: ${postgres_user}

artifactRoot:
  s3:
    enabled: true
    bucket: ${s3_bucket_name}

