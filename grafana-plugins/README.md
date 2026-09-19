# Grafana Plugins

`plugins-13.2.2.tar.gz` is an intentionally curated one-shot archive. The
package recipe verifies the archive's pinned checksum but does not attempt to
reconstruct it from individual upstream releases.

```bash
grafana cli plugins install grafana-exploretraces-app
grafana cli plugins install grafana-lokiexplore-app
grafana cli plugins install grafana-metricsdrilldown-app
grafana cli plugins install grafana-pyroscope-app

grafana cli plugins install knightss27-weathermap-panel
grafana cli plugins install marcusolsson-calendar-panel
grafana cli plugins install marcusolsson-dynamictext-panel
grafana cli plugins install marcusolsson-hourly-heatmap-panel
grafana cli plugins install marcusolsson-json-datasource
grafana cli plugins install marcusolsson-static-datasource
grafana cli plugins install marcusolsson-treemap-panel
grafana cli plugins install volkovlabs-echarts-panel
grafana cli plugins install volkovlabs-form-panel
grafana cli plugins install volkovlabs-grapi-datasource
grafana cli plugins install volkovlabs-image-panel
grafana cli plugins install volkovlabs-rss-datasource
grafana cli plugins install volkovlabs-table-panel
grafana cli plugins install volkovlabs-variable-panel
```


```bash

cd /tmp
mkdir plugins
cp -rf /var/lib/grafana/plugins/knightss27-weathermap-panel        /tmp/plugins/                    
cp -rf /var/lib/grafana/plugins/marcusolsson-calendar-panel        /tmp/plugins/                    
cp -rf /var/lib/grafana/plugins/marcusolsson-dynamictext-panel     /tmp/plugins/                       
cp -rf /var/lib/grafana/plugins/marcusolsson-hourly-heatmap-panel  /tmp/plugins/                          
cp -rf /var/lib/grafana/plugins/marcusolsson-json-datasource       /tmp/plugins/                     
cp -rf /var/lib/grafana/plugins/marcusolsson-static-datasource     /tmp/plugins/                       
cp -rf /var/lib/grafana/plugins/marcusolsson-treemap-panel         /tmp/plugins/                   
cp -rf /var/lib/grafana/plugins/volkovlabs-echarts-panel           /tmp/plugins/                 
cp -rf /var/lib/grafana/plugins/volkovlabs-form-panel              /tmp/plugins/              
cp -rf /var/lib/grafana/plugins/volkovlabs-grapi-datasource        /tmp/plugins/                    
cp -rf /var/lib/grafana/plugins/volkovlabs-image-panel             /tmp/plugins/               
cp -rf /var/lib/grafana/plugins/volkovlabs-rss-datasource          /tmp/plugins/                  
cp -rf /var/lib/grafana/plugins/volkovlabs-table-panel             /tmp/plugins/               
cp -rf /var/lib/grafana/plugins/volkovlabs-variable-panel          /tmp/plugins/                  

tar -cvf /tmp/plugins-13.2.2.tar.gz plugins
scp meta:/tmp/plugins-13.2.2.tar.gz tarball/
make grafana-plugins
```

## 2026-09-19 bundle

Pinned Grafana catalog releases; each downloaded ZIP was verified against the catalog SHA256.

| Plugin | Version | SHA256 of downloaded ZIP |
|---|---|---|
| knightss27-weathermap-panel | 0.4.3 | preserved from the checksum-pinned 13.0.0 bundle |
| marcusolsson-calendar-panel | 4.2.4 | a6a3f3ff0173c777dfc8c6180a8a37e1ba1fe5443f433ebb57f13d7384128b38 |
| marcusolsson-dynamictext-panel | 6.3.0 | 9e86d31dcfc6b9c7f0c8318cb313e90e29bdb71cdfca08b55058dde9747e9cb7 |
| marcusolsson-hourly-heatmap-panel | 2.0.1 | preserved from the checksum-pinned 13.0.0 bundle |
| marcusolsson-json-datasource | 1.4.2 | 71814c1c4f5df0c09bc6609a56ed0766f2db0a03a92bfe8f2ef6f3ca7b7efd04 |
| marcusolsson-static-datasource | 6.1.1 | 32de6f19e6213783f5e636714d6cad99f75e3c8dc0e0aabe4a21f1bc23ac93a0 |
| marcusolsson-treemap-panel | 2.1.1 | preserved from the checksum-pinned 13.0.0 bundle |
| volkovlabs-echarts-panel | 7.2.5 | e49f520eef92f391d11c77a94f5503b540451e9e755da9ac5cb3553a8e5db3b5 |
| volkovlabs-form-panel | 6.3.5 | 6ccab1571d1188c58a309f57336b90a59af5173f0439a0acf565bd859dc0885b |
| volkovlabs-grapi-datasource | 3.6.0 | preserved from the checksum-pinned 13.0.0 bundle |
| volkovlabs-image-panel | 7.3.3 | 1d6da708a27adb80a8d277470fd94c8129da986952ae57ef0cccb12fc3de8f05 |
| volkovlabs-rss-datasource | 4.4.1 | 49a4b3aed02207dec8336b1ed512c1924a597858cc9af4bda394a2d9a18ebfe7 |
| volkovlabs-table-panel | 3.6.8 | 89322330f4ebe7c0aeff76dc3ae1f3f48ada36e1dd1162a772fcf2fa8303a1ab |
| volkovlabs-variable-panel | 5.2.0 | 333c4a389843734aa88083c29e17f96c6fc6712cd3e916f063153cd508ff34ef |
