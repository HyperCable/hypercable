# frozen_string_literal: true

class SessionJob
  include Sidekiq::Worker

  def perform(*args)
    form, request = args
    p form
    p "------"
    p request
    Rails.logger.info args.inspect
  end
end


# {"events_json"=>"[{\"name\":\"$view\",\"properties\":{\"url\":\"http://localhost:3000/\",\"title\":\"极客分享\",\"page\":\"/\"},\"time\":1607976183.145,\"id\":\"a37bd684-112e-43c6-a99c-26c9364637a4\",\"js\":true}]", "visitor_token"=>"b7586f77-d25d-479e-a4cd-2269c256830e", "authenticity_token"=>"CUA2NXv0b7+n/3d0WPiRqAfH7SxlVlU8K0J/LLS5FrQ+WRhpgUphBjO6dANO58hJLhELy6WTBdCbVfXN7CVqOg==", "visit_token"=>"b52259a6-c77c-4b90-b978-d30cd98aa0ff"}
# sidekiq_1    | "------"
# sidekiq_1    | {"ip"=>"172.29.0.1", "user_agent"=>"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36"}
# sidekiq_1    | 2020-12-14T20:03:05.432Z pid=1 tid=clx class=HelloJob jid=c0476c2a-f76b-4c78-833e-790782b1266b elapsed=1.019 INFO: done
