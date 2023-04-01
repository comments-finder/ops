aws eks update-kubeconfig --region us-west-2 --name search
helm install helm helm
kubectl create secret docker-registry ghcr-secret --docker-server=ghcr.io --docker-username=danxil --docker-password=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 --namespace=scrapper
kubectl create secret docker-registry ghcr-secret --docker-server=ghcr.io --docker-username=danxil --docker-password=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 --namespace=search
kubectl create secret docker-registry ghcr-secret --docker-server=ghcr.io --docker-username=danxil --docker-password=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 --namespace=ui
kubectl create secret generic zenrows-key --from-literal=ZENROWS_KEY=042572b0dad995a60dd8be884ec746290fa7d10c --namespace=scrapper
