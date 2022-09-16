#!/bin/bash

set -x
set +e

export REPO_NAME=$SESSION_NAMESPACE-$(date +%s)
#echo $REPO_NAME > repo.txt

export GIT_USERNAME=$(kubectl get secret gitea-secret -n default -o json | jq -r '.data.username' | base64 -d)
export GIT_PASSWORD=$(kubectl get secret gitea-secret -n default -o json | jq -r '.data.password' | base64 -d)
export GIT_HOST=tapgit.tap11.tanzupartnerdemo.com

mkdir partnertapdemo
cd partnertapdemo
echo "# TAP Demo for Tanzu Partners" >> README.md
git init
git checkout -b main
git config user.name $GIT_USERNAME
git config user.email "$GIT_USERNAME@gitea.com"
git add .
git commit -a -m "Initial Commit"


git remote add origin https://$GIT_USERNAME:$GIT_PASSWORD@${GIT_HOST}/$GIT_USERNAME/$REPO_NAME.git
git push -u origin main

cd ..
# git clone https://gitea_admin:$GITEA_PASSWORD@gitea.${INGRESS_DOMAIN}/gitea_admin/gitops-workloads.git
# git -C /home/eduk8s/gitops-workloads config user.name gitea_admin
# git -C /home/eduk8s/gitops-workloads config user.email "gitea_admin@example.com"

# envsubst < workload.yaml > gitops-workloads/workload-$SESSION_NAMESPACE.yaml

# git clone https://gitea_admin:$GITEA_PASSWORD@gitea.${INGRESS_DOMAIN}/gitea_admin/gitops-deliverables.git
# git -C /home/eduk8s/gitops-deliverables config user.name gitea_admin
# git -C /home/eduk8s/gitops-deliverables config user.email "gitea_admin@example.com"

# envsubst < deliverable.yaml > gitops-deliverables/deliverable-$SESSION_NAMESPACE.yaml

# rm workload.yaml
