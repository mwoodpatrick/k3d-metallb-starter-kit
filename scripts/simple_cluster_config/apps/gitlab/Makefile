install:
	helm repo add gitlab https://charts.gitlab.io/
	helm repo update
	helm upgrade --install gitlab gitlab/gitlab \
	  --timeout 600s \
	  --set global.hosts.domain=gitlab.westie-dev.org \
	  --set global.hosts.externalIP=10.10.10.10 \
	  --set certmanager-issuer.email=me@example.com \
	  --set postgresql.image.tag=13.6.0

get-password:
	kubectl get secret gitlab-gitlab-initial-root-password -ojsonpath='{.data.password}' | base64 --decode ; echo

