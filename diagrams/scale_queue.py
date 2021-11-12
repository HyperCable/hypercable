from diagrams import Cluster, Diagram
from diagrams.custom import Custom

with Diagram("scale queue", show=False):
    ga = Custom("Google Analytics v4", "./imgs/ga.png")
    redis = Custom("redis", "./imgs/redis.png")
    
    openresty = Custom("openresty", "./imgs/openresty.png")
    rails = Custom("rails", "./imgs/rails.png")
    tidb = Custom("tidb", "./imgs/tidb.png")
    
    

    with Cluster("Self-Service BI"):
        metabase = Custom("metabase", "./imgs/metabase.png")
        chartio = Custom("chartio", "./imgs/chartio.png")
        bi = [metabase, chartio]

    with Cluster("Sidekiq Group"):
        sidekiq1 = Custom("sidekiq-1", "./imgs/sidekiq.png")
        sidekiq2 = Custom("sidekiq-2", "./imgs/sidekiq.png")
        sidekiq3 = Custom("sidekiq-3", "./imgs/sidekiq.png")
        sidekiq_group = [sidekiq1, sidekiq2, sidekiq3]


    rails >> tidb
    ga >> openresty >> redis >> sidekiq_group 
    sidekiq1 >> tidb
    sidekiq2 >> tidb
    sidekiq3 >> tidb
    tidb >> bi 
