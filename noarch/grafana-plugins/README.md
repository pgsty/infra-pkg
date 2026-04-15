# Grafana Plugins

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

tar -cvf /tmp/plugins-13.0.0.tar.gz plugins
scp meta:/tmp/plugins-13.0.0.tar.gz noarch/tarball/
cd noarch make grafana-plugins
```