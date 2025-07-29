apiVersion: networking.istio.io/v1beta1
kind: Gateway
metadata:
  name: "${name}-gateway"
  namespace: "${namespace}"
spec:
  selector:
    app: istio-ingress
    istio: ingress
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "${domain}"
    tls:
      httpsRedirect: true
  - port:
      number: 443
      name: https
      protocol: HTTPS
    hosts:
    - "${domain}"
    tls:
      mode: SIMPLE
      credentialName: "${name}-tls-secret"