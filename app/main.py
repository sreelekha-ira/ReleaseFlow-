from flask import Flask, jsonify
import os

app = Flask(__name__)
VERSION = os.environ.get("RELEASEFLOW_VERSION", "dev")


@app.route("/")
def root():
    return jsonify({"name": "ReleaseFlow Demo App", "version": VERSION})


@app.route("/health")
def health():
    return "OK", 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
