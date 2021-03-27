from diagrams import Cluster, Diagram
from diagrams.custom import Custom

with Diagram("simple_architecture", show=False):
    ga = Custom("Google Analytics v4", "./imgs/ga.png")
    redis = Custom("redis", "./imgs/redis.png")
    sidekiq = Custom("sidekiq", "./imgs/sidekiq.png")
    openresty = Custom("openresty", "./imgs/openresty.png")
    rails = Custom("rails", "./imgs/rails.png")
    postgresql = Custom("postgresql", "./imgs/postgresql.png")
    timescaledb = Custom("tsdb", "./imgs/TimescaleDB.png")
    

    with Cluster("self service BI"):
        metabase = Custom("metabase", "./imgs/metabase.png")
        chartio = Custom("chartio", "./imgs/chartio.png")
        bi = [metabase, chartio]
    
    rails >> [postgresql, timescaledb]
    ga >> openresty >> redis >> sidekiq >> timescaledb
    timescaledb >> bi 
