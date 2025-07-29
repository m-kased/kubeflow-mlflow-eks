apiVersion: networking.istio.io/v1beta1
kind: VirtualService
metadata:
  name: "${name}-vs"
  namespace: "${namespace}"
spec:
  hosts:
  - "${domain}"
  gateways:
  - "${name}-gateway"
  http:
  - route:
    - destination:
        # Assumes the service name is the same as the app name
        host: "${name}.${namespace}.svc.cluster.local"
        port:
          number: 443