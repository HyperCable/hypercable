## Google Analytics

```
<script async src="https://www.googletagmanager.com/gtag/js?id=<%= ga_tracking_id %>"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', '<%= ga_tracking_id %>', { transport_url: 'http://localhost:8000' });

  document.addEventListener('turbolinks:load', event => {
    if (typeof gtag === 'function') {
      gtag('config', '<%= ga_tracking_id %>', {
        'page_location': event.data.url,
        transport_url: 'http://localhost:8000'
      });
    }
  });
</script>
```
