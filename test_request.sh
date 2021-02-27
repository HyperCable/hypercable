#!/usr/bin/env sh

curl 'http://localhost:8000/ahoy/events' \
-X POST \
-H 'Connection: keep-alive' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.88 Safari/537.36' \
-H 'Content-Type: multipart/form-data; boundary=----WebKitFormBoundarycF1PzwWBXs6VuEz7' \
-H 'Accept: */*' \
-H 'Origin: http://localhost:3000' \
-H 'Sec-Fetch-Site: same-site' \
-H 'Sec-Fetch-Mode: no-cors' \
-H 'Sec-Fetch-Dest: empty' \
-H 'Referer: http://localhost:3000/' \
-H 'Accept-Language: zh-CN,zh;q=0.9,en;q=0.8,zh-TW;q=0.7' \
-H 'Cookie: a=1' \
-H 'X-Forwarded-For: 52.77.234.3' \
--data-binary $'------WebKitFormBoundarycF1PzwWBXs6VuEz7\r\nContent-Disposition: form-data; name="visit_token"\r\n\r\n4f989f5d-1a8a-412f-baac-479bd701e6d8\r\n------WebKitFormBoundarycF1PzwWBXs6VuEz7\r\nContent-Disposition: form-data; name="visitor_token"\r\n\r\n25bfcf36-5859-4c8f-ba17-b5a74b9072db\r\n------WebKitFormBoundarycF1PzwWBXs6VuEz7\r\nContent-Disposition: form-data; name="authenticity_token"\r\n\r\nIybjvw2tO+p+MN7wLltaCoOAGboIPKqVOjLunVK0+7YUP83j9xM1U+p13Yc4RAPrqlb/Xcj5+nmKJWR8CiiHOA==\r\n------WebKitFormBoundarycF1PzwWBXs6VuEz7\r\nContent-Disposition: form-data; name="events_json"\r\n\r\n[{"name":"$view","properties":{"url":"http://localhost:3000/bookmarks","title":"极客分享","page":"/bookmarks"},"time":1608823797.563,"id":"d66dfce2-1277-4d58-8679-b9a1595f2b3e","js":true}]\r\n------WebKitFormBoundarycF1PzwWBXs6VuEz7--\r\n'