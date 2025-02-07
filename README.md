 aws eks update-kubeconfig --name swissborg-cluster --region us-east-1
(kubectl create namespace argo)   
kubectl apply -n argo -f argocd/install.yaml

kubectl apply -n argo -f traefik/traefik-application.yaml

ubrizgamo url gde treba

kubectl apply -f storage/storage-application.yaml

kubectl apply -f keycloak/keycloak-application.yaml 
kubectl apply -f argocd-config/argocd-oidc-application.yaml 
kubectl apply -f ingresses/ingresses-application.yaml