# verify-images

Script simples para consultar imagens usadas nos clusters k8s, devido a mudança no catálogo público [Bitnami](https://github.com/bitnami/containers/issues/83267)

## Dependencies

- kubectl

## Use

```bash
wget https://raw.githubusercontent.com/Emerson89/verify-images/refs/heads/main/verify-images.sh
```

```bash
bash verify-images.sh
```

- Alterando context

```yaml
kubectl já está instalado

Verificando o contexto atual do kubeconfig...................................................

CURRENT  CLUSTER
*        new-cluster

Voce deseja atualizar o context? (YES(y)/NO(n)/CANCEL(c)): y

Selecione o contexto3 desejado: 

CLUSTERS

1) new-cluster
2) exit
#? 1
```

- Sem alterar

```yaml
kubectl já está instalado

Verificando o contexto atual do kubeconfig...................................................

CURRENT  CLUSTER
*        new-cluster

Voce deseja atualizar o context? (YES(y)/NO(n)/CANCEL(c)): n

Consultando imagens......................................................
namespace: cert-manager → image: quay.io/jetstack/cert-manager-controller:v1.18.2 
namespace: cert-manager → image: quay.io/jetstack/cert-manager-cainjector:v1.18.2 
namespace: cert-manager → image: quay.io/jetstack/cert-manager-webhook:v1.18.2 
```

- Salva em arquivo

```yaml
Voce deseja salvar em arquivo? (YES(y)/NO(n)/CANCEL(c)): y

Insira o nome do cluster: k8s
```