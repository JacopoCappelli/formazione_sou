from flask import Flask
from opentelemetry import metrics
from opentelemetry.sdk.metrics import MeterProvider
from opentelemetry.sdk.resources import SERVICE_NAME, Resource
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.sdk.metrics.export import PeriodicExportingMetricReader
from opentelemetry.exporter.otlp.proto.grpc.metric_exporter import OTLPMetricExporter

resource = Resource(attributes={
    SERVICE_NAME: "python-app"
})
from opentelemetry.sdk.metrics.export import ConsoleMetricExporter 

console_exporter = ConsoleMetricExporter()
console_reader = PeriodicExportingMetricReader(console_exporter, export_interval_millis=1000)

exporter = OTLPMetricExporter(endpoint="http://otel-collector:4317", insecure=True)

reader = PeriodicExportingMetricReader(exporter)
provider = MeterProvider(resource=resource, metric_readers=[console_reader,reader])


metrics.set_meter_provider(provider)
meter= metrics.get_meter_provider().get_meter("python-app")

request_counter = meter.create_counter(
    name="app_request_count",
    description="Number of requests to the root endpoint",
    unit="1"
   
)

# Flask App
app = Flask(__name__)
FlaskInstrumentor().instrument_app(app)

@app.route("/")
def hello():
    request_counter.add(1)
    return "Hello from Flask + OTEL!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
