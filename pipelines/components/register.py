from kfp import dsl
@dsl.component(base_image="{{IMAGE}}")
def get_model_uri(run_id: str, model_name: str) -> str:
    import mlflow
    client = mlflow.tracking.MlflowClient()
    latest_versions = client.get_latest_versions(model_name, stages=["None"])
    if not latest_versions:
        raise ValueError(f"No versions found for model '{model_name}' in stage 'None'.")
    latest = latest_versions[0]
    return latest.source
