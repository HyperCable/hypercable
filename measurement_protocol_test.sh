#!/usr/bin/env bash
curl -H "Content-Type: application/json" "localhost:8000/e63f4903-293c-408c-807f-63b49a2d7376/debug/mp/collect?measurement_id=55&api_secret=7164faca075113e13d8f8ce0d2c7da537d2f588d" -X POST --data '{"events": [], "client_id": 1, "user_properties": {}}'

curl -v -H "Content-Type: application/json" "localhost:8000/e63f4903-293c-408c-807f-63b49a2d7376/mp/collect?measurement_id=55&api_secret=7164faca075113e13d8f8ce0d2c7da537d2f588d" -X POST --data '{"client_id":"client_id","events":[{"name":"add_shipping_info","params":{"coupon":"SUMMER_FUN","currency":"USD","items":[{"item_id":"SKU_12345","item_name":"jeggings","coupon":"SUMMER_FUN","discount":2.22,"affiliation":"Google Store","item_brand":"Gucci","item_category":"pants","item_variant":"Black","price":9.99,"currency":"USD"}],"shipping_tier":"Ground","value":7.77}}]}'

