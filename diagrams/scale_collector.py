from diagrams import Cluster, Diagram
from diagrams.custom import Custom
from diagrams.aws.network import ELB

with Diagram("scale collector", show=False):
    ga = Custom("Google Analytics v4", "./imgs/ga.png")
    lb = ELB("lb")
    tidb = Custom("tidb", "./imgs/tidb.png")
    bi = Custom("metabase", "./imgs/metabase.png")

    with Cluster("collector"):
        openresty = Custom("openresty", "./imgs/openresty.png")
        redis = Custom("redis", "./imgs/redis.png")
        sidekiq = Custom("sidekiq", "./imgs/sidekiq.png")
        collector_group = openresty >> redis >> sidekiq

    with Cluster("collector1"):
        openresty1 = Custom("openresty", "./imgs/openresty.png")
        redis1 = Custom("redis", "./imgs/redis.png")
        sidekiq1 = Custom("sidekiq", "./imgs/sidekiq.png")
        collector_group1 = openresty1 >> redis1 >> sidekiq1

    with Cluster("collector2"):
        openresty2 = Custom("openresty", "./imgs/openresty.png")
        redis2 = Custom("redis", "./imgs/redis.png")
        sidekiq2 = Custom("sidekiq", "./imgs/sidekiq.png")
        collector_group2 = openresty2 >> redis2 >> sidekiq2

    ga >> lb
    lb >> openresty 
    lb >> openresty1
    lb >> openresty2
    [collector_group, collector_group1, collector_group2] >> tidb >> bi
