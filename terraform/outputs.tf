output "argocd_url" {
  #value = "http://$(kubectl get svc -n argocd argocd-server -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')"
  value = "http://argocd.local"
}
