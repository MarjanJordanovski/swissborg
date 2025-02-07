kubectl create namespace argo   
kubectl apply -n argo -f install.yaml

TO access argoCD right away:

kubectl port-forward svc/argocd-server -n argo 8080:443