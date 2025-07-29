from kfp import dsl
@dsl.component(base_image="{{IMAGE}}")
def ingest_data(url: str) -> str:
    import pandas, tempfile, requests, os, pathlib, json
    df = pandas.read_csv(url)
    path = pathlib.Path(tempfile.mkdtemp()) / "data.csv"
    df.to_csv(path, index=False)
    return str(path)
