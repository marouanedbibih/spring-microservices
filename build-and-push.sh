#!/bin/bash
set -e

# -------------------------
# CONFIGURATION
# -------------------------
REGISTRY="marouanedbibih"   # ✅ change this to DockerHub or GitLab registry
TAG="latest"                                             # you can make this dynamic using TAG=$(date +%Y%m%d%H%M)

# -------------------------
# SERVICES to build
# -------------------------
SERVICES=("eureka" "gateway" "car-service" "client-service" "web")

# -------------------------
# Build and push each service
# -------------------------
for SERVICE in "${SERVICES[@]}"; do
  case $SERVICE in
    eureka)
      CONTEXT="eureka/"
      DOCKERFILE="Dockerfile"
      ;;
    gateway)
      CONTEXT="gateway/"
      DOCKERFILE="Dockerfile"
      ;;
    car-service)
      CONTEXT="car/"
      DOCKERFILE="Dockerfile"
      ;;
    client-service)
      CONTEXT="client/"
      DOCKERFILE="Dockerfile"
      ;;
    # web)
    #   CONTEXT="web/"
    #   DOCKERFILE="Dockerfile"
    #   ;;
    *)
      echo "❌ Unknown service: $SERVICE"
      exit 1
      ;;
  esac

  IMAGE_NAME="${REGISTRY}/${SERVICE}:${TAG}"

  echo "🚀 Building image for ${SERVICE}..."
  docker build --target prod -t "${IMAGE_NAME}" -f "${CONTEXT}/${DOCKERFILE}" "${CONTEXT}"

  echo "📤 Pushing ${IMAGE_NAME} to registry..."
  docker push "${IMAGE_NAME}"

  echo "✅ Done with ${SERVICE}."
done

echo "🎉 All images built and pushed successfully!"
