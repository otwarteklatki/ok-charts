FROM alpine/helm:2.16.1

ENV HOME /opt/repo
WORKDIR $HOME

ADD charts $HOME/charts
ADD serve  /usr/local/bin

RUN \
  mkdir -p $HOME/packages && \
  helm init --client-only && \
  for chart in `find charts -type f -name Chart.yaml`; do \
    helm package -d $HOME/packages "$(dirname $chart)";\
  done && \
  helm repo index $HOME/packages

ENTRYPOINT []
CMD ["/usr/local/bin/serve"]
