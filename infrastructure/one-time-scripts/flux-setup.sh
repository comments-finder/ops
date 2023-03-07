flux bootstrap github --components-extra=image-reflector-controller,image-automation-controller \
 --read-write-key --owner=comments-finder --repository=terraform --path=./kube --branch=main
 
flux create image repository podinfo \
--image=ghcr.io/comments-finder/ui \
--interval=1m \
--export > ./a