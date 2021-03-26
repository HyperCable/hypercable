from diagrams import Cluster, Diagram
from diagrams.custom import Custom

with Diagram("Hypercable data flow diagram", show=False):
    ga = Custom("Google Analytics v4", "./imgs/ga.png")
    redis = Custom("redis", "./imgs/redis.png")
    sidekiq = Custom("sidekiq", "./imgs/sidekiq.png")
    openresty = Custom("openresty", "./imgs/openresty.png")
    rails = Custom("rails", "./imgs/rails.png")
    postgresql = Custom("postgresql", "./imgs/postgresql.png")
    timescaledb = Custom("tsdb", "./imgs/TimescaleDB.png")
    metabase = Custom("metabase", "./imgs/metabase.png")
    chartio = Custom("chartio", "./imgs/chartio.png")

    with Cluster("visual BI"):
        bi = [metabase, chartio]

    ga >> openresty >> redis >> sidekiq >> timescaledb
    rails >> [postgresql, timescaledb]
    timescaledb >> bi 
