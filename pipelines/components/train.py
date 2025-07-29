from kfp import dsl
@dsl.component(base_image="{{IMAGE}}")
def train_model(data_path: str, model_name: str) -> str:
    import pandas as pd, mlflow, mlflow.sklearn, os, json
    from sklearn.ensemble import RandomForestRegressor
    df = pd.read_csv(data_path)
    X, y = df.drop("median_house_value", axis=1), df["median_house_value"]
    mlflow.set_experiment("housing")
    with mlflow.start_run() as run:
        rf = RandomForestRegressor(n_estimators=100, random_state=42).fit(X, y)
        mlflow.sklearn.log_model(rf, artifact_path="model",
                                 registered_model_name=model_name)
        mlflow.log_metric("rmse", ((rf.predict(X) - y) ** 2).mean() ** .5)
        run_id = run.info.run_id
    return run_id
