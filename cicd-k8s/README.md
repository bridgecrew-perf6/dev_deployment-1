helm install cert-manager jetstack/cert-manager \
  --namespace cert-manager \ 
  --create-namespace \                  
  --version v1.5.1

helm install rancher rancher-latest/rancher \                       
  --namespace cattle-system \                    
  --set hostname=rancher.osc-devops.kr \
  --set replicas=1 \
--set bootstrapPassword=1234qwer

ingress 수정사항
metadata:
  annotations:
    ...
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/ssl-redirect: "false"
    ...

service 수정사항
servicetype : ClusterIP -> LoadBalancer
