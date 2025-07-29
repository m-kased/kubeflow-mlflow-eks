apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: "${name}-certificate"
  namespace: "${namespace}"
spec:
  secretName: "${name}-tls-secret"
  dnsNames:
  - "${domain}"
  issuerRef:
    name: "${issuer_name}"
    kind: ClusterIssuer