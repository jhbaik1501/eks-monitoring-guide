## 1. Role 생성 및 Key 생성 
- IAM > 역할 > 역할 생성 > AWS 서비스 > CloudFormation > AdministratorAccess > 역할명 cloudformation_admin > 생성
- EC2 > 키 페어 > 키 페어 생성 > 키 페어명 eks-monitoring-test-key > 생성

## 2. cf 실행 (bastion 서버 생성) 
- https://github.com/jhbaik1501/eks-monitoring-guide/blob/main/cloudformation.yaml  다운로드
- CloudFormation > 스택 > 스택 생성 > 템플릿 파일 업로드 > eks-cloudformation-stack-test 실행


## 3. eksctl-bastion-fixed 접속
- cd eks-monitoring-guide/
- vi eksctl.yaml
  - \<PublicSubnetAId\>, \<PublicSubnetCId\>, \<VpcId\> 정보 변경

## 3. 클러스터 생성
eksctl create cluster -f eksctl.yaml

## 4. Helm 레포지토리 추가 및 업데이트
- helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
- helm repo update

- kubectl create namespace monitoring

- helm install prometheus-stack prometheus-community/kube-prometheus-stack \\
  -f prometheus-values.yaml \\
  --namespace monitoring

## 5. Endpoint 확인
- chmod +x info.sh
- ./info.sh

## 6. 대시보드 확인 및 알람설정
- Dashboards > Node Exporter / Nodes
- Alert rules
``` query
(
  (1 - sum without (mode) (rate(node_cpu_seconds_total{job="node-exporter", mode=~"idle|iowait|steal", instance="10.50.1.57:9100"}[$__rate_interval])))
/ ignoring(cpu) group_left
  count without (cpu, mode) (node_cpu_seconds_total{job="node-exporter", mode="idle", instance="10.50.1.57:9100"})
) * 100
```
- 부하 추가 ) `yes > /dev/null`


## 7. 클러스터 삭제
eksctl delete cluster -f eksctl.yaml

## 8. CloudFormation 스택 삭제
CloudFormation 삭제
