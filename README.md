# Implémentation DevOps d'une Application Web Go

Ce projet décrit les étapes de "dévopsification" d'une application web Go en intégrant les pratiques DevOps courantes.

## Containerisation et Déploiement Kubernetes

- **Containerisation de l'application web Go avec Docker** : Une approche multi-stage a été utilisée pour optimiser la taille et la sécurité de l'image, aboutissant à une image finale basée sur une image distroless.

- **Création de manifestes Kubernetes (Deployment, Service, Ingress)** pour orchestrer le déploiement de l'application sur un cluster Kubernetes.

- **Mise en place d'un cluster EKS sur AWS** comme plateforme de déploiement cible.

- **Configuration d'un contrôleur Ingress Nginx** pour gérer le trafic externe vers l'application. Le contrôleur Ingress a créé un load balancer sur AWS, et le nom d'hôte de l'application a été mappé à l'adresse IP du load balancer via des enregistrements DNS locaux.

- **Migration vers un cluster local avec Minikube** : Bascule du déploiement vers un cluster local Minikube pour économiser sur les coûts liés à l’utilisation d’AWS, en configurant un Ingress Nginx spécifique à Minikube pour reproduire la gestion du trafic sans dépendre d'un load balancer AWS.

## Gestion de la Configuration et Automatisation CI/CD

- **Création d'un Helm chart** pour packager et déployer l'application sur différents environnements. Les templates Helm ont permis de paramétrer les manifestes Kubernetes, et les valeurs ont été configurées via le fichier `values.yaml`.

- **Mise en œuvre d'un pipeline CI/CD avec GitHub Actions** pour automatiser les processus de build, de test et de déploiement. Le pipeline comprenait plusieurs étapes : build et tests unitaires, analyse de code statique, création et push d'images Docker, et mise à jour du Helm chart.

- **Intégration d'Argo CD pour implémenter GitOps** : Synchronisation de l'application sur le cluster Kubernetes en fonction des modifications du Helm chart. Argo CD a été configuré pour des déploiements automatiques avec self-healing afin de garantir l'état souhaité de l'application.

---

Ce projet démontre l'application des meilleures pratiques DevOps pour transformer une application web Go en une application déployable et gérable dans un environnement Kubernetes.
