# Anypoint Platform Production Ready 開発ベストプラクティス (2024/07/16)

## Software requirement check
https://salesforce.quip.com/JImIAuaAifZD

* JDK8
* Maven 3.9.6
* Anypoint Studio 7.17

## Account information
### Org info
* org id : 064830c3-425f-4dac-8d44-1a698363a016
* ap.client.id : a74a245b8b6646ecb77715398aa04ac9
* api.client.secret : 5978A9BEbCCf4C04aDf36d453f1a9145

### proxy info
* prod : 19724428
* dev : TBU
* test : TBU

### ConnectedApps info
* exchange viewer 
  * ap.client.id : 6f06517137fa48d6b4709693efb98ae0
  * ap.client.secret : 25Dd36d5a534423CB6e0865e1Ba062cd
* exchange contributor
  * ccc150a061d54c2faf5e6903cf00c895
  * B984F3b1389A4ad483F6Cd25706e2Eae
* cloudhub deployment
  * b8aecedd260a434d96374bace4b6f9a8
  * 17C353e124B04e5b86A68A585290e84e

## 主要コマンド
```
mvn -DmuleDeploy deploy -Dap.client_id=a74a245b8b6646ecb77715398aa04ac9 -Dap.client_secret=5978A9BEbCCf4C04aDf36d453f1a9145 -Dap.ca.client_id=b8aecedd260a434d96374bace4b6f9a8 -Dap.ca.client_secret=17C353e124B04e5b86A68A585290e84e


mvn -DmuleDeploy deploy -Dap.client_id=a74a245b8b6646ecb77715398aa04ac9 -Dap.client_secret=5978A9BEbCCf4C04aDf36d453f1a9145 -Dap.ca.client_id=b8aecedd260a434d96374bace4b6f9a8 -Dap.ca.client_secret=17C353e124B04e5b86A68A585290e84e -Dencrypt.key=secure12345 -Ddeployment.env=dev

mvn -DmuleDeploy deploy -Dap.client_id=a74a245b8b6646ecb77715398aa04ac9 -Dap.client_secret=5978A9BEbCCf4C04aDf36d453f1a9145 -Dap.ca.client_id=b8aecedd260a434d96374bace4b6f9a8 -Dap.ca.client_secret=17C353e124B04e5b86A68A585290e84e -Dencrypt.key=secure12345 -Ddeployment.env=test

mvn -DmuleDeploy deploy -Dap.client_id=a74a245b8b6646ecb77715398aa04ac9 -Dap.client_secret=5978A9BEbCCf4C04aDf36d453f1a9145 -Dap.ca.client_id=b8aecedd260a434d96374bace4b6f9a8 -Dap.ca.client_secret=17C353e124B04e5b86A68A585290e84e -Dencrypt.key=secure12345 -Ddeployment.env=prod -Ddeployment.suffix=

curl -ik -X PUT -H "Content-Type: application/json" -d "{\"lastName\":\"Smith\",\"numBags\":2}" https://check-in-papi-dev-bwfnd0.5sc6y6-2.usa-e2.cloudhub.io/api/v1/tickets/123/checkin


```

## References
* Codeshare : https://codeshare.io/6pE97Y
* Limnu : https://limnu.com/d/draw.html?b=B_ed6EFRIBT6mW1c& (直接閲覧したい方のみ)
