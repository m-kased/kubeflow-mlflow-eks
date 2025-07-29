import os
from kfp import dsl, compiler

ACCOUNT_ID = os.getenv("AWS_ACCOUNT_ID")
REGION     = os.getenv("AWS_REGION", "eu-central-1")

if not ACCOUNT_ID:
    raise ValueError("AWS_ACCOUNT_ID environment variable must be set.")

IMAGE_URI = (
    f"{ACCOUNT_ID}.dkr.ecr.{REGION}.amazonaws.com/"
    "kubeflow-models:pipeline-base"
)

ingest   = dsl.import_component_from_file("components/ingest.py")
train    = dsl.import_component_from_file("components/train.py")
register = dsl.import_component_from_file("components/register.py")

for comp in (ingest, train, register):
    comp.spec.implementation.container.image = IMAGE_URI

@dsl.pipeline(name="housing-train-register")
def housing_pipeline():
    """
    Ingest data, train a model, and register it in MLflow.
    No serving step - the pipeline ends after registration.
    """
    raw = ingest(
        url=(
            "https://raw.githubusercontent.com/ageron/handson-ml/"
            "master/datasets/housing/housing.csv"
        )
    )
    run = train(
        data_path=raw.output,
        model_name="housing"
    )
    register(
        run_id=run.output,
        model_name="housing"
    )

if __name__ == "__main__":
    compiler.Compiler().compile(housing_pipeline, "housing_pipeline.yaml")
