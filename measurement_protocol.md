# Hypercable Analytics Measurement Protocol

The Hypercable Analytics Measurement Protocol allows developers to make HTTP requests to send events directly to Hypercable Analytics servers. This allows developers to measure how users interact with their business from any HTTP-enabled environment. Notably, this makes it easy to measure interactions that happen server-to-server.

Developers can use the Measurement Protocol to:

* Tie online to offline behavior
* Measure interactions both client-side and server-side
* Send events that happen outside standard user-interaction (e.g. offline conversions)

Note: Hypercable Analytics Measurement Protocol is compatible with Google Analytics Measurement Protocol for Google Analytics 4.

## Overview
There are two parts to sending data to Hypercable Analytics using the Measurement Protocol:

* The transport - where and how you send data
* The payload - the data you send

This document describes how the transport and payload are formatted.

## Transport

### URL endpoint
You send data using the Measurement Protocol by making HTTP POST requests to the following endpoint:

```
https://hypercable-host/hypercable-site-id/mp/collect

e.g. 
https://hypercable.plus/e63f4903-293c-408c-807f-63b49a2d7376/mp/collect
```

To send an event, issue the following HTTP POST request:

```
POST https://hypercable.plus/e63f4903-293c-408c-807f-63b49a2d7376/mp/collect
payload_data
```

* payload_data

The BODY of the request. The body should be JSON. See [Payload](https://developers.google.com/analytics/devguides/collection/protocol/ga4/reference?client_type=gtag#payload).

* send event

```js
const measurementId = `G-XXXXXXXXXX`;
const apiSecret = `<secret_value>`;

fetch(`https://www.hypercable.plus/e63f4903-293c-408c-807f-63b49a2d7376/mp/collect?measurement_id=${measurementId}&api_secret=${apiSecret}`, {
  method: "POST",
  body: JSON.stringify({
    "client_id": "client_id",
    "events": [{
      "name": "add_payment_info",
      "params": {
        "coupon": "SUMMER_FUN",
        "currency": "USD",
        "items": [{
          "item_id": "SKU_12345",
          "item_name": "jeggings",
          "coupon": "SUMMER_FUN",
          "discount": 2.22,
          "affiliation": "Google Store",
          "item_brand": "Gucci",
          "item_category": "pants",
          "item_variant": "Black",
          "price": 9.99,
          "currency": "USD"
        }],
        "payment_type": "Credit Card",
        "value": 7.77
      }
    }]
  })
});
```

## Response codes
The Measurement Protocol always returns a 2xx status code if the HTTP request was received. The Measurement Protocol does not return an error code if the payload data was malformed, or if the data in the payload was incorrect or was not processed by Hypercable Analytics.

## Debug server

The Hypercable Analytics Measurement Protocol does not return HTTP error codes, even if an event is malformed or missing required parameters. To ensure your events are valid, you should test them against the Measurement Protocol Validation Server before deploying them to production. After you have validated that your events are structured properly, you should verify your implementation to make sure you're using the correct keys.

You can either call the Validation Server directly, or use the [GA4 Event Builder](https://ga-dev-tools.appspot.com/ga4-event-builder/). The GA4 Event Builder allows you to interactively construct events, and uses the Measurement Protocol Validation Server to validate them.

* real server endpoint: https://hypercable.plus/e63f4903-293c-408c-807f-63b49a2d7376/mp/collect
* debug server endpoint: https://hypercable.plus/e63f4903-293c-408c-807f-63b49a2d7376/debug/mp/collect

## reference

* https://developers.google.com/analytics/devguides/collection/protocol/ga4/reference
* https://ga-dev-tools.appspot.com/ga4-event-builder/
* https://developers.google.com/analytics/devguides/collection/protocol/ga4/validating-events