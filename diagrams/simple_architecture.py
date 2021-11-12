from diagrams import Cluster, Diagram
from diagrams.custom import Custom

with Diagram("simple_architecture", show=False):
    ga = Custom("Google Analytics v4", "./imgs/ga.png")
    redis = Custom("redis", "./imgs/redis.png")
    sidekiq = Custom("sidekiq", "./imgs/sidekiq.png")
    openresty = Custom("openresty", "./imgs/openresty.png")
    rails = Custom("rails", "./imgs/rails.png")
    
    tidb = Custom("tidb", "./imgs/tidb.png")
    

    with Cluster("Self-Service BI"):
        metabase = Custom("metabase", "./imgs/metabase.png")
        chartio = Custom("chartio", "./imgs/chartio.png")
        bi = [metabase, chartio]
    
    rails >> tidb
    ga >> openresty >> redis >> sidekiq >> tidb
    tidb >> bi 
