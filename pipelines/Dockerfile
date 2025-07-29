FROM python:3.11-slim

RUN pip install --no-cache-dir \
      pandas scikit-learn mlflow \
      kfp==2.5.0 kubernetes pyyaml

ENV MLFLOW_TRACKING_URI=http://mlflow.mlflow.svc.cluster.local:5000
