```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress
  namespace: developers
  annotations:
    nginx.ingress.kubernetes.io/backend-protocol: HTTPS
    nginx.ingress.kubernetes.io/configuration-snippet: >
      rewrite / https://my-example.com/test/ui$uri
      permanent;
    nginx.ingress.kubernetes.io/proxy-body-size: 50m
    nginx.ingress.kubernetes.io/proxy-read-timeout: '300'
    nginx.ingress.kubernetes.io/ssl-redirect: 'true'
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - my-example.com
      secretName: my-ingress-tls
  rules:
    - host: my-example.com
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: ui-service
                port:
                  number: 8080
```

This ingress resource will redirect the users who tried to access __https://my-example.com__ to __https://my-example.com/test/ui__


Reference: https://stackoverflow.com/questions/58687909/kubernetes-ingress-domain-redirect
