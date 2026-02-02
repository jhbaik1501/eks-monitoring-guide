# 노드들의 Public IP 리스트 추출
NODE_IPS=$(kubectl get nodes -o jsonpath='{.items[*].status.addresses[?(@.type=="ExternalIP")].address}')

# 할당된 NodePort 추출
PROM_PORT=$(kubectl get svc -n monitoring prometheus-stack-kube-prom-prometheus -o jsonpath='{.spec.ports[0].nodePort}')
GRAF_PORT=$(kubectl get svc -n monitoring prometheus-stack-grafana -o jsonpath='{.spec.ports[0].nodePort}')

echo "--------------------------------------------------"
echo "🚀 Prometheus & Grafana Access Info"
echo "--------------------------------------------------"
for IP in $NODE_IPS; do
  echo "Prometheus: http://$IP:$PROM_PORT"
  echo "Grafana:    http://$IP:$GRAF_PORT"
  echo "--------------------------------------------------"
done

# Grafana 초기 비밀번호 확인 (ID: admin)
echo "Grafana Default Admin Password:"
kubectl get secret -n monitoring prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
