## 1. Role 생성 및 Key 생성 
- IAM > 역할 > 역할 생성 > AWS 서비스 > CloudFormation > AdministratorAccess > 역할명 cloudformation_admin > 생성
- EC2 > 키 페어 > 키 페어 생성 > 키 페어명 eks-monitoring-test-key > 생성

## 2. cf 실행 (bastion 서버 생성) 
- https://github.com/jhbaik1501/eks-monitoring-guide/blob/main/cloudformation.yaml  다운로드
- CloudFormation > 스택 > 스택 생성 > 템플릿 파일 업로드 > eks-cloudformation-stack-test > 


## 1. EKSCTL 설치 

curl -sL https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz \
| tar xz -C /tmp && sudo mv /tmp/eksctl /usr/local/bin



## 2. Git Clone
git clone https://github.com/jhbaik1501/eks-monitoring-guide.git


## 3. 클러스터 생성
eksctl create cluster -f eksctl-test-account.yaml




## 5. 클러스터 삭제
eksctl delete cluster -f eksctl-test-account.yaml
