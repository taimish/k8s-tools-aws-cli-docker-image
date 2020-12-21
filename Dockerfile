# docker build -t k8s-tools-awscli:latest .

FROM amazon/aws-cli:latest

# Installing support tools
RUN \
  yum -y update && \
  yum -y install tar gzip

# Installing k8s tools
RUN \
  cd /tmp; \
  K8S_VER=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt) && \
  curl -LO https://storage.googleapis.com/kubernetes-release/release/${K8S_VER}/bin/linux/amd64/kubectl && \
  chmod 775 kubectl && \
  mv /tmp/kubectl /bin/kubectl && \
  curl -s https://api.github.com/repos/kubernetes-sigs/kustomize/releases | grep browser_download_url | grep linux | head -n1 | awk '-F"' '{print $4}' | xargs curl -LO && \
  tar xvzf kustomize*.tar.gz && \
  chmod 775 kustomize && \
  mv /tmp/kustomize /bin/kustomize && \
  curl -s https://api.github.com/repos/zegl/kube-score/releases | grep browser_download_url | grep tar | grep linux | head -n1 | awk '-F"' '{print $4}' | xargs curl -LO && \
  tar xvzf kube-score*.tar.gz && \
  chmod 775 kube-score && \
  mv /tmp/kube-score /bin/kube-score && \
  curl -LO https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
  tar xvzf kubeval*.tar.gz && \
  chmod 775 kubeval && \
  mv /tmp/kubeval /bin/kubeval && \
  rm /tmp/*
  
ENTRYPOINT [""]